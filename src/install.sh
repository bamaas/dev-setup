#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

PLAYBOOK=${1:-setup.yaml}
dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

test -f "${dir}/${PLAYBOOK}" || { echo "Playbook not found: ${PLAYBOOK}"; exit 1; }

if [ "$(uname)" == "Darwin" ]; then
	${dir}/macos.sh || exit 1
else
	${dir}/linux.sh || exit 1
fi

ansible-galaxy install -r ${dir}/requirements.yaml

run="ansible-playbook ${dir}/${PLAYBOOK}.yaml -vvv"
# Ask for sudo password if not running on macOS
if [ "$(uname)" != "Darwin" ]; then
	run="${run} --ask-become-pass"
fi
# Ask for sudo password if running on macOS and not in Azure Pipelines
if [ "$(uname)" == "Darwin" ] && [ -z "${BUILD_BUILDID:-}" ]; then
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
