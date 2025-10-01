package main

import (
	_ "github.com/caddy-dns/route53"
	_ "github.com/caddyserver/cache-handler"
	_ "github.com/caddyserver/caddy/v2"
	_ "github.com/darkweak/storages/go-redis/caddy"
	_ "github.com/greenpau/caddy-security"
)
