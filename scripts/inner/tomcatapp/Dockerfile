# base image
# FROM maven:3.6.3-openjdk-11-slim
FROM tomcat:9.0.38-jdk11-openjdk-slim

MAINTAINER Jacek Oleś <jacek.oles0925@gmail.com>

USER root

# Passed as "--build-arg"
ARG P_Container_Workdir="unset"
ARG P_Copied="unset"
ARG F_PrintFunctions="unset"
ARG F_ContainerFiles="unset"
ARG F_Entrypoint="unset"
ARG F_Run="unset"

ENV P_Container_Workdir="$P_Container_Workdir"
ENV P_Copied="$P_Copied"
ENV F_PrintFunctions="$F_PrintFunctions"
ENV F_ContainerFiles="$F_ContainerFiles"
ENV F_Entrypoint="$F_Entrypoint"
ENV F_Run="$F_Run"

RUN echo "P_Container_Workdir: \"$P_Container_Workdir\""
RUN echo "P_Copied: \"$P_Copied\""
RUN echo "F_PrintFunctions: \"$F_PrintFunctions\""
RUN echo "F_ContainerFiles: \"$F_ContainerFiles\""
RUN echo "F_Entrypoint: \"$F_Entrypoint\""
RUN echo "F_Run: \"$F_Run\""

#WORKDIR "/usr/local/tomcat"
#ENTRYPOINT []
#CMD ["catalina.sh", "run"]

#WORKDIR "$P_Container_Workdir"
#ENTRYPOINT ["./entrypoint.sh"]
#CMD []

COPY "$P_Copied/$F_PrintFunctions" "$P_Container_Workdir"
COPY "$F_Entrypoint" "$P_Container_Workdir"

# CMD has already access to entry point so do not need source
# CMD 'mkdir -p $...';
# CMD 'chmod 777 $...';

# RUN apt -y update >/dev/null 2>&1

# RUN apt -y install git >/dev/null 2>&1

# RUN apt clean all >/dev/null 2>&1

# RUN mkdir /usr/share/man/man1/ \
#  && apt -y install maven 1>/dev/null 2>/dev/null

# https://stackoverflow.com/questions/44589875/i-am-trying-to-perform-mvn-install-from-dockerfile-but-it-is-not-working-says-mv
# http://trimc-devops.blogspot.com/2015/03/running-docker-applications-apache.html

RUN echo "Dockerfile finished successfully"
