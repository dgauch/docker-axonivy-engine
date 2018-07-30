FROM openjdk:jre-alpine
LABEL maintainer="Daniel Gauch <daniel@gauch.biz>"

# Install wget, unzip and jre since the downloaded engine does not include jre
RUN apk update && \
    apk add --no-cache wget curl unzip shadow coreutils sudo

RUN adduser -h /home/ivy -s /bin/sh -D ivy ivy \
    && echo "ivy ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ivy
WORKDIR /home/ivy

# Download and extract Axon.ivy Engine
RUN wget https://download.axonivy.com/7.0.6/AxonIvyEngine7.0.6.59030_All_x64.zip -O AxonIvyEngine.zip && \
    unzip AxonIvyEngine.zip -d /home/ivy/AxonIvyEngine && \
    rm -f AxonIvyEngine.zip

RUN chown -R ivy:ivy /home/ivy/AxonIvyEngine

COPY start-axonivy-engine.sh /home/ivy/start-axonivy-engine.sh

RUN ["sudo",  "chmod", "+x", "/home/ivy/start-axonivy-engine.sh"]

VOLUME /data

EXPOSE 8081

ENTRYPOINT [ "/home/ivy/start-axonivy-engine.sh" ]