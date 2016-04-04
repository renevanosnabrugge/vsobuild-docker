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

# INSTALL Expect
RUN sudo apt-get install expect -y

# INSTALL GIT
RUN sudo apt-get install git -y

# INSTALL CURL
RUN sudo apt-get install curl -y

# INSTALL NODE
RUN curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
RUN sudo apt-get install -y nodejs

# INSTALL VSO Agent
RUN sudo npm install vsoagent-installer -g

#CREATE SOME dirs
RUN mkdir opt/buildagent
RUN mkdir opt/buildagent/_work

#COPY expect file
WORKDIR /opt/buildagent
COPY ConfigureAgent.expect ConfigureAgent.expect

#  Create a service user 
RUN echo "${vso_service_username}\n${vso_service_password}\n\n\n\n\n\n\n" | adduser ${vso_service_username}
RUN su ${vso_service_username}

#  Install the agent
WORKDIR /opt/buildagent
RUN vsoagent-installer
WORKDIR /opt/buildagent/agent
RUN sudo chown -R ${vso_service_username} /opt/buildagent

WORKDIR /opt/buildagent
COPY run.sh run.sh
RUN sudo chmod +x run.sh
CMD ["/bin/sh","./run.sh"]