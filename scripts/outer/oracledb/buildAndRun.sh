#!/bin/bash

source "$F_S_O_Oracledb_Entrypoint"

containerConfigure() {
  section_info "Configure $v_oracle_db_descriptive_name container - $v_oracle_db_container_name"

  command_info "docker exec -it $v_oracle_db_container_name bash -c \"source /home/oracle/.bashrc
                                                                    $F_Container_Workdir_SetupContainer\""

  docker exec -it "$v_oracle_db_container_name" bash -c "source /home/oracle/.bashrc
                                                     $F_Container_Workdir_SetupContainer"
}
startContainer() {
  section_info "Run $v_oracle_db_descriptive_name container - $v_oracle_db_container_name | PORTS: $v_oracle_db_container_port_outer:$v_oracle_db_container_port_inner"
  # -e SETUP_DIR_PATH
  docker run -d -p "$v_oracle_db_container_port_outer:$v_oracle_db_container_port_inner" -it --name "$v_oracle_db_container_name" "$v_oracle_db_image_name"
}
buildAndRun() {
  part_info "$v_oracle_db_descriptive_name" "Preparing image and container"

  cleanUp \
    descriptiveDockerName="$v_oracle_db_descriptive_name" \
    imageName="$v_oracle_db_image_name" containerName="$v_oracle_db_container_name";
  buildImage;
  runContainer \
    descriptiveDockerName="$v_oracle_db_descriptive_name" \
    imageName="$v_oracle_db_image_name" containerName="$v_oracle_db_container_name" \
    portOuter="$v_oracle_db_container_port_outer" portInner="$v_oracle_db_container_port_inner";
}

buildAndRun