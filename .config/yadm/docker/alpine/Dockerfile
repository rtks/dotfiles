FROM alpine:latest AS base

#RUN dnf install -y sudo git vim procps-ng
RUN --mount=type=cache,target=/var/cache/apk \
    apk --update add sudo bash

RUN adduser -D abc && \
    echo "abc    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/abc

USER abc

WORKDIR /home/abc

STOPSIGNAL SIGKILL

CMD [ "bash" ]

FROM base AS full

RUN --mount=type=cache,target=/var/cache/apk \
    sudo apk --update add fish tmux neovim
