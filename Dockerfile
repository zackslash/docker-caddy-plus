FROM caddy:2.10.2-builder AS builder

RUN xcaddy build v2.10.0 \
    --with github.com/caddy-dns/route53@v1.5.1 \
    --with github.com/greenpau/caddy-security@v1.1.31 \
    --with github.com/caddyserver/cache-handler@v0.16.0 \
    --with github.com/darkweak/storages/go-redis/caddy@v0.0.16

FROM caddy:2.10.2

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
RUN /usr/bin/caddy version
RUN /usr/bin/caddy list-modules --skip-standard --versions
