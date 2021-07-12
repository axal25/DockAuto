#!/bin/bash

try_service_sql() {
  sqlplus -S /nolog <<EOF
  SET ECHO OFF;
  SET HEADING OFF;
  SET HEAD OFF;
  SET AUTOPRINT OFF;
  SET SERVEROUTPUT OFF;

  SET TRIM ON;
  SET ERRORLOGGING OFF;
  SET FLUSH OFF;

  SPOOL $TRY_SERVICE_TMP_OUTPUT_PATH;
  SET TERMOUT OFF;

  WHENEVER OSERROR EXIT 1;
  WHENEVER SQLERROR EXIT 2;

  CONNECT $USERNAME_SYS/$PASSWORD_SYS_DEFAULT@$HOST/$SCHEMA_SYS.$DOMAIN AS $ROLE_SYS;
  EXIT 0;
EOF
return $?;
}

try_service_sql_disabled_shell_print() {
  # >/dev/null 2>&1 needed so it does not print to shell sql error
  try_service_sql >/dev/null 2>&1;

  try_service_result=$?;
}

try_service_print_debug() {

  if [[ $try_service_result -ne 0 ]]; then
    echo "\\/\\/\\/\\\/\\/\\/\\/\\/"
    echo "\\/ Service connection offline reason: \\/"
    cat $TRY_SERVICE_TMP_OUTPUT_PATH;
    echo "\\/                   \\/"
    echo "\\/\\/\\/\\\/\\/\\/\\/\\/"
  fi
}

try_service() {
  try_service_sql_disabled_shell_print;
  
  # try_service_print_debug; #remove

  rm -f $TRY_SERVICE_TMP_OUTPUT_PATH;
}

try_service_loop() {
  echo "Trying out SQL Plus service connection...";
  try_service;

  until [[ $try_service_result -eq 0 ]]; do
    # echo "Service connection is offline."; # remove
    sleep 1.0;
    try_service;
  done

  echo "Service connection is online.";
}

command_info "try_service_loop"
try_service_loop;