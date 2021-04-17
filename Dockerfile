FROM caddy:builder-alpine AS builder

MAINTAINER labulac

RUN xcaddy build \
    --with github.com/caddy-dns/dnspod

FROM caddy:alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

COPY caddy.json /config

CMD ["caddy", "run", "--config", "/config/caddy.json"]
