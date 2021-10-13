FROM python:3.8-slim

MAINTAINER vEpiphyte <epiphyte@vertex.link>

ENV DEBIAN_FRONTEND="noninteractive"
ENV PYTHONUNBUFFERED 1

COPY requirements.txt requirements.txt
COPY pandoc.deb.sha256 pandoc.deb.sha256
# apt get clean / update / upgrade / install required packages / clean up
# setup locales
# Setup crontab from https://github.com/renskiy/cron-docker-image/blob/master/debian/Dockerfile
# install python packages
# install cron
# making logging pipe
# make pam_loginuid.so optional for cron
# see https://github.com/docker/docker/issues/5663#issuecomment-42550548
RUN set -ex \
    && apt-get clean \
    && apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y build-essential libffi-dev libssl-dev libpq-dev locales cron git tree procps net-tools curl supervisor tini\
    && apt-get clean && apt-get purge \
    && rm -rf /var/lib/apt/lists/* \
    && curl -L -o pandoc-amd64.deb https://github.com/jgm/pandoc/releases/download/2.14.0.1/pandoc-2.14.0.1-1-amd64.deb \
    && sha256sum --check pandoc.deb.sha256 \
    && dpkg -i ppandoc-amd64.deb \
    && rm pandoc.deb.sha256 \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && dpkg-reconfigure locales \
    && /usr/sbin/update-locale LANG=en_US.UTF-8 \
    && mkdir -p /var/log/supervisor \
    && pip install -r requirements.txt \
    && rm requirements.txt \
    && mkfifo --mode 0666 /var/log/cron.log \
    && sed --regexp-extended --in-place \
    's/^session\s+required\s+pam_loginuid.so$/session optional pam_loginuid.so/' \
    /etc/pam.d/cron

ENV LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8" LC_ALL="en_US.UTF-8"
