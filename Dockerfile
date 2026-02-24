FROM caddy:2.11.1-builder AS builder

ENV GOFLAGS=-mod=mod

RUN xcaddy build v2.11.1 \
    --with github.com/caddy-dns/route53@v1.6.0 \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/greenpau/caddy-security@v1.1.31 \
    --with github.com/caddyserver/cache-handler@v0.16.0 \
    --with github.com/darkweak/storages/go-redis/caddy@v0.0.16 \
    --replace github.com/slackhq/nebula@v1.9.5=github.com/slackhq/nebula@v1.10.3 \
    --replace github.com/smallstep/certificates@v0.28.4=github.com/smallstep/certificates@v0.29.0

FROM caddy:2.11.1

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN /usr/bin/caddy version
RUN /usr/bin/caddy list-modules --skip-standard --versions