Este diret�rio possui 2 tipos de arquivos : 
 * queries MDX 
 * configura��o de cubo do Mondrian
 
Os arquivos padr�o est�o no projeto "auster:dware-console", no diret�rio src/main/webapp/WEB-INF/queries.

Para incluir novas queries, deve-se criar novos JSPs com as queries MDX usando como padr�o as j� existentes no diret�rio acima
mencionado. Al�m disto, � necess�rio alterar a p�gina reports/queries-content.jsp adicionando links para as novas queries MDX.

Caso acrescentem-se cubos, ou os j� existentes sejam modificados, � necess�rio alterar o arquivo ep.xml. O nome od arquivo n�o
pode ser alterado.


