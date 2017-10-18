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
RUN wget http://download.axonivy.com/7.0.0/AxonIvyEngine7.0.0.55921_All_x64.zip -O AxonIvyEngine7.zip && \
    unzip AxonIvyEngine7.zip -d /opt/AxonIvyEngine7 && \
    rm -f AxonIvyEngine7.zip && \
    useradd -s /sbin/nologin axonivy && \
    chown -R axonivy:axonivy /opt/AxonIvyEngine7

COPY start-axonivy-engine.sh /usr/local/bin/start-axonivy-engine.sh

# Fix for issue #25527. Remove as soon as fixed.
# RUN sed -i 's/\-djava\.awt\.headless=true/-Djava.awt.headless=true/g' /opt/AxonIvyEngine7/bin/AxonIvyEngine.conf

USER axonivy

VOLUME /data

EXPOSE 8081

ENTRYPOINT [ "start-axonivy-engine.sh" ]