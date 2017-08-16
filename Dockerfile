FROM registry.eorlbruder.de/nginx-php
MAINTAINER  David Magnus Henriques <eorlbruder@magnus-henriques.de>

RUN pacman -Syyu --noconfirm --quiet --needed git && \
    pacman -Sc --noconfirm

WORKDIR /usr/share/webapps
RUN git clone https://github.com/FreshRSS/FreshRSS.git

RUN ln -s /usr/share/webapps/FreshRSS/p/ /srv/http/freshrss
RUN chown http:http -R /usr/share/webapps/FreshRSS

ADD assets/fcrontab /etc/fcrontab

RUN fcrontab /etc/fcrontab

ADD assets/0-freshrss.conf /etc/nginx/sites-available/0-freshrss.conf

CMD ["supervisord", "-n"]
