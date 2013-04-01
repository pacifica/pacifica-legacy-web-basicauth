VERSION=1.0.0

build-all:
	echo nothing to be done.

dist:
	rm -f pacifica-web-basicauth-${VERSION}.tar.gz
	rm -rf pacifica-web-basicauth-${VERSION}
	mkdir -p pacifica-web-basicauth-${VERSION}
	ln -s ../conf pacifica-web-basicauth-${VERSION}/conf
	cp pacifica-web-basicauth.spec pacifica-web-basicauth-${VERSION}/
	tar --dereference --exclude '.svn' -zcvf pacifica-web-basicauth-${VERSION}.tar.gz pacifica-web-basicauth-${VERSION}/*

rpm: dist
	rm -rf `pwd`/packages
	mkdir -p `pwd`/packages/src
	mkdir -p `pwd`/packages/bin
	rpmbuild -ta pacifica-web-basicauth-${VERSION}.tar.gz --define '_rpmdir '`pwd`'/packages/bin' --define '_srcrpmdir '`pwd`'/packages/src'

rpms: rpm

MOCKOPTS=
MOCKDIST=fedora-18-x86_64
MOCK=/usr/bin/mock

mock: dist
	rm -rf packages/"$(MOCKDIST)"
	mkdir -p packages/"$(MOCKDIST)"/srpms
	mkdir -p packages/"$(MOCKDIST)"/bin
	$(MOCK) -r "$(MOCKDIST)" --buildsrpm --spec pacifica-web-basicauth-${VERSION}/pacifica-web-basicauth.spec $(MOCKOPTS) --sources "`pwd`"
	mv "/var/lib/mock/$(MOCKDIST)/result/"*.src.rpm packages/"$(MOCKDIST)"/srpms/
	$(MOCK) -r "$(MOCKDIST)" --result "$(CURDIR)"/packages/"$(MOCKDIST)"/bin $(MOCKOPTS) "$(CURDIR)"/packages/"$(MOCKDIST)"/srpms/*.src.rpm
