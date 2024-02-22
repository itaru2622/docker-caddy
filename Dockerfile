ARG base=bookworm
FROM debian:${base}
ARG base

RUN apt update; apt install -y curl debian-keyring debian-archive-keyring; \
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg; \
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list; \
    apt update;
RUN apt install -y caddy    bash-completion git make procps net-tools;

# same as official caddy:2 startup
RUN mkdir -p /config /data
ENV XDG_CONFIG_HOME /config
ENV XDG_DATA_HOME   /data

EXPOSE 80
EXPOSE 443
EXPOSE 443/udp
EXPOSE 2019

WORKDIR /data
CMD caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
