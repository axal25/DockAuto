#!/bin/bash

property_not_existing="property_not_existing"
property_existing="property_existing"
((waitInterval=10));
((waitTimeLimit=5*60));
((waitIterationCountLimit=waitTimeLimit/waitInterval));

# check if container exists
# echos: "true" or "false"
isExist_Container() {
  local containerName;
  local "${@}";

  if [[ $(docker ps -a -q -f name="$containerName") != "" ]]; then
    echo true;
  else
    echo false;
  fi
}

################################################################################################################################################################################################################################################

# check if container's .State property exists
# echos: "true" or "false"
isExist_State() {
  local containerName;
  local "${@}";

  if [[ $(docker inspect -f '{{range $k, $v := .}}{{if eq $k "State"}}true{{end}}{{end}}' "$containerName") != "" ]]; then
    echo true;
  else
    echo false;
  fi
}

# check if container's .State.Running property exists
# echos: "true" or "false"
isExist_State_Running() {
  local containerName;
  local "${@}";

  if [[ $(isExist_State containerName=$containerName) == true && $(docker inspect -f '{{with .State}}{{range $k, $v := .}}{{if eq $k "Running"}}property_existing{{end}}{{end}}{{end}}' "$containerName") == "$property_existing" ]]; then
    echo true;
  else
    echo false;
  fi
}

# check if container's .State.ExitCode property exists
# echos: "true" or "false"
isExist_State_ExitCode() {
  local containerName;
  local "${@}";

  if [[ $(isExist_State containerName=$containerName) == true
    && $(docker inspect -f '{{with .State}}{{range $k, $v := .}}{{if eq $k "ExitCode"}}property_existing{{end}}{{end}}{{end}}' "$containerName") == "$property_existing"
  ]]; then
    echo true;
  else
    echo false;
  fi
}

# check if container's .State.Error property exists
# echos: "true" or "false"
isExist_State_Error() {
  local containerName;
  local "${@}";

  if [[ $(isExist_State containerName=$containerName) == true
    && $(docker inspect -f '{{with .State}}{{range $k, $v := .}}{{if eq $k "Error"}}property_existing{{end}}{{end}}{{end}}' "$containerName") == "$property_existing"
  ]]; then
    echo true;
  else
    echo false;
  fi
}

# check if container's .State.Status property exists
# echos: "true" or "false"
isExist_State_Status() {
  local containerName;
  local "${@}";

  if [[ $(isExist_State containerName=$containerName) == true
    && $(docker inspect -f '{{with .State}}{{range $k, $v := .}}{{if eq $k "Status"}}property_existing{{end}}{{end}}{{end}}' "$containerName") == "$property_existing"
  ]]; then
    echo true;
  else
    echo false;
  fi
}

# check if container's .State.Health property exists
# echos: "true" or "false"
isExist_State_Health() {
  local containerName;
  local "${@}";

  if [[ $(isExist_State containerName=$containerName) == true
    && $(docker inspect -f '{{with .State}}{{range $k, $v := .}}{{if eq $k "Health"}}property_existing{{end}}{{end}}{{end}}' "$containerName") == "$property_existing"
  ]]; then
    echo true;
  else
    echo false;
  fi
}

# check if container's .State.Health.Status property exists
# echos: "true" or "false"
isExist_State_Health_Status() {
  local containerName;
  local "${@}";

  if [[ "$(isExist_State_Health containerName=$containerName)" == true
    && $(docker inspect -f '{{with .State.Health}}{{range $k, $v := .}}{{if eq $k "Status"}}property_existing{{end}}{{end}}{{end}}' "$containerName") == "$property_existing"
  ]]; then
    echo true;
  else
    echo false;
  fi
}

################################################################################################################################################################################################################################################

# gets container's .State.Running property value
# echo "true", "false", "$property_not_existing"
get_State_Running() {
  local containerName;
  local "${@}";

  if [[ "$(isExist_State_Running containerName=$containerName)" == true ]]; then
    echo "$(docker inspect -f '{{.State.Running}}' $containerName)";
  else
    echo "$property_not_existing";
  fi
}

# gets container's .State.ExitCode property value
# echo "0", "1", ..., "$property_not_existing"
get_State_ExitCode() {
  local containerName;
  local "${@}";

  if [[ "$(isExist_State_ExitCode containerName=$containerName)" == true ]]; then
    echo "$(docker inspect -f '{{.State.ExitCode}}' $containerName)";
  else
    echo "$property_not_existing";
  fi
}

# gets container's .State.Error property value
# echo "", "...", "$property_not_existing"
get_State_Error() {
  local containerName;
  local "${@}";

  if [[ "$(isExist_State_Error containerName=$containerName)" == true ]]; then
    echo "$(docker inspect -f '{{.State.Error}}' $containerName)";
  else
    echo "$property_not_existing";
  fi
}

