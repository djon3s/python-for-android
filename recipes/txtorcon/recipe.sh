#!/bin/bash

# version of your package
VERSION_txtorcon=

# dependencies of this recipe
DEPS_txtorcon=(tor twisted)

# url of the
#URL_txtorcon=https://github.com/meejah/txtorcon/archive/3b370a0cc77ee7c52fcd956611c5aed244c19a96.zip
URL_txtorcon=https://github.com/meejah/txtorcon/archive/v0.7.tar.gz

# md5 of the package
MD5_txtorcon=

# default build path
BUILD_txtorcon=$BUILD_PATH/txtorcon/$(get_directory $URL_txtorcon)

# default recipe path
RECIPE_txtorcon=$RECIPES_PATH/txtorcon

# function called for preparing source code if needed
# (you can apply patch etc here.)
function prebuild_txtorcon() {
	
    cd $BUILD_txtorcon
    	# check marker in our source build
	if [ -f .patched ]; then
		# no patch needed
		return
	fi
	
	cd $BUILD_txtorcon/txtorcon
	try patch -p1 -i $RECIPE_txtorcon/patches/no-pygeoip.patch
	cd $BUILD_txtorcon
#   	try patch -p1 -i $RECIPE_txtorcon/patches/setup.py.patch
#
	# everything done, touch the marker !
	touch .patched
#       true
}

# function called to build the source code
function build_txtorcon() {
    cd $BUILD_txtorcon

#    push_arm
#	try $BUILD_PATH/python-install/bin/python.host setup.py install -O2

#	export PYTHONPATH=$BUILD_PATH/hostpython/Python-2.7.2/Lib/site-packages

#    try $BUILD_hostpython/hostpython setup.py install -O2 --root=$BUILD_PATH/python-install --install-lib=lib/python2.7/site-packages

    rm -rvf txtorcon/test
    cp -rv txtorcon $BUILD_PATH/python-install/lib/python2.7/site-packages

	#try rm -rf $BUILD_PATH/python-install/lib/python*/dist-packages/txtorcon*/txtorcon/test
	#try rm -rf $BUILD_PATH/python-install/lib/python*/dist-packages/txtorcon*/share/txtorcon/examples

#    pop_arm
}

# function called after all the compile have been done
function postbuild_txtorcon() {
	true
}
