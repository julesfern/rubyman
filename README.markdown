A series of utility scripts that extend your bash shell with magical ruby management capabilities.

A shared problem
----------------
Long have been the days since all Ruby developers lived in the same, gigantic house - wallowed in the same filth, drank the same flat soda. Once a common brotherhood, now a fractured land of lost souls shouting gibberish at each other. "I'm working on a few apps at the same time," they scream, "but they've all got problems with different ruby versions! And not all gems work in all Ruby environments! What am I to do? Ruby development has become a hassle!"

IT IS _NOT_ A HASSLE!
---------------------
With this patented set of scripts mostly cobbled together from other scripts found on github, you'll be able to manage multiple Ruby revisions like a pro, even running different patchlevels of the same Ruby version alongside each other. Each Ruby version even gets its own Rubygems installation. Experience anal retentive gem management on a level *never before experienced*. After mere minutes of using this script, most developers gain the ability to *eat sharks and other large marine wildlife*.

The coder's lament!
-------------------
A common complaint about multiruby systems is that they are *too automatic* and *not at all fussy enough about patchlevels*. With this set of scripts, you'll be painfully aware of every single teensy itty-bitty revision and update to your favourite scripting language.

Installing it
=============

If you're me
------------
cd ~
git clone git@github.com:danski/rubyman.git
echo "source ~/rubyman/ruby_switcher.sh" >> ~/.bash_profile
echo "source ~/rubyman/gem_quick_install.sh" >> ~/.bash_profile

If you're not me
----------------
cd ~
git clone git://github.com/danski/rubyman.git
echo "source ~/rubyman/ruby_switcher.sh" >> ~/.bash_profile
echo "source ~/rubyman/gem_quick_install.sh" >> ~/.bash_profile

Using it
========

To install Ruby 1.8.7 at patchlevel 174:

	install_mri "1.8" "7" "174"
	
To use Ruby 1.8.7 at patchlevel 174:

	use_mri "1.8" "7" "174"
	
To set a default ruby:

Edit the ruby_switcher.sh and set your own damned defaults.

This package also includes some functions I use to install gems.
