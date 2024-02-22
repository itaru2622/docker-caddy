ARG base=bookworm
FROM debian:${base}
ARG base

RUN apt update; apt install -y curl debian-keyring debian-archive-keyring; \
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg; \
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list; \
    apt update;
RUN apt install -y caddy    bash-completion git make procps net-tools;

# same as official caddy:2 startup
CMD caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
