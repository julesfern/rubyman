#!/bin/bash

function rubyman_new_profile {
	rubyman_profile_name "general" "g"
	
	rubyman_ruby_install "1.8" "7" "72"
	rubyman_rubygems_install "1.3" "5"
	
	rubyman_gem_install "jeweler"
}