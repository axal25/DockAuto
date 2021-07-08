# base image
# FROM maven:3.6.3-openjdk-11-slim
FROM tomcat:9.0.38-jdk11-openjdk-slim

USER root

RUN apt -y update \
	&& apt -y install git \
	&& mkdir /usr/share/man/man1/ \
	&& apt -y install maven \
	&& apt clean all

COPY shell_functions.sh /shell_functions.sh
COPY run_tomcatapp_inner.sh /run_tomcatapp_inner.sh

CMD ["/run_tomcatapp_inner.sh"]

RUN echo "TOMCAT Application - Dockerfile finished sucessfully"

# https://stackoverflow.com/questions/44589875/i-am-trying-to-perform-mvn-install-from-dockerfile-but-it-is-not-working-says-mv
# http://trimc-devops.blogspot.com/2015/03/running-docker-applications-apache.html
