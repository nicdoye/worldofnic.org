#
# Pretty basic nginx
#

# Pull base image
FROM nginx:mainline-alpine

RUN apk update && \
    apk upgrade && \
    mkdir /etc/ssl/nginx && \
    rm -f /etc/nginx/conf.d/default.conf

# Should you use secrets for SSL?
COPY files/hugo/public             /usr/share/nginx/html/
COPY files/etc/nginx                /etc/nginx/
COPY files/etc/ssl/nginx            /etc/ssl/nginx/

EXPOSE 80
EXPOSE 443
