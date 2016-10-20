# Mac Development Ansible Playbook

This playbook installs and configures most of the software I use on my Mac for web and software development.

This playbook will be updated throughout my life with various features, functions and roles - but they will always convey the same purpose.

## Installation

  Run the following from the command line, and enter your administrative password when requested.
  
  Note that initially you'll need to install xcode command line tools before you can proceed.
  
  1. `xcode-select --install`
  2. `curl https://raw.githubusercontent.com/fubarhouse/mac-dev-playbook/master/install.sh | bash` 

## Included Applications / Configuration

Applications (installed with Homebrew Cask):

  - adobe-creative-cloud
  - ccleaner
  - dropbox
  - filezilla
  - firefoxdeveloperedition
  - gitkraken
  - google-chrome
  - google-drive
  - google-hangouts
  - iterm2
  - jetbrains-toolbox
  - kodi
  - steam
  - sublime-text
  - teamviewer
  - tower
  - vagrant
  - virtualbox
  - vlc

Packages (installed with Homebrew):

  - ansible
  - dockutil
  - git
  - go
  - gpg
  - python
  - sqlite
  - mcrypt
  - mysql
  - npm
  - nvm
  - php56
  - php56-mcrypt
  - php56-xdebug
  - ssh-copy-id
  - cowsay
  - ios-sim
  - readline
  - subversion
  - openssl
  - drush
  - wget
  
This playbook supports Mac Apple Store products, but none are currently a part of automation.

My [dotfiles](https://github.com/fubarhouse/mac-dev-playbook-dotfiles) are also installed into the current user's home directory.

## Ansible for DevOps

Check out [Ansible for DevOps](http://www.ansiblefordevops.com/), which will teach you how to do some other amazing things with Ansible.

## Special thanks

[Jeff Geerling](http://jeffgeerling.com/) for creating the amazing [mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook).

## Authors/Contributors

[Karl Hepworth](http://twitter.com/fubarhouse), Making this fork more personalized.

[Jeff Geerling](http://jeffgeerling.com/), 2014 (originally inspired by [MWGriffin/ansible-playbooks](https://github.com/MWGriffin/ansible-playbooks)).
