FROM python:3.7-slim

MAINTAINER vEpiphyte <epiphyte@vertex.link>

ENV DEBIAN_FRONTEND="noninteractive"
ENV PYTHONUNBUFFERED 1

COPY requirements.txt requirements.txt
COPY pandoc.deb.sha256 pandoc.deb.sha256
# apt get clean / update / upgrade / install required packages / clean up
# setup locales
# install python packages
RUN set -ex \
    && apt-get clean \
    && apt-get update \
    && apt-get -y upgrade \
    && apt-get install --no-install-recommends -y build-essential locales tini\
    && apt-get clean && apt-get purge \
    && rm -rf /var/lib/apt/lists/* \
    && curl -L -o pandoc-amd64.deb https://github.com/jgm/pandoc/releases/download/2.14.0.1/pandoc-2.14.0.1-1-amd64.deb \
    && sha256sum --check pandoc.deb.sha256 \
    && dpkg -i pandoc-amd64.deb \
    && rm pandoc.deb.sha256 \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && dpkg-reconfigure locales \
    && /usr/sbin/update-locale LANG=en_US.UTF-8 \
    && mkdir -p /var/log/supervisor \
    && pip install -r requirements.txt \
    && rm requirements.txt \
    && apt remove -y curl build-essential \
    && apt autoremove -y \
    && apt-get clean && apt-get purge \
    && rm -rf /var/lib/apt/lists/*

ENV LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8" LC_ALL="en_US.UTF-8"