# gets container's .State.Status property value
# echos: "starting", "running", "exited", "$property_not_existing"
get_State_Status() {
  local containerName;
  local "${@}";

  if [[ "$(isExist_State_Status containerName=$containerName)" == true ]]; then
    echo "$(docker inspect -f '{{.State.Status}}' $containerName)";
  else
    echo "$property_not_existing";
  fi
}

# gets container's .State.Health.Status property value
# echos: "healthy", "unhealthy", "$property_not_existing"
get_State_Health_Status() {
  local containerName;
  local "${@}";

  if [[ "$(isExist_State_Health_Status containerName=$containerName)" == true ]]; then
    echo "$(docker inspect -f '{{.State.Health.Status}}' $containerName)";
  else
    echo "$property_not_existing";
  fi
}

################################################################################################################################################################################################################################################

isRunSuccessful() {
  local containerName;
  local "${@}";

  if [[ "$(isExist_Container containerName=$containerName)" == true
    && "$(get_State_Running containerName=$containerName)" == true
    && $(get_State_ExitCode containerName=$containerName) -eq 0
    && "$(get_State_Error containerName=$containerName)" == ""
    && "$(get_State_Status containerName=$containerName)" == "running"
    && "$(get_State_Health_Status containerName=$containerName)" == "healthy"
  ]]; then
    echo true;
  else
    echo false;
  fi
}

isRunFailed() {
  local containerName;
  local "${@}";

  if [[ "$(isExist_Container)" == false ]]; then
    echo true;
  elif [[ "$(get_State_Health_Status containerName=$containerName)" == "unhealthy" ]] \
      && [[ "$(get_State_Running containerName=$containerName)" == false
        || $(get_State_ExitCode containerName=$containerName) -ne 0
        || "$(get_State_Error containerName=$containerName)" != ""
        || "$(get_State_Status containerName=$containerName)" == "exited"
      ]]; then
    echo true;
  else
    echo false;
  fi
}

################################################################################################################################################################################################################################################

printWaitOnCondition() {
  local containerName;
  local "${@}";

  printIsBoolean "isRunSuccessful" "$(isRunSuccessful containerName=$containerName)"
  printIsBoolean "isRunFailed" "$(isRunFailed containerName=$containerName)"
}

################################################################################################################################################################################################################################################

debugContainerDiagnostics() {
  local containerName;
  local "${@}";

  section_info "debugContainerDiagnostics for $containerName"

  command_info "docker ps -a -f name=$containerName"
  docker ps -a -f name="$containerName"

  command_info "docker logs --tail --details $containerName"
  docker logs --tail --details "$containerName"

  command_info "is container existing"

  printIsBoolean "#1 isExist_Container" "$(isExist_Container containerName=$containerName)";

  command_info "are inspect properties existing"

  printIsBoolean "#2 .State.Running isExist_State_Running" "$(isExist_State_Running containerName=$containerName)";
  printIsBoolean "#3 .State.ExitCode isExist_State_ExitCode" "$(isExist_State_ExitCode containerName=$containerName)";
  printIsBoolean "#4 .State.Error isExist_State_Error" "$(isExist_State_Error containerName=$containerName)";
  printIsBoolean "#5 .State.Status isExist_State_Status" "$(isExist_State_Status containerName=$containerName)";
  printIsBoolean "#6 .State.Health isExist_State_Health" "$(isExist_State_Health containerName=$containerName)";
  printIsBoolean "#7 .State.Health.Status isExist_State_Health_Status" "$(isExist_State_Health_Status containerName=$containerName)";

  command_info "what are inspect properties' values"

  printIsBoolean "#8 State.Running State_Running" "$(get_State_Running containerName=$containerName)";
  printIsBoolean "#9 State.ExitCode State_ExitCode" "$(get_State_ExitCode containerName=$containerName)";
  printIsBoolean "#10 State.Error State_Error" "$(get_State_Error containerName=$containerName)";
  printIsBoolean "#11 State.Status State_Status" "$(get_State_Status containerName=$containerName)";
  printIsBoolean "#12 State.Health.Status State_Health_Status" "$(get_State_Health_Status containerName=$containerName)";

  command_info "are wait on run conditions satisfied"

  printIsBoolean "#13 isRunFailed" "$(isRunFailed containerName=$containerName)"
  printIsBoolean "#14 isRunSuccessful" "$(isRunSuccessful containerName=$containerName)"
}

printContainerLogs() {
  local containerName;
  local "${@}";

  section_info "Docker container $containerName failed to start correctly on run"
  debugContainerDiagnostics containerName="$containerName";
}