#!/bin/bash
set -euo pipefail

SERVER_DIR=/home/steam/7DTDServer
DATA_DIR=/home/steam/.local/share/7DaysToDie
BINARY="${SERVER_DIR}/7DaysToDieServer.x86_64"

log() { echo "[entrypoint] $*"; }

mkdir -p "${DATA_DIR}/logs"

# SteamCMD only unpacks its own bundled Steamworks client library
# (steamclient.so, needed further down) on its own first invocation —
# unrelated to AUTO_UPDATE/the game's +app_update below, which this run
# may skip entirely (AUTO_UPDATE=0 with the binary already present). Its
# own install directory isn't a persisted volume, so a freshly recreated
# container can reach that skip with the library never having been
# unpacked at all. `+quit` alone is cheap even against an already-warm
# cache; always run it so the library is there regardless of what happens
# next. Not fatal on its own — the real update attempt below has its own
# error handling.
steamcmd +quit || true

# Only pass -beta when a non-default branch was requested; "public" is the
# default branch already.
BETA_ARGS=()
if [[ -n "${GAME_VERSION:-}" && "${GAME_VERSION}" != "public" ]]; then
  BETA_ARGS=(-beta "${GAME_VERSION}")
fi

VALIDATE_ARGS=()
if [[ "${STEAM_VALIDATE:-false}" == "true" || ! -f "${BINARY}" ]]; then
  VALIDATE_ARGS=(validate)
fi

# On a cold SteamCMD cache (first ever run against a fresh $HOME), a single
# +login anonymous +app_update in the same session reliably fails once with
# "ERROR! Failed to install app '294420' (Missing configuration)" — SteamCMD
# hasn't warmed its local appinfo cache for this app yet. Retrying the exact
# same command immediately afterwards succeeds, cache now warm. This is a
# known SteamCMD quirk, not specific to this app or image.
if [[ "${AUTO_UPDATE:-true}" == "true" || ! -f "${BINARY}" ]]; then
  log "Updating 7 Days to Die dedicated server (appid ${STEAMAPPID})..."
  ATTEMPTS=3
  for ((i = 1; i <= ATTEMPTS; i++)); do
    if steamcmd +force_install_dir "${SERVER_DIR}" \
      +login anonymous \
      +app_update "${STEAMAPPID}" "${BETA_ARGS[@]}" "${VALIDATE_ARGS[@]}" \
      +quit; then
      break
    fi
    if [[ $i -eq $ATTEMPTS ]]; then
      log "ERROR: SteamCMD app_update failed after ${ATTEMPTS} attempts."
      exit 1
    fi
    log "SteamCMD app_update failed (attempt ${i}/${ATTEMPTS}), retrying..."
  done
else
  log "AUTO_UPDATE disabled and server files already present, skipping update."
fi

if [[ ! -f "${BINARY}" ]]; then
  log "ERROR: ${BINARY} still missing after app_update, aborting."
  exit 1
fi

# The game's embedded Steamworks client looks for steamclient.so under
# ~/.steam/sdk32 and sdk64 — a symlink the official Steam client normally
# creates on install, which SteamCMD never does on its own. Without it
# SteamGameServer_Init fails (logged, not fatal — the process keeps
# running) and the server reports "Server is still initializing" to every
# connecting player forever, even once the world and EOS session are
# already fully up. SteamCMD ships its own copy of the library right next
# to itself; point the missing symlinks at that.
STEAMCMD_DIR="${HOME}/.local/share/Steam/steamcmd"
mkdir -p "${HOME}/.steam/sdk32" "${HOME}/.steam/sdk64"
ln -sf "${STEAMCMD_DIR}/linux32/steamclient.so" "${HOME}/.steam/sdk32/steamclient.so"
ln -sf "${STEAMCMD_DIR}/linux64/steamclient.so" "${HOME}/.steam/sdk64/steamclient.so"

chmod +x "${BINARY}"
cd "${SERVER_DIR}"

ARGS=(
  -configfile=serverconfig.xml
  -logfile "${DATA_DIR}/logs/latest.log"
  -quit -batchmode -nographics -dedicated
  -ServerPort="${GAME_PORT:-26900}"
  -ServerName="${SERVER_NAME:-7DaysToDieServer}"
  -ServerDescription="${SERVER_DESC:-7DaysToDieServer}"
  -ServerMaxPlayerCount="${MAX_PLAYERS:-8}"
  -ServerVisibility="${PUBLIC_SERVER:-2}"
  -GameDifficulty="${GAME_DIFFICULTY:-2}"
  -TelnetEnabled=true
  -TelnetPort="${TELNET_PORT:-8081}"
  -WebDashboardEnabled="${WEB_DASHBOARD_ENABLED:-true}"
  -WebDashboardPort="${WEB_DASHBOARD_PORT:-8080}"
  -EnableMapRendering="${ENABLE_MAP_RENDERING:-true}"
)

[[ -n "${SERVER_PASSWORD:-}" ]] && ARGS+=(-ServerPassword="${SERVER_PASSWORD}")
[[ -n "${TELNET_PASSWORD:-}" ]] && ARGS+=(-TelnetPassword="${TELNET_PASSWORD}")
[[ -n "${SERVER_DISABLED_NETWORK_PROTOCOLS:-}" ]] && ARGS+=(-ServerDisabledNetworkProtocols="${SERVER_DISABLED_NETWORK_PROTOCOLS}")

log "Starting 7 Days to Die dedicated server on port ${GAME_PORT:-26900}..."

# The binary's real log goes only to -logfile, never to stdout, so
# `asc app logs`/`docker logs` would otherwise show nothing past this
# script's own banner lines. Tail that file to stdout in the background,
# ahead of the exec below rather than backgrounding the game itself:
# `exec` keeps the game as PID 1, so signals reach it directly (no manual
# SIGTERM forwarding needed) and — the part that actually matters for the
# admin console — it inherits this script's real stdin. Backgrounding the
# game instead would silently swap that stdin for /dev/null, same as any
# backgrounded job in a non-interactive shell, breaking `asc attach`
# console input even with the container's own stdin wired up correctly.
# `-F` (not `-f`) tolerates starting before the game has created the file
# yet; `--pid=$$` stops tail once this script's PID exits (the exec below
# keeps that same PID, just running a different program under it).
tail -n +1 -F "${DATA_DIR}/logs/latest.log" --pid=$$ &

exec "${BINARY}" "${ARGS[@]}"
