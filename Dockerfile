FROM debian:jessie
LABEL maintainer Camptocamp "info@camptocamp.com"

RUN \
  apt-get update && \
  apt-get install --assume-yes --no-install-recommends gettext-base python3 && \
  apt-get clean && \
  rm --recursive --force /var/lib/apt/lists/*

COPY bin/* /usr/bin/

COPY mapserver /etc/mapserver
VOLUME /etc/mapserver

COPY qgisserver /project
VOLUME /project

COPY mapcache /mapcache
VOLUME /mapcache

COPY tilegeneration /etc/tilegeneration
VOLUME /etc/tilegeneration

COPY print/print-apps /usr/local/tomcat/webapps/ROOT/print-apps
VOLUME /usr/local/tomcat/webapps/ROOT/print-apps

COPY front /etc/haproxy
VOLUME /etc/haproxy

COPY sftp/conf /etc/sftp
VOLUME /etc/sftp
COPY sftp/keys /home/sigdev/.ssh/keys
VOLUME /home/sigdev/.ssh/keys

ENTRYPOINT [ "/usr/bin/eval-templates" ]
