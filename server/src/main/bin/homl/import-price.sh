echo
echo \#\#
echo \#\# Copyright 2004-2008 Auster Solutions do Brasil
echo \#\#
echo \#\#  --- BillCheckout Tool v4.X ---
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

printUsage() {
	echo "Usage: $0 <INPUT-FILE>" 
	echo
	echo "   INPUT-FILE     the file to be imported "
	echo
	exit 1
}

if [ -z "$1" ]; then 
     printUsage
fi
if [ "$1" = "-help" ]; then
     printUsage
fi
if [ "$1" = "--help" ]; then
     printUsage
fi
if [  "$1" = "-h" ]; then
     printUsage
fi

INPUT_FILE=$1
EFFECTIVE_DATE=`date +%Y-%m-%d`
CMDLINE_OPTS=$3
checkAnt
checkJava

# Getting BILLCHECKOUT_HOME absolute path
BILLCHECKOUT_HOME=/opt/Billc/server
#BILLCHECKOUT_HOME=/stage/vivo/billcheckout/server

cd $BILLCHECKOUT_HOME

echo
echo INFO  Após o término da carga de serviços reinicie o processo do billcheckout-server.
echo

if ls $INPUT_FILE > /dev/null 2>&1
  then
    echo Arquivo de entrada $INPUT_FILE encontrado.
  else
    echo Arquivo de entrada $INPUT_FILE nao encontrado.
    exit
fi

SPLITTING_LINES=100000
TEMP_DIR=/tmp/import-price

if [ ! -d $TEMP_DIR ]
  then
    mkdir $TEMP_DIR
  else
    if ls $TEMP_DIR/* > /dev/null 2>&1
      then
        rm $TEMP_DIR/*
    fi
fi

# Starting Clean Services Tables
echo
echo Starting Clean Services Tables
echo

echo Clean Table: prc_service_price
sqlplus -S billchkow/billchkow@BILLCQA @conf/sql/truncate-service-price.sql

echo Clean Table: prc_service
sqlplus -S billchkow/billchkow@BILLCQA @conf/sql/delete-service.sql

echo Clean Table: prc_service_free_units
sqlplus -S billchkow/billchkow@BILLCQA @conf/sql/delete-service-free-units.sql

echo
echo [ Finished Clean ]
echo

# Starting Billcheckout Import
echo
echo Starting BillCheckout Import
echo

cp -p $INPUT_FILE $TEMP_DIR/import.input
cd $TEMP_DIR
split -l $SPLITTING_LINES import.input

# renaming first file so it will not be handled in the for bellow
mv xaa firstfile
cd -

# running for first file; import Id will be generated here
 ${JAVA_HOME}/bin/java -cp ${ANT_HOME}/lib/ant-launcher.jar \
                      -Dant.home=${ANT_HOME} \
                      -Dbasedir=${BILLCHECKOUT_HOME} \
                      -Dinput.file=$TEMP_DIR/firstfile \
                      -Deffective.date=${EFFECTIVE_DATE} \
                      -Dconfig.file="import/hibernate-configuration.xml" \
                      -Dconfig.descriptionFile="import/import-service.xml" \
                      -Dimport.useImportId=0 \
                      -Dcmdline.opts=${CMDLINE_OPTS} \
                      org.apache.tools.ant.launch.Launcher -file ${BILLCHECKOUT_HOME}/bin/import-price.xml

ImportId=`sqlplus -S billchkow/billchkow@BILLCQA @conf/select-import-id.sql | tail -2 | head -1 | sed -e 's/^ *//' -e 's/ *$//'`

for SPLIT_FILE in $TEMP_DIR/x*
  do
    echo Processando $SPLIT_FILE
    ${JAVA_HOME}/bin/java -cp ${ANT_HOME}/lib/ant-launcher.jar \
                      -Dant.home=${ANT_HOME} \
                      -Dbasedir=${BILLCHECKOUT_HOME} \
                      -Dinput.file=${SPLIT_FILE} \
                      -Deffective.date=${EFFECTIVE_DATE} \
                      -Dconfig.file="import/hibernate-configuration.xml" \
                      -Dconfig.descriptionFile="import/import-service.xml" \
                      -Dcmdline.opts=${CMDLINE_OPTS} \
                      -Dimport.useImportId=${ImportId} \
                      org.apache.tools.ant.launch.Launcher -file ${BILLCHECKOUT_HOME}/bin/import-price.xml
done

echo
echo [ Finished Import ]
echo
