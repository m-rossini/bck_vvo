<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:str="http://exslt.org/strings"
  xmlns:java="http://xml.apache.org/xalan/java"
  xmlns:number="xalan://br.com.auster.common.lang.NumberUtils"
  xmlns:cache="xalan://br.com.auster.common.cache.DOMCache"
  xmlns:vivo="xalan://br.com.auster.vivo.invoice.util.extensions" 
  exclude-result-prefixes="str number cache java vivo" 
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  version="1.0">

<xsl:decimal-format name="european" decimal-separator=',' grouping-separator='.' />


<xsl:template name="FORMAT-DOUBLE" >
		<xsl:param name="number" select="0"/>
		<xsl:value-of select="format-number($number, '###.##0,00', 'european')"/> 
	</xsl:template>


<xsl:template name="FORMAT-ICMS" >
	<xsl:param name="number" select="0"/>
	<xsl:value-of select="format-number($number, '###.####,##', 'european')"/> 
</xsl:template>

	
	<xsl:template name="FORMAT-HMS" >
		<xsl:param name="number" select="0"/>
		<xsl:value-of select="vivo:DurationFormat.formatFromMinutesString($number)"/> 
	</xsl:template>
	
	<xsl:template name="FORMAT-TARIFF">
		<xsl:param name="tarifa" select="''" />
		<xsl:choose>
			<xsl:when test="$tarifa = 'O'">
				<xsl:value-of select="'reduzida'"/>
			</xsl:when>
			<xsl:when test="$tarifa = 'P'">
				<xsl:value-of select="'normal'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'outra'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="FORMAT-HMS-INTEIRO" >
		<xsl:param name="number" select="0"/>
		<xsl:variable name="hora" select="substring($number,1,2)" />
		<xsl:variable name="minuto" select="substring($number,3,2)" />
		<xsl:variable name="segundo" select="substring($number,5,2)" />
		<xsl:value-of select="concat($hora,'h',$minuto,'m',$segundo,'s')"/>
	</xsl:template>
	
	<xsl:template name="FORMAT-AMOUNT">
		<xsl:param name="number" select="0"/>
		<xsl:param name="format">#.##0,00'&#160;&#160;&#160;';#.##0,00 CR</xsl:param>
		<xsl:call-template name="FORMAT-DOUBLE">
			<xsl:with-param name="number" select="$number"/>
			<xsl:with-param name="format" select="$format"/>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="FORMAT-CURRENCY">
		<xsl:param name="number" select="0"/>
		<xsl:param name="currencyLabel" select="'R$ '"/>
		<xsl:variable name="formattedAmount">
			<xsl:call-template name="FORMAT-AMOUNT">
				<xsl:with-param name="number" select="$number"/>
				</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat($currencyLabel,$formattedAmount)"/>
	</xsl:template>  
	
	<xsl:template name="FORMAT-HREF-URL">
		<xsl:param name="downloadUri" select="'do'"/>
		<xsl:param name="accountNumber" select="'acc'"/>
		<xsl:param name="dueDate" select="'due'"/>
		<xsl:param name="formatCode" select="'html'"/>
		<xsl:param name="referencedFile" select="''"/>
		<xsl:param name="displayText" select="''"/>
		<xsl:variable name="formattedDueDate" select="concat(substring($dueDate,7,2),'-',substring($dueDate,5,2),'-',substring($dueDate,1,4))"/>
			<a href="{$downloadUri}?acc={$accountNumber}&amp;duedt={$formattedDueDate}&amp;format={$formatCode}&amp;key={$referencedFile}">
				<xsl:value-of select="$displayText"/>
			</a>
	</xsl:template>
	
	<xsl:template name="BAR_CODE">
		<xsl:variable name="barcode" select="java:br.com.auster.common.xsl.extensions.BarCode.new()" /> 
		<fo:external-graphic src="conf/image/pdf/images/fake.gif"/>
	</xsl:template>


</xsl:stylesheet>
