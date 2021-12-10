#!/bin/bash

preBuildImage() {
  mkdir -p "$P_S_I_Oracledb_Copied";

  cp -R "$F_S_PrintFunctions" "$P_S_I_Oracledb_Copied";
}

postBuildImage() {
  rm -R "$P_S_I_Oracledb_Copied";
}

buildImage() {
  section_info "Build new $v_oracle_db_descriptive_name image - $v_oracle_db_image_name";

  command_info "docker login";
  docker login;

  command_info "Prepare to build $v_oracle_db_descriptive_name image - $v_oracle_db_image_name";
  preBuildImage;

  command_info "Build $v_oracle_db_descriptive_name image - $v_oracle_db_image_name";
  docker build --no-cache $(get_build_args_exp "$F_S_O_Oracledb_BuildArgs") "$P_S_I_Oracledb" -t "$v_oracle_db_image_name";

  command_info "Clean up after building $v_oracle_db_descriptive_name image - $v_oracle_db_image_name";
  postBuildImage;
}