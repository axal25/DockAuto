#!/bin/bash

source ./copy_to/common/common_outer_shell_functions.sh

command_info "source oracledb_inner_paths.env"
source ./oracledb/oracledb_inner_paths.env

part_info "Oracle Database DOCKER" "Preparing oracle database docker environment"

command_info "source oracledb_outer_vars.env"
source ./copy_to/oracledb/oracledb_outer_vars.env

command_info "docker login"
docker login

section_info "Clean up previous docker image, container"

command_info "Stop ORACLE Database container - $ORACLE_DB_CONTAINER_NAME"
docker stop $ORACLE_DB_CONTAINER_NAME

command_info "Remove ORACLE Database container - $ORACLE_DB_CONTAINER_NAME"
docker container rm $ORACLE_DB_CONTAINER_NAME

command_info "Remove ORACLE Database image - $ORACLE_DB_IMAGE_NAME"
docker image rm $ORACLE_DB_IMAGE_NAME

command_info "Remove remove unnecessary volumes"
docker volume prune -f

section_info "Create new docker image, container"

command_info "Build ORACLE Database image - $ORACLE_DB_IMAGE_NAME"
docker build --build-arg SETUP_DIR_PATH_FWD_SLASH_ENDED ./oracledb -t $ORACLE_DB_IMAGE_NAME

command_info "Run ORACLE Database container - $ORACLE_DB_CONTAINER_NAME | PORTS: $ORACLE_DB_CONTAINER_PORT_OUTER:$ORACLE_DB_CONTAINER_PORT_INNER"
# -e SETUP_DIR_PATH
docker run -d -p $ORACLE_DB_CONTAINER_PORT_OUTER:$ORACLE_DB_CONTAINER_PORT_INNER -it --name $ORACLE_DB_CONTAINER_NAME $ORACLE_DB_IMAGE_NAME

section_info "Waiting on startup of ORACLE Database container to finish"

command_info "docker ps"
docker ps

echo "docker exec -it $ORACLE_DB_CONTAINER_NAME bash -c \"source /home/oracle/.bashrc
                                                   ls /home/oracle/setup\""
docker exec -it $ORACLE_DB_CONTAINER_NAME bash -c "source /home/oracle/.bashrc
                                                   ls /home/oracle/setup"

echo "docker exec -it $ORACLE_DB_CONTAINER_NAME bash -c \"source /home/oracle/.bashrc
                                                   ls /home/oracle/setup/dockerInit.sh\""
docker exec -it $ORACLE_DB_CONTAINER_NAME bash -c "source /home/oracle/.bashrc
                                                   ls /home/oracle/setup/dockerInit.sh"

command_info "Waiting on \"\$(docker inspect -f {{.State.Running}} $ORACLE_DB_CONTAINER_NAME)\" = true"

until [ "$(docker inspect -f {{.State.Running}} $ORACLE_DB_CONTAINER_NAME)" = true ]; do
  # echo "$(docker inspect -f {{.State.Running}} $ORACLE_DB_CONTAINER_NAME) = true ?"
  # docker inspect -f {{.State.Running}} $ORACLE_DB_CONTAINER_NAME
  sleep 1.0
done

command_info "docker inspect -f {{.State.Running}} $ORACLE_DB_CONTAINER_NAME"
docker inspect -f {{.State.Running}} $ORACLE_DB_CONTAINER_NAME

command_info "Waiting on \"\$(docker inspect -f {{.State.Health.Status}} $ORACLE_DB_CONTAINER_NAME)\" = \"healthy\""

until [ "$(docker inspect -f {{.State.Health.Status}} $ORACLE_DB_CONTAINER_NAME)" = "healthy" ]; do
  # echo "$(docker inspect -f {{.State.Health.Status}} $ORACLE_DB_CONTAINER_NAME) = healthy ?"
  # docker inspect -f {{.State.Health.Status}} $ORACLE_DB_CONTAINER_NAME
  sleep 1.0
done

command_info "docker inspect -f {{.State.Health.Status}} $ORACLE_DB_CONTAINER_NAME"
docker inspect -f {{.State.Health.Status}} $ORACLE_DB_CONTAINER_NAME

command_info "docker ps"
docker ps

section_info "Configure ORACLE Database container"

command_info "docker exec -it $ORACLE_DB_CONTAINER_NAME bash -c \"source /home/oracle/.bashrc
                                                   $SETUP_SCRIPT_PATH\""
docker exec -it $ORACLE_DB_CONTAINER_NAME bash -c "source /home/oracle/.bashrc
                                                   $SETUP_SCRIPT_PATH"