#MYPATH=/opt/Billc/server
MYPATH=/stage/vivo/billcheckout/server

PORT=2004

echo 
echo Starting RMI Registry for Billcheckout v3.1.x
echo
echo Running RMI Registry on port $PORT
echo
 
CLASSPATH="${MYPATH}/lib/vivo-billcheckout-server-*.jar"
export CLASSPATH

echo $CLASSPATH

${JAVA_HOME}/bin/rmiregistry $PORT

