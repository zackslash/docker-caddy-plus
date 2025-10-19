# docker-caddy-plus

A feature-rich Docker image for Caddy v2 with essential modules for DNS management, caching, and security.

## 🚀 Features

This image includes the following Caddy modules:

- **DNS Providers**
  - `caddy-dns/route53` - AWS Route53 DNS provider for ACME DNS challenges
  - `caddy-dns/cloudflare` - Cloudflare DNS provider for ACME DNS challenges

- **Performance**
  - `caddyserver/cache-handler` - HTTP cache handler for improved performance
  - `darkweak/storages/go-redis` - Redis storage backend for distributed caching

- **Security**
  - `greenpau/caddy-security` - Authentication, authorization, and security features

## 📦 Usage

Pull the image from GitHub Container Registry:

```bash
docker pull ghcr.io/zackslash/caddy-plus:latest
```

### Basic Docker Run

```bash
docker run -d \
  -p 80:80 \
  -p 443:443 \
  -v $(pwd)/Caddyfile:/etc/caddy/Caddyfile \
  -v caddy_data:/data \
  -v caddy_config:/config \
  ghcr.io/zackslash/caddy-plus:latest
```

### Docker Compose Example

```yaml
version: '3.8'

services:
  caddy:
    image: ghcr.io/zackslash/caddy-plus:latest
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./Caddyfile:/etc/caddy/Caddyfile
      - ./volumes/data:/data
      - ./volumes/config:/config
    environment:
      - AWS_ACCESS_KEY_ID=your_access_key
      - AWS_SECRET_ACCESS_KEY=your_secret_key
      # Or for Cloudflare:
      # - CF_API_TOKEN=your_cloudflare_token
```

## 🔧 Configuration Examples

### Route53 DNS Challenge

```caddyfile
example.com {
    tls {
        dns route53 {
            access_key_id {env.AWS_ACCESS_KEY_ID}
            secret_access_key {env.AWS_SECRET_ACCESS_KEY}
        }
    }
    reverse_proxy backend:8080
}
```

### Cloudflare DNS Challenge

```caddyfile
example.com {
    tls {
        dns cloudflare {env.CF_API_TOKEN}
    }
    reverse_proxy backend:8080
}
```

### With Caching

```caddyfile
example.com {
    route {
        cache {
            ttl 1h
        }
        reverse_proxy backend:8080
    }
}
```

### With Redis Cache Backend

```caddyfile
{
    order cache before rewrite
    cache {
        redis {
            url redis://redis:6379
        }
    }
}

example.com {
    cache
    reverse_proxy backend:8080
}
```

## 📂 Volume Mounts

- `/data` - Caddy data directory (certificates, etc.)
- `/config` - Caddy configuration directory
- `/etc/caddy/Caddyfile` - Your Caddyfile configuration

## 🔐 Environment Variables

### For AWS Route53
- `AWS_ACCESS_KEY_ID` - Your AWS access key
- `AWS_SECRET_ACCESS_KEY` - Your AWS secret key
- `AWS_REGION` - AWS region (optional, defaults to us-east-1)

### For Cloudflare
- `CF_API_TOKEN` - Your Cloudflare API token

## 🛠️ Building

To build this image yourself:

```bash
git clone https://github.com/zackslash/docker-caddy-plus.git
cd docker-caddy-plus
docker build -t caddy-plus .
```

## 📄 License

This project builds upon [Caddy](https://caddyserver.com/) and its various plugins. Please refer to their respective licenses.

## 🔗 Links

- [Caddy Documentation](https://caddyserver.com/docs/)
- [Caddy DNS Providers](https://github.com/caddy-dns)
- [Caddy Cache Handler](https://github.com/caddyserver/cache-handler)
- [Caddy Security](https://github.com/greenpau/caddy-security)
