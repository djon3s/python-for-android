#!/bin/bash

VERSION_libyaml=0.1.4
URL_libyaml=http://pyyaml.org/download/libyaml/yaml-$VERSION_libyaml.tar.gz
DEPS_libyaml=()
MD5_libyaml=36c852831d02cf90508c29852361d01b
BUILD_libyaml=$BUILD_PATH/libyaml/$(get_directory $URL_libyaml)
RECIPE_libyaml=$RECIPES_PATH/libyaml

function prebuild_libyaml() {
	true
}

function build_libyaml() {
	cd $BUILD_libyaml

	push_arm

	try ./configure --host=arm-linux-eabi
	try make 

	pop_arm
}

function postbuild_libyaml() {
	true
}
