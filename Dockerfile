FROM ubuntu:14.04
MAINTAINER Daniel Gauch <daniel@gauch.biz>

# Install wget and unzip 
RUN sudo apt-get update
RUN sudo apt-get install -y wget
RUN sudo apt-get install -y unzip 

# Download and extract Axon.ivy Engine
RUN sudo wget http://developer.axonivy.com/download/5.1.1/AxonIvyEngine5.1.1.47273_Linux_x64.zip
RUN sudo unzip AxonIvyEngine5.1.1.47273_Linux_x64.zip -d /opt/AxonIvyEngine5.1
RUN sudo rm -f AxonIvyEngine5.1.1.47273_Linux_x64.zip

COPY start-axonivy-engine.sh /usr/local/bin/start-axonivy-engine.sh
RUN chmod +x /usr/local/bin/*.sh

VOLUME /data

EXPOSE 8081

CMD start-axonivy-engine.sh
