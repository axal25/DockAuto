#!/bin/bash

source "$F_Entrypoint"

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

runSqlSetupScript() {
  local enableOutput debugPrint;
  local "${@}";

  runSqlCommand \
    descriptiveCommandName="runSqlSetupScript" \
    username="$s_username_sys" password="$s_password_sys" role="$s_role_sys" \
    host="$v_host" schema="$s_schema_sys" domain="$v_domain" \
    command="@$P_Container_Workdir/$F_Setup;" \
    spoolPath="$F_Container_Workdir_Tmp_RunSqlSetupScript" \
    enableOutput="$enableOutput" \
    debugPrint="$debugPrint";

  return $?;
}

runDebugSqlSetupScript() {
  local enableOutput debugPrint;
  local "${@}";

  runSqlCommand \
    descriptiveCommandName="runDebugSqlSetupScript" \
    username="$s_username_sys" password="$s_password_sys" role="$s_role_sys" \
    host="$v_host" schema="$s_schema_sys" domain="$v_domain" \
    command="@$P_Container_Workdir/$F_Debug;" \
    spoolPath="$F_Container_Workdir_Tmp_VerifySqlSetupScript" \
    enableOutput="$enableOutput" \
    debugPrint="$debugPrint";

  return $?;
}

runSqlUnSetupScript() {
  local enableOutput debugPrint;
  local "${@}";

  runSqlCommand \
    descriptiveCommandName="runSqlUnSetupScript" \
    username="$s_username_sys" password="$s_password_sys" role="$s_role_sys" \
    host="$v_host" schema="$s_schema_sys" domain="$v_domain" \
    command="@$P_Container_Workdir/$F_UnSetup;" \
    spoolPath="$F_Container_Workdir_Tmp_RunSqlUnSetupScript" \
    enableOutput="$enableOutput" \
    debugPrint="$debugPrint";

  return $?;
}

removeSecrets() {
  section_info "Remove secrets"

  command_info "rm -f \"$P_Container_Workdir/$F_Secrets\""
  rm -f "$P_Container_Workdir/$F_Secrets";
}

getDefaultDebugPrint() {
  local debugPrint=false;
  echo "$debugPrint";
}

getDefaultEnableOutput() {
  local enableOutput=false;
  echo "$enableOutput";
}

setupContainer() {
  local enableOutput="$(getDefaultEnableOutput)";
  local debugPrint="$(getDefaultDebugPrint)";

  section_info "Configure $v_oracle_db_descriptive_name container - try service"
  tryService enableOutput="$enableOutput" debugPrint="$debugPrint";

  section_info "Configure $v_oracle_db_descriptive_name container - change password"
  changePassword enableOutput="$enableOutput" debugPrint="$debugPrint";

  section_info "Configure $v_oracle_db_descriptive_name container - run sql setup script"
  runSqlSetupScript enableOutput="$enableOutput" debugPrint="$debugPrint";

  local runSqlSetupScript_statusCode=$?;

  section_info "Configure $v_oracle_db_descriptive_name container - debug sql setup script"
  runDebugSqlSetupScript enableOutput="$enableOutput" debugPrint="$debugPrint";

  local runDebugSqlSetupScript_statusCode=$?;

  if [[ $runSqlSetupScript_statusCode -ne 0 || $runDebugSqlSetupScript_statusCode -ne 0 ]]; then
    command_info "Something went wrong during sql setup script";
  else
    command_info "Sql setup script ended successfully"
  fi

  removeSecrets;
}

setupContainer;