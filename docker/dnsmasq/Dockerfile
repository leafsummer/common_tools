# Version: 0.0.1
FROM ubuntu:14.04
MAINTAINER leafsummmer "wing.sun1987@gmail.com"
ENV REFRESHED_AT 2016-04-05

RUN apt-get update
RUN apt-get install -q -y wget
RUN apt-get install -q -y dnsmasq


RUN echo 'nameserver 8.8.8.8' >> /etc/resolv.dnsmasq.conf
RUN echo 'nameserver 8.8.4.4' >> /etc/resolv.dnsmasq.conf

RUN touch /etc/dnsmasq.host
RUN mkdir -p /etc/dnsmasq.d
RUN mv /etc/dnsmasq.conf /etc/dnsmasq.conf.bak

ADD dnsmasq.conf /etc/dnsmasq.conf
ADD run.sh /root/run.sh
ADD reload.sh /root/reload.sh
ADD updateddnsmasq.sh /root/updateddnsmasq.sh
ADD updateddnsmasq-cron /etc/cron.d/updateddnsmasq-cron

RUN chmod 755 /root/run.sh
RUN chmod 755 /root/reload.sh
RUN chmod 755 /root/updateddnsmasq.sh
RUN chmod 644 /etc/cron.d/updateddnsmasq-cron

EXPOSE 53

CMD cron
CMD /root/run.sh

