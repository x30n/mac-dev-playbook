#!/bin/bash

if [[ -z $(which ansible) ]]; then
    echo "Install PIP";
    sudo easy_install pip;
    echo "Install Ansible";
    sudo pip install ansible;
    echo "Make Ansible directory and set permissions.";
    sudo mkdir -p /etc/ansible
    sudo chown -R $(whoami) /etc/ansible
    echo "Make Brew directory and set permissions.";
    sudo mkdir -p /usr/local
    sudo chown -R $(whoami) /etc/ansible
fi

ansible-galaxy install -r requirements.yml
ansible-playbook main.yml -i inventory -U $(whoami) --ask-sudo-pass