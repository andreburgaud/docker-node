FROM node:13.1.0-buster-slim

LABEL maintainer="andre.burgaud@gmail.com"

RUN apt-get update && apt-get upgrade -yqq && \
    DEBIAN_FRONTEND=noninteractive apt-get install rlwrap vim -yqq && \
    apt-get clean

COPY vimrc /root/.vimrc

COPY entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

ENV EDITOR=vim

ENTRYPOINT ["entrypoint.sh"]
