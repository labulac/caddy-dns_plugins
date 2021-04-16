FROM caddy:builder-alpine AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/dnspod

FROM caddy:alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

CMD ["caddy", "run", "--config", "/config/caddy.json"]
