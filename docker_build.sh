#!/bin/bash
script_dir=$(cd $(dirname $0);pwd)

# Config
# version_map[<branch_name>]=<docker_image_name>
declare -A version_map
version_map["develop_v1.14.x"]="px4io/px4-dev-nuttx-focal:2023-12-04"

# Set parameters
DOCEKR_NAME=NxtCompileContainer;
DOCKER_IMAGE_VERSION="";
VOLUME_PATH="";
set_param(){
  DOCKER_IMAGE_VERSION=${version_map[$1]}
  echo "Docker image version: ${DOCKER_IMAGE_VERSION}"
}

# Git functions
switch_branch(){
  cd $script_dir/PX4-Autopilot

  # Check if branch exists
  if git branch --list | grep -q "$1"; then
  echo "Branch $1 exists"
  else
    echo "Branch $1 does not exist"
  fi

  # Switch branch
  echo "Warning: this will remove all changes including untracked files"
  read -p "Confirm?(Y/N)" ans

  if [[ "$ans" == [Yy] ]]; then
    echo "Confirmed"
    git checkout -f $1
    git clean -xdf -f
    git submodule update --recursive
    git submodule foreach --recursive git fetch --all
    git submodule foreach --recursive git reset --hard
    git submodule foreach --recursive git clean -fdx -f

    echo "Successfully switched to branch $1"
  else
    echo "Canceled"
    exit 1
  fi
}

# Docker functions
pull_docker(){
  docker pull "${DOCKER_IMAGE_VERSION}"
}

check_image(){
  docker_image_exist=$(docker images ${DOCKER_IMAGE_VERSION})
  if [ -n "$docker_image_exist" ]
  then
    echo "Docker image is downloaded will build the containter"
    return 0
  else
    echo "erro: Docker images need to be downloaded"
    return 1
  fi
}

stop_container(){
  docker stop ${DOCEKR_NAME}
}

start_containter(){
  docker start ${DOCEKR_NAME}
}

build_frameware(){
  docker exec ${DOCEKR_NAME} bash -c "cd /src/NxtPX4/PX4-Autopilot; make clean ; make $1; chmod 777 -R /src/NxtPX4/PX4-Autopilot"
  stop_container
}

build_run_container(){
  # check mount dir
  VOLUME_PATH=$script_dir;
  echo "Mount ${VOLUME_PATH} to docker:/src/NxtPX4/ "
  if [ ! -d $VOLUME_PATH ]
    then
      echo "Path: ${VOLUME_PATH} is not NxtPX4 repo please run this script under xxx/NxtPX4/PX4-Autopilot/"
  fi

  docker run --rm -dit --privileged \
  --env=LOCAL_USER_ID="$(id -u)" \
  -v ${VOLUME_PATH}:/src/NxtPX4/:rw \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -e DISPLAY=:0 \
  -p 14556:14556/udp \
  --name=${DOCEKR_NAME} ${DOCKER_IMAGE_VERSION}
  return 0
}

help(){
  echo "Usage:    ./docker_build.sh <branch_name> <frameware_name>"
  echo "Example:  ./docker_build.sh develop_v1.14.x hkust_nxt-v1"
  echo "          ./docker_build.sh develop_v1.14.x hkust_nxt-v1_bootloader"
}

check_docker(){
  echo "Check Docker......"
  docker -v
  if [ $? -ne 0 ]
    then
      echo "Install docker using the following command:"
      echo "curl -sSL https://get.daocloud.io/docker | sh"
      exit 1
  fi
}

main(){
  switch_branch $1
  set_param $1
  check_docker
  docker_exist=$(docker ps -a|grep ${DOCEKR_NAME})
  if [ -n "$docker_exist" ]
    then
      echo "Docker container exist start container to compile"
      start_containter
    else
      echo "build run container"
      build_run_container
  fi
  build_frameware $2
}

if [ $# -ne 2 ]
  then
    help
  else
    main $1 $2
fi