#!/bin/bash

if [[ -z $(which brew) ]]; then
  echo "Installing Homebrew...";
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" > /dev/null;
fi

if [[ -z $(which ansible) ]]; then
    echo "Installing Ansible";
    brew install ansible > /dev/null;
fi

rm -rf ~/Documents/dotfiles > /dev/null;
rm -rf ~/.setup > /dev/null;

git clone git@github.com:fubarhouse/mac-dev-playbook.git ~/.setup > /dev/null;
git clone git@github.com:fubarhouse/mac-dev-playbook-dotfiles.git ~/Documents/dotfiles > /dev/null;

ansible-galaxy install -r ~/.setup/requirements.yml > /dev/null;
ansible-playbook ~/.setup/main.yml -i inventory -U $(whoami) --ask-sudo-pass > /dev/null;

rm -rf ~/Documents/dotfiles  > /dev/null;
rm -rf ~/.setup > /dev/null;