<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:output method="text"/>

<xsl:template match="/request-info">

Olá <xsl:value-of select="@user-name"/>,

Sua requisição de número <xsl:value-of select="@request-id"/>, criada em <xsl:value-of select="@request-date"/>, foi processada.

Sumário:
Total : <xsl:value-of select="@accounts-total"/> contas
Processamentos com sucesso : <xsl:value-of select="@accounts-ok"/> contas
Erros de processamento : <xsl:value-of select="@accounts-error"/> contas


Acesse o portal do Billcheckout em https://vivo.printlaser.com/billcheckout para maiores informações e resultados.


Obrigado por utilizar nossos serviços,

Auster Solutions do Brasil
www.auster.com.br
</xsl:template>


</xsl:stylesheet>

