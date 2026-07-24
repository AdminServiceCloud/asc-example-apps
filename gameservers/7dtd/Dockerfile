# 7 Days to Die dedicated server: plain SteamCMD + the official game binary,
# no LinuxGSM/LGSM layer. Every per-instance setting (name, password, max
# players, port, visibility...) is passed straight to the game binary as a
# -PropertyName=value override on top of its own bundled serverconfig.xml
# template, so the entrypoint never has to template or `cp` a config file
# itself (that's what broke the previous image).
FROM steamcmd/steamcmd:ubuntu-24

ENV STEAMAPPID=294420 \
    HOME=/home/steam

RUN useradd --create-home --shell /bin/bash steam \
    && mkdir -p /home/steam/7DTDServer /home/steam/.local/share/7DaysToDie/logs \
    && chown -R steam:steam /home/steam

COPY --chown=steam:steam --chmod=755 entrypoint.sh /home/steam/entrypoint.sh

USER steam
WORKDIR /home/steam

VOLUME ["/home/steam/7DTDServer", "/home/steam/.local/share/7DaysToDie"]

EXPOSE 26900/tcp 26900/udp 26901/udp 26902/udp 8081/tcp 8080/tcp

STOPSIGNAL SIGTERM

ENTRYPOINT ["/home/steam/entrypoint.sh"]
