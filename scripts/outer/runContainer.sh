#!/bin/bash

startContainer() {
  local descriptiveDockerName;
  local imageName containerName;
  local portsOuterName portsInnerName;
  local "${@}";

  local -n portsOuterArray="$portsOuterName"; # nameref
  local -n portsInnerArray="$portsInnerName"; # nameref

  local portsOuterLength=${#portsOuterArray[@]};
  local portsInnerLength=${#portsInnerArray[@]};

  local ports="";

  for ((i=0; i < portsOuterLength && i < portsInnerLength; i++)); do
    if [[ "$ports" != "" ]]; then
      ports+=" ";
    fi
    ports+="-p ";
    ports+="${portsOuterArray[$i]}";
    ports+=":";
    ports+="${portsInnerArray[$i]}";
  done

  section_info "Run $descriptiveDockerName container | PORTS: \"$ports\" - container: $containerName, image: $imageName"
  # -e SETUP_DIR_PATH
   eval "docker run -d $ports -it --name $containerName $imageName";
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
    containerConfigure;
  elif [[ "$(isRunFailed containerName=$containerName)" == true ]]; then
    printContainerLogs containerName="$containerName";
  elif [[ $waitIterationCounter -gt waitIterationCountLimit ]]; then
    command_info "Wait on iteration count limit exceeded.";
    debugContainerDiagnostics containerName="$containerName";
  else
    unhandledLogicError description="$descriptiveDockerName container $containerName"
    debugContainerDiagnostics containerName="$containerName";
  fi
}

runContainer() {
  local descriptiveDockerName;
  local imageName containerName;
  local portsOuterName portsInnerName;
  local "${@}";

  startContainer \
    descriptiveDockerName="$descriptiveDockerName" \
    imageName="$imageName" containerName="$containerName" \
    portsOuterName="$portsOuterName" portsInnerName="$portsInnerName";
  waitOnContainerRun \
    descriptiveDockerName="$descriptiveDockerName" \
    containerName="$containerName";
  containerConfigureOrPrintContainerLogs \
    descriptiveDockerName="$descriptiveDockerName" \
    containerName="$containerName";
}