FROM ubuntu:16.04
LABEL maintainer="Daniel Gauch <daniel@gauch.biz>"

# Install wget, unzip and jre since the downloaded engine does not include jre
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    curl \
    unzip \
    default-jre

# Download and extract Axon.ivy Engine
RUN wget https://developer.axonivy.com/download/stable/Engine-All-x64.zip -O AxonIvyEngine.zip && \
    unzip AxonIvyEngine.zip -d /opt/AxonIvyEngine && \
    rm -f AxonIvyEngine.zip && \
    useradd -s /sbin/nologin axonivy && \
    chown -R axonivy:axonivy /opt/AxonIvyEngine

COPY start-axonivy-engine.sh /usr/local/bin/start-axonivy-engine.sh

# Fix for issue #25527. Remove as soon as fixed.
# RUN sed -i 's/\-djava\.awt\.headless=true/-Djava.awt.headless=true/g' /opt/AxonIvyEngine/bin/AxonIvyEngine.conf

USER axonivy

VOLUME /data

EXPOSE 8081

ENTRYPOINT [ "start-axonivy-engine.sh" ]