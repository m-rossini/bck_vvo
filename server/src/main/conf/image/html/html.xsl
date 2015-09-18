<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:str="http://exslt.org/strings"
  xmlns:java="http://xml.apache.org/xalan/java"
  xmlns:number="xalan://br.com.auster.common.lang.NumberUtils"
  xmlns:cache="xalan://br.com.auster.common.cache.DOMCache"
  xmlns:vivo="xalan://br.com.auster.vivo.invoice.util.extensions" 
  xmlns:req="xalan://br.com.auster.dware.graph.Request"
  exclude-result-prefixes="str number cache java vivo" 
  version="1.0">
 
	
	<!-- inclui as paginas da fatura -->
	<xsl:import href="boleto_pf.xsl"/>
	<xsl:import href="nota_fiscal_pf.xsl"/>
	<xsl:import href="pagina2_pf.xsl"/>
	<xsl:import href="pagina3_pf.xsl"/>
	<xsl:import href="pagina4_pf.xsl"/>
	<xsl:import href="pagina5_pf.xsl"/>
	<xsl:import href="pagina6_pf.xsl"/>
	
	<xsl:import href="boleto_pj.xsl"/>
	<xsl:import href="nota_fiscal_pj.xsl"/>
	<xsl:import href="pagina2_pj.xsl"/>
	<xsl:import href="pagina3_pj.xsl"/>
	<xsl:import href="pagina4_pj.xsl"/>
	<xsl:import href="pagina5_pj.xsl"/>
	<xsl:import href="pagina6_pj.xsl"/>
	<xsl:import href="erro.xsl"/>
	
	<!-- fim inclusoes -->
	
	<!-- include do formatador -->
	<xsl:include href="templates.xsl"/>
	<!-- fim do foramtador-->
	
	
	<xsl:param name="req:request"/>
		
	
		
	<xsl:template match="/SIRS">
	
	<!-- xsl:variable name="tamanhoXML" select="req:getWeight($req:request)" / -->
	
	<!-- xsl:value-of select="$tamanhoXML"/ -->
	
		<!-- xsl:if test="$tamanhoXML > 17000" -->
			<xsl:call-template name="principal"/>
		<!-- /xsl:if -->
		
	
	</xsl:template>	
		
	<xsl:template  name="principal" match="/CYCLE_SUMMARY">


	
	<xsl:if test="$context/@CustTypeInd = 'F'">
	
		<xsl:call-template name="pagina_boleto_pf"/>
		
		<xsl:call-template name="pagina_nota_pf"/>
		
		<xsl:call-template name="pagina2_pf"/>
		
		<xsl:call-template name="pagina3_pf"/>
		
		<xsl:call-template name="pagina4_pf"/>
		
		<xsl:call-template name="pagina5_pf"/>
		
		<xsl:call-template name="pagina6_pf"/>
		
	
	</xsl:if>
	<xsl:if test="$context/@CustTypeInd != 'F'">
	
		<xsl:call-template name="pagina_boleto_pj"/>
		
		<xsl:call-template name="pagina_nota_pj"/>
		
		<xsl:call-template name="pagina2_pj"/>
		
		<xsl:call-template name="pagina3_pj"/>
		
		<xsl:call-template name="pagina4_pj"/>
		
		<xsl:call-template name="pagina5_pj"/>
		
		<xsl:call-template name="pagina6_pj"/>
		
		
	</xsl:if>

</xsl:template>

</xsl:stylesheet>