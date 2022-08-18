#!/bin/bash

source "$F_Entrypoint"

getDefaultDebugPrint() {
  local debugPrint=false;
  echo "$debugPrint";
}

getDefaultEnableOutput() {
  local enableOutput=false;
  echo "$enableOutput";
}

tryService() {
  local enableOutput debugPrint;
  local "${@}";

  runSqlCommandLoop \
    descriptiveCommandName="tryService" \
    username="$s_username_sys" password="$s_password_sys_default" role="$s_role_sys" \
    host="$v_host" schema="$s_schema_sys" domain="$v_domain" \
    command="" \
    spoolPath="$F_Container_Workdir_Tmp_TryServiceOutput" \
    enableOutput="$enableOutput" \
    debugPrint="$debugPrint";

  return $?;
}

changePassword() {
  local enableOutput debugPrint;
  local "${@}";

  runSqlCommand \
    descriptiveCommandName="changePassword" \
    username="$s_username_sys" password="$s_password_sys_default" role="$s_role_sys" \
    host="$v_host" schema="$s_schema_sys" domain="$v_domain" \
    command="ALTER USER $s_username_sys IDENTIFIED BY $s_password_sys REPLACE $s_password_sys_default;" \
    spoolPath="$F_Container_Workdir_Tmp_ChangePasswordOutput" \
    enableOutput="$enableOutput" \
    debugPrint="$debugPrint";

  return $?;
}

setup() {
  local enableOutput debugPrint;
  local "${@}";

  enableOutput=true;
  debugPrint=true;

  mkdir -p /home/oracle/oradata/localSqlDeveloper;
  mkdir -p /home/oracle/oradata/ecommerce;

  runSqlCommand \
    descriptiveCommandName="setup" \
    username="$s_username_sys" password="$s_password_sys" role="$s_role_sys" \
    host="$v_host" schema="$s_schema_sys" domain="$v_domain" \
    command="@$P_Container_Workdir/$F_Setup;" \
    spoolPath="$F_Container_Workdir_Tmp_SetupOutput" \
    enableOutput="$enableOutput" \
    debugPrint="$debugPrint";

  return $?;
}

debugSetup() {
  local enableOutput debugPrint;
  local "${@}";

  runSqlCommand \
    descriptiveCommandName="debugSetup" \
    username="$s_username_sys" password="$s_password_sys" role="$s_role_sys" \
    host="$v_host" schema="$s_schema_sys" domain="$v_domain" \
    command="@$P_Container_Workdir/$F_DebugSetup;" \
    spoolPath="$F_Container_Workdir_Tmp_DebugSetupOutput" \
    enableOutput="$enableOutput" \
    debugPrint="$debugPrint";

  return $?;
}

unSetup() {
  local enableOutput debugPrint;
  local "${@}";

  runSqlCommand \
    descriptiveCommandName="unSetup" \
    username="$s_username_sys" password="$s_password_sys" role="$s_role_sys" \
    host="$v_host" schema="$s_schema_sys" domain="$v_domain" \
    command="@$P_Container_Workdir/$F_UnSetup;" \
    spoolPath="$F_Container_Workdir_Tmp_unSetup" \
    enableOutput="$enableOutput" \
    debugPrint="$debugPrint";

  return $?;
}

ecommerce() {
  local enableOutput debugPrint;
  local "${@}";

  enableOutput=true;
  debugPrint=true;

  runSqlCommand \
    descriptiveCommandName="ecommerce" \
    username="$s_username_sys" password="$s_password_sys" role="$s_role_sys" \
    host="$v_host" schema="$s_schema_ecommerce_main" domain="$v_domain" \
    command="@$P_Container_Workdir/$F_Ecommerce" \
    spoolPath="$F_Container_Workdir_Tmp_EcommerceOutput" \
    enableOutput="$enableOutput" \
    debugPrint="$debugPrint";

  return $?;
}

removeSecrets() {
  section_info "Remove secrets"

  command_info "rm -f \"$P_Container_Workdir/$F_Secrets\""
  rm -f "$P_Container_Workdir/$F_Secrets";
}

setupContainer() {
  local enableOutput="$(getDefaultEnableOutput)";
  local debugPrint="$(getDefaultDebugPrint)";

  section_info "Configure $v_oracle_db_descriptive_name container - try service"
  tryService enableOutput="$enableOutput" debugPrint="$debugPrint";
  local tryService_result=$?;
  if [[ $tryService_result -ne 0 ]]; then
    return 1;
  fi

  section_info "Configure $v_oracle_db_descriptive_name container - change password"
  changePassword enableOutput="$enableOutput" debugPrint="$debugPrint";
  local changePassword_result=$?;
  if [[ $changePassword_result -ne 0 ]]; then
    return 1;
  fi

  section_info "Configure $v_oracle_db_descriptive_name container - SETUP"
  setup enableOutput="$enableOutput" debugPrint="$debugPrint";
  local setup_statusCode=$?;
  if [[ $setup_statusCode -ne 0 ]]; then
    return 1;
  fi
#
#  section_info "Configure $v_oracle_db_descriptive_name container - debug sql setup script"
#  debugSetup enableOutput="$enableOutput" debugPrint="$debugPrint";
#  local debugSetup_statusCode=$?;
#
#  if [[ $setup_statusCode -ne 0 || $debugSetup_statusCode -ne 0 ]]; then

  section_info "Configure $v_oracle_db_descriptive_name container - run \"ecommerce\" setup"
  ecommerce enableOutput="$enableOutput" debugPrint="$debugPrint";
  local ecommerce_statusCode=$?;
  if [[ $ecommerce_statusCode -ne 0 ]]; then
    return 1;
  fi

  removeSecrets;
}

setupContainer;