#!/bin/bash

entryPoint() {
  echo "source files.env;"
  source "files.env";

  echo "source $F_S_Entrypoint;"
  source "$F_S_Entrypoint";

  echo "source $F_S_Files;"
  source "$F_S_Files";

  echo "source $F_S_I_Files;"
  source "$F_S_I_Files";

  echo "source $F_S_O_Oracledb_Entrypoint;"
  source "$F_S_O_Oracledb_Entrypoint";

  echo "source $P_S_I_Oracledb/$F_Vars;"
  source "$P_S_I_Oracledb/$F_Vars"

  echo "source $P_S_I_Oracledb/$F_Secrets;"
  source "$P_S_I_Oracledb/$F_Secrets";

  echo "source $P_S_I_Oracledb/$F_RunSqlCommand;"
  source "$P_S_I_Oracledb/$F_RunSqlCommand";
}

updateContainerFiles() {
  command_info "docker cp $F_S_PrintFunctions $v_oracle_db_container_name:$P_Container_Workdir"
  docker cp "$F_S_PrintFunctions" "$v_oracle_db_container_name:$P_Container_Workdir"

  command_info "docker cp $F_S_I_Oracledb_RunSqlCommand $v_oracle_db_container_name:$P_Container_Workdir"
  docker cp "$F_S_I_Oracledb_RunSqlCommand" "$v_oracle_db_container_name:$P_Container_Workdir"

  command_info "docker cp $F_S_I_Oracledb_SetupContainer $v_oracle_db_container_name:$P_Container_Workdir"
  docker cp "$F_S_I_Oracledb_SetupContainer" "$v_oracle_db_container_name:$P_Container_Workdir"

  command_info "docker cp $F_S_I_Oracledb_Setup $v_oracle_db_container_name:$P_Container_Workdir"
  docker cp "$F_S_I_Oracledb_Setup" "$v_oracle_db_container_name:$P_Container_Workdir"

  command_info "docker cp $F_S_I_Oracledb_UnSetup $v_oracle_db_container_name:$P_Container_Workdir"
  docker cp "$F_S_I_Oracledb_UnSetup" "$v_oracle_db_container_name:$P_Container_Workdir"

  command_info "docker cp $F_S_I_Oracledb_Debug $v_oracle_db_container_name:$P_Container_Workdir"
  docker cp "$F_S_I_Oracledb_Debug" "$v_oracle_db_container_name:$P_Container_Workdir"
}

runUpdatedCommand() {
  clear;
  entryPoint;
  updateContainerFiles;

#  command_info "docker exec -it $v_oracle_db_container_name bash -c \"source /home/oracle/.bashrc \\
#                                                                         && source $F_Entrypoint \\
#                                                                         && source $F_SetupContainer \\
#                                                                         && tryService\""
#  docker exec -it "$v_oracle_db_container_name" bash -c "source /home/oracle/.bashrc \
#                                                         && source $F_Entrypoint \
#                                                         && source $F_SetupContainer \
#                                                         && tryService";
#
#  command_info "docker exec -it $v_oracle_db_container_name bash -c \"source /home/oracle/.bashrc \\
#                                                                         && source $F_Entrypoint \\
#                                                                         && source $F_SetupContainer \\
#                                                                         && changePassword\""
#  docker exec -it "$v_oracle_db_container_name" bash -c "source /home/oracle/.bashrc \
#                                                         && source $F_Entrypoint \
#                                                         && source $F_SetupContainer \
#                                                         && changePassword";

  command_info "docker exec -it $v_oracle_db_container_name bash -c \"source /home/oracle/.bashrc \\
                                                                         && source $F_Entrypoint \\
                                                                         && source $F_SetupContainer \\
                                                                         && runSqlSetupScript\""
  docker exec -it "$v_oracle_db_container_name" bash -c "source /home/oracle/.bashrc \
                                                         && source $F_Entrypoint \
                                                         && source $F_SetupContainer \
                                                         && runSqlSetupScript";

  command_info "docker exec -it $v_oracle_db_container_name bash -c \"source /home/oracle/.bashrc \\
                                                                         && source $F_Entrypoint \\
                                                                         && source $F_SetupContainer \\
                                                                         && runDebugSqlSetupScript\""
  docker exec -it "$v_oracle_db_container_name" bash -c "source /home/oracle/.bashrc \
                                                         && source $F_Entrypoint \
                                                         && source $F_SetupContainer \
                                                         && runDebugSqlSetupScript";

  command_info "docker exec -it $v_oracle_db_container_name bash -c \"source /home/oracle/.bashrc \\
                                                                         && source $F_Entrypoint \\
                                                                         && source $F_SetupContainer \\
                                                                         && runSqlUnSetupScript\""
  docker exec -it "$v_oracle_db_container_name" bash -c "source /home/oracle/.bashrc \
                                                           && source $F_Entrypoint \
                                                           && source $F_SetupContainer \
                                                           && runSqlUnSetupScript";
}

runUpdatedCommand;