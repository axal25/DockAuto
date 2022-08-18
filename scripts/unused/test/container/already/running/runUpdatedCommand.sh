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

  command_info "docker cp $F_S_I_Oracledb_DebugSetup $v_oracle_db_container_name:$P_Container_Workdir"
  docker cp "$F_S_I_Oracledb_DebugSetup" "$v_oracle_db_container_name:$P_Container_Workdir"
}

runContainerScripts() {

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
                                                                         && setup\""
  docker exec -it "$v_oracle_db_container_name" bash -c "source /home/oracle/.bashrc \
                                                         && source $F_Entrypoint \
                                                         && source $F_SetupContainer \
                                                         && setup";

  command_info "docker exec -it $v_oracle_db_container_name bash -c \"source /home/oracle/.bashrc \\
                                                                         && source $F_Entrypoint \\
                                                                         && source $F_SetupContainer \\
                                                                         && runDebugSetupSqlScript\""
  docker exec -it "$v_oracle_db_container_name" bash -c "source /home/oracle/.bashrc \
                                                         && source $F_Entrypoint \
                                                         && source $F_SetupContainer \
                                                         && runDebugSetupSqlScript";

  command_info "docker exec -it $v_oracle_db_container_name bash -c \"source /home/oracle/.bashrc \\
                                                                         && source $F_Entrypoint \\
                                                                         && source $F_SetupContainer \\
                                                                         && runUnSetupSqlScript\""
  docker exec -it "$v_oracle_db_container_name" bash -c "source /home/oracle/.bashrc \
                                                           && source $F_Entrypoint \
                                                           && source $F_SetupContainer \
                                                           && runUnSetupSqlScript";
}

runUpdatedCommand() {
  clear;
  echo "runUpdatedCommand";
  entryPoint;
  updateContainerFiles;
  runContainerScripts;
}

runUpdatedCommand;