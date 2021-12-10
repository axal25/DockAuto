#!/bin/bash

startContainer() {
  local descriptiveDockerName;
  local imageName containerName;
  local portOuter portInner;
  local "${@}";

  section_info "Run $descriptiveDockerName container - $containerName | PORTS: $portOuter:$portInner"
  # -e SETUP_DIR_PATH
  docker run -d -p "$v_oracle_db_container_port_outer:$v_oracle_db_container_port_inner" -it --name "$containerName" "$imageName"
}

waitOnContainerRun() {
  local containerName descriptiveDockerName;
  local "${@}";

  section_info "Waiting on startup of $descriptiveDockerName container to finish - $containerName"

  ((waitIterationCounter=0));
  until [[ "$(isRunSuccessful containerName=$containerName)" == true || "$(isRunFailed containerName=$containerName)" == true || $waitIterationCounter -gt waitIterationCountLimit ]]; do
    # printWaitOnCondition containerName="$containerName"; # remove

    sleep $waitInterval;
    ((waitIterationCounter++));
  done

  # printWaitOnCondition containerName="$containerName"; # remove
}

containerConfigure() {
  section_info "containerConfigure function must be implemented using override";
  return 1;
}

containerConfigureOrPrintContainerLogs() {
  local containerName descriptiveDockerName;
  local "${@}";

  if [[ "$(isRunSuccessful containerName=$containerName)" == true ]]; then
    containerConfigure
  elif [[ "$(isRunFailed containerName=$containerName)" == true ]]; then
    printContainerLogs containerName="$containerName"
  elif [[ $waitIterationCounter -gt waitIterationCountLimit ]]; then
    command_info "Wait on iteration count limit exceeded."
  else
    unhandledLogicError description="$descriptiveDockerName container $containerName"
    debugContainerDiagnostics containerName="$containerName";
  fi
}

runContainer() {
  local descriptiveDockerName;
  local imageName containerName;
  local portOuter portInner;
  local "${@}";

  startContainer \
    descriptiveDockerName="$descriptiveDockerName" \
    imageName="$imageName" containerName="$containerName" \
    portOuter="$portOuter" portInner="$portInner";
  waitOnContainerRun \
    descriptiveDockerName="$descriptiveDockerName" \
    containerName="$containerName";
  containerConfigureOrPrintContainerLogs \
    descriptiveDockerName="$descriptiveDockerName" \
    containerName="$containerName";
}