#!/bin/bash

preBuildImage() {
  local copyFilesTargetPath copyFilesArrayName;
  local "${@}";

  local -n copyFilesArray="$copyFilesArrayName"; # nameref

  mkdir -p "$copyFilesTargetPath";

  for fileToCopy in "${copyFilesArray[@]}"; do
    cp -R "$fileToCopy" "$copyFilesTargetPath";
  done
}

postBuildImage() {
  local copyFilesTargetPath;
  local "${@}";

  rm -R "$copyFilesTargetPath";
}

buildImage() {
  local descriptiveDockerName;
  local imageName;
  local copyFilesTargetPath copyFilesArrayName;
  local buildArgsFilePath dockerFilePath;
  local "${@}";

  section_info "Build new $descriptiveDockerName image - $imageName";

  command_info "docker login";
  docker login;

  command_info "Prepare to build $descriptiveDockerName image - $imageName";
  preBuildImage copyFilesTargetPath="$copyFilesTargetPath" copyFilesArrayName="$copyFilesArrayName";

  command_info "Build $descriptiveDockerName image - $imageName";
  docker build --no-cache $(get_build_args_exp "$buildArgsFilePath") "$dockerFilePath" -t "$imageName";

  command_info "Clean up after building $descriptiveDockerName image - $imageName";
  postBuildImage copyFilesTargetPath="$copyFilesTargetPath";
}