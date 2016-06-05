#
# Pretty basic nginx
#

# Pull base image
FROM abiosoft/caddy

RUN apk update && \
    apk upgrade
#setcap cap_net_bind_service=+ep /etc/caddy/caddy

# Should you use secrets for SSL?
COPY files/hugo/public              /srv/
COPY files/etc/Caddyfile            /etc/

EXPOSE 80
EXPOSE 443
