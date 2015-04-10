USE_PKGBUILD=1
include /usr/local/share/luggage/luggage.make

TITLE=anatida
PACKAGE_NAME=anatida
REVERSE_DOMAIN=com.chordata
PAYLOAD=\
				pack-script\
				pack-Library-LaunchDaemons-com.chordata.anatida.plist \
				pack-script-postinstall

pack-script:
	@sudo mkdir -p ${WORK_D}/etc/ansible/facts.d
	@sudo ${CP} mac.fact ${WORK_D}/etc/ansible/facts.d/mac.fact
	@sudo mkdir -p ${WORK_D}/usr/local/chordata
	@sudo ${CP} anatidaSetup ${WORK_D}/usr/local/chordata/anatidaSetup
	@sudo chmod 700 ${WORK_D}/usr/local/chordata/anatidaSetup
	@sudo ${CP} anatidaRun ${WORK_D}/usr/local/chordata/anatidaRun
	@sudo chmod 700 ${WORK_D}/usr/local/chordata/anatidaRun
