FROM alpine:edge

RUN apk update && apk upgrade \
  && apk add --no-cache ca-certificates \
  && apk add libstdc++ libuv openssl-dev \
  openssl libuv-dev make cmake g++ \
  && export H2O_VERSION="2.0.0-beta2" \
  && mkdir "/opt" && cd "/opt" \
  && wget "https://github.com/h2o/h2o/archive/v$H2O_VERSION.tar.gz" -O - | tar xz \
  && cd "/opt/h2o-$H2O_VERSION" \
  && cmake -DWITH_BUNDLED_SSL=off . \
  && make \
  && mv "./h2o" "/opt/h2o" \
  && mv "./libh2o.a" "/opt/libh2o.a" \
  && mv "./libh2o-evloop.a" "/opt/libh2o-evloop.a" \
  && mv "./examples" /opt/examples \
  && cd .. && rm -rf "h2o-$H2O_VERSION" \
  && apk del make cmake g++ libuv \
  && apk del openssl-dev \
  && apk add openssl \
  && apk add libstdc++ \
  && rm -rf /var/cache/apk/* \
