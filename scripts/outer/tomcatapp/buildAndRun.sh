#!/bin/bash

source "$F_S_O_Tomcatapp_Entrypoint"

preBuildImage() {
  mkdir -p "$P_S_I_Tomcatapp_Copied";

  cp -R "$F_S_PrintFunctions" "$P_S_I_Tomcatapp_Copied";
}

postBuildImage() {
  rm -R "$P_S_I_Tomcatapp_Copied";
}

buildImage() {
  section_info "Build new $v_tomcat_app_descriptive_name image - $v_tomcat_app_image_name";

  command_info "Prepare to build $v_tomcat_app_descriptive_name image - $v_tomcat_app_image_name";
  preBuildImage;

  command_info "Build $v_tomcat_app_descriptive_name image - $v_tomcat_app_image_name";
  docker build --no-cache $(get_build_args_exp "$F_S_O_Tomcatapp_BuildArgs") "$P_S_I_Tomcatapp" -t $v_tomcat_app_image_name;

  command_info "Clean up after building $v_tomcat_app_descriptive_name image - $v_tomcat_app_image_name";
  postBuildImage;
}

runContainer() {
  section_info "Run $v_tomcat_app_descriptive_name container - $v_tomcat_app_container_name | PORTS: $v_tomcat_app_container_port_outer:$v_tomcat_app_container_port_inner";
  docker run -p "$v_tomcat_app_container_port_outer:$v_tomcat_app_container_port_inner" -it --name $v_tomcat_app_container_name $v_tomcat_app_image_name;
}

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

  cleanUp \
    descriptiveDockerName="$v_tomcat_app_descriptive_name" \
    imageName="$v_tomcat_app_image_name" \
    containerName="$v_tomcat_app_container_name";
  buildImage;
  runContainer;
  containerConfigure;
}

buildAndRun;
