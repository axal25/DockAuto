#! /bin/sh

source ./tomcatapp/copied_from/common/common_outer_shell_functions.sh

command_info "source tomcatapp_inner_paths.env"
source ./tomcatapp/tomcatapp_inner_paths.env

section_info "Clean up previous docker image, container"

echo "2. TOMCAT application"

echo "---------------------------------"
echo "---------------------------------"
echo "---------------------------------"
echo "2.1. Stop TOMCAT Application container - $TOMCAT_APP_CONTAINER_NAME"
docker stop $TOMCAT_APP_CONTAINER_NAME

echo "---------------------------------"
echo "---------------------------------"
echo "---------------------------------"
echo "2.2. Remove TOMCAT Application container - $TOMCAT_APP_CONTAINER_NAME"
docker container rm $TOMCAT_APP_CONTAINER_NAME

echo "---------------------------------"
echo "---------------------------------"
echo "---------------------------------"
echo "2.3. Removing TOMCAT app image"
docker image rm $TOMCAT_APP_IMAGE_NAME



echo "---------------------------------"
echo "---------------------------------"
echo "---------------------------------"
echo "2.4. Build TOMCAT app image"
docker build ./tomcatapp -t $TOMCAT_APP_IMAGE_NAME

echo "---------------------------------"
echo "---------------------------------"
echo "---------------------------------"
echo "2.5. Run TOMCAT app container"
docker run -p 8081:8080 --name $TOMCAT_APP_CONTAINER_NAME $TOMCAT_APP_IMAGE_NAME
