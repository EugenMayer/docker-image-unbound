FROM {{.Env.DK_FROM_IMAGE}}

COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN apk --update add openssl unbound bash \
    && chmod +x /docker-entrypoint.sh

COPY unbound/records.conf /etc/unbound/
COPY unbound/unbound.conf /etc/unbound/
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/unbound","-d","-c","/etc/unbound/unbound.conf"]
