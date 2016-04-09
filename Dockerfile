#
# Pretty basic httpd
#

# Pull base image
FROM httpd:2.4

#COPY files/www.worldofnic.org/_site /usr/local/apache2/htdocs/
#COPY files/conf /usr/local/apache2/conf
#COPY files/certificates /usr/local/apache2/conf

MKDIR /usr/local/apache2/certificates

EXPOSE 80
EXPOSE 443
