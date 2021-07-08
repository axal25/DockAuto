#!/bin/bash

cd /oracledb/setup/

source common_outer_shell_functions.sh

section_info "Configure ORACLE Database container - try service"
./oracledb_inner_run_try_service.sh

section_info "Configure ORACLE Database container - change password"
./oracledb_inner_run_change_sys_password_from_default.sh

section_info "Configure ORACLE Database container - run setup"
./oracledb_inner_run_setup.sh

section_info "Configure ORACLE Database container - not yet working"
./oracledb_inner_run_TO_DO.sh