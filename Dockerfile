#
# Unofficial alpine-rvm Dockerfile 
#
# https://github.com/nicdoye/alpine-rvm
#

# Pull base image
FROM httpd:2.4

COPY files/www.worldofnic.org/_site /usr/local/apache2/htdocs/
COPY files/conf /usr/local/apache2/conf
COPY files/certificates /usr/local/apache2/conf

EXPOSE 80
EXPOSE 443
