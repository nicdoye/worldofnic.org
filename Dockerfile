#
# Pretty basic nginx
#

# Pull base image
FROM nginx:mainline-alpine

RUN mkdir /etc/ssl/nginx && \
    rm -f /etc/nginx/conf.d/default.conf

COPY files/www.worldofnic.org/_site /usr/share/nginx/html/
COPY files/etc/nginx                /etc/nginx/
COPY files/etc/ssl/nginx            /etc/ssl/nginx/

EXPOSE 80
EXPOSE 443
