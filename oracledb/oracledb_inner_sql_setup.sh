#!/bin/bash

source oracledb_inner_entrypoint.sh

run_setup_sql() {
  sqlplus -S /nolog <<EOF
  SET ECHO OFF;
  SET HEADING OFF;
  SET HEAD OFF;
  SET AUTOPRINT OFF;
  SET SERVEROUTPUT OFF;

  SET TRIM ON;
  SET ERRORLOGGING OFF;
  SET FLUSH OFF;

  SPOOL $RUN_SETUP_TMP_OUTPUT_PATH;
  SET TERMOUT OFF;

  WHENEVER OSERROR EXIT 1;
  WHENEVER SQLERROR EXIT 2;

  CONNECT $USERNAME_SYS/$PASSWORD_SYS@$HOST/$SCHEMA_SYS.$DOMAIN AS $ROLE_SYS;
  @$SETUP_DIR_PATH/oracledb_setup.sql;
  EXIT 0;
EOF
return $?;
}

run_setup_print_debug() {

  if [[ $run_setup_result -ne 0 ]]; then
    echo "\\/\\/\\/\\\/\\/\\/\\/\\/"
    echo "\\/ Setup failed reason: \\/"
    cat $RUN_SETUP_TMP_OUTPUT_PATH;
    echo "\\/                   \\/"
    echo "\\/\\/\\/\\\/\\/\\/\\/\\/"
  fi
}

run_setup_print_if_success() {

  if [[ $run_setup_result -eq 0 ]]; then
    echo "Setup finished correctly."
  fi
}

run_setup_disabled_shell_print() {
  # >/dev/null 2>&1 needed so it does not print to shell sql error
  run_setup_sql >/dev/null 2>&1;

  run_setup_result=$?;

  # run_setup_print_debug; #remove
  run_setup_print_if_success;

  rm -f $RUN_SETUP_TMP_OUTPUT_PATH;
}

command_info "Run setup SQL script"
run_setup_disabled_shell_print;