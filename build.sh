#!/bin/bash

build_path=build
docker_name="ubuntu20.04"
shell_path=$(dirname $(readlink -f "$0"))

docker_run() {
  if [[ -n $(sudo docker ps -q -f "name=${docker_name}") ]];then
    echo "docker exec"
    sudo docker exec -it -w ${shell_path} ${docker_name} /bin/bash
  else
    echo "docker start"
    sudo docker start ${docker_name}
    echo "docker exec"
    sudo docker exec -it -w ${shell_path} ${docker_name} /bin/bash
  fi
}

cmake_build() {
  cmake -B $build_path
  cmake --build $build_path
}

if [ $1 == "cmake" ]
then
  cmake_build
elif [ $1 == "docker" ]
then
  docker_run
else
  echo "没有符合的命令"
fi
