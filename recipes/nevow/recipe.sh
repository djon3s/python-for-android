#!/bin/bash


# version of your package
VERSION_nevow=

# dependencies of this recipe
DEPS_nevow=(twisted)

# url of the
URL_nevow=https://pypi.python.org/packages/source/N/Nevow/Nevow-0.10.0.tar.gz

# md5 of the package
MD5_nevow=66dda2ad88f42dea05911add15f4d1b2

# default build path
BUILD_nevow=$BUILD_PATH/nevow/$(get_directory $URL_nevow)

# default recipe path
RECIPE_nevow=$RECIPES_PATH/nevow

# function called for preparing source code if needed
# (you can apply patch etc here.)
function prebuild_nevow() {
	true
}

# function called to build the source code
function build_nevow() {
    cd $BUILD_nevow
    push_arm
#    try $BUILD_PATH/python-install/bin/python.host setup.py install -O2
	export LDFLAGS="$LDFLAGS -L$LIBS_PATH"
	export LDSHARED="$LIBLINK"

	export PYTHONPATH=$BUILD_hostpython/Lib/site-packages

	# fake try to be able to cythonize generated files
	$BUILD_PATH/python-install/bin/python.host setup.py build_ext
	try find . -iname '*.pyx' -exec cython {} \;
	try $BUILD_PATH/python-install/bin/python.host setup.py build_ext -v
	try find build/lib.* -name "*.o" -exec $STRIP {} \;

        try $BUILD_hostpython/hostpython setup.py install -O2 --root=$BUILD_PATH/python-install --install-lib=lib/python2.7/site-packages

    pop_arm
}

# function called after all the compile have been done
function postbuild_nevow() {
	true
}
