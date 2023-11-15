#!/bin/bash

build_path=build
docker_name="env_ede"
shell_path=$(dirname $(readlink -f "$0"))

docker_run() {
  if [[ -n $(docker ps -q -f "name=${docker_name}") ]];then
    echo "docker exec"
    docker exec -it -w ${shell_path} ${docker_name} /bin/bash
  else
    echo "docker start"
    docker start ${docker_name}
    echo "docker exec"
    docker exec -it -w ${shell_path} ${docker_name} /bin/bash
  fi
}

cmake_build() {
  cmake -B $build_path
  cmake --build $build_path
}

binfile="../build/PRO_MCU.bin"
openocd_program() {
  cd tools
  openocd -f openocd-jlink-swd.cfg -c "program $binfile"
  cd ..
}

if [ $1 == "cmake" ]
then
  cmake_build
elif [ $1 == "docker" ]
then
  docker_run
elif [ $1 == "download" ]
then
  openocd_program
else
  echo "没有符合的命令"
fi
