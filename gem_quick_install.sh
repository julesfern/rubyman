# This is a function I use for me personally to install the gems I use in each of my projects.

export GEM_INSTALL_INVOCATION="sudo gem install --no-rdoc --no-ri"

function install_all_gems {
	install_app_gems
	install_deployment_gems
	install_test_gems
	install_service_gems
	install_developer_gems
	install_blogging_gems
	install_mysql_gems
	install_merb_edge
	install_datamapper_edge
}

function install_app_gems {
	geminst "merb rails sinatra"
	geminst "mislav-will_paginate mbleigh-mash"
}

function install_deployment_gems {
	geminst "capistrano capistrano-ext mongrel mongrel_cluster thin memcache-client ferret"
}

function install_datamapper_edge {
	$GEM_INSTALL_INVOCATION dm-core -s http://gems.datamapper.org
	$GEM_INSTALL_INVOCATION dm-more -s http://gems.datamapper.org
	$GEM_INSTALL_INVOCATION data_objects -s http://gems.datamapper.org
	$GEM_INSTALL_INVOCATION do_sqlite3 -s http://gems.datamapper.org
	$GEM_INSTALL_INVOCATION do_mysql -s http://gems.datamapper.org -- --with-mysql-config=`which mysql_config`
}

function install_merb_edge {
	mkdir -p ~/tmp &&
	pushd ~/tmp &&
	rm -rf merb &&
	git clone git://github.com/wycats/merb.git &&
	pushd ~/tmp/merb &&	sudo rake install:core && 
	pushd ~/tmp/merb/merb_datamapper && sudo rake install &&
	pushd ~/tmp/merb &&	sudo rake install:more &&
	sudo rm -rf ~/tmp/merb
	# This is to avoid the ridiculous dependency chain problems in edge merb
}

function install_mysql_gems {
	sudo env ARCHFLAGS="-arch i386" $GEM_INSTALL_INVOCATION mysql -- --with-mysql-config=`which mysql_config`
}

function install_test_gems {
	geminst "redgreen rspec cucumber thoughtbot-shoulda webrat"
}

function install_service_gems {
	geminst "aws-s3"
}

function install_developer_gems {
	geminst "technicalpickles-jeweler"
	geminst "httparty nokogiri"
	geminst "net-scp net-sftp net-ssh net-ssh-gateway"
	geminst "image_science"
	geminst "liquid treetop"
	geminst "BlueCloth RedCloth maruku"
	geminst "libxml-ruby ruby-hmac"
	geminst "english"
}

function install_blogging_gems {
	geminst "mojombo-jekyll"
}

function geminst {
	$GEM_INSTALL_INVOCATION $1
}
