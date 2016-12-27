FROM ubuntu:16.04
MAINTAINER Daniel Gauch <daniel@gauch.biz>

# Install wget and unzip 
RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y unzip 

# Download and extract Axon.ivy Engine
RUN wget http://download.axonivy.com/6.4.0/AxonIvyEngine6.4.0.52683_Linux_x64.zip -O AxonIvyEngine6.zip && \
    unzip AxonIvyEngine6.zip -d /opt/AxonIvyEngine6 && \
    rm -f AxonIvyEngine6.zip && \
    useradd -s /sbin/nologin axonivy && \
	chown -R axonivy:axonivy /opt/AxonIvyEngine6 && \
	chown -R axonivy:axonivy /opt/AxonIvyEngine6/

COPY start-axonivy-engine.sh /usr/local/bin/start-axonivy-engine.sh
RUN chmod +x /usr/local/bin/*.sh

# Fix for issue #25527. Remove as soon as fixed.
RUN sed -i 's/\-djava\.awt\.headless=true/-Djava.awt.headless=true/g' /opt/AxonIvyEngine6/bin/AxonIvyEngine.conf

USER axonivy

VOLUME /data

EXPOSE 8081

CMD start-axonivy-engine.sh
