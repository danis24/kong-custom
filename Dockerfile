FROM kong:1.0.0-alpine

ENV KONG_CUSTOM_PLUGINS=kong-oidc-auth,rbac

RUN apk add git
RUN luarocks install kong-oidc-auth
RUN luarocks install --server=http://luarocks.org/manifests/hhy5861 kong-plugin-rbac
RUN apk del git

ENV KONG_VERSION 1.0.0
ENV KONG_DATABASE postgres

RUN apk add --no-cache --virtual .build-deps git \
	&& apk del .build-deps

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8000 8443 8001 8444

STOPSIGNAL SIGQUIT

CMD ["kong", "docker-start"]
