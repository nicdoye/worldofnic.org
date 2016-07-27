#
# Pretty basic caddy
#

# Pull base image
FROM alpine:latest

ENV version v0.9.0
ENV conf    /etc
ENV docs    /srv
ENV ldocs   files/hugo/public
ENV lconf   files/etc

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
        curl \
        tar

RUN curl -sLO https://github.com/mholt/caddy/releases/download/${version}/caddy_linux_amd64.tar.gz && \
    tar zxf caddy_linux_amd64.tar.gz && \
    mv caddy_linux_amd64 /usr/bin/caddy && \
    chmod 755 /usr/bin/caddy && \
    rm -rf caddy* && \
    mkdir -p ${docs}

# Should you use secrets for SSL?
COPY ${ldocs}                                   ${docs}
COPY ${lconf}/Caddyfile                         ${conf}
COPY ${lconf}/www.worldofnic.org.key            ${conf}
COPY ${lconf}/www.worldofnic.org-bundle.crt     ${conf}

EXPOSE 80
EXPOSE 443

WORKDIR ${conf}

CMD ["/usr/bin/caddy", "--conf", "/etc/Caddyfile"]
