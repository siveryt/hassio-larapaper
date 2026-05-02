ARG BUILD_FROM=ghcr.io/usetrmnl/larapaper:latest
FROM ${BUILD_FROM}

RUN apk add --no-cache jq

COPY run.sh /ha_run.sh
RUN chmod +x /ha_run.sh

ENTRYPOINT ["/ha_run.sh"]
