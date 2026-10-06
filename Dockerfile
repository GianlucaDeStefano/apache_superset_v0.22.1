FROM --platform=linux/amd64 amancevice/superset:0.22.1@sha256:c5bdb166a20b749495d7f082c0fd8362678441ba384dc139164ef2024e6d6ddb

# The base image defaults to USER superset; apt needs root.
USER root

RUN rm -f /etc/apt/sources.list.d/* && printf '%s\n' \
        'deb [trusted=yes,check-valid-until=no] http://archive.debian.org/debian stretch main' \
        'deb [trusted=yes,check-valid-until=no] http://archive.debian.org/debian-security stretch/updates main' \
        > /etc/apt/sources.list \
    && apt-get -o Acquire::Check-Valid-Until=false update

RUN apt-get install -y --no-install-recommends --allow-unauthenticated \
        netcat-openbsd \
        ca-certificates \
        iputils-ping \
        dnsutils \
        procps \
        wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && command -v nc

USER superset
