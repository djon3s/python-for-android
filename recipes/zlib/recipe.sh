#!/bin/bash

# REPLACE ALL THE "zlib" OF THIS FILE WITH THE MODULE NAME
# THEN REMOVE THIS ERROR AND EXIT
#error "not configure" && exit -1

# version of your package
VERSION_zlib=1.2.7

# dependencies of this recipe
DEPS_zlib=() #perhaps add zlib if this doesn't work

# url of the package
URL_zlib=http://zlib.net/zlib-1.2.7.tar.gz

# md5 of the package
MD5_zlib=60df6a37c56e7c1366cca812414f7b85

# default build path
BUILD_zlib=$BUILD_PATH/TOR/$(get_directory $URL_zlib)

# default recipe path
RECIPE_zlib=$RECIPES_PATH/zlib

# function called for preparing source code if needed
# (you can apply patch etc here.)
function prebuild_zlib() {
	true
}

# function called to build the source code
function build_zlib() {
	cd $BUILD_zlib
	
	push_arm
	
	try ./configure --host=arm-linux-eabi --build=x86_64
	try make test
	
	pop_arm
}

# function called after all the compile have been done
function postbuild_zlib() {
	true
}
