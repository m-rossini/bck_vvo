echo
echo \#\#
echo \#\# Copyright 2004-2006 Auster Solutions do Brasil
echo \#\#
echo \#\#  --- BillCheckout Tool v4.x ---
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

BASEDIR=/opt/Billc/report
#BASEDIR=/stage/vivo/billcheckout/report

echo 
echo Starting Billcheckout Generate Report On Demand
echo
echo

${JAVA_HOME}/bin/java \
  -Xmx32M \
  -cp ${ANT_HOME}/lib/ant-launcher.jar \
  -Dant.home=$ANT_HOME \
  -Dbasedir=$BASEDIR \
	-Dcmdline.args="$*" \
  org.apache.tools.ant.launch.Launcher \
  -file bin/generate-run.xml
resultado=$?

echo
echo [ Finished with result: $resultado ]
echo
