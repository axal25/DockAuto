#!/bin/bash

source "$F_S_Entrypoint";

isDockerRunning() {
  [[ \
    $(systemctl show --property ActiveState docker) == "ActiveState=active" \
    && $(systemctl is-active docker) == "active" \
    && $(docker info > /dev/null 2>&1) -eq 0 \
  ]] && isDockerRunning=true || isDockerRunning=false;
  echo "$isDockerRunning";
}

buildImagesAndRunContainers() {
  docker_info "$v_oracle_db_descriptive_name";
  "$F_S_O_Oracledb_BuildAndRun";

#  docker_info "Tomcat Application";
#  "$F_S_O_Tomcatapp_BuildAndRun";
}

buildAndRun() {
  if [[ "$(isDockerRunning)" == true ]]; then
    buildImagesAndRunContainers;
  else
    echo "Docker is not installed or not running.";
    exit 1;
  fi
}

buildAndRun;