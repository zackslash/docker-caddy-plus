FROM docker.io/caddy:2.11.2-builder AS builder

ENV GOFLAGS=-mod=mod

RUN xcaddy build v2.11.2 \
    --with github.com/caddy-dns/route53@v1.6.0 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/greenpau/caddy-security@v1.1.62 \
    --with github.com/caddyserver/cache-handler@v0.16.0 \
    --with github.com/darkweak/storages/go-redis/caddy@v0.0.19

FROM docker.io/caddy:2.11.2

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN /usr/bin/caddy version
RUN /usr/bin/caddy list-modules --skip-standard --versions