#!/bin/bash

install_path=$1

if [ ! -n "$install_path" ]; then
	install_path=~/.rubyman
else
	echo "export $RUBYMAN_HOME=$install_path" >> ~/.bash_profile
fi

echo "Installing Rubyman to $install_path"

mkdir -p "$install_path"

# move files to install_path
mv includes/ "$install_path/"

if [ -d ".git" ]; then
	mv .git "$install_path/"
fi

# load rubyman.sh into the profile
echo "source $install_path/rubyman.sh" >> ~/.bash_profile

# load rubyman into the current shell
source $install_path/rubyman.sh
