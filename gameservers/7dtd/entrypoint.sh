#!/bin/bash
set -euo pipefail

SERVER_DIR=/home/steam/7DTDServer
DATA_DIR=/home/steam/.local/share/7DaysToDie
BINARY="${SERVER_DIR}/7DaysToDieServer.x86_64"

log() { echo "[entrypoint] $*"; }

mkdir -p "${DATA_DIR}/logs"

# Only pass -beta when a non-default branch was requested; "public" is the
# default branch already.
BETA_ARGS=()
if [[ -n "${GAME_VERSION:-}" && "${GAME_VERSION}" != "public" ]]; then
  BETA_ARGS=(-beta "${GAME_VERSION}")
fi

VALIDATE_ARGS=()
if [[ "${STEAM_VALIDATE:-0}" == "1" || ! -f "${BINARY}" ]]; then
  VALIDATE_ARGS=(validate)
fi

# On a cold SteamCMD cache (first ever run against a fresh $HOME), a single
# +login anonymous +app_update in the same session reliably fails once with
# "ERROR! Failed to install app '294420' (Missing configuration)" — SteamCMD
# hasn't warmed its local appinfo cache for this app yet. Retrying the exact
# same command immediately afterwards succeeds, cache now warm. This is a
# known SteamCMD quirk, not specific to this app or image.
if [[ "${AUTO_UPDATE:-1}" == "1" || ! -f "${BINARY}" ]]; then
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
)

[[ -n "${SERVER_PASSWORD:-}" ]] && ARGS+=(-ServerPassword="${SERVER_PASSWORD}")
[[ -n "${TELNET_PASSWORD:-}" ]] && ARGS+=(-TelnetPassword="${TELNET_PASSWORD}")
[[ -n "${SERVER_DISABLED_NETWORK_PROTOCOLS:-}" ]] && ARGS+=(-ServerDisabledNetworkProtocols="${SERVER_DISABLED_NETWORK_PROTOCOLS}")

log "Starting 7 Days to Die dedicated server on port ${GAME_PORT:-26900}..."
exec "${BINARY}" "${ARGS[@]}"
