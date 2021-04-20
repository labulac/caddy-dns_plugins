FROM caddy:builder-alpine AS builder

MAINTAINER labulac <labulac@88.com>

RUN xcaddy build \
    --with github.com/caddy-dns/dnspod \
    --with github.com/caddy-dns/alidns \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddy-dns/lego-deprecated

FROM caddy:alpine

WORKDIR /

COPY ./dnspod /etc/caddy/dnspod

COPY ./alidns /etc/caddy/alidns

COPY ./cloudflare /etc/caddy/cloudflare

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

HEALTHCHECK --interval=5s --timeout=3s CMD caddy || exit 1
