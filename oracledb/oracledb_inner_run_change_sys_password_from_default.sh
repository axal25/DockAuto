#!/bin/bash

cd /oracledb/setup/

source common_outer_shell_functions.sh

command_info "source oracledb_inner_vars.env"
source oracledb_inner_vars.env

command_info "source oracledb_inner_users.env"
source oracledb_inner_users.env

command_info "source oracledb_inner_paths.env"
source oracledb_inner_paths.env

change_sys_user_password_from_default_sql() {
  sqlplus -S /nolog <<EOF
  SET ECHO OFF;
  SET HEADING OFF;
  SET HEAD OFF;
  SET AUTOPRINT OFF;
  SET SERVEROUTPUT OFF;

  SET TRIM ON;
  SET ERRORLOGGING OFF;
  SET FLUSH OFF;

  SPOOL $CHANGE_SYS_USER_PASSWORD_FROM_DEFAULT_TMP_OUTPUT_PATH;
  SET TERMOUT OFF;

  WHENEVER OSERROR EXIT 1;
  WHENEVER SQLERROR EXIT 2;

  CONNECT $USERNAME_SYS/$PASSWORD_SYS_DEFAULT@$HOST/$SCHEMA_SYS.$DOMAIN AS $ROLE_SYS;
  ALTER USER $USERNAME_SYS IDENTIFIED BY $PASSWORD_SYS REPLACE $PASSWORD_SYS_DEFAULT;
  EXIT 0;
EOF
return $?;
}

change_sys_user_password_from_default_print_debug() {

  if [[ $change_sys_user_password_from_default_result -ne 0 ]]; then
    echo "\\/\\/\\/\\\/\\/\\/\\/\\/"
    echo "\\/ Password change failed reason: \\/"
    cat $CHANGE_SYS_USER_PASSWORD_FROM_DEFAULT_TMP_OUTPUT_PATH;
    echo "\\/                   \\/"
    echo "\\/\\/\\/\\\/\\/\\/\\/\\/"
  fi
}

change_sys_user_password_from_default_print_if_success() {

  if [[ $change_sys_user_password_from_default_result -eq 0 ]]; then
    echo "Password changed from default."
  fi
}

change_sys_user_password_from_default_disabled_shell_print() {
  # >/dev/null 2>&1 needed so it does not print to shell sql error
  change_sys_user_password_from_default_sql >/dev/null 2>&1;

  change_sys_user_password_from_default_result=$?;

  # change_sys_user_password_from_default_print_debug; #remove
  change_sys_user_password_from_default_print_if_success;

  rm -f $CHANGE_SYS_USER_PASSWORD_FROM_DEFAULT_TMP_OUTPUT_PATH;
}

command_info "Change sys user's password from default"
change_sys_user_password_from_default_disabled_shell_print;