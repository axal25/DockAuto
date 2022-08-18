#!/bin/bash

source "$F_S_O_Tomcatapp_Entrypoint";

containerConfigure() {
  section_info "Configure v_tomcat_app_descriptive_name container - $v_tomcat_app_container_name"

  command_info "docker exec -it $v_tomcat_app_container_name bash -c \"ls\""

  docker exec -it "$v_v_tomcat_app_container_name" bash -c "ls"

  command_info "docker exec -it $v_tomcat_app_container_name bash -c \"source /home/oracle/.bashrc
                                                                    $F_Container_Workdir_SetupContainer\""

  docker exec -it "$v_v_tomcat_app_container_name" bash -c "source /home/oracle/.bashrc
                                                     $F_Container_Workdir_SetupContainer"
}

buildAndRun() {
  part_info "$v_tomcat_app_descriptive_name" "Preparing image and container";

  tomcatAppCopyFiles=("$F_S_PrintFunctions");

  removeImageContainerAndLeftovers \
    descriptiveDockerName="$v_tomcat_app_descriptive_name" \
    imageName="$v_tomcat_app_image_name" \
    containerName="$v_tomcat_app_container_name";
  buildImage \
    descriptiveDockerName="$v_tomcat_app_descriptive_name" \
    imageName="$v_tomcat_app_image_name" \
    copyFilesTargetPath="$P_S_I_Tomcatapp_Copied" \
    copyFilesArrayName="tomcatAppCopyFiles" \
    buildArgsFilePath="$F_S_O_Tomcatapp_BuildArgs" \
    dockerFilePath="$P_S_I_Tomcatapp";
  runContainer \
    descriptiveDockerName="$v_tomcat_app_descriptive_name" \
    imageName="$v_tomcat_app_image_name" containerName="$v_tomcat_app_container_name" \
    portsOuterName="v_tomcat_app_container_ports_outer" portsInnerName="v_tomcat_app_container_ports_inner";
}

buildAndRun;
