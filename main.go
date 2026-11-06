package main

import (
	caddycmd "github.com/caddyserver/caddy/v2/cmd"

	_ "github.com/caddy-dns/cloudflare"
	_ "github.com/caddy-dns/route53"
	_ "github.com/caddyserver/cache-handler"
	_ "github.com/darkweak/storages/go-redis/caddy"
)

func main() { caddycmd.Main() }
