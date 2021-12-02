FROM debian:buster

RUN apt-get update -y && apt-get install squid nano -y

ADD *.txt /etc/squid/
ADD *.css /etc/squid/
ADD *.conf /etc/squid/

EXPOSE 3128/tcp
EXPOSE 3128/udp

CMD ["/usr/sbin/squid", "-NYCd1"]
