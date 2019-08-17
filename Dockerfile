FROM kong:1.2.2-alpine

ENV KONG_CUSTOM_PLUGINS=rbac
RUN luarocks install kong-oidc-auth
RUN luarocks install kong-plugin-rbac

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8000 8443 8001 8444

STOPSIGNAL SIGQUIT

CMD ["kong", "docker-start"]