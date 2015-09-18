<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:str="http://exslt.org/strings"
  xmlns:java="http://xml.apache.org/xalan/java"
  xmlns:number="xalan://br.com.auster.common.lang.NumberUtils"
  xmlns:cache="xalan://br.com.auster.common.cache.DOMCache"
  xmlns:vivo="xalan://br.com.auster.vivo.invoice.util.extensions" 
  xmlns:req="xalan://br.com.auster.dware.graph.Request"
  xmlns:map="xalan://java.util.Map"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  exclude-result-prefixes="str number cache java vivo" 
  version="1.0">
 	
 	<!-- imports de paginas -->
 	<xsl:import href="Boleto.xsl" />
	<xsl:import href="Nota.xsl" />
	<xsl:import href="Session2.xsl" />
	<xsl:import href="Session3.xsl" />
	<xsl:import href="Session4.xsl" />
	<xsl:import href="Session5.xsl" />
	<xsl:import href="Session6.xsl" />

	
	<!-- import de templates -->
	<xsl:include href="templates.xsl" />


	<!-- parametro request -->
	<xsl:param name="req:request" />

	
	<xsl:template match="/SIRS">

		<xsl:call-template name="principal" />

	</xsl:template>
	
		
	

	
	<!-- inclui as paginas da fatura -->
	<xsl:template name="principal" match="/CYCLE_SUMMARY">
	
	<xsl:variable name="requestAtts" select="req:getAttributes($req:request)" />
 	<xsl:variable name="nomeSessao" select="map:get($requestAtts,'session')"/>
 	<xsl:variable name="terminalNumber" select="map:get($requestAtts,'terminal')"/>
	
	
	<xsl:if test="$nomeSessao = 'boleto'">
        	<xsl:call-template name="Boleto"/>
        </xsl:if>

	<xsl:if test="$nomeSessao = 'nota'">
        	<xsl:call-template name="Nota"/>
        </xsl:if>

	<xsl:if test="$nomeSessao = 'session2'">
        	<xsl:call-template name="Session2"/>
        </xsl:if>

	<xsl:if test="$nomeSessao = 'session3'">
        	<xsl:call-template name="Session3"/>
        </xsl:if>

	<xsl:if test="$nomeSessao = 'session4'">
        	<xsl:call-template name="Session4"/>
        </xsl:if>

	<xsl:if test="$nomeSessao = 'session5'">
        	<xsl:call-template name="Session5"/>
        </xsl:if>

	<xsl:if test="$nomeSessao = 'session6'">
        	<xsl:call-template name="Session6"/>
        </xsl:if>
         
	</xsl:template>
	
	
	
	

</xsl:stylesheet>
