#!/bin/bash

# To execute run:
. <( https://raw.githubusercontent.com/igormorgado/dotfiles/master/bin/startenv.sh )

# Install packages
PACKAGES="
vim
mc
exuberant-ctags
git
build-essential
"
sudo apt-get update
sudo apt-get -y -f --force-yes install ${PACKAGES}


# git clone dotfiles at $HOME
if [ ! -d "${HOME}/dotfiles" ]; then
	pushd ${HOME}
	git clone https://github.com/igormorgado/dotfiles
	popd
fi

# dotinst bash vim
pushd ${HOME}/dotfiles
./dotinst bash
./dotinst vim
popd

# Vim install plugins
vim -c "PlugInstall | qa"

# Load congfigs
source ${HOME}/.bashrc

