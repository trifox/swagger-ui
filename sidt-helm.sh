#!/usr/bin/env bash

log(){
	echo "[$(date +"%Y-%m-%d %H:%M:%S")] $@"
}

log ""
log "SIDT HELM - Service Infrastructure Debug Test"
log ""


THIS_APP_AREAS=(componenttest componenttest-e2e-selenium)
THIS_APP_SERVICES=(dependencies service )

TEST=0
MAKE=0
INFO=1

help() {
  echo " "
  echo " SIDT Helm"
  echo " "
  echo " ./sidt-helm.sh [options] "
  echo " "
  echo " Helm control for sidt organised stacks, use to build and test your suite. Control Starting and stopping indivudally using sidt.sh"
  echo " Options:"
  echo "   -h           Show this help"
  echo "   -i           Show info about apps/areas"
  echo "   -t           Test all areas"
  echo "   -m           Make all Applications/Services/Dockerfiles"
  echo ""
  echo " Default behavior: Creates all Services and Executes all Areas "
  echo ""
  echo " (author) author: ck@froso.de"
}

while getopts 'ihtmk' OPTION; do
  case $OPTION in

    m)
    	log "Make flag found -m creating application Dockerfiles"
        MAKE=1
    ;;
 m)
    	log "Info flag found -i printing stats of found apps and area stacks"
        INFO=1
    ;;

    t)
    	log "Test flag -t found, starting tests for all areas"
        TEST=1
    ;;
    h)
        help
        exit 0
    ;;

  esac
done

# Make
#
# Executes a full stack create, test and optional teardown
#
makeApplication(){


  log "Making application $1"
./sidt.sh -m $1
}

#
# Executes a full stack create, test and optional teardown
#
executeStack(){

  log "Deleting test report folders $(pwd)/${1}/robot/report"
  rm -rf $(pwd)/${1}/robot/report


  log "Executing Test $1"
#  Bring up Stack detached in background, but recreate docker-compose
  ./sidt.sh -a $1 -d all
  ./sidt.sh -a $1 -u all  -c
  ./sidt.sh -a $1 -s all  -c
#  Execute the test in foreground
  ./sidt.sh -a $1 -u test -b
#  Teardown
  ./sidt.sh -a $1 -d all
}

findStacks(){

  SERVICES=()

  log "Available Stacks"
  cd stacks
  for i in *;
  do # Whitespace-safe but not recursive.
    #    echo "musi $i"

    SERVICES+=("$i")
  done

  # echo "FOUND: [${SERVICES[*]} "

  for areaCandidate in "${SERVICES[@]}"
  do

    if [  -d ${areaCandidate} ]; then
    log "sidt.sh -a -> ${areaCandidate}"
    else
    log "WANING: not suitable ${areaCandidate}"
    fi
  done
  cd ..
}
findAreas(){

  SERVICES=()

  log ""
  log "Available Areas"
  log ""
  cd stacks
  for i in *;
  do # Whitespace-safe but not recursive.
    #    echo "musi $i"

    SERVICES+=("$i")
  done

  # echo "FOUND: [${SERVICES[*]} "

  for areaCandidate in "${SERVICES[@]}"
  do

    if [  -d ${areaCandidate} ]; then
    log sidt.sh "-a ${areaCandidate}"
    else
    log "WANING: not suitable ${areaCandidate}"
    fi
  done
  cd ..
}
findServices(){

  SERVICES=( Dockerfile)

  log ""
  log "Available Applications"
  log ""
  for i in Dockerfile.*; do # Whitespace-safe but not recursive.
    SERVICES+=("$i")
  done

  # echo "FOUND: [${SERVICES[*]} "
  for dockerFilename in "${SERVICES[@]}"
  do
    if [ -f "${dockerFilename}" ]; then
    if [  "${dockerFilename}" == "Dockerfile" ]; then

      VALUE="service"
     else
        VALUE=${dockerFilename//Dockerfile\./}
      fi
      log "sidt.sh -m ${VALUE} "

    else
    log "WANING: NOT FOUND: ${dockerFilename}"
    fi
  done
}


if [ "${MAKE}" -eq "1" ];then
log "Executing Make for all Applications ${THIS_APP_SERVICES[@]}"
for app_name in "${THIS_APP_SERVICES[@]}"
do
  makeApplication  ${app_name}
done
fi

if [ "${TEST}" -eq "1" ];then
log "Executing Tests for all areas ${THIS_APP_AREAS[@]}"
for area_name in "${THIS_APP_AREAS[@]}"
do
  executeStack  ${area_name}
done
fi



if [ "${INFO}" -eq "1" ];then
findAreas
findServices

fi
