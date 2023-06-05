FROM alpine:3.18 AS build

RUN apk add openssl-dev db-dev autoconf make automake g++ 

COPY . /app/
WORKDIR /app


RUN ./autogen.sh && ./configure && make


FROM alpine:3.18

RUN apk add openssl db

COPY --from=build /app/bruteforce-wallet /usr/local/bin/bruteforce-wallet
COPY --from=build /app/bruteforce-wallet.1 /usr/local/share/man/man1


CMD "bruteforce-wallet"
