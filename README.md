# Docker Apache HTTPD 
A Dockerfile installing Apache 2.4 from source. Built on Alpine Linux.

[![Docker Stars](https://img.shields.io/docker/stars/alfg/httpd.svg)](https://hub.docker.com/r/alfg/httpd/)
[![Docker Pulls](https://img.shields.io/docker/pulls/alfg/httpd.svg)](https://hub.docker.com/r/alfg/httpd/)
[![Docker Automated build](https://img.shields.io/docker/automated/alfg/httpd.svg)](https://hub.docker.com/r/alfg/httpd/builds/)
[![Build Status](https://travis-ci.org/alfg/docker-httpd.svg?branch=master)](https://travis-ci.org/alfg/docker-httpd)

## Usage

* Pull docker image and run:
```
docker pull alfg/httpd
docker run -d -p 8080:80 --rm alfg/httpd
```
* or build and run container from source:
```
docker build -t httpd 
docker run -d -p 8080:80 --rm httpd
```

* or build using `docker-compose`:
```
docker-compose build
docker-compose up
```

* cURL the server to verify:
```
$ curl -I localhost:8080/index.html

HTTP/1.1 200 OK
Date: Fri, 26 Jul 2019 23:56:07 GMT
Server: Apache/2.4.39 (Unix)
Last-Modified: Fri, 26 Jul 2019 23:55:34 GMT
ETag: "86-58e9e47322980"
Accept-Ranges: bytes
Content-Length: 134
Content-Type: text/html
```

*Please note the container must be run in daemon mode, and not interactive due to Apache HTTPD shutting down on `SIGWINCH` signal. This is by design.*

* https://github.com/docker-library/httpd/issues/9
* https://bz.apache.org/bugzilla/show_bug.cgi?id=50669


## Configure
Apache HTTPD default configurations are included in the [etc](/etc) directory. You can override the configurations and these will be copied over into the container.

Also see [etc/httpd/sites/](/etc/httpd/sites) for adding or editing virtual hosts.

## Resources
* http://httpd.apache.org/docs/2.4/install.html