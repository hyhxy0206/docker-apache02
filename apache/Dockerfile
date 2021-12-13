FROM alpine
LABEL MAINTAINER "hy 1@2.com"

ENV version 2.4.51
ENV PATH /usr/local/apache/bin:$PATH

COPY files /tmp/

RUN  /tmp/install.sh

WORKDIR /usr/local/apache
EXPOSE 80 443
CMD ["-D","FOREGROUND"]
ENTRYPOINT ["httpd"]
