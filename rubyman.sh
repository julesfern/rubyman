#!/bin/bash

#export PATH=$PATH:$RUBYMAN_HOME/bin

if [ ! -n "$RUBYMAN_HOME" ]
	then
		export RUBYMAN_HOME="~/.rubyman"
fi

if [ ! -n "$RUBYMAN_TMP" ]
	then
		export RUBYMAN_TMP="${RUBYMAN_HOME}/tmp"
fi

if [ "$RUBYMAN_LOADED_CURRENT" != "true" ]
	then
		rubyman_switch_profile current
		export RUBYMAN_LOADED_CURRENT="true"
fi

function rubyman {

	if [ "$RUBYMAN_IS_ALIVE" != "true" ]
		then
			source $RUBYMAN_HOME/includes/environment.sh
			source $RUBYMAN_HOME/includes/gem.sh
			source $RUBYMAN_HOME/includes/profile.sh
			source $RUBYMAN_HOME/includes/ruby.sh
			source $RUBYMAN_HOME/includes/rubygems.sh
			source $RUBYMAN_HOME/rubyman.sh
			source $RUBYMAN_HOME/includes/utils.sh

			export RUBYMAN_IS_ALIVE="true"
	fi



	
	if [ !$# == 2 ]; then
	  echo "Usage: $0 action options"
	  exit
	fi

	action=$1
	args=("$@")

	case $action in
		create) rubyman_profile_create "${args[@]}";;
		delete) rubyman_profile_delete "${args[@]}";;
		use) rubyman_profile_use "${args[@]}";;
		info) rubyman_profile_info "${args[@]}";;
		update) rubyman_update;;
		install) rubyman_profile_create "${args[@]}";;
		version) rubyman_version;;
	esac
}

function rubyman_version {
	echo "Rubyman 0.0.1"
}

# switches the active profile to one specified
function rubyman_switch_profile {
	local profile=$1
	
	if [ -d "${RUBYMAN_HOME}/profiles/${profile}" ]; then
		echo "Switching profiles to '${profile}'"
	
		export RUBYMAN_ACTIVE_PROFILE="${profile}"
		export RUBYMAN_ACTIVE_PROFILE_DIR="${RUBYMAN_HOME}/profiles/${profile}"
		
		export PATH=$RUBYMAN_ACTIVE_PROFILE_DIR/bin:$PATH
		
		# make current
		if [ $profile != "current" ]; then
			rm -f $RUBYMAN_HOME/profiles/current
			ln -s $RUBYMAN_ACTIVE_PROFILE_DIR $RUBYMAN_HOME/profiles/current
		fi
	else
		echo "The profile '${profile}' does not exist in rubyman"
		#exit 1
	fi
}

function rubyman_update {
	if [ -d "$RUBYMAN_HOME/.git" ]; then
		export RUBYMAN_LAST_DIR=`pwd`
		`pushd $RUBYMAN_HOME`
	
		git pull origin projectman
	
		`pushd $RUBYMAN_LAST_DIR`
		
		echo "Rubyman upto date"
	else
		echo "Requires Rubyman to be installed via Git"
	fi
}

# enters the state for installing from source
function rubyman_enter_source_install {
	rubyman_utils_create_tmp
	
	export RUBYMAN_LAST_DIR=`pwd`
	
	pushd $RUBYMAN_TMP > /dev/null
}

function rubyman_exit_source_install {
	pushd $RUBYMAN_LAST_DIR > /dev/null
	
	rubyman_utils_create_tmp
}