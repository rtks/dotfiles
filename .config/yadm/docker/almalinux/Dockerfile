FROM almalinux:latest AS base

RUN --mount=type=cache,target=/var/cache/dnf,sharing=locked \
    dnf install -y sudo procps-ng

RUN useradd -p abc abc && \
    echo "abc    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/abc

USER abc

WORKDIR /home/abc

STOPSIGNAL SIGKILL

CMD [ "bash", "-l" ]

FROM base AS full

#RUN --mount=type=cache,target=/var/cache/dnf,sharing=locked \
#    sudo dnf install -y git vim
#
#RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
#    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/abc/.bash_profile
#
#RUN --mount=type=cache,uid=1000,gid=1000,target=/home/abc/.cache/Homebrew \
#    bash -lc brew install fish tmux

RUN --mount=type=cache,target=/var/cache/dnf,sharing=locked \
    sudo dnf install -y epel-release && \
    sudo dnf install -y fish tmux neovim
