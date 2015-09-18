<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:str="http://exslt.org/strings"
  xmlns:java="http://xml.apache.org/xalan/java"
  xmlns:number="xalan://br.com.auster.common.lang.NumberUtils"
  xmlns:cache="xalan://br.com.auster.common.cache.DOMCache"
  xmlns:vivo="xalan://br.com.auster.vivo.invoice.util.extensions" 
  exclude-result-prefixes="str number cache java vivo" 
  version="1.0">
 
		
	<xsl:template name="erro">

<html>
<head>
<style>
.font12{
font-family:arial;
font-size:14px;
color:#000000;
}
</style>
</head>
<body>
<div class="font12" style="width:400px;height:140px;border:1px solid;padding-top:20px;padding-left:20px;position:absolute;top:50px;left:300px;">
<b>Não é possível gerar a imagem da fatura</b><br></br>
O arquivo de origem possui um tamanho superior à 17mb.<br></br><br></br>
<b>Informações da conta</b><br></br><br></br>
Número da conta = <xsl:value-of select="CYCLE_SUMMARY/@AccountNumber"/><br></br>
Ciclo = <xsl:value-of select="CYCLE_SUMMARY/@CycleCode"/>
</div>
</body>
</html>

</xsl:template>

</xsl:stylesheet>