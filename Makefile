MODULES = twisted pyyaml scapy
DISTNAME = $(shell echo ${MODULES} | sed -e 's/ /-/g')
PROJDIR = project/${DISTNAME}
LOGFILE = log/${DISTNAME}.log

dist: 
	mkdir -p log ${PROJDIR}
	# XXX distribute.sh sometimes tries to cp and rm nonexistent files, hence 
	#     the "-". this is ok unless the build ends lacking libpymodules.so,
	#     then no distdir is made (it should throw an error at the beginning)
	-./distribute.sh -m '${MODULES}' -d ${DISTNAME} -x
	#-./distribute.sh -m '${MODULES}' -d ${DISTNAME} -x | tee ${LOGFILE}
	
build : dist
	cd ${DISTNAME}/default
	./build.py --package org.test.ooniprobe --name ooniprobe --version 0.1 \
		--dir ${PROJDIR} debug

install : build
	cd ${DISTNAME}/default
	./build.py --package org.test.ooniprobe --name ooniprobe --version 0.1 \
		--dir ${PROJDIR} installd

clean :
	rm -rf build/*
	rm -rf dist/*
#	find build -maxdepth 1 -type d | grep -Ev '^(python|host)' | xargs rm -rvf

.PHONY : clean build install dist
