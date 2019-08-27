FROM alpine:3.10

ARG HTTPD_VERSION=2.4.39

ARG PREFIX=/opt/httpd
ARG MAKEFLAGS="-j4"

RUN apk add --update \
  apr \
  apr-dev \
  apr-util \
  apr-util-dev \
  ca-certificates \
  coreutils \
  dpkg-dev dpkg \
  gcc \
  gnupg \
  libc-dev \
  # mod_md
  curl-dev \
  jansson-dev \
  # mod_proxy_html mod_xml2enc
  libxml2-dev \
  # mod_lua
  lua-dev \
  make \
  # mod_http2
  nghttp2-dev \
  # mod_session_crypto
  openssl \
  openssl-dev \
  pcre-dev \
  tar \
  # mod_deflate
  wget \
  zlib-dev

RUN cd /tmp && \
    wget http://apache.mirrors.ionfish.org//httpd/httpd-${HTTPD_VERSION}.tar.gz && \
    tar zxf httpd-${HTTPD_VERSION}.tar.gz && rm httpd-${HTTPD_VERSION}.tar.gz

RUN cd /tmp/httpd-${HTTPD_VERSION} && \
    ./configure \
    --prefix=${PREFIX} \
    --enable-mods-shared=reallyall \
		--enable-mpms-shared=all && \
    make && make install

# Cleanup
RUN rm -rf /var/cache/apk/* /tmp/*

COPY src/ /var/www/html/
COPY etc/httpd/httpd.conf /opt/httpd/conf/httpd.conf
COPY etc/httpd/sites/ /opt/httpd/sites/

EXPOSE 80

WORKDIR /var/www/html/

ENTRYPOINT [ "/opt/httpd/bin/httpd", "-D", "FOREGROUND" ]
