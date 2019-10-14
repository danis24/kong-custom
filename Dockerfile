FROM kong:1.3.0-alpine

# ENV KONG_CUSTOM_PLUGINS=kong-oidc-auth,rbac

# RUN apk add git
# RUN luarocks install kong-oidc-auth
# RUN luarocks install --server=http://luarocks.org/manifests/hhy5861 kong-plugin-rbac
# RUN apk del git

ENV KONG_VERSION 1.3.0
ENV KONG_IMAGES_TAG 3.0.0
ENV KONG_DATABASE postgres
ENV KONG_PLUGINS 'bundled, rbac'

RUN apk add --no-cache --virtual .build-deps git \
	&& luarocks install --server=http://luarocks.org/manifests/danis24 kong-plugin-rbac ${KONG_IMAGES_TAG} \
	&& apk del .build-deps

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8000 8443 8001 8444

STOPSIGNAL SIGQUIT

CMD ["kong", "docker-start"]
