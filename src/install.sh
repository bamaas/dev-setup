#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
alias sudo="sudo -E"

PLAYBOOK=${1:-setup.yaml}
# dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
dir="$(dirname "$(realpath "$0")")"



# Install sudo if running inside a docker container
if [[ -f "/.dockerenv" ]] || [[ "${DOCKER_BUILD}" == "true" ]]
then
	apt-get update
	apt-get install sudo -y
fi

# Create user 'desls' if not exists
if [[ $(whoami) == root ]]
then
	# echo You should not be root to run this.
	# echo If you want to create a user, type 'y' to continue, else 'n' to exit
	# read -r answer
	# if [[ ${answer} != 'y' ]]
	# then
	# 	exit
	# fi
	# read -r -p 'new username: ' newuser
	# read -r -s -p 'new password: ' password1
	# echo
	# read -r -s -p 'new password (again): ' password2
	# if [[ "${password1}" != "${password2}" ]]
	# then
	# 	echo
	# 	echo "Passwords don't match, exiting"
	# 	exit 1
	# fi
	# if grep -w "^${newuser}" /etc/passwd
	# then
	# 	echo "user ${newuser} already created"
	# 	echo "please re-run after running 'su - <newuser>'"
	# 	exit 1
	# fi

	newuser="bas"
	password="bas123"

	useradd -m -s /bin/bash "${newuser}"
	echo "${newuser}:${password}" | chpasswd
	echo "${newuser} ALL=(ALL) NOPASSWD:ALL" | sudo EDITOR='tee -a' visudo
	sudo -u "${newuser}" "$(realpath $0)"
	sudo su - "${newuser}"
	exit $?
fi

# # Disallow root, unless in a docker container.
# if [[ ! -f "/.dockerenv" ]] && [[ $(whoami) == root ]] && [[ "${DOCKER_BUILD}" != "true" ]]
# then
# 	echo You should not be root to run this.
# 	echo If you want to create a user, type 'y' to continue, else 'n' to exit
# 	read -r answer
# 	if [[ ${answer} != 'y' ]]
# 	then
# 		exit
# 	fi
# 	read -r -p 'new username: ' newuser
# 	read -r -s -p 'new password: ' password1
# 	echo
# 	read -r -s -p 'new password (again): ' password2
# 	if [[ "${password1}" != "${password2}" ]]
# 	then
# 		echo
# 		echo "Passwords don't match, exiting"
# 		exit 1
# 	fi
# 	if grep -w "^${newuser}" /etc/passwd
# 	then
# 		echo "user ${newuser} already created"
# 		echo "please re-run after running 'su - <newuser>'"
# 		exit 1
# 	fi
# 	useradd -m -s /bin/bash "${newuser}"
# 	echo "${newuser}:${password1}" | chpasswd
# 	echo "${newuser} ALL=(ALL) NOPASSWD:ALL" | sudo EDITOR='tee -a' visudo
# 	sudo -u "${newuser}" "./$0"
# 	sudo su - "${newuser}"
# 	exit $?
# fi

# TODO: move this to ansible
sudo apt-get install -y language-pack-en
sudo update-locale

# Clean up
sudo rm -rf /var/lib/apt/lists/partial/*

# Address issue with apt update failed because certificate verification
sudo apt-get install ca-certificates -y
sudo apt-get update

# Install prerequisites for Ansible
sudo apt-get install -y python3-pip
sudo pip3 install --upgrade pip
sudo pip3 install ansible==2.9.17 Jinja2==3.0 --no-cache-dir

# Install ansible requirements
ansible-galaxy install -r $(realpath "${dir}")/requirements.yaml

# Run ansible playbook
run="ansible-playbook $(realpath "${dir}")/${PLAYBOOK} -vvv --become"
# # Ask for sudo password if not running on macOS
# if [ "$(uname)" != "Darwin" ]; then
# 	run="${run} --ask-become-pass"
# fi
# # Ask for sudo password if running on macOS and not in Azure Pipelines
# if [ "$(uname)" == "Darwin" ] && [ -z "${BUILD_BUILDID:-}" ]; then
#     run="${run} --ask-become-pass"
# fi
${run}
ansible_exit_code=$?

# Colors
red="\e[0;91m"
green="\e[0;92m"
reset="\e[0m"

# Create man pages
yes | sudo unminimize
sudo apt install man-db -y

if [ ${ansible_exit_code} -eq 0 ]; then
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
