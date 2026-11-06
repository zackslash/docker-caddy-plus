ARG CADDY_VERSION=2.11.9
FROM docker.io/caddy:${CADDY_VERSION}-builder AS builder

ENV GOFLAGS=-mod=readonly

WORKDIR /src
COPY go.mod go.sum ./
COPY main.go ./
RUN CGO_ENABLED=0 go build -trimpath -o /usr/bin/caddy .

FROM docker.io/caddy:${CADDY_VERSION}

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN /usr/bin/caddy version && \
  /usr/bin/caddy list-modules --skip-standard --versions
