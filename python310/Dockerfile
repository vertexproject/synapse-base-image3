FROM ubuntu:20.04

MAINTAINER vEpiphyte <epiphyte@vertex.link>

ENV DEBIAN_FRONTEND="noninteractive"
ENV PYTHONUNBUFFERED 1

COPY requirements.txt requirements.txt
COPY pandoc.deb.sha256 pandoc.deb.sha256
# apt get clean / update / upgrade / install required packages / clean up
# setup locales
# see https://github.com/docker/docker/issues/5663#issuecomment-42550548
RUN set -ex \
    && apt-get clean \
    && apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y locales curl tini software-properties-common build-essential \
    && add-apt-repository -y ppa:deadsnakes/ppa \
    && apt-get install -y python3.10-full python3.10-dev \
    && update-alternatives --install /usr/bin/python3 python /usr/bin/python3.10 1 \
    && curl -sS https://bootstrap.pypa.io/get-pip.py | python3 \
    && curl -L -o pandoc-amd64.deb https://github.com/jgm/pandoc/releases/download/2.14.0.1/pandoc-2.14.0.1-1-amd64.deb \
    && sha256sum --check pandoc.deb.sha256 \
    && dpkg -i pandoc-amd64.deb \
    && rm pandoc.deb.sha256 \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && dpkg-reconfigure locales \
    && /usr/sbin/update-locale LANG=en_US.UTF-8 \
    && pip install -r requirements.txt \
    && rm requirements.txt \
    && apt remove -y curl build-essential \
    && apt autoremove -y \
    && apt-get clean && apt-get purge \
    && rm -rf /var/lib/apt/lists/*

ENV LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8" LC_ALL="en_US.UTF-8"
