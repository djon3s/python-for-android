MODULES = twisted pyyaml scapy
DISTNAME = $(shell echo ${MODULES} | sed -e 's/ /-/g')
PROJDIR = project/${DISTNAME}
LOGFILE = log/${DISTNAME}.log

dist: 
	mkdir -p log ${PROJDIR}
	# distribute.sh sometimes cp's and rm's nonexistent things, but it's usually ok
	-./distribute.sh -m '${MODULES} python' -d ${DISTNAME} | tee ${LOGFILE}
	
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
