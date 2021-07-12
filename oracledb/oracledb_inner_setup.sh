#!/bin/bash

source oracledb_inner_entrypoint.sh

section_info "Configure ORACLE Database container - try service"

command_info "$SETUP_TRY_SERVICE_PATH"
$TRY_SERVICE_SCRIPT_PATH

section_info "Configure ORACLE Database container - change password"
$CHANGE_SYS_PASSWORD_FROM_DEFAULT_SCRIPT_PATH

section_info "Configure ORACLE Database container - run sql setup"
$SQL_SETUP_SCRIPT_PATH