FROM ubuntu:focal

RUN apt-get update && apt-get -y upgrade && apt-get clean

RUN echo "deb [arch=amd64] http://repo.powerdns.com/ubuntu focal-rec-master main" > /etc/apt/sources.list.d/pdns.list

RUN echo "Package: pdns-* \
Pin: origin repo.powerdns.com \
Pin-Priority: 600" > /etc/apt/preferences.d/pdns

RUN apt-get -y install curl gnupg

RUN curl https://repo.powerdns.com/CBC8B383-pub.asc | apt-key add -

RUN apt-get update && apt-get -y install pdns-recursor && mkdir -p /var/run/pdns-recursor

EXPOSE 53 53/udp

ADD akamai.lua /akamai.lua

ENTRYPOINT [ "/usr/sbin/pdns_recursor" ]

CMD [ "--daemon=no", "--local-address=0.0.0.0", "--lua-dns-script=/akamai.lua" ]

