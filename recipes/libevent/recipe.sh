#!/bin/bash

# REPLACE ALL THE "libevent" OF THIS FILE WITH THE MODULE NAME
# THEN REMOVE THIS ERROR AND EXIT
#error "not configure" && exit -1

# version of your package
VERSION_libevent=2.0.21

# dependencies of this recipe
DEPS_libevent=() #perhaps add zlib if this doesn't work

# url of the package
URL_libevent=https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz

# md5 of the package
MD5_libevent=b2405cc9ebf264aa47ff615d9de527a2

# default build path
BUILD_libevent=$BUILD_PATH/libevent/$(get_directory $URL_libevent)

# default recipe path
RECIPE_libevent=$RECIPES_PATH/libevent

# function called for preparing source code if needed
# (you can apply patch etc here.)
function prebuild_libevent() {
	true
}

# function called to build the source code
function build_libevent() {
	cd $BUILD_libevent
	
	push_arm
	
	try ./configure --host=arm-linux-eabi
	try make verify
	
	pop_arm
}

# function called after all the compile have been done
function postbuild_libevent() {
	true
}
