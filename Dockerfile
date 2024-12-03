FROM ubuntu:24.04

ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# apt-fast
RUN apt-get update && apt-get install -y \
    software-properties-common && \
    rm -rf /var/lib/apt/lists/*
RUN add-apt-repository ppa:apt-fast/stable
RUN apt-get update && apt install -y \
    apt-fast \
    && apt-fast clean && rm -rf /var/lib/apt/lists/*

RUN apt-fast update \
    && apt-fast install -y git curl zip unzip zlib1g-dev init systemd vim redis jq wget \
    && apt-fast clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O- https://git.io/shellspec | sh -s -- --yes
RUN ln -s /root/.local/bin/shellspec /usr/local/bin/

WORKDIR /working
CMD ["shellspec", "-s", "bash"]