#!/bin/bash

if [[ -z $(which brew) ]]; then
  echo "Installing Homebrew...";
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" > /dev/null;
else
  echo "found brew";
fi

if [[ -z $(which ansible) ]]; then
    echo "Installing Ansible";
    brew install ansible > /dev/null;
else
  echo "found ansible";
fi

rm -rf ~/Documents/dotfiles > /dev/null;
rm -rf ~/.setup > /dev/null;

git clone git@github.com:fubarhouse/mac-dev-playbook.git ~/.setup > /dev/null;
git clone git@github.com:fubarhouse/mac-dev-playbook-dotfiles.git ~/Documents/dotfiles > /dev/null;

cd ~/.setup/;
ansible-galaxy install -r ./requirements.yml > /dev/null;
ansible-playbook ./main.yml -i inventory -U $(whoami) --ask-sudo-pass;
cd ~;

rm -rf ~/Documents/dotfiles  > /dev/null;
rm -rf ~/.setup > /dev/null;