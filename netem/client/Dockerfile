FROM alpine:3.20

RUN apk add --no-cache \
    bash \
    iproute2 \
    iputils \
    tcpdump \
    curl \
    python3 \
    busybox-extras \
    net-snmp \
    net-snmp-tools

COPY snmpd.conf /etc/snmp/snmpd.conf

CMD ["sh"]