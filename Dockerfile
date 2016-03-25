#
# Unofficial alpine-rvm Dockerfile 
#
# https://github.com/nicdoye/alpine-rvm
#

# Pull base image
FROM httpd:2.4

COPY files/www.worldofnic.org/_site /usr/local/apache2/htdocs/
COPY files/conf/httpd.conf /usr/local/apache2/conf/httpd.conf
COPY files/certificates/server.crt /usr/local/apache2/conf/
COPY files/certificates/server.key /usr/local/apache2/conf/

EXPOSE 80
EXPOSE 443
