FROM node:6.9.1-alpine
MAINTAINER Martin Bucko <bucko@treecom.net>

ENV BUILD_PACKAGES="python make gcc g++ git libuv bash curl tar bzip2 krb5-dev"
ENV PYTHONPATH=/usr/lib/python2.7/
ENV GYP_DEFINES="linux_use_gold_flags=0"

WORKDIR /

COPY scripts /scripts

RUN apk add --update --no-cache ${BUILD_PACKAGES} \
	&& npm install -g node-gyp \
	&& node-gyp install

ONBUILD COPY .build/bundle /app
ONBUILD RUN sh /scripts/build_app.sh
ONBUILD RUN sh /scripts/rebuild_npm_modules.sh
ONBUILD RUN sh /scripts/clean-final.sh

EXPOSE 80

ENTRYPOINT sh /scripts/run_app.sh
