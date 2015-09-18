Este diretório possui 2 tipos de arquivos : 
 * queries MDX 
 * configuração de cubo do Mondrian
 
Os arquivos padrão estão no projeto "auster:dware-console", no diretório src/main/webapp/WEB-INF/queries.

Para incluir novas queries, deve-se criar novos JSPs com as queries MDX usando como padrão as já existentes no diretório acima
mencionado. Além disto, é necessário alterar a página reports/queries-content.jsp adicionando links para as novas queries MDX.

Caso acrescentem-se cubos, ou os já existentes sejam modificados, é necessário alterar o arquivo ep.xml. O nome od arquivo não
pode ser alterado.


