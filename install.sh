#!/bin/bash

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

# Get Username for Mac Store
read -rp "Mac Store Email: " APPSTOREEMAIL;
# Get Password for Mac Store
read -srp "Mac Store Password: " APPSTOREPASSWORD;
echo "";

if [[ ! "${APPSTOREEMAIL}" == '' ]] && [[ ! "${APPSTOREPASSWORD}" ]]; then
    EXTRAVARS="--extra-vars \"app_store_email=${APPSTOREEMAIL} app_store_password=${APPSTOREPASSWORD}\"";
else
    EXTRAVARS="";
fi

cd "/Users/${WHOAMI}/.setup/";
echo "Installing requirements";
ansible-galaxy install -r ./requirements.yml;
echo "Initiating playbook";
ansible-playbook ./main.yml -i inventory -U $(whoami) --ask-sudo-pass "${EXTRAVARS}";
cd "/Users/${WHOAMI}";

if [[ -d "/Users/${WHOAMI}/.setup" ]]; then
    echo "Removing playbook";
    rm -rf "/Users/${WHOAMI}/.setup" > /dev/null;
fi
