#!/bin/bash

# To execute run:
# . <( curl -s https://raw.githubusercontent.com/igormorgado/dotfiles/master/bin/startenv.sh )

# Install packages
PACKAGES="
autoconf
autogen
automake
autopoint
build-essential
cmake
cvs
exuberant-ctags
fdupes
git
git
libtool
m4
make
mc
mercurial
pkg-config
python3-pip
subversion
vim
virtualenv
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

