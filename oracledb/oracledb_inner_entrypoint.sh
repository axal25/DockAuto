#!/bin/sh

source ./common_outer_shell_functions.sh

command_info "source oracledb_outer_vars.env"
source ./oracledb_outer_vars.env

command_info "source oracledb_inner_vars.env"
source ./oracledb_inner_vars.env

command_info "source oracledb_inner_users.env"
source ./oracledb_inner_users.env

command_info "source oracledb_inner_paths.env"
source ./oracledb_inner_paths.env

# Then run the CMD
exec "$@"