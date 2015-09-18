echo
echo \#\#
echo \#\# Copyright 2004-2005 Auster Solutions do Brasil
echo \#\#
echo \#\#  --- BillCheckout Tool v3.0.0 ---
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


BASEDIR=/opt/Billc/server

RMIBASE=`ls -1 ${BASEDIR}/lib/vivo-billcheckout-server*`

${JAVA_HOME}/bin/java -cp ${ANT_HOME}/lib/ant-launcher.jar \
  -Dant.home=$ANT_HOME \
  -Dbasedir=${BASEDIR} \
  -Drmi.base=${RMIBASE} \
  -Dcmdline.args="$*" \
  org.apache.tools.ant.launch.Launcher \
  -file bin/image-run.xml

echo
echo [ Finished ]
echo
