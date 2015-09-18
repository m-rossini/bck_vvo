#!/usr/bin/ksh
echo \#\#
echo \#\# Copyright 2004-2008 Auster Solutions do Brasil
echo \#\#
echo \#\#  --- Price Extractor ---
echo \#\#
checkParameters() {
  if [ $NUM_PARMS != 1 ]
    then
      echo 
      echo "ERROR: Executar extract-price.sh job_request"
      echo '       onde: job_request = job request associado a este processo batch.'
      echo
      exit 2
  fi
}
NUM_PARMS=$#
checkParameters

# VIVO settings
BASEDIR=/opt/Billc/server
CONNECT_BCK=billchkow/billchkow@BILLCPR1
CONNECT_DTBN=db_billc/db_bill#2008@dtbn

echo \#\#  Retrieving parameters
RESULT=`sqlplus -S ${CONNECT_BCK} @${BASEDIR}/conf/sql/selectbatch.sql BCK037 $1 | tail -2 | head -1 | sed 's/^.*|//'`

if [ "$RESULT" == "Error" ]
  then
    echo "ERROR: Não existe JOB criado na tabela de controle."
		echo "Cadastre um JOB correspondente a esse script e execute-o novamente."
    exit 1
fi

if [ -f $RESULT ]
then
  rm -f $RESULT
fi

echo \#\#  Extracting price information
sqlplus -S ${CONNECT_DTBN} @${BASEDIR}/conf/sql/extractPrice.sql $RESULT

echo \#\#  Updating batch execution
sqlplus -S ${CONNECT_BCK} @${BASEDIR}/conf/sql/updatebatch.sql BCK037 $1

echo
echo [ Finished ]
echo
