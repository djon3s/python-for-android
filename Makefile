include config.mk

dist:
	./distribute.sh -m ${MODULES}
	
build : dist
	cd ${DISTDIR}


install : build

clean :
	find ${BUILDDIR} -maxdepth 1 -type d | grep -Ev '^(python|host)' | xargs rm -rvf

distclean :
	rm -rvf build/*

.PHONY : clean build install dist
