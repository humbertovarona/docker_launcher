#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
if [[ ! -f "$1" ]]; then
  echo -e "${RED}Error: Configuration file does not exist or is not specified.${NC}"
  exit 1
fi
while IFS= read -r line || [[ -n "$line" ]]; do
  IFS='&' read -r image container_name params command local_dir <<< "$line"
  if [[ -z "$image" || -z "$container_name" || -z "$params" || -z "$local_dir" ]]; then
    echo -e "${RED}Error: Missing fields in line: $line${NC}"
    continue
  fi
  if [[ ! -d "$local_dir" ]]; then
    echo -e "${RED}Error: Directory $local_dir does not exist${NC}"
    continue
  fi
  original_dir=$(pwd)
  cd "$local_dir" || { echo -e "${RED}Error: Could not change to directory $local_dir${NC}"; continue; }
  params_expanded="${params//\$(pwd)/${PWD}}"
  echo -e "${GREEN}Starting container $container_name with image $image in directory $local_dir${NC}"
  if [[ -z "$command" ]]; then
    if eval "docker run -d $params_expanded --name \"$container_name\" \"$image\""; then
      echo -e "${GREEN}Container $container_name started successfully without command.${NC}"
    else
      echo -e "${RED}Error starting container $container_name.${NC}"
    fi
  else
    if eval "docker run -d $params_expanded --name \"$container_name\" \"$image\" $command"; then
      echo -e "${GREEN}Container $container_name started successfully.${NC}"
    else
      echo -e "${RED}Error starting container $container_name.${NC}"
    fi
  fi
  cd "$original_dir" || { echo -e "${RED}Error: Could not return to directory $original_dir${NC}"; exit 1; }
done < "$1"
echo -e "${GREEN}Finished.${NC}"
