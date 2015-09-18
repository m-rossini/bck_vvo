echo
echo \#\#
echo \#\# Copyright 2004-2005 Auster Solutions do Brasil
echo \#\#
echo \#\#  --- BillCheckout Tool v3.1.x Remove Transaction ---
echo \#\#
echo

checkAnt() {
	if [ -z "${ANT_HOME}" ]; then
		echo ANT_HOME is set incorrectly or Ant could not be located. Please set ANT_HOME.
		exit 1
	fi
	if [ ! -r ${ANT_HOME}/lib/ant.jar ]; then
		echo ANT_HOME is set incorrectly or Ant could not be located. Please set ANT_HOME.
		exit 1
	fi
}

checkJava() {
	if [ -z "${JAVA_HOME}" ]; then
		echo JAVA_HOME is set incorrectly or java could not be located. Please set JAVA_HOME.
		exit 1
	fi
	if [ ! -r ${JAVA_HOME}/bin/java ]; then
		echo JAVA_HOME is set incorrectly or java could not be located. Please set JAVA_HOME.
		exit 1
	fi
}


checkAnt
checkJava

#BASEDIR=/opt/Billc/server
BASEDIR=/stage/vivo/billcheckout/server

CONFSQL=${basedir}/conf/sql/generic-jdbc-config.xml
CONFLOG=${basedir}/conf/logging/log4j.xml

${JAVA_HOME}/bin/java \
 -Xmx32M \
 -cp ${ANT_HOME}/lib/ant-launcher.jar \
 -Dauster.application.name=remove-transaction \
 -Dant.home=$ANT_HOME \
 -Dbasedir=${basedir} \
 -Dconf.sql=${CONFSQL} \
 -Dconf.log=${CONFLOG} \
 org.apache.tools.ant.launch.Launcher \
 -file bin/remove-transaction.xml

resultado=$?

echo
echo [ Finished with result= $resultado]
echo

exit $resultado
