ARG BUILD_FROM=ghcr.io/usetrmnl/larapaper:latest
FROM ${BUILD_FROM}

RUN apt-get update \
    && apt-get install -y --no-install-recommends jq \
    && rm -rf /var/lib/apt/lists/*

COPY run.sh /ha_run.sh
RUN chmod +x /ha_run.sh

ENTRYPOINT ["/ha_run.sh"]
