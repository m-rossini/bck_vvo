#! /bin/sh

SERVERPID=`ps -ef | grep java | grep billc | grep Xmx2048 | awk '{print $2}'`

if [ -z "${SERVERPID}" ]; then
   echo "Gerador de Relat�rios n�o est� rodando."
else
   echo "Processo ${SERVERPID}"
fi