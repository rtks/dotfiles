FROM ubuntu:latest AS base

#RUN dnf install -y sudo git vim procps-ng
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && apt-get install -y sudo

RUN useradd -p abc abc && \
    echo "abc    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/abc

USER abc

WORKDIR /home/abc

STOPSIGNAL SIGKILL

CMD [ "bash" ]

FROM base AS full

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked --mount=type=cache,target=/var/lib/apt,sharing=locked \
    sudo apt-get install -y software-properties-common && \
    sudo apt-add-repository ppa:fish-shell/release-3 && \
    sudo apt-get install -y fish tmux vim