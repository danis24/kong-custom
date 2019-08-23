FROM kong:1.3.0-alpine

ENV KONG_CUSTOM_PLUGINS=kong-oidc-auth,rbac

RUN apk add git
RUN luarocks install kong-oidc-auth
RUN luarocks install --server=http://luarocks.org/manifests/hhy5861 kong-plugin-rbac
RUN apk del git

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8000 8443 8001 8444

STOPSIGNAL SIGQUIT

CMD ["kong", "docker-start"]
