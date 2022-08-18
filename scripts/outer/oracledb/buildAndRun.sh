#!/bin/bash

source "$F_S_O_Oracledb_Entrypoint";

containerConfigure() {
  section_info "Configure $v_oracle_db_descriptive_name container - $v_oracle_db_container_name";

  command_info "docker exec -it $v_oracle_db_container_name bash -c \"source /home/oracle/.bashrc
                                                                      $F_Container_Workdir_SetupContainer\"";

  docker exec -it "$v_oracle_db_container_name" bash -c "source /home/oracle/.bashrc
                                                        $F_Container_Workdir_SetupContainer";
}

buildAndRun() {
  part_info "$v_oracle_db_descriptive_name" "Preparing image and container";

  oracleDbCopyFiles=("$F_S_PrintFunctions");

  removeImageContainerAndLeftovers \
    descriptiveDockerName="$v_oracle_db_descriptive_name" \
    imageName="$v_oracle_db_image_name" containerName="$v_oracle_db_container_name";
  buildImage \
    descriptiveDockerName="$v_oracle_db_descriptive_name" \
    imageName="$v_oracle_db_image_name" \
    copyFilesTargetPath="$P_S_I_Oracledb_Copied" \
    copyFilesArrayName="oracleDbCopyFiles" \
    buildArgsFilePath="$F_S_O_Oracledb_BuildArgs" \
    dockerFilePath="$P_S_I_Oracledb";
  runContainer \
    descriptiveDockerName="$v_oracle_db_descriptive_name" \
    imageName="$v_oracle_db_image_name" containerName="$v_oracle_db_container_name" \
    portsOuterName="v_oracle_db_container_ports_outer" portsInnerName="v_oracle_db_container_ports_inner";
}

buildAndRun;