#!/bin/bash

alias rbm="rubyman"

# the main rubyman function
function rubyman {	
	if [ ! -n "$RUBYMAN_HOME" ]
		then
			export RUBYMAN_HOME="~/.rubyman"
	fi
	
	if [ ! -n "$RUBYMAN_TMP" ]
		then
			export RUBYMAN_TMP="${RUBYMAN_HOME}/tmp"
	fi
	
	if [ "$RUBYMAN_IS_ALIVE" != "false" ]
		then
			echo "Rubyman is setting up ..."
			
			source $RUBYMAN_HOME/gem.sh
			source $RUBYMAN_HOME/profile.sh
			source $RUBYMAN_HOME/ruby.sh
			source $RUBYMAN_HOME/utils.sh
			
			export RUBYMAN_IS_ALIVE="true"
	fi
	
	if [ !$# == 2 ]; then
	  echo "Usage: $0 action options"
	  exit
	fi
	
	local action=$1
	local args=("$@")
	
	case $action in
		create) rubyman_profile_create "${args[@]}";;
		delete) rubyman_profile_delete "${args[@]}";;
		use) rubyman_use_profile "${args[@]}";;
		install) rubyman_install;;
	esac
	
	echo "Finished"
}

function rubyman_use_profile {
	rubyman_switch_profile $2
	
	export PATH=$RUBYMAN_ACTIVE_PROFILE_DIR/bin:$PATH
	
	# check for gem updates here?
}

# switches the active profile to one specified
function rubyman_switch_profile {
	local profile=$1
	
	if [ -d "${RUBYMAN_HOME}/profiles/${profile}" ]; then
		echo "Switching profiles to '${profile}'"
	
		export RUBYMAN_ACTIVE_PROFILE="${profile}"
		export RUBYMAN_ACTIVE_PROFILE_DIR="${RUBYMAN_HOME}/profiles/${profile}"
	else
		echo "The profile '${profile}' does not exist in rubyman"
		#exit 1
	fi
}

# enters the state for installing from source
function rubyman_enter_source_install {
	rubyman_utils_create_tmp
	
	export RUBYMAN_LAST_DIR=`pwd`
	
	pushd $RUBYMAN_TMP
}

function rubyman_exit_source_install {
	pushd $RUBYMAN_LAST_DIR
	
	rubyman_utils_create_tmp
}