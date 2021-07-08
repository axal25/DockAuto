#!/bin/bash

clear

source ./copy_to/common/common_outer_shell_functions.sh

# copying files

mkdir -p ./oracledb/copied_from/common
mkdir -p ./oracledb/copied_from/oracledb

mkdir -p ./tomcatapp/copied_from/common
mkdir -p ./tomcatapp/copied_from/tomcatapp

cp -R ./copy_to/common/common_outer_shell_functions.sh ./oracledb/copied_from/common
cp -R ./copy_to/common/common_outer_shell_functions.sh ./tomcatapp/copied_from/common

cp -R ./copy_to/oracledb/oracledb_outer_vars.env ./oracledb/copied_from/oracledb

cp -R ./copy_to/tomcatapp/tomcatapp_outer_vars.env ./tomcatapp/copied_from/oracledb

# proper setup start

docker_info "Oracle Database Docker";

docker/oracledb_outer_build_and_run_docker.sh

# docker_info "Tomcat Application Docker";

# docker/tomcatapp_outer_build_and_run_docker.sh

# clean up of copied files

rm -R ./oracledb/copied_from
rm -R ./tomcatapp/copied_from