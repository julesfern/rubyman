#!/bin/bash

# installs the specified ruby version
function rubyman_ruby_install {
	local ruby_major=$1
	local ruby_minor=$2
	local patch_level=$3
	local version="ruby-$1.$2-p$patch_level"
	local url="ftp://ftp.ruby-lang.org/pub/ruby/$ruby_major/$version.tar.gz"

	echo "Installing Ruby ${version} into the '${RUBYMAN_ACTIVE_PROFILE}' profile"
	
	rubyman_enter_source_install
	
	rubyman_utils_fetch_remote ${url} "${version}.tar.gz"
	
	tar xzf ${version}.tar.gz
	cd ${version}

	./configure --prefix="${RUBYMAN_ACTIVE_PROFILE_DIR}" --enable-shared
	make
	make install
	
	rubyman_exit_source_install
}

# installs the specified jruby version
function rubyman_jruby_install {
	local version=$1
	
	echo "Installing jRuby ${version} ..."
}

