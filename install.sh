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

git clone git@github.com:fubarhouse/mac-dev-playbook.git "/Users/${WHOAMI}/.setup" > /dev/null;
git clone git@github.com:fubarhouse/mac-dev-playbook-dotfiles.git "/Users/${WHOAMI}/Documents/dotfiles" > /dev/null;

cd "/Users/${WHOAMI}/.setup/";
ansible-galaxy install -r ./requirements.yml > /dev/null;
ansible-playbook ./main.yml -i inventory -U $(whoami) --ask-sudo-pass;
cd "/Users/${WHOAMI}";

if [[ -d "/Users/${WHOAMI}/.setup" ]]; then
    echo "Removing playbook";
    rm -rf "/Users/${WHOAMI}/.setup" > /dev/null;
fi