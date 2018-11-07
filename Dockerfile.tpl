FROM {{.Env.DK_FROM_IMAGE}}

COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN apk --update add openssl unbound bash curl ca-certificates \
    && chmod +x /docker-entrypoint.sh \
    && curl -o /etc/unbound/root.hints https://www.internic.net/domain/named.cache \
    && mkdir -p /etc/unbound/conf.d

COPY unbound/unbound.conf /etc/unbound/

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/unbound","-d", "-c","/etc/unbound/unbound.conf" ]
