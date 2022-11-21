.PHONY: help setup install

VERSION := 2.60.3
VERSION_TINI := 0.14.0

URL_DOWNLOAD := https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/$(VERSION)/jenkins-war-$(VERSION).war
CHECKSUM := 2d71b8f87c8417f9303a73d52901a59678ee6c0eefcf7325efed6035ff39372a
CHECKSUM_TINI := 6c41ec7d33e857d4779f14d9c74924cab0c7973485d2972419a3b7c7620ff5fd

USER := jenkins
GROUP := jenkins
ID_USER := 1000
ID_GROUP := 1000

HOME_JENKINS := /var/jenkins_home

help:
	@cat $(firstword $(MAKEFILE_LIST))

setup: \
	/usr/bin/git \
	/usr/bin/make \
	/usr/bin/which \
	/usr/bin/sudo \
	/usr/local/etc/group/jenkins \
	/usr/local/etc/user/jenkins

/usr/local/etc/group/jenkins: /usr/local/etc/group
	groupadd -g $(ID_GROUP) $(GROUP)
	grep '^$(USER)' /etc/group > $@

/usr/local/etc/user/jenkins: /usr/local/etc/user
	useradd -d "$(HOME_JENKINS)" -u $(ID_USER) -g $(ID_GROUP) -m -s /bin/bash $(USER)
	grep '^$(USER)' /etc/group > $@

/usr/local/etc/group:
	mkdir $@

/usr/local/etc/user:
	mkdir $@

install: \
	/usr/bin/java \
	/usr/bin/tini \
	/usr/share/jenkins/jenkins.war

/usr/bin/make:
	dnf install -y make

/usr/bin/which:
	dnf install -y which

/usr/bin/sudo:
	dnf install -y sudo

/usr/bin/java:
	dnf install -y java-17-amazon-corretto

/usr/bin/git:
	dnf install -y git

/usr/share/jenkins/jenkins.war: /usr/share/jenkins
	curl -fsSL $(URL_DOWNLOAD) -o $@
	echo "$(CHECKSUM) $@" | sha256sum -c -

/usr/bin/tini:
	curl -fsSL https://github.com/krallin/tini/releases/download/v$(VERSION_TINI)/tini-static-amd64 -o $@
	chmod +x $@
	echo "$(CHECKSUM_TINI) $@" | sha256sum -c -

/usr/share/jenkins:
	mkdir $@

/var/jenkins_home:
	$(error $@ should be created by another rule)

clean:
	rm -rf /usr/share/jenkins
	rm -rf /usr/bin/tini
	-userdel jenkins
	rm -rf /usr/local/etc/user/jenkins
	-groupdel jenkins
	rm -rf /usr/local/etc/group/jenkins
