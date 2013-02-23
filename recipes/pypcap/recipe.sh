#!/bin/bash

VERSION_pypcap=
URL_pypcap=https://github.com/hellais/pypcap/zipball/master/pypcap-master.zip
DEPS_pypcap=(libpcap hostpython python)
MD5_pypcap=8e49c81691f2741da3701b332be49f12
BUILD_pypcap=$BUILD_PATH/pypcap/$(get_directory $URL_pypcap)
RECIPE_pypcap=$RECIPES_PATH/pypcap

function prebuild_pypcap() {
	cd $BUILD_pypcap

	# check marker in our source build
	if [ -f .patched ]; then
		# no patch needed
		return
	fi

	try patch -p1 < $RECIPE_pypcap/patches/use-external-cython.diff

	touch .patched
}

function build_pypcap() {

	if [ -d "$BUILD_PATH/python-install/lib/python2.7/site-packages/pcap.so" ]; then
		return
	fi

	cd $BUILD_pypcap

	push_arm

	export CC="$CC -I$BUILD_libpcap"
	export LDFLAGS="$LDFLAGS -L$LIBS_PATH -L$BUILD_libpcap"

	try find . -iname '*.pyx' -exec cython {} \;
	try $BUILD_PATH/python-install/bin/python.host setup.py config --with-pcap $BUILD_libpcap build_ext -v
	try $BUILD_PATH/python-install/bin/python.host setup.py install -O2

	try rm -f $BUILD_PATH/python-install/pcap_ex.h

	pop_arm
}

function postbuild_pypcap() {
	true
}



