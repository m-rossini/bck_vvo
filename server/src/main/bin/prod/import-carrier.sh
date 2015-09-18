echo
echo \#\#
echo \#\# Copyright 2004-2005 Auster Solutions do Brasil
echo \#\#
echo \#\#  --- BillCheckout Import Tool v1.3.0 ---
echo \#\#
echo

function checkAnt {
	if [[ -z ${ANT_HOME} || ! ( -r ${ANT_HOME}/lib/ant.jar ) ]]; then
		echo ANT_HOME is set incorrectly or Ant could not be located. Please set ANT_HOME.
		exit 1
	fi
}

function checkJava {
	if [[ -z ${JAVA_HOME} || ! ( -r ${JAVA_HOME}/bin/java ) ]]; then
		echo JAVA_HOME is set incorrectly or java could not be located. Please set JAVA_HOME.
		exit 1
	fi
}

function printUsage {
	echo "Usage: $0 <INPUT-FILE>" 
	echo
	echo "   INPUT-FILE     the file to be imported "
	echo
	exit 1
}

if [[ -z "$1" || "$1" = "-help" || "$1" = "--help" || "$1" = "-h" ]]; then 
	printUsage
fi


INPUT_FILE=$1
checkAnt
checkJava

# Getting BILLCHECKOUT_HOME absolute path
ORIGINAL_PATH=${PWD}
#BILLCHECKOUT_HOME=$( dirname $0 )
#cd $BILLCHECKOUT_HOME
BILLCHECKOUT_HOME=".."
cd ${ORIGINAL_PATH}

# Starting Billcheckout Import
echo
echo [ Starting BillCheckout Import ]
echo
${JAVA_HOME}/bin/java -cp ${ANT_HOME}/lib/ant-launcher.jar -Dant.home=$ANT_HOME -Dbasedir=$BILLCHECKOUT_HOME -Dinput.file=$INPUT_FILE -Dconfig.file="conf/import/hibernate-configuration.xml" -Dconfig.descriptionFile="conf/import/import-carrier.xml" org.apache.tools.ant.launch.Launcher -file ${BILLCHECKOUT_HOME}/bin/import-carrier.xml
echo
echo [ Finished ]
echo
