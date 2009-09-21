#!/bin/bash

function rubyman_rubygems_install {
	local major=$1
	local minor=$2
	local package="rubygems-$1.$2.tgz"
	
	echo "Installing RubyGems ${version} into the '${RUBYMAN_ACTIVE_PROFILE}' profile"
	
	rubyman_enter_source_install
	
	rubyman_utils_fetch_remote "http://rubyforge.org/frs/download.php/60718/$package" "$package"
	
	tar xzf $package
	cd rubygems*
	
	ruby setup.rb
	
	rubyman_exit_source_install
}