FROM ubuntu:14.04
MAINTAINER Daniel Gauch <daniel@gauch.biz>

# Install wget and unzip 
RUN sudo apt-get update
RUN sudo apt-get install -y wget
RUN sudo apt-get install -y unzip 

# Download and extract Axon.ivy Engine
RUN sudo wget http://download.axonivy.com/6.3.0/AxonIvyEngine6.3.0.52421_Linux_x64.zip && \
    sudo unzip AxonIvyEngine6.3.0.52421_Linux_x64.zip -d /opt/AxonIvyEngine6 && \
    sudo rm -f AxonIvyEngine6.3.0.52421_Linux_x64.zip

COPY start-axonivy-engine.sh /usr/local/bin/start-axonivy-engine.sh
RUN chmod +x /usr/local/bin/*.sh

# Fix for issue #25527. Remove as soon as fixed.
RUN sed -i 's/\-djava\.awt\.headless=true/-Djava.awt.headless=true/g' /opt/AxonIvyEngine6/bin/AxonIvyEngine.conf

RUN sudo useradd -s /sbin/nologin axonivy && \
	sudo chown -R axonivy:axonivy /opt/AxonIvyEngine6 && \
	sudo chown -R axonivy:axonivy /opt/AxonIvyEngine6/

USER axonivy

VOLUME /data

EXPOSE 8081

CMD start-axonivy-engine.sh
