#!/bin/bash

set -o errexit
set -o nounset

dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ "$(uname)" == "Darwin" ]; then
	${dir}/macos.sh
else
	${dir}/linux.sh
fi

ansible-galaxy install -r ${dir}/requirements.yaml

# TODO: build in a check if not running in a pipeline and darwin append --ask-become-pass
run="ansible-playbook ${dir}/setup.yml -vvv"
if [ "$(uname)" != "Darwin" ]; then
	run="${run} --ask-become-pass"
fi
${run}

# Colors
red="\e[0;91m"
green="\e[0;92m"
reset="\e[0m"

if [ $? -eq 0 ]; then
	echo "---------------------------------------------------------------------"
	printf "${green}DONE: installed successfully.${reset}\n"
	printf "${green}Please logout and log back in for every change to take effect.${reset}\n"
	echo "---------------------------------------------------------------------"
	exit 0
else
	echo "---------------------------------------------------------------------"
    printf "${red}ERROR: not everything installed successfully.${reset}\n"
	printf "${red}Please check the above error logs.${reset}\n"
	echo "---------------------------------------------------------------------"
    exit 1
fi
