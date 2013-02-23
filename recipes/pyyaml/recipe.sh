#!/bin/bash

VERSION_pyyaml=3.10
URL_pyyaml=http://pyyaml.org/download/pyyaml/PyYAML-$VERSION_pyyaml.tar.gz
DEPS_pyyaml=(libyaml)
MD5_pyyaml=74c94a383886519e9e7b3dd1ee540247 
BUILD_pyyaml=$BUILD_PATH/pyyaml/$(get_directory $URL_pyyaml)
RECIPE_pyyaml=$RECIPES_PATH/pyyaml

function prebuild_pyyaml() {
	true
}

function build_pyyaml() {
	cd $BUILD_pyyaml

	push_arm

	export CC="$CC -I$BUILD_libyaml/include"
	export LDFLAGS="$LDFLAGS -L$LIBS_PATH -L$BUILD_libyaml/src/.libs"

	# this is only a test
	sed -i -e "s|#include_dirs=/usr/local/include:../../include|include_dirs=${BUILD_libyaml}/include|" setup.cfg
	sed -i -e "s|#library_dirs=/usr/local/lib:../../lib|library_dirs=${LIBS_PATH}:${BUILD_libyaml}/src/.libs|" setup.cfg

	try find . -iname '*.pyx' -exec cython {} \;
	try $BUILD_PATH/python-install/bin/python.host setup.py build_ext -v
	try $BUILD_PATH/python-install/bin/python.host setup.py --with-libyaml install -O2

	pop_arm
}

function postbuild_pyyaml() {
	true
}
