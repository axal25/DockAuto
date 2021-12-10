#!/bin/bash

execSqlCommand() {
  local username password role;
  local host schema domain;
  local command spoolPath;
  local "${@}";

  local spoolAndTermOutOff;

  [[ $spoolPath != "" ]] \
    && spoolAndTermOutOff="SPOOL $spoolPath;
    SET TERMOUT OFF;
    SET SERVEROUTPUT OFF;
    SET ERRORLOGGING OFF;
    SET AUTOPRINT OFF;
    SET ECHO OFF;
    SET HEADING OFF;" \
    || spoolAndTermOutOff="";

  sqlplus -S /nolog <<EOF

  WHENEVER OSERROR EXIT 1;
  WHENEVER SQLERROR EXIT 2;

  CONNECT ${username}/${password}@${host}/${schema}.${domain} AS ${role};

  SET COLSEP ' | ';
  SET LINESIZE 200;
  SET PAGESIZE 50000 EMBEDDED ON;

  SET TRIM ON;
  SET FLUSH OFF;

  ${spoolAndTermOutOff}

  ${command}

  EXIT 0;
EOF

  return $?;
}

isSpoolFile() {
  local spoolPath;
  local "${@}";

  if [[ "$spoolPath" != "" && -f "$spoolPath" ]]; then
    echo true;
  else
    echo false;
  fi
}

printParameters() {
  local descriptiveCommandName;
  local username password role;
  local host schema domain;
  local command spoolPath;
  local enableOutput debugPrint;

  local "${@}"

  if [[ $debugPrint == true ]]; then
    echo "Passed parameter values
      descriptiveCommandName: $descriptiveCommandName
      username: $username
      password: $password
      role: $role
      host: $host
      schema: $schema
      domain: $domain
      command: $command
      spoolPath: $spoolPath
      enableOutput: $enableOutput
      debugPrint: $debugPrint
    ";
  fi
}

getCommandName() {
  local descriptiveCommandName;
  local command;

  local "${@}"

  local executedCommand="";

  if [[ $descriptiveCommandName != "" ]]; then
    local executedCommand="${executedCommand}${descriptiveCommandName} ";
  fi

  if [[ $command != "" ]]; then
    local executedCommand="${executedCommand}- ${command} ";
  fi

  local executedCommand="${executedCommand}(unreliable status code)"

  echo "$executedCommand";
}

runSqlCommandDebugPrint() {
  local descriptiveCommandName;
  local username password role;
  local host schema domain;
  local command spoolPath;
  local enableOutput debugPrint;
  local statusCode;

  local "${@}";

  echo "";
  echo "---------------------------";
  echo "\\/\\/\\/\\/\\/\\/\\/\\/\\/";

  printParameters \
    descriptiveCommandName="$descriptiveCommandName" \
    username="$username" password="$password" role="$role" \
    host="$host" schema="$schema" domain="$domain" \
    command="$command" spoolPath="$spoolPath" \
    enableOutput="$enableOutput" debugPrint="$debugPrint";

  getCommandName \
    descriptiveCommandName=$descriptiveCommandName \
    command=$command;

  local commandName=$?;

  printErrorCode \
    executedCommand="$commandName"
    statusCode=$statusCode \
    printAlways="$debugPrint";

  if [[ $(isSpoolFile spoolPath="$spoolPath") == true ]]; then
    echo "cat \$spoolPath: $spoolPath";
    if [[ $(cat "$spoolPath") != "" ]]; then
      cat "$spoolPath";
    else
      echo "\"\" (empty)";
    fi
  fi;

  echo "/\\/\\/\\/\\/\\/\\/\\/\\/\\";
  echo "---------------------------";
  echo "";

  return $statusCode;
}

runSqlCommand() {
  local descriptiveCommandName;
  local username password role;
  local host schema domain;
  local command spoolPath;
  local enableOutput debugPrint;
  local "${@}";

  [[ "$enableOutput" == true ]] && local enableOutput=true || local enableOutput=false;
  [[ "$debugPrint" == true ]] && local debugPrint=true || local debugPrint=false;

  if [[ "$enableOutput" != true ]]; then
    # >/dev/null 2>&1 needed so it does not print output to shell
     exec 3>&1 4>&2 1>/dev/null 2>&1;
  fi

  execSqlCommand \
      username="$username" password="$password" role="$role" \
      host="$host" schema="$schema" domain="$domain" \
      command="$command" spoolPath="$spoolPath";

  local statusCode=$?;

  if [[ "$enableOutput" != true ]]; then
     exec 1>&3 2>&4;
  fi

  if [[ "$debugPrint" == true ]]; then
    runSqlCommandDebugPrint \
      descriptiveCommandName="$descriptiveCommandName" \
      username="$username" password="$password" role="$role" \
      host="$host" schema="$schema" domain="$domain" \
      command="$command" spoolPath="$spoolPath" \
      enableOutput="$enableOutput" debugPrint="$debugPrint" \
      statusCode=$statusCode;
  fi

  if [[ $(isSpoolFile spoolPath="$spoolPath") == true ]]; then
    rm -f "$spoolPath";
  fi

  return $statusCode;
}

isSqlCommandSuccessful() {
  local spoolPath statusCode;
  local "${@}";

  local errorLine="(SP[0-9]*-[0-9]*:.*)|(ORA-[0-9]*:.*)";

  if [[ $statusCode -eq 0 ]] \
    || [[ $(isSpoolFile spoolPath="$spoolPath") == true \
    && ! $(cat "$spoolPath") =~ $errorLine ]]; then
      echo true;
  else
    echo false;
  fi
}

runSqlCommandLoop() {
  local descriptiveCommandName;
  local username password role;
  local host schema domain;
  local command spoolPath;
  local enableOutput debugPrint;
  local "${@}";

  ((waitInterval=10));
  ((waitTimeLimit=5*60));
  ((waitIterationCountLimit=waitTimeLimit/waitInterval));

  ((waitIterationCounter=0));

  command_info "Starting $descriptiveCommandName loop";

  runSqlCommand \
    descriptiveCommandName="$descriptiveCommandName" \
    username="$username" password="$password" role="$role" \
    host="$host" schema="$schema" domain="$domain" \
    command="$command" spoolPath="$spoolPath" \
    enableOutput="$enableOutput" debugPrint="$debugPrint";

  local statusCode=$?;

  until [[ $(isSqlCommandSuccessful spoolPath="$spoolPath" statusCode=$statusCode) == true \
    || $waitIterationCounter -gt waitIterationCountLimit ]]; do

    runSqlCommand \
      descriptiveCommandName="$descriptiveCommandName" \
      username="$username" password="$password" role="$role" \
      host="$host" schema="$schema" domain="$domain" \
      command="$command" spoolPath="$spoolPath";

    local statusCode=$?;

    sleep $waitInterval;
    ((waitIterationCounter++));
  done

  if [[ $(isSqlCommandSuccessful spoolPath="$spoolPath" statusCode=$statusCode) == true ]]; then
    command_info "Ended $descriptiveCommandName loop with success";
    return $statusCode;
  elif [[ $waitIterationCounter -gt waitIterationCountLimit ]]; then
    command_info "Wait on $descriptiveCommandName iteration count limit exceeded."
    return 1;
  else
    unhandledLogicError description="$descriptiveCommandName"
    return 2;
  fi
}