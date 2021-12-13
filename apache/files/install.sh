#!/bin/sh

	sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories && \
	apk update && \
	apk add --no-cache -U openssl-dev pcre-dev expat-dev libtool gcc  make libc-dev && \
	adduser -S -H -s /sbin/noglogin apache && \
	cd /tmp && \
	tar xf apr-1.7.0.tar.gz && \
	tar xf apr-util-1.6.1.tar.gz && \
	tar xf httpd-${version}.tar.gz && \
	cd apr-1.7.0 && \
	sed -i '/$RM "$cfgfile"/d' configure && \
	./configure --prefix=/usr/local/apr  && \
	make -j $(nproc) && make install && \
	cd ../apr-util-1.6.1 && \
	./configure --prefix=/usr/local/apr-util --with-apr=/usr/local/apr && \
	make -j $(nproc) && make install && \
	cd ../httpd-${version} && \
	./configure --prefix=/usr/local/apache \
	  --enable-so \
	  --enable-ssl \
	  --enable-cgi \
	  --enable-rewrite \
	  --with-zlib \
	  --with-pcre \
	  --with-apr=/usr/local/apr \
	  --with-apr-util=/usr/local/apr-util/ \
	  --enable-modules=most \
	  --enable-mpms-shared=all \
	  --with-mpm=prefork && \
	make -j $(nproc) && make install && \
	apk del gcc make && \
	rm -rf /var/cache/* /tmp/* 
