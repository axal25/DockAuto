#!/bin/bash

removeImageContainerAndLeftovers() {
  local descriptiveDockerName;
  local imageName containerName;
  local "${@}";

  section_info "Clean up previous docker image, container"

  command_info "Stop $descriptiveDockerName container - $containerName"
  docker stop "$containerName" > /dev/null 2>&1

  command_info "Remove $descriptiveDockerName container - $containerName"
  docker container rm "$containerName" > /dev/null 2>&1

  command_info "Remove $descriptiveDockerName image - $imageName"
  docker image rm "$imageName" > /dev/null 2>&1

  command_info "Remove unused (stopped) containers, unused (optionally) volumes, unused networks, (dangling and unreferenced) images"
  # docker network prune -f
  # docker container prune -f
  # docker volume prune -f
  # docker image prune -f -a
  docker system prune -f --volumes > /dev/null 2>&1
}