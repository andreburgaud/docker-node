FROM node:13.10.1-alpine3.10

LABEL maintainer="andre.burgaud@gmail.com"

RUN apk add --no-cache bash

RUN mkdir /js

COPY entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
