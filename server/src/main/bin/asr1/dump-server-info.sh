SERVERPID=`ps -ef | grep java | grep billc | grep -v grep | grep bckSERVER | awk '{print $2}'`

if [ -z "${SERVERPID}" ]; then
   echo "Servidor de Processamento não está rodando."
   exit 1
fi

if [ -z "${JAVA_HOME}" ]; then
   echo "Variável de ambiente JAVA_HOME não está defnida."
   exit 2
fi

if [ ! -r ${JAVA_HOME}/bin/jmap ]; then
   echo "Comando JMAP não existe na instalação de Java atual."
   exit 3
fi
if [ ! -r ${JAVA_HOME}/bin/jstat ]; then
   echo "Comando JSTAT não existe na instalação de Java atual."
   exit 4
fi

${JAVA_HOME}/bin/jmap -d64 -heap ${SERVERPID} > jmap1.${SERVERPID}.txt
${JAVA_HOME}/bin/jstat -d64 -gcutil ${SERVERPID} 5000 60 > jstat.${SERVERPID}.txt
${JAVA_HOME}/bin/jmap -d64 -heap ${SERVERPID} > jmap2.${SERVERPID}.txt
${JAVA_HOME}/bin/jmap -d64 -histo ${SERVERPID} > jmap3.${SERVERPID}.txt
