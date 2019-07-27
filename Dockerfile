FROM alpine:3.9

ARG HTTPD_VERSION=2.4.39

ARG PREFIX=/opt/httpd
ARG MAKEFLAGS="-j4"

RUN apk add --update \
  apr \
  apr-dev \
  apr-util \
  apr-util-dev \
  build-base \
  gcc \
  pcre \
  pcre-dev \
  pkgconf \
  pkgconfig \
  wget

RUN cd /tmp && \
    wget http://apache.mirrors.ionfish.org//httpd/httpd-${HTTPD_VERSION}.tar.gz && \
    tar zxf httpd-${HTTPD_VERSION}.tar.gz && rm httpd-${HTTPD_VERSION}.tar.gz

RUN cd /tmp/httpd-${HTTPD_VERSION} && \
    ./configure --prefix=${PREFIX} && \
    make && make install

# Cleanup
RUN rm -rf /var/cache/apk/* /tmp/*

COPY src/ /var/www/html/
COPY etc/httpd/httpd.conf /opt/httpd/conf/httpd.conf
COPY etc/httpd/sites/ /opt/httpd/sites/
COPY scripts/entrypoint.sh /opt/entrypoint.sh

EXPOSE 80

WORKDIR /var/www/html/

ENTRYPOINT [ "/opt/httpd/bin/httpd", "-D", "FOREGROUND" ]