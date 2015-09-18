SERVERPID=`ps -ef | grep java | grep billc | grep -v grep | grep bckSERVER | awk '{print $2}'`
IMAGEPID=`ps -ef | grep java | grep billc | grep -v grep | grep ImageBuilder | awk '{print $2}'`
RMIPID=`ps -ef | grep rmiregistry | grep -v grep | awk '{print $2}'`

if [ -z "${SERVERPID}" ]; then
   echo "Servidor de Processamento não está rodando."
else
   echo "Processo ${SERVERPID}"
fi

if  [ -z "${RMIPID}" ]; then
   echo "Processo rmi não está rodando."
else
   echo "Processo rmi ${RMIPID}"
fi

if [ -z "${IMAGEPID}" ]; then
   echo "Gerador de Imagens de Fatura não está rodando."
else
   echo "Gerador de Imagens de Fatura ${IMAGEPID}"
fi
