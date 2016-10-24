#!/bin/bash

# Usage:
# install.sh accout@apple.com password

if [[ -z $(which brew) ]]; then
  echo "Installing Homebrew...";
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" > /dev/null;
fi

if [[ -z $(which ansible) ]]; then
    echo "Installing Ansible";
    brew install ansible > /dev/null;
fi

WHOAMI=$(whoami);

if [[ -d "/Users/${WHOAMI}/Documents/dotfiles" ]]; then
    echo "Removing dotfiles";
    rm -rf "/Users/${WHOAMI}/Documents/dotfiles" > /dev/null;
fi
if [[ -d "/Users/${WHOAMI}/.setup" ]]; then
    echo "Removing playbook";
    rm -rf "/Users/${WHOAMI}/.setup" > /dev/null;
fi

git clone https://github.com/fubarhouse/mac-dev-playbook.git "/Users/${WHOAMI}/.setup" > /dev/null;
git clone https://github.com/fubarhouse/mac-dev-playbook-dotfiles.git "/Users/${WHOAMI}/Documents/dotfiles" > /dev/null;

if [[ -n $1 ]] && [[ -n $2 ]]; then
    EXTRAVARS="app_store_email=${1} app_store_password=${2}";
    echo "user accepted as ${1}";
    echo "pass accepted as ${2}";
else
    EXTRAVARS="a=b";
    echo "user/pass not found."
fi

cd "/Users/${WHOAMI}/.setup/";

# Removing role installation - see https://github.com/ansible/ansible/issues/11266
# echo "Installing requirements";
# ansible-galaxy install ./requirements.yml;

echo "Initiating playbook";

ansible-playbook ./main.yml -i inventory -U $(whoami) --ask-sudo-pass --extra-vars "\"${EXTRAVARS}\"";
cd "/Users/${WHOAMI}";

if [[ -d "/Users/${WHOAMI}/.setup" ]]; then
    echo "Removing playbook";
    rm -rf "/Users/${WHOAMI}/.setup" > /dev/null;
fi