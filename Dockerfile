FROM ubuntu:14.04
MAINTAINER name <email@domain.com>

#env variables
ENV vso_username=""
ENV vso_password=""
ENV vso_url=""
ENV vso_agentname=$HOSTNAME
ENV vso_agentpool=default
ENV vso_service_username=vsoservice
ENV vso_service_password=vsoservice


RUN sudo apt-get update

# INSTALL NODE
RUN sudo apt-get install expect -y
RUN sudo apt-get install nodejs npm -y
RUN sudo apt-get install nodejs-legacy -y
RUN sudo npm install vsoagent-installer -g

#CREATE SOME dirs
RUN mkdir opt/buildagent
RUN mkdir opt/buildagent/_work

#COPY expect file
WORKDIR /opt/buildagent
COPY ConfigureAgent.expect ConfigureAgent.expect
COPY run.sh run.sh
RUN sudo chmod +x run.sh 

#  Create a service user 
RUN echo "${vso_service_username}\n${vso_service_password}\n\n\n\n\n\n\n" | adduser ${vso_service_username}
RUN su ${vso_service_username}

#  Install the agent
WORKDIR /opt/buildagent
RUN vsoagent-installer
WORKDIR /opt/buildagent/agent
RUN sudo chown -R ${vso_service_username} /opt/buildagent

WORKDIR /opt/buildagent
CMD ./run.sh
