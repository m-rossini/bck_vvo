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
 
  
	<xsl:template name="pagina5_pf" >
		
	<!-- cria uma página para cada numero de telefone -->	
	<xsl:for-each select="$subscription">
	
	<!-- variaveis de verificacao de todos os itens da pagina -->
	
	<xsl:variable name="verificaNumerosEspecificos" select="sum(OPERATOR_CALL/VAS_TOTAL/@UsedUnits)"/>
	
	<xsl:variable name="verificaNumeros0500" select="sum(OPERATOR_CALL/Calls0500Total/@UsedUnits)" />
	
	<xsl:variable name="verificaServicosTerceiros" select="sum(OPERATOR_CALL/PARTY_3RD_TOTAL/@UsedUnits)" />
	
	<xsl:variable name="verificaTorpedos" select="sum(OPERATOR_CALL/SMS_TOTAL/@UsedUnits)" />
	<xsl:variable name="verificaTonsImagens" select="sum(OPERATOR_CALL/TonesAndImagesTotal/@UsedUnits)" />
	<xsl:variable name="verificaJogosAplicacoes" select="sum(OPERATOR_CALL/GamesAndApplicationsTotal/@UsedUnits)" />
	<xsl:variable name="verificaWap" select="sum(OPERATOR_CALL/WAPTotal/@UsedUnits)" />
	<xsl:variable name="verificaVivoPlay" select="sum(OPERATOR_CALL/PlayTotal/@UsedUnits)" />
	<xsl:variable name="verificaVivoZap" select="sum(OPERATOR_CALL/ZAPTotal/@UsedUnits)" />
	
	<xsl:variable name="verificaSomaServicosDados" select="$verificaTorpedos + $verificaTonsImagens +  $verificaJogosAplicacoes + $verificaWap + $verificaVivoPlay + $verificaVivoZap" />

	<xsl:variable name="verificaOutrosVoz" select="sum(OPERATOR_CALL/VoiceServicesTotal/@UsedUnits)"/>
	
	<xsl:variable name="verificaSomaPagina" select="$verificaNumerosEspecificos + $verificaNumeros0500 + $verificaServicosTerceiros + $verificaSomaServicosDados + $verificaOutrosVoz "/>
	
	<!--  fim das variaveis de verificacao -->
	
	<!-- verifica pagina -->
	<xsl:if test="$verificaSomaPagina != 0" >

<xsl:variable name="pageCounter"><xsl:number /></xsl:variable>		
<html id="session5_">'<xsl:value-of select="$pageCounter"/>'

<head>
<link href="../portal/css/fatura_css/fatura.css" rel="stylesheet" type="text/css" />
<script language="javascript">

if(navigator.appName == 'Microsoft Internet Explorer'){
	document.write('<link href="../portal/css/fatura_css/faturaIE.css" rel="stylesheet" type="text/css" />');
}

</script>
</head>

<body>
<!--
<div id="container_geral" class="container_geral">
<div id="container_fatura" class="container_fatura">
-->
<!-- página 5 PF -->

<div id="pagina5" class="pagina5">
	
	<!-- cabecalho incomum a todas as paginas -->
	<div class="cabecalho">
		<div class="cabecalho1"></div>
		<div class="cabecalho2"></div>
		<div class="cabecalho3"></div>
	</div>
	<!-- fim cabecalho -->
	
	<!-- sub cabecalho informacoes de nome endereco cliente e vivo -->
	<div class="subCabecalho">
		<div class="subCabecalho1">
			<div class="subCabecalho1_1">
					<span id="regraEstilo" title="R52-02">
					<span id="regraEstilo" title="R52-03">
					<span id="regraEstilo" title="R78-01">
					<span id="regraEstilo" title="R78-02">
					<span id="regraEstilo" title="R78-03">
				
				
				<span class="f12"><span id="R52_nomeCliente"><span id="R78_nomeCliente"><b><xsl:value-of select="$context/BILLING_ADDRESS/@CustomerName"/></b></span></span></span><br></br>
				<span class="f12"><b><xsl:value-of select="$context/BILLING_ADDRESS/@AddressLine2"/></b></span><br></br>
				<span class="f12"><b><xsl:value-of select="$context/BILLING_ADDRESS/@AddressLine3"/></b></span><br></br>
				<span class="f12"><b><xsl:value-of select="$context/BILLING_ADDRESS/@AddressLine4"/></b></span><br></br>
				<span class="f12"><b><xsl:value-of select="$context/BILLING_ADDRESS/@AddressLine5"/></b></span><br></br>
					</span>
					</span>
					</span>
					</span>
					</span>
			</div>
		</div>
		<div class="subCabecalho2">
			<div class="subCabecalho2_1" style="padding-left:100px;">
				<xsl:value-of select="$opera/@NAME" /><br></br>
				<xsl:value-of select="$opera/@ADDRESS" /><br></br>
				Ins.Mun. <xsl:value-of select="$opera/@INSC_MUNICIPAL" />
				CNPJ <xsl:value-of select="$opera/@CNPJ" /><br></br>
				
				<span class="f12">
				<b>Plano: <xsl:value-of select="ENTIRE_SUBSCRIPTION_TOTAL/ACTIVATION_TOTAL/ACTIVATION_DETAIL/@Descricao" /></b><br></br>
				Mês de Referência: <xsl:value-of select="vivo:DateFormat.formatMMYYYY(/SIRS/CYCLE_SUMMARY/@BillingDate)"/><br></br>
				<b>Número da Conta:<xsl:value-of select="$accountNumber"/></b><br></br>
				<b>Número do Telefone:<xsl:value-of select="@PhoneNumber"/></b><br></br>
				Nome: <xsl:value-of select="$context/BILLING_ADDRESS/@AddressLine1"/><br></br>
				<br></br>
				<span style="text-align:right;width:280px;"><b>Página 0000005/0000006</b></span>
				</span>
			</div>
		</div>
	</div>
	<!-- fim do sub cabecalho -->
	
	<!-- conteúdo da página5 PF -->
	<div class="f14" style="width:776px;float:left" >
		<b>DETALHAMENTO DE UTILIZAÇÃO:   VIVO S.A.</b>
	</div> 
	
	
	<!--  verificacao de chamadas a numeros especificos  -->
	<xsl:if test="$verificaNumerosEspecificos != 0" >
	
	<!-- Chamadas a serviços de Número específicos 590T -->
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Chamadas a Serviços de Números Específicos</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<!-- por operadora -->
	
	
	<xsl:for-each select="OPERATOR_CALL/VAS_TOTAL">
		<br></br>
		<div style="width:776;float:left;">
			<div class="f12" style="width:506px;float:left;">
				<b></b>
				<br></br>
			</div>
			<div class="f12" style="width:70px;float:left;text-align:right;">
				<b>Subtotal:</b>
			</div>
			<div class="f12" style="width:100px;float:left;text-align:right;">
				<b>
						<xsl:call-template name="FORMAT-HMS">
							<xsl:with-param name="number" select="@UsedUnits" />
						</xsl:call-template>
						</b>
			</div>
			<div class="f12" style="width:100px;float:left;text-align:right;">
				<b>
				<xsl:variable name="valorMonetarioVariavel6"
					select="sum(@Subtotal)"/>
				<xsl:call-template name="FORMAT-DOUBLE">
					<xsl:with-param name="number" select="$valorMonetarioVariavel6"/>
				</xsl:call-template>
				</b>
			</div>
		</div>
		
		<div style="width:776px;float:left;">
			<div class="f11" style="width:40px;float:left;">
				<b>Seq.:</b><br></br>
			</div>
						
			<div class="f11" style="width:81px;float:left;text-align:left;">
				<b>Data</b><br></br>
			</div>
			
			<div class="f11" style="width:80px;float:left;text-align:left;">
				<b>Hora Início</b><br></br>
			</div>
			
			<div class="f11" style="width:200px;float:left;text-align:left;">
				<b>Descrição</b><br></br>
			</div>
			
			<div class="f11" style="width:175px;float:left;text-align:left;">
				<b>Número Chamado</b><br></br>
			</div>
						
			<div class="f11" style="width:100px;float:left;text-align:left;">
				<b>Duração</b><br></br>
			</div>
			
			<div class="f11" style="width:100px;float:left;text-align:right;">
				<b>Valor</b><br></br>
			</div>
			
		</div>
		
		<!-- 590D -->
		
			
		<xsl:for-each select="VAS_DETAIL">
			
			<xsl:variable name="contador"><xsl:number /></xsl:variable>
			
			<div style="width:776px;float:left;">
				<span id="regraEstilo" title="R01-01">
				<span id="regraEstilo" title="R01-01">
				<span id="regraEstilo" title="R01-02">
				<span id="regraEstilo" title="R01-03">
				<span id="regraEstilo" title="R01-04">
				<span id="regraEstilo" title="R01-05">
				<span id="regraEstilo" title="R02-1">
				<span id="regraEstilo" title="R02-2">
				<span id="regraEstilo" title="R02-3">
				<span id="regraEstilo" title="R05-1">
				<span id="regraEstilo" title="R05-2">
				<span id="regraEstilo" title="R05-3">
				<span id="regraEstilo" title="R05-03">
				<span id="regraEstilo" title="R06-01">
				<span id="regraEstilo" title="R06-02">
				<span id="regraEstilo" title="R06-03">
				<span id="regraEstilo" title="R06-04">
				<span id="regraEstilo" title="R07-01">
				<span id="regraEstilo" title="R10-1">
				<span id="regraEstilo" title="R11-1">
				<span id="regraEstilo" title="R11-2">
				<span id="regraEstilo" title="R16-1">
				<span id="regraEstilo" title="R16-2">
				<span id="regraEstilo" title="R16-3">
				<span id="regraEstilo" title="R19-0">
				<span id="regraEstilo" title="R19-1">
				<span id="regraEstilo" title="R19-2">
				<span id="regraEstilo" title="R30-01">
				<span id="regraEstilo" title="R30-02">
				<span id="regraEstilo" title="R31-01">
				<span id="regraEstilo" title="R31-02">
				<span id="regraEstilo" title="R31-03">
				<span id="regraEstilo" title="R32-01">
				<span id="regraEstilo" title="R32-01c">
				<span id="regraEstilo" title="R32-02">
				<span id="regraEstilo" title="R32-03">
				<span id="regraEstilo" title="R32-04">
				<span id="regraEstilo" title="R32-05">
				<span id="regraEstilo" title="R32-06">
				<span id="regraEstilo" title="R50-01">
				<span id="regraEstilo" title="R50-02">
				<span id="regraEstilo" title="R50-03">
				<span id="regraEstilo" title="R56-01">
				<span id="regraEstilo" title="R83-01">
				<span id="regraEstilo" title="R83-02">
				<span id="regraEstilo" title="R83-03">
				<span id="regraEstilo" title="R83-04">
				<span id="regraEstilo" title="R83-05">
				<span id="regraEstilo" title="R83-06">
				<span id="regraEstilo" title="R83-07">
				<span id="regraEstilo" title="R83-08">
				<span id="regraEstilo" title="R83-09">
				<span id="regraEstilo" title="R83-10">
				<span id="regraEstilo" title="R83-11">
				<span id="regraEstilo" title="R83-12">
				<span id="regraEstilo" title="R83-13">
				<span id="regraEstilo" title="R83-14">
				<span id="regraEstilo" title="R83-15">
				<span id="regraEstilo" title="R83-16">
				<span id="regraEstilo" title="R83-17">
				<div class="f11" style="width:40px;float:left;">
					<xsl:value-of select="$contador"/><br></br>
				</div>
				<span id="R01_value1">
				<span id="R02_value1">
				<span id="R05_value1">
				<span id="R06_data">
				<span id="R10_data">
				<span id="R11_value1">
				<span id="R16_data">
				<span id="R19_data">
				<span id="R30_data">
				<span id="R31_data">
				<span id="R32_data">
				<span id="R50_value1">
				<span id="R56_value1">
				<span id="R83_data">
				<div class="f11" style="width:81px;float:left;">
					<xsl:value-of select="vivo:DateFormat.formatDDMMYY(@Date)" /><br></br>
				</div>
								</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>

				<span id="R01_value2">
				<span id="R02_value2">
				<span id="R05_value2">
				<span id="R06_hora">
				<span id="R10_hora">
				<span id="R11_value2">
				<span id="R16_hora">
				<span id="R19_hora">
				<span id="R30_hora">
				<span id="R31_hora">
				<span id="R32_hora">
				<span id="R50_value2">
				<span id="R56_value2">
				<span id="R83_hora">
				<div class="f11" style="width:80px;float:left;">
					<xsl:call-template name="FORMAT-HMS-INTEIRO">
								<xsl:with-param name="number" select="@Time" />
							</xsl:call-template>
					<br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				
				<div class="f11" style="width:200px;float:left;">
					<xsl:value-of select="@Destination" /><br></br>
				</div>
				<span id="R01_value1">
				<span id="R02_value1">
				<span id="R06_destino">
				<span id="R07_destino2">
				<span id="R50_value1">
				<div class="f11" style="width:175px;float:left;">
					<xsl:value-of select="@NumberCalled" /><br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				<span id="R07_duracao2">
				<div class="f11" style="width:100px;float:left;">
					<xsl:call-template name="FORMAT-HMS">
						<xsl:with-param name="number" select="@Duration" />
					</xsl:call-template>
					<br></br>
				</div>
				</span>
				<span id="R07_valor2">
				<div class="f11" style="width:97px;float:left;text-align:right;">
					<xsl:call-template name="FORMAT-DOUBLE">
						<xsl:with-param name="number" select="@Amount"/>
					</xsl:call-template>
					<br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
			</div>
	
		</xsl:for-each>
	</xsl:for-each>
	</xsl:if>
	<!--  fim verificacao chamadas numeros especificos -->
	<!--fim por operadora -->
	<!-- fim Chamadas  -->
	
	
	<!--  verificacao de chamadas numeros 0500 -->
	<xsl:if test="$verificaNumeros0500 != 0" >
	
	<!-- Chamadas a numeros 0500 595T -->
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Chamadas para Números - 0500</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<!-- por operadora -->
	
	
	<xsl:for-each select="OPERATOR_CALL/Calls0500Total">
		<br></br>
		<div style="width:776;float:left;">
			<div class="f12" style="width:506px;float:left;">
				<b></b>
				<br></br>
			</div>
			<div class="f12" style="width:70px;float:left;text-align:right;">
				<b>Subtotal:</b>
			</div>
			<div class="f12" style="width:100px;float:left;text-align:right;">
				<b>
						<xsl:call-template name="FORMAT-HMS">
							<xsl:with-param name="number" select="@UsedUnits" />
						</xsl:call-template>
						</b>
			</div>
			<div class="f12" style="width:100px;float:left;text-align:right;">
				<b>
				<xsl:variable name="valorMonetarioVariavel6"
					select="sum(@Subtotal)"/>
				<xsl:call-template name="FORMAT-DOUBLE">
					<xsl:with-param name="number" select="$valorMonetarioVariavel6"/>
				</xsl:call-template>
				</b>
			</div>
		</div>
		
		<div style="width:776px;float:left;">
			<div class="f11" style="width:40px;float:left;">
				<b>Seq.:</b><br></br>
			</div>
						
			<div class="f11" style="width:81px;float:left;text-align:left;">
				<b>Data</b><br></br>
			</div>
			
			<div class="f11" style="width:80px;float:left;text-align:left;">
				<b>Hora Início</b><br></br>
			</div>
			
			<div class="f11" style="width:200px;float:left;text-align:left;">
				<b>Descrição</b><br></br>
			</div>
			
			<div class="f11" style="width:175px;float:left;text-align:left;">
				<b>Número Chamado</b><br></br>
			</div>
						
			<div class="f11" style="width:100px;float:left;text-align:left;">
				<b>Duração</b><br></br>
			</div>
			
			<div class="f11" style="width:100px;float:left;text-align:right;">
				<b>Valor</b><br></br>
			</div>
			
		</div>
		
		<!-- 595D -->
		
		
		
		<xsl:for-each select="Calls0500Detail">
		
			<xsl:variable name="contador"><xsl:number /></xsl:variable>
		
			<div style="width:776px;float:left;">
				<span id="regraEstilo" title="R01-01">
				<span id="regraEstilo" title="R01-02">
				<span id="regraEstilo" title="R01-03">
				<span id="regraEstilo" title="R01-04">
				<span id="regraEstilo" title="R01-05">
				<span id="regraEstilo" title="R02-1">
				<span id="regraEstilo" title="R02-2">
				<span id="regraEstilo" title="R02-3">
				<span id="regraEstilo" title="R05-1">
				<span id="regraEstilo" title="R05-2">
				<span id="regraEstilo" title="R05-3">
				<span id="regraEstilo" title="R05-03">
				<span id="regraEstilo" title="R06-01">
				<span id="regraEstilo" title="R06-02">
				<span id="regraEstilo" title="R06-03">
				<span id="regraEstilo" title="R06-04">
				<span id="regraEstilo" title="R07-01">
				<span id="regraEstilo" title="R10-1">
				<span id="regraEstilo" title="R11-1">
				<span id="regraEstilo" title="R11-2">
				<span id="regraEstilo" title="R16-1">
				<span id="regraEstilo" title="R16-2">
				<span id="regraEstilo" title="R16-3">
				<span id="regraEstilo" title="R19-0">
				<span id="regraEstilo" title="R19-1">
				<span id="regraEstilo" title="R19-2">
				<span id="regraEstilo" title="R30-01">
				<span id="regraEstilo" title="R30-02">
				<span id="regraEstilo" title="R31-01">
				<span id="regraEstilo" title="R31-02">
				<span id="regraEstilo" title="R31-03">
				<span id="regraEstilo" title="R32-01">
				<span id="regraEstilo" title="R32-01c">
				<span id="regraEstilo" title="R32-02">
				<span id="regraEstilo" title="R32-03">
				<span id="regraEstilo" title="R32-04">
				<span id="regraEstilo" title="R32-05">
				<span id="regraEstilo" title="R32-06">
				<span id="regraEstilo" title="R50-01">
				<span id="regraEstilo" title="R50-02">
				<span id="regraEstilo" title="R50-03">
				<span id="regraEstilo" title="R56-01">
				<span id="regraEstilo" title="R83-01">
				<span id="regraEstilo" title="R83-02">
				<span id="regraEstilo" title="R83-03">
				<span id="regraEstilo" title="R83-04">
				<span id="regraEstilo" title="R83-05">
				<span id="regraEstilo" title="R83-06">
				<span id="regraEstilo" title="R83-07">
				<span id="regraEstilo" title="R83-08">
				<span id="regraEstilo" title="R83-09">
				<span id="regraEstilo" title="R83-10">
				<span id="regraEstilo" title="R83-11">
				<span id="regraEstilo" title="R83-12">
				<span id="regraEstilo" title="R83-13">
				<span id="regraEstilo" title="R83-14">
				<span id="regraEstilo" title="R83-15">
				<span id="regraEstilo" title="R83-16">
				<span id="regraEstilo" title="R83-17">
				<div class="f11" style="width:40px;float:left;">
					<xsl:value-of select="$contador"/><br></br>
				</div>
				<span id="R01_value1">
				<span id="R02_value1">
				<span id="R05_value1">
				<span id="R06_data">
				<span id="R10_data">
				<span id="R11_value1">
				<span id="R16_data">
				<span id="R19_data">
				<span id="R30_data">
				<span id="R31_data">
				<span id="R32_data">
				<span id="R50_value1">
				<span id="R56_value1">
				<span id="R83_data">
				<div class="f11" style="width:81px;float:left;">
					<xsl:value-of select="vivo:DateFormat.formatDDMMYY(@Date)" /><br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>

				<span id="R01_value2">
				<span id="R02_value2">
				<span id="R05_value2">
				<span id="R06_hora">
				<span id="R10_hora">
				<span id="R11_value2">
				<span id="R16_hora">
				<span id="R19_hora">
				<span id="R30_hora">
				<span id="R31_hora">
				<span id="R32_hora">
				<span id="R50_value2">
				<span id="R56_value2">
				<span id="R83_hora">
				<div class="f11" style="width:80px;float:left;">
					<xsl:call-template name="FORMAT-HMS-INTEIRO">
								<xsl:with-param name="number" select="@Time" />
							</xsl:call-template>
					<br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				
				<div class="f11" style="width:200px;float:left;">
					<xsl:value-of select="@Destination" /><br></br>
				</div>
				<span id="R07_destino2">
				<div class="f11" style="width:175px;float:left;">
					<xsl:value-of select="@NumberCalled" /><br></br>
				</div>
				</span>
				<span id="R07_duracao2">
				<div class="f11" style="width:100px;float:left;">
					<xsl:call-template name="FORMAT-HMS">
						<xsl:with-param name="number" select="@Duration" />
					</xsl:call-template>
					<br></br>
				</div>
				</span>
				<span id="R07_valor2">
				<div class="f11" style="width:97px;float:left;text-align:right;">
					<xsl:call-template name="FORMAT-DOUBLE">
						<xsl:with-param name="number" select="@Amount"/>
					</xsl:call-template>
					<br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
			</div>
	
		</xsl:for-each>
	
	</xsl:for-each>
	
	</xsl:if>
	
	<!--  fim verifica 0500 -->
	<!--fim por operadora -->
	<!-- fim Chamadas  -->
	
	
	
	<!--  verifica servicos prestados por terceiros -->
	
	<xsl:if test="$verificaServicosTerceiros != 0">
	
	<!-- Chamadas a numeros prestados por terceiros 600T -->
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Serviços Prestados por Terceiros</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<!-- por operadora -->
	
	
	<xsl:for-each select="OPERATOR_CALL/PARTY_3RD_TOTAL">
		<br></br>
		<div style="width:776;float:left;">
			<div class="f12" style="width:506px;float:left;">
				<b></b>
				<br></br>
			</div>
			<div class="f12" style="width:70px;float:left;text-align:right;">
				<b>Subtotal:</b>
			</div>
			<div class="f12" style="width:100px;float:left;text-align:right;">
				<b>
						<xsl:call-template name="FORMAT-HMS">
							<xsl:with-param name="number" select="@UsedUnits" />
						</xsl:call-template>
						</b>
			</div>
			<div class="f12" style="width:100px;float:left;text-align:right;">
				<b>
				<xsl:variable name="valorMonetarioVariavel6"
					select="sum(@Subtotal)"/>
				<xsl:call-template name="FORMAT-DOUBLE">
					<xsl:with-param name="number" select="$valorMonetarioVariavel6"/>
				</xsl:call-template>
				</b>
			</div>
		</div>
		
		<div style="width:776px;float:left;">
			<div class="f11" style="width:40px;float:left;">
				<b>Seq.:</b><br></br>
			</div>
						
			<div class="f11" style="width:81px;float:left;text-align:left;">
				<b>Data</b><br></br>
			</div>
			
			<div class="f11" style="width:80px;float:left;text-align:left;">
				<b>Hora Início</b><br></br>
			</div>
			
			<div class="f11" style="width:200px;float:left;text-align:left;">
				<b>Descrição</b><br></br>
			</div>
			
			<div class="f11" style="width:175px;float:left;text-align:left;">
				<b>Número Chamado</b><br></br>
			</div>
						
			<div class="f11" style="width:100px;float:left;text-align:left;">
				<b>Duração</b><br></br>
			</div>
			
			<div class="f11" style="width:100px;float:left;text-align:right;">
				<b>Valor</b><br></br>
			</div>
			
		</div>
		
		<!-- 600D -->
		
		<xsl:for-each select="PARTY_3RD_DETAIL">
	
		<xsl:variable name="contador"><xsl:number /></xsl:variable>
		
			<div style="width:776px;float:left;">
				<span id="regraEstilo" title="R01-01">
				<span id="regraEstilo" title="R01-02">
				<span id="regraEstilo" title="R01-03">
				<span id="regraEstilo" title="R01-04">
				<span id="regraEstilo" title="R01-05">
				<span id="regraEstilo" title="R02-1">
				<span id="regraEstilo" title="R02-2">
				<span id="regraEstilo" title="R02-3">
				<span id="regraEstilo" title="R05-1">
				<span id="regraEstilo" title="R05-2">
				<span id="regraEstilo" title="R05-3">
				<span id="regraEstilo" title="R05-03">
				<span id="regraEstilo" title="R06-01">
				<span id="regraEstilo" title="R06-02">
				<span id="regraEstilo" title="R06-03">
				<span id="regraEstilo" title="R06-04">
				<span id="regraEstilo" title="R07-01">
				<span id="regraEstilo" title="R10-1">
				<span id="regraEstilo" title="R11-1">
				<span id="regraEstilo" title="R11-2">
				<span id="regraEstilo" title="R16-1">
				<span id="regraEstilo" title="R16-2">
				<span id="regraEstilo" title="R16-3">
				<span id="regraEstilo" title="R19-0">
				<span id="regraEstilo" title="R19-1">
				<span id="regraEstilo" title="R19-2">
				<span id="regraEstilo" title="R30-01">
				<span id="regraEstilo" title="R30-02">
				<span id="regraEstilo" title="R31-01">
				<span id="regraEstilo" title="R31-02">
				<span id="regraEstilo" title="R31-03">
				<span id="regraEstilo" title="R32-01">
				<span id="regraEstilo" title="R32-01c">
				<span id="regraEstilo" title="R32-02">
				<span id="regraEstilo" title="R32-03">
				<span id="regraEstilo" title="R32-04">
				<span id="regraEstilo" title="R32-05">
				<span id="regraEstilo" title="R32-06">
				<span id="regraEstilo" title="R50-01">
				<span id="regraEstilo" title="R50-02">
				<span id="regraEstilo" title="R50-03">
				<span id="regraEstilo" title="R56-01">
				<span id="regraEstilo" title="R83-01">
				<span id="regraEstilo" title="R83-02">
				<span id="regraEstilo" title="R83-03">
				<span id="regraEstilo" title="R83-04">
				<span id="regraEstilo" title="R83-05">
				<span id="regraEstilo" title="R83-06">
				<span id="regraEstilo" title="R83-07">
				<span id="regraEstilo" title="R83-08">
				<span id="regraEstilo" title="R83-09">
				<span id="regraEstilo" title="R83-10">
				<span id="regraEstilo" title="R83-11">
				<span id="regraEstilo" title="R83-12">
				<span id="regraEstilo" title="R83-13">
				<span id="regraEstilo" title="R83-14">
				<span id="regraEstilo" title="R83-15">
				<span id="regraEstilo" title="R83-16">
				<span id="regraEstilo" title="R83-17">
					
				<div class="f11" style="width:40px;float:left;">
					<xsl:value-of select="$contador"/><br></br>
				</div>
				<span id="R01_value1">
				<span id="R02_value1">
				<span id="R05_value1">
				<span id="R06_data">
				<span id="R10_data">
				<span id="R11_value1">
				<span id="R16_data">
				<span id="R19_data">
				<span id="R30_data">
				<span id="R31_data">
				<span id="R32_data">
				<span id="R50_value1">
				<span id="R56_value1">
				<span id="R83_data">
				<div class="f11" style="width:81px;float:left;">
					<xsl:value-of select="vivo:DateFormat.formatDDMMYY(@Date)" /><br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>

				<span id="R01_value2">
				<span id="R02_value2">
				<span id="R05_value2">
				<span id="R06_hora">
				<span id="R10_hora">
				<span id="R11_value2">
				<span id="R16_hora">
				<span id="R19_hora">
				<span id="R30_hora">
				<span id="R31_hora">
				<span id="R32_hora">
				<span id="R50_value2">
				<span id="R56_value2">
				<span id="R83_hora">
				<div class="f11" style="width:80px;float:left;">
					<xsl:call-template name="FORMAT-HMS-INTEIRO">
								<xsl:with-param name="number" select="@Time" />
							</xsl:call-template>
					<br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				
				<div class="f11" style="width:200px;float:left;">
					<xsl:value-of select="@ServicePlan" /><br></br>
				</div>
				<span id="R07_destino2">
				<div class="f11" style="width:175px;float:left;">
					<xsl:value-of select="@NumberCalled" /><br></br>
				</div>
				</span>
				<span id="R07_duracao2">
				<div class="f11" style="width:100px;float:left;">
					<xsl:call-template name="FORMAT-HMS">
						<xsl:with-param name="number" select="@Duration" />
					</xsl:call-template>
					<br></br>
				</div>
				</span>
				<span id="R07_valor2">
				<div class="f11" style="width:97px;float:left;text-align:right;">
					<xsl:call-template name="FORMAT-DOUBLE">
						<xsl:with-param name="number" select="@Amount"/>
					</xsl:call-template>
					<br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
			</div>
	
		</xsl:for-each>
	
	</xsl:for-each>
	
	<!-- fim Chamadas  -->
	</xsl:if>
	<!--  fim verifica servicos terceiros -->
	
	
	
	<!--  verifica servicos de dados totais -->
	
	<xsl:if test="$verificaSomaServicosDados != 0 ">
	
	
	<!-- Utilizacao dos servicos de dados 650T, 655T, 660T, 665T, 670T, 675T -->
	
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Utilização de Serviços de Dados</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<!-- torpedos semi detalhado
	
	<div class="f12" style="width:776px;float:left;">
		<br></br>
		<b>Torpedos</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	 por tipo 650
	
	
	
		
		<div style="width:776;float:left;">
			<div class="f12" style="width:506px;float:left;">
				<b></b>
				<br></br>
			</div>
			<div class="f12" style="width:70px;float:left;text-align:right;">
				
			</div>
			<div class="f12" style="width:100px;float:left;text-align:right;">
				<b>Subtotal:</b>
			</div>
			<div class="f12" style="width:100px;float:left;text-align:right;">
				<b>
				<xsl:variable name="valorMonetarioVariavel6"
					select="sum(OPERATOR_CALL/SMS_TOTAL/@Subtotal)"/>
				<xsl:call-template name="FORMAT-DOUBLE">
					<xsl:with-param name="number" select="$valorMonetarioVariavel6"/>
				</xsl:call-template>
				</b>
			</div>
		</div>
		
		<div style="width:776px;float:left;">
			<div class="f11" style="width:156px;float:left;">
				<b>Descrição</b><br></br>
			</div>
						
			<div class="f11" style="width:155px;float:left;text-align:left;">
				<b>Mensagens Inclusas</b><br></br>
			</div>
			
			<div class="f11" style="width:155px;float:left;text-align:left;">
				<b>Mensagens Utilizadas</b><br></br>
			</div>
			
			<div class="f11" style="width:155px;float:left;text-align:left;">
				<b>Mensagens Excedidas</b><br></br>
			</div>
			
			<div class="f11" style="width:155px;float:left;text-align:right;">
				<b>Valor Excedido R$</b><br></br>
			</div>

		</div>

		<xsl:for-each select="OPERATOR_CALL/SMS_TOTAL">

		<div style="width:776px;float:left;">
			
			<div class="f11" style="width:156px;float:left;">
				<xsl:value-of select="@ServicePlan"/><br></br>
			</div>
			
			<div class="f11" style="width:155px;float:left;">
				<xsl:call-template name="FORMAT-HMS">
				<xsl:with-param name="number" select="@IncludedUnits" />
			</xsl:call-template>
			<br></br>
			</div>
			
						
			<div class="f11" style="width:155px;float:left;">
						<xsl:call-template name="FORMAT-HMS">
							<xsl:with-param name="number" select="@UsedUnits" />
						</xsl:call-template>
						<br></br>
			</div>
			
			<div class="f11" style="width:155px;float:left;">
				<xsl:value-of select="@BilledUnits" /><br></br>
			</div>
			
			<div class="f11" style="width:155px;float:left;text-align:right;">
				<xsl:call-template name="FORMAT-DOUBLE">
					<xsl:with-param name="number" select="@Subtotal"/>
				</xsl:call-template>
				<br></br>
			</div>
			
		</div>
	
	</xsl:for-each>
	
	
	
	 torpedos -->
	 
	 
	 <!-- verifica torpedos -->
	 <xsl:if test="$verificaTorpedos != 0">
	 
	 <!--  torpedos detalahdos -->
	
	<div class="f12" style="width:776px;float:left;">
		<br></br>
		<b>Torpedos</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<!-- por tipo 650-->

		<div style="width:776;float:left;">
			<div class="f12" style="width:506px;float:left;">
				<b></b>
				<br></br>
			</div>
			<div class="f12" style="width:70px;float:left;text-align:right;">
				
			</div>
			<div class="f12" style="width:100px;float:left;text-align:right;">
				<b>Subtotal:</b>
			</div>
			<div class="f12" style="width:100px;float:left;text-align:right;">
				<b>
				<xsl:variable name="valorMonetarioVariavel6"
					select="sum(OPERATOR_CALL/SMS_TOTAL/@Subtotal)"/>
				<xsl:call-template name="FORMAT-DOUBLE">
					<xsl:with-param name="number" select="$valorMonetarioVariavel6"/>
				</xsl:call-template>
				</b>
			</div>
		</div>
		
		<div style="width:776px;float:left;">
			<div class="f11" style="width:40px;float:left;">
				<b>Seq.:</b><br></br>
			</div>
						
			<div class="f11" style="width:81px;float:left;text-align:left;">
				<b>Data</b><br></br>
			</div>
			
			<div class="f11" style="width:80px;float:left;text-align:left;">
				<b>Hora Início</b><br></br>
			</div>
			
			<div class="f11" style="width:100px;float:left;text-align:left;">
				<b>Origem</b><br></br>
			</div>
			
			<div class="f11" style="width:100px;float:left;text-align:left;">
				<b>Núm. Chamado</b><br></br>
			</div>
			
			<div class="f11" style="width:175px;float:left;text-align:left;">
				<b>Serviço</b><br></br>
			</div>
						
			<div class="f11" style="width:100px;float:left;text-align:left;">
				<b>Unidade</b><br></br>
			</div>
			
			<div class="f11" style="width:100px;float:left;text-align:right;">
				<b>Valor</b><br></br>
			</div>
			
		</div>
		
		<!-- 650D -->
		<xsl:for-each select="OPERATOR_CALL/SMS_TOTAL/SMS_DETAIL">
			
			<xsl:variable name="contador"><xsl:number /></xsl:variable>
	
			<div style="width:776px;float:left;">
				<span id="regraEstilo" title="R01-01">
				<span id="regraEstilo" title="R01-02">
				<span id="regraEstilo" title="R01-03">
				<span id="regraEstilo" title="R01-04">
				<span id="regraEstilo" title="R01-05">
				<span id="regraEstilo" title="R02-1">
				<span id="regraEstilo" title="R02-2">
				<span id="regraEstilo" title="R02-3">
				<span id="regraEstilo" title="R05-1">
				<span id="regraEstilo" title="R05-2">
				<span id="regraEstilo" title="R05-3">
				<span id="regraEstilo" title="R05-03">
				<span id="regraEstilo" title="R06-01">
				<span id="regraEstilo" title="R06-02">
				<span id="regraEstilo" title="R06-03">
				<span id="regraEstilo" title="R06-04">
				<span id="regraEstilo" title="R10-1">
				<span id="regraEstilo" title="R11-1">
				<span id="regraEstilo" title="R11-2">
				<span id="regraEstilo" title="R16-1">
				<span id="regraEstilo" title="R16-2">
				<span id="regraEstilo" title="R16-3">
				<span id="regraEstilo" title="R19-0">
				<span id="regraEstilo" title="R19-1">
				<span id="regraEstilo" title="R19-2">
				<span id="regraEstilo" title="R30-01">
				<span id="regraEstilo" title="R30-02">
				<span id="regraEstilo" title="R31-01">
				<span id="regraEstilo" title="R31-02">
				<span id="regraEstilo" title="R31-03">
				<span id="regraEstilo" title="R32-01">
				<span id="regraEstilo" title="R32-01c">
				<span id="regraEstilo" title="R32-02">
				<span id="regraEstilo" title="R32-03">
				<span id="regraEstilo" title="R32-04">
				<span id="regraEstilo" title="R32-05">
				<span id="regraEstilo" title="R32-06">
				<span id="regraEstilo" title="R50-01">
				<span id="regraEstilo" title="R50-02">
				<span id="regraEstilo" title="R50-03">
				<span id="regraEstilo" title="R56-01">
				<span id="regraEstilo" title="R83-01">
				<span id="regraEstilo" title="R83-02">
				<span id="regraEstilo" title="R83-03">
				<span id="regraEstilo" title="R83-04">
				<span id="regraEstilo" title="R83-05">
				<span id="regraEstilo" title="R83-06">
				<span id="regraEstilo" title="R83-07">
				<span id="regraEstilo" title="R83-08">
				<span id="regraEstilo" title="R83-09">
				<span id="regraEstilo" title="R83-10">
				<span id="regraEstilo" title="R83-11">
				<span id="regraEstilo" title="R83-12">
				<span id="regraEstilo" title="R83-13">
				<span id="regraEstilo" title="R83-14">
				<span id="regraEstilo" title="R83-15">
				<span id="regraEstilo" title="R83-16">
				<span id="regraEstilo" title="R83-17">
						
				<div class="f11" style="width:40px;float:left;">
					<xsl:value-of select="$contador"/><br></br>
				</div>
				<span id="R01_value1">
				<span id="R02_value1">
				<span id="R05_value1">
				<span id="R06_data">
				<span id="R10_data">
				<span id="R11_value1">
				<span id="R16_data">
				<span id="R19_data">
				<span id="R30_data">
				<span id="R31_data">
				<span id="R32_data">
				<span id="R50_value1">
				<span id="R56_value1">
				<span id="R83_data">
				<div class="f11" style="width:81px;float:left;">
					<xsl:value-of select="vivo:DateFormat.formatDDMMYY(@Date)" /><br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>

				<span id="R01_value2">
				<span id="R02_value2">
				<span id="R05_value2">
				<span id="R06_hora">
				<span id="R10_hora">
				<span id="R11_value2">
				<span id="R16_hora">
				<span id="R19_hora">
				<span id="R30_hora">
				<span id="R31_hora">
				<span id="R32_hora">
				<span id="R50_value2">
				<span id="R56_value2">
				<span id="R83_hora">
				<div class="f11" style="width:80px;float:left;">
					<xsl:call-template name="FORMAT-HMS-INTEIRO">
								<xsl:with-param name="number" select="@Time" />
							</xsl:call-template>
					<br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				<div class="f11" style="width:100px;float:left;">
					<xsl:value-of select="@Destination" /><br></br>
				</div>
				<div class="f11" style="width:100px;float:left;">
					<xsl:value-of select="@NumberCalled" /><br></br>
				</div>
				<div class="f11" style="width:175px;float:left;">
					<xsl:value-of select="@ServicePlan" /><br></br>
				</div>
				<div class="f11" style="width:100px;float:left;">
					<xsl:value-of select="@UnitDescription" /><br></br>
				</div>
				<div class="f11" style="width:100px;float:left;text-align:right;">
					<xsl:call-template name="FORMAT-DOUBLE">
						<xsl:with-param name="number" select="@Amount"/>
					</xsl:call-template>
					<br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
			</div>
	
		</xsl:for-each>
	<!-- fim torpedos  -->
	</xsl:if>
	<!--  fim verifica torpedos  -->
	
	
	<!--  verifica tons e imagens  -->
	<xsl:if test="verificaTonsImagens != 0 ">
	
	<!-- toms e imagens -->
	
	<div class="f12" style="width:776px;float:left;">
		<br></br>
		<b>Tons e Imagens</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<!-- por tipo 655T-->
	
	
	<xsl:for-each select="OPERATOR_CALL/TonesAndImagesTotal">
		
		<div style="width:776;float:left;">
			<div class="f12" style="width:506px;float:left;">
				<b></b>
				<br></br>
			</div>
			<div class="f12" style="width:70px;float:left;text-align:right;">
				
			</div>
			<div class="f12" style="width:100px;float:left;text-align:right;">
				<b>Subtotal:</b>
			</div>
			<div class="f12" style="width:100px;float:left;text-align:right;">
				<b>
				<xsl:variable name="valorMonetarioVariavel6"
					select="sum(@Subtotal)"/>
				<xsl:call-template name="FORMAT-DOUBLE">
					<xsl:with-param name="number" select="$valorMonetarioVariavel6"/>
				</xsl:call-template>
				</b>
			</div>
		</div>
		
		<div style="width:776px;float:left;">
			<div class="f11" style="width:40px;float:left;">
				<b>Seq.:</b><br></br>
			</div>
						
			<div class="f11" style="width:81px;float:left;text-align:left;">
				<b>Data</b><br></br>
			</div>
			
			<div class="f11" style="width:80px;float:left;text-align:left;">
				<b>Hora Início</b><br></br>
			</div>
			
			<div class="f11" style="width:100px;float:left;text-align:left;">
				<b>Origem</b><br></br>
			</div>
			
			<div class="f11" style="width:150px;float:left;text-align:left;">
				<b>Serviço</b><br></br>
			</div>
			
			<div class="f11" style="width:125px;float:left;text-align:left;">
				<b>Quantidade</b><br></br>
			</div>
						
			<div class="f11" style="width:100px;float:left;text-align:left;">
				<b>Unidade</b><br></br>
			</div>
			
			<div class="f11" style="width:100px;float:left;text-align:right;">
				<b>Valor</b><br></br>
			</div>
			
		</div>
		
		<!-- 655D -->
		
		
		
		<xsl:for-each select="TonesAndImagesDetail">
			<xsl:variable name="contador"><xsl:number /></xsl:variable>
			
			<div style="width:776px;float:left;">
				<span id="regraEstilo" title="R01-01">
				<span id="regraEstilo" title="R01-02">
				<span id="regraEstilo" title="R01-03">
				<span id="regraEstilo" title="R01-04">
				<span id="regraEstilo" title="R01-05">
				<span id="regraEstilo" title="R02-1">
				<span id="regraEstilo" title="R02-2">
				<span id="regraEstilo" title="R02-3">
				<span id="regraEstilo" title="R05-1">
				<span id="regraEstilo" title="R05-2">
				<span id="regraEstilo" title="R05-3">
				<span id="regraEstilo" title="R05-03">
				<span id="regraEstilo" title="R06-01">
				<span id="regraEstilo" title="R06-02">
				<span id="regraEstilo" title="R06-03">
				<span id="regraEstilo" title="R06-04">
				<span id="regraEstilo" title="R07-01">
				<span id="regraEstilo" title="R10-1">
				<span id="regraEstilo" title="R11-1">
				<span id="regraEstilo" title="R11-2">
				<span id="regraEstilo" title="R16-1">
				<span id="regraEstilo" title="R16-2">
				<span id="regraEstilo" title="R16-3">
				<span id="regraEstilo" title="R19-0">
				<span id="regraEstilo" title="R19-1">
				<span id="regraEstilo" title="R19-2">
				<span id="regraEstilo" title="R30-01">
				<span id="regraEstilo" title="R30-02">
				<span id="regraEstilo" title="R31-01">
				<span id="regraEstilo" title="R31-02">
				<span id="regraEstilo" title="R31-03">
				<span id="regraEstilo" title="R32-01">
				<span id="regraEstilo" title="R32-01c">
				<span id="regraEstilo" title="R32-02">
				<span id="regraEstilo" title="R32-03">
				<span id="regraEstilo" title="R32-04">
				<span id="regraEstilo" title="R32-05">
				<span id="regraEstilo" title="R32-06">
				<span id="regraEstilo" title="R50-01">
				<span id="regraEstilo" title="R50-02">
				<span id="regraEstilo" title="R50-03">
				<span id="regraEstilo" title="R56-01">
				<span id="regraEstilo" title="R83-01">
				<span id="regraEstilo" title="R83-02">
				<span id="regraEstilo" title="R83-03">
				<span id="regraEstilo" title="R83-04">
				<span id="regraEstilo" title="R83-05">
				<span id="regraEstilo" title="R83-06">
				<span id="regraEstilo" title="R83-07">
				<span id="regraEstilo" title="R83-08">
				<span id="regraEstilo" title="R83-09">
				<span id="regraEstilo" title="R83-10">
				<span id="regraEstilo" title="R83-11">
				<span id="regraEstilo" title="R83-12">
				<span id="regraEstilo" title="R83-13">
				<span id="regraEstilo" title="R83-14">
				<span id="regraEstilo" title="R83-15">
				<span id="regraEstilo" title="R83-16">
				<span id="regraEstilo" title="R83-17">
					
				<div class="f11" style="width:40px;float:left;">
					<xsl:value-of select="$contador"/><br></br>
				</div>
				<span id="R01_value1">
				<span id="R02_value1">
				<span id="R05_value1">
				<span id="R06_data">
				<span id="R10_data">
				<span id="R11_value1">
				<span id="R16_data">
				<span id="R19_data">
				<span id="R30_data">
				<span id="R31_data">
				<span id="R32_data">
				<span id="R50_value1">
				<span id="R56_value1">
				<span id="R83_data">
				<div class="f11" style="width:81px;float:left;">
					<xsl:value-of select="vivo:DateFormat.formatDDMMYY(@Date)" /><br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				<span id="R01_value2">
				<span id="R02_value2">
				<span id="R05_value2">
				<span id="R06_hora">
				<span id="R10_hora">
				<span id="R11_value2">
				<span id="R16_hora">
				<span id="R19_hora">
				<span id="R30_hora">
				<span id="R31_hora">
				<span id="R32_hora">
				<span id="R50_value2">
				<span id="R56_value2">
				<span id="R83_hora">
				<div class="f11" style="width:80px;float:left;">
					<xsl:call-template name="FORMAT-HMS-INTEIRO">
								<xsl:with-param name="number" select="@Time" />
							</xsl:call-template>
					<br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				<span id="R07_destino2">
				<div class="f11" style="width:100px;float:left;">
					<xsl:value-of select="@NumberCalled" /><br></br>
				</div>
				</span>
				<div class="f11" style="width:150px;float:left;">
					<xsl:value-of select="@ServicePlan" /><br></br>
				</div>
				<span id="R07_duracao2">
				<div class="f11" style="width:125px;float:left;">
					<xsl:call-template name="FORMAT-HMS">
						<xsl:with-param name="number" select="@Duration" />
					</xsl:call-template>
					<br></br>
				</div>
				</span>
				<div class="f11" style="width:100px;float:left;">
					<xsl:value-of select="@UnitDescription" /><br></br>
				</div>
				<span id="R07_valor2">
				<div class="f11" style="width:97px;float:left;text-align:right;">
					<xsl:call-template name="FORMAT-DOUBLE">
						<xsl:with-param name="number" select="@Amount"/>
					</xsl:call-template>
					<br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
			</div>
	
		</xsl:for-each>
	
	</xsl:for-each>
	
	<!-- fim tons e imagens  -->
	</xsl:if>
	<!-- fim verifica tons imagens  -->
	
	
	<!--  verifica jogos e aplicacoes -->
	<xsl:if test="$verificaJogosAplicacoes != 0" >
	
	<!-- jogos e aplicacoes -->
	
	<div class="f12" style="width:776px;float:left;">
		<br></br>
		<b>Jogos e Aplicações</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<!-- por tipo 660T-->
	
	
	<xsl:for-each select="OPERATOR_CALL/GamesAndApplicationsTotal">
		
		<div style="width:776;float:left;">
			<div class="f12" style="width:506px;float:left;">
				<b></b>
				<br></br>
			</div>
			<div class="f12" style="width:70px;float:left;text-align:right;">
				
			</div>
			<div class="f12" style="width:100px;float:left;text-align:right;">
				<b>Subtotal:</b>
			</div>
			<div class="f12" style="width:100px;float:left;text-align:right;">
				<b>
				<xsl:variable name="valorMonetarioVariavel6"
					select="sum(@Subtotal)"/>
				<xsl:call-template name="FORMAT-DOUBLE">
					<xsl:with-param name="number" select="$valorMonetarioVariavel6"/>
				</xsl:call-template>
				</b>
			</div>
		</div>
		
		<div style="width:776px;float:left;">
			<div class="f11" style="width:40px;float:left;">
				<b>Seq.:</b><br></br>
			</div>
						
			<div class="f11" style="width:81px;float:left;text-align:left;">
				<b>Data</b><br></br>
			</div>
			
			<div class="f11" style="width:80px;float:left;text-align:left;">
				<b>Hora Início</b><br></br>
			</div>
			
			<div class="f11" style="width:100px;float:left;text-align:left;">
				<b>Origem</b><br></br>
			</div>
			
			<div class="f11" style="width:150px;float:left;text-align:left;">
				<b>Serviço</b><br></br>
			</div>
			
			<div class="f11" style="width:125px;float:left;text-align:left;">
				<b>Quantidade</b><br></br>
			</div>
						
			<div class="f11" style="width:100px;float:left;text-align:left;">
				<b>Unidade</b><br></br>
			</div>
			
			<div class="f11" style="width:100px;float:left;text-align:right;">
				<b>Valor</b><br></br>
			</div>
			
		</div>
		
		<!-- 655D -->
		
		<xsl:for-each select="GamesAndApplicationsDetail">
			
			<xsl:variable name="contador"><xsl:number /></xsl:variable>
			
			<div style="width:776px;float:left;">
				<span id="regraEstilo" title="R01-01">
				<span id="regraEstilo" title="R01-02">
				<span id="regraEstilo" title="R01-03">
				<span id="regraEstilo" title="R01-04">
				<span id="regraEstilo" title="R01-05">
				<span id="regraEstilo" title="R02-1">
				<span id="regraEstilo" title="R02-2">
				<span id="regraEstilo" title="R02-3">
				<span id="regraEstilo" title="R05-1">
				<span id="regraEstilo" title="R05-2">
				<span id="regraEstilo" title="R05-3">
				<span id="regraEstilo" title="R05-03">
				<span id="regraEstilo" title="R06-01">
				<span id="regraEstilo" title="R06-02">
				<span id="regraEstilo" title="R06-03">
				<span id="regraEstilo" title="R06-04">
				<span id="regraEstilo" title="R07-01">
				<span id="regraEstilo" title="R10-1">
				<span id="regraEstilo" title="R11-1">
				<span id="regraEstilo" title="R11-2">
				<span id="regraEstilo" title="R16-1">
				<span id="regraEstilo" title="R16-2">
				<span id="regraEstilo" title="R16-3">
				<span id="regraEstilo" title="R19-0">
				<span id="regraEstilo" title="R19-1">
				<span id="regraEstilo" title="R19-2">
				<span id="regraEstilo" title="R30-01">
				<span id="regraEstilo" title="R30-02">
				<span id="regraEstilo" title="R31-01">
				<span id="regraEstilo" title="R31-02">
				<span id="regraEstilo" title="R31-03">
				<span id="regraEstilo" title="R32-01">
				<span id="regraEstilo" title="R32-01c">
				<span id="regraEstilo" title="R32-02">
				<span id="regraEstilo" title="R32-03">
				<span id="regraEstilo" title="R32-04">
				<span id="regraEstilo" title="R32-05">
				<span id="regraEstilo" title="R32-06">
				<span id="regraEstilo" title="R50-01">
				<span id="regraEstilo" title="R50-02">
				<span id="regraEstilo" title="R50-03">
				<span id="regraEstilo" title="R56-01">
				<span id="regraEstilo" title="R83-01">
				<span id="regraEstilo" title="R83-02">
				<span id="regraEstilo" title="R83-03">
				<span id="regraEstilo" title="R83-04">
				<span id="regraEstilo" title="R83-05">
				<span id="regraEstilo" title="R83-06">
				<span id="regraEstilo" title="R83-07">
				<span id="regraEstilo" title="R83-08">
				<span id="regraEstilo" title="R83-09">
				<span id="regraEstilo" title="R83-10">
				<span id="regraEstilo" title="R83-11">
				<span id="regraEstilo" title="R83-12">
				<span id="regraEstilo" title="R83-13">
				<span id="regraEstilo" title="R83-14">
				<span id="regraEstilo" title="R83-15">
				<span id="regraEstilo" title="R83-16">
				<span id="regraEstilo" title="R83-17">
					
				<div class="f11" style="width:40px;float:left;">
					<xsl:value-of select="$contador"/><br></br>
				</div>
				<span id="R01_value1">
				<span id="R02_value1">
				<span id="R05_value1">
				<span id="R06_data">
				<span id="R10_data">
				<span id="R11_value1">
				<span id="R16_data">
				<span id="R19_data">
				<span id="R30_data">
				<span id="R31_data">
				<span id="R32_data">
				<span id="R50_value1">
				<span id="R56_value1">
				<span id="R83_data">
				<div class="f11" style="width:81px;float:left;">
					<xsl:value-of select="vivo:DateFormat.formatDDMMYY(@Date)" /><br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>

				<span id="R01_value2">
				<span id="R02_value2">
				<span id="R05_value2">
				<span id="R06_hora">
				<span id="R10_hora">
				<span id="R11_value2">
				<span id="R16_hora">
				<span id="R19_hora">
				<span id="R30_hora">
				<span id="R31_hora">
				<span id="R32_hora">
				<span id="R50_value2">
				<span id="R56_value2">
				<span id="R83_hora">
				<div class="f11" style="width:80px;float:left;">
					<xsl:call-template name="FORMAT-HMS-INTEIRO">
								<xsl:with-param name="number" select="@Time" />
							</xsl:call-template>
					<br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				<span id="R07_destino2">
				<div class="f11" style="width:100px;float:left;">
					<xsl:value-of select="@NumberCalled" /><br></br>
				</div>
				</span>
				<div class="f11" style="width:150px;float:left;">
					<xsl:value-of select="@ServicePlan" /><br></br>
				</div>
				<span id="R07_duracao2">
				<div class="f11" style="width:125px;float:left;">
					<xsl:call-template name="FORMAT-HMS">
						<xsl:with-param name="number" select="@Duration" />
					</xsl:call-template>
					<br></br>
				</div>
				</span>
				<div class="f11" style="width:100px;float:left;">
					<xsl:value-of select="@UnitDescription" /><br></br>
				</div>
				<span id="R07_valor2">
				<div class="f11" style="width:97px;float:left;text-align:right;">
					<xsl:call-template name="FORMAT-DOUBLE">
						<xsl:with-param name="number" select="@Amount"/>
					</xsl:call-template>
					<br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
			</div>
	
		</xsl:for-each>
	</xsl:for-each>
	<!-- fim jogos e aplicacoes  -->
	</xsl:if>
	<!-- fim verificacao jogos e aplicacoes -->
	
	
	<!--  verifica wap  -->
	<xsl:if test="$verificaWap != 0" >
	
	<!-- wap -->
	
	<div class="f12" style="width:776px;float:left;">
		<br></br>
		<b>Vivo Wap</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<!-- por tipo 665T-->
	
	
	<xsl:for-each select="OPERATOR_CALL/WAPTotal">
		
		<div style="width:776;float:left;">
			<div class="f12" style="width:506px;float:left;">
				<b></b>
				<br></br>
			</div>
			<div class="f12" style="width:70px;float:left;text-align:right;">
				
			</div>
			<div class="f12" style="width:100px;float:left;text-align:right;">
				<b>Subtotal:</b>
			</div>
			<div class="f12" style="width:100px;float:left;text-align:right;">
				<b>
				<xsl:variable name="valorMonetarioVariavel6"
					select="sum(@Subtotal)"/>
				<xsl:call-template name="FORMAT-DOUBLE">
					<xsl:with-param name="number" select="$valorMonetarioVariavel6"/>
				</xsl:call-template>
				</b>
			</div>
		</div>
		
		<div style="width:776px;float:left;">
			<div class="f11" style="width:40px;float:left;">
				<b>Seq.:</b><br></br>
			</div>
						
			<div class="f11" style="width:81px;float:left;text-align:left;">
				<b>Data</b><br></br>
			</div>
			
			<div class="f11" style="width:80px;float:left;text-align:left;">
				<b>Hora Início</b><br></br>
			</div>
			
			<div class="f11" style="width:100px;float:left;text-align:left;">
				<b>Origem</b><br></br>
			</div>
			
			<div class="f11" style="width:150px;float:left;text-align:left;">
				<b>Serviço</b><br></br>
			</div>
			
			<div class="f11" style="width:125px;float:left;text-align:left;">
				<b>Quantidade</b><br></br>
			</div>
						
			<div class="f11" style="width:100px;float:left;text-align:left;">
				<b>Unidade</b><br></br>
			</div>
			
			<div class="f11" style="width:100px;float:left;text-align:right;">
				<b>Valor</b><br></br>
			</div>
			
		</div>
		
		<!-- 665D -->
		
		<xsl:for-each select="WAPDetail">
			
			<xsl:variable name="contador"><xsl:number /></xsl:variable>
	
			<div style="width:776px;float:left;">
				<span id="regraEstilo" title="R01-01">
				<span id="regraEstilo" title="R01-02">
				<span id="regraEstilo" title="R01-03">
				<span id="regraEstilo" title="R01-04">
				<span id="regraEstilo" title="R01-05">
				<span id="regraEstilo" title="R02-1">
				<span id="regraEstilo" title="R02-2">
				<span id="regraEstilo" title="R02-3">
				<span id="regraEstilo" title="R05-1">
				<span id="regraEstilo" title="R05-2">
				<span id="regraEstilo" title="R05-3">
				<span id="regraEstilo" title="R05-03">
				<span id="regraEstilo" title="R06-01">
				<span id="regraEstilo" title="R06-02">
				<span id="regraEstilo" title="R06-03">
				<span id="regraEstilo" title="R06-04">
				<span id="regraEstilo" title="R10-1">
				<span id="regraEstilo" title="R11-1">
				<span id="regraEstilo" title="R11-2">
				<span id="regraEstilo" title="R16-1">
				<span id="regraEstilo" title="R16-2">
				<span id="regraEstilo" title="R16-3">
				<span id="regraEstilo" title="R19-0">
				<span id="regraEstilo" title="R19-1">
				<span id="regraEstilo" title="R19-2">
				<span id="regraEstilo" title="R20-0">
				<span id="regraEstilo" title="R20-1">
				<span id="regraEstilo" title="R20-2">
				<span id="regraEstilo" title="R20-3">
				<span id="regraEstilo" title="R20-4">
				<span id="regraEstilo" title="R20-5">
				<span id="regraEstilo" title="R30-01">
				<span id="regraEstilo" title="R30-02">
				<span id="regraEstilo" title="R31-01">
				<span id="regraEstilo" title="R31-02">
				<span id="regraEstilo" title="R31-03">
				<span id="regraEstilo" title="R32-01">
				<span id="regraEstilo" title="R32-01c">
				<span id="regraEstilo" title="R32-02">
				<span id="regraEstilo" title="R32-03">
				<span id="regraEstilo" title="R32-04">
				<span id="regraEstilo" title="R32-05">
				<span id="regraEstilo" title="R32-06">
				<span id="regraEstilo" title="R50-01">
				<span id="regraEstilo" title="R50-02">
				<span id="regraEstilo" title="R50-03">
				<span id="regraEstilo" title="R56-01">
				<span id="regraEstilo" title="R83-01">
				<span id="regraEstilo" title="R83-02">
				<span id="regraEstilo" title="R83-03">
				<span id="regraEstilo" title="R83-04">
				<span id="regraEstilo" title="R83-05">
				<span id="regraEstilo" title="R83-06">
				<span id="regraEstilo" title="R83-07">
				<span id="regraEstilo" title="R83-08">
				<span id="regraEstilo" title="R83-09">
				<span id="regraEstilo" title="R83-10">
				<span id="regraEstilo" title="R83-11">
				<span id="regraEstilo" title="R83-12">
				<span id="regraEstilo" title="R83-13">
				<span id="regraEstilo" title="R83-14">
				<span id="regraEstilo" title="R83-15">
				<span id="regraEstilo" title="R83-16">
				<span id="regraEstilo" title="R83-17">
				
				<div class="f11" style="width:40px;float:left;">
					<xsl:value-of select="$contador"/><br></br>
				</div>
				
				<span id="R01_value1">
				<span id="R02_value1">
				<span id="R05_value1">
				<span id="R06_data">
				<span id="R10_data">
				<span id="R11_value1">
				<span id="R16_data">
				<span id="R19_data">
				<span id="R30_data">
				<span id="R31_data">
				<span id="R32_data">
				<span id="R50_value1">
				<span id="R56_value1">
				<span id="R83_data">
				<div class="f11" style="width:81px;float:left;">
					<xsl:value-of select="vivo:DateFormat.formatDDMMYY(@Date)" /><br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>

				<span id="R01_value2">
				<span id="R02_value2">
				<span id="R05_value2">
				<span id="R06_hora">
				<span id="R10_hora">
				<span id="R11_value2">
				<span id="R16_hora">
				<span id="R19_hora">
				<span id="R30_hora">
				<span id="R31_hora">
				<span id="R32_hora">
				<span id="R50_value2">
				<span id="R56_value2">
				<span id="R83_hora">
				<div class="f11" style="width:80px;float:left;">
					<xsl:call-template name="FORMAT-HMS-INTEIRO">
								<xsl:with-param name="number" select="@Time" />
							</xsl:call-template>
					<br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				<div class="f11" style="width:100px;float:left;">
					<xsl:value-of select="@Origin" /><br></br>
				</div>
				<span id="R20_nomeDoServico">
				<div class="f11" style="width:150px;float:left;">
					<xsl:value-of select="@ServicePlan" /><br></br>
				</div>
				</span>
				<div class="f11" style="width:125px;float:left;">
					<xsl:call-template name="FORMAT-HMS">
						<xsl:with-param name="number" select="@Duration" />
					</xsl:call-template>
					<br></br>
				</div>
				<div class="f11" style="width:100px;float:left;">
					<xsl:value-of select="@UnitDescription" /><br></br>
				</div>
				<span id="R20_valorCobrado">
				<div class="f11" style="width:97px;float:left;text-align:right;">
					<xsl:call-template name="FORMAT-DOUBLE">
						<xsl:with-param name="number" select="@Amount"/>
					</xsl:call-template>
					<br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
			</div>
	
		</xsl:for-each>
	</xsl:for-each>
	<!-- fim wap  -->
	</xsl:if>
	<!--  fim verifica wap -->
	
	
	<!--  verifica vivo play -->
	<xsl:if test="$verificaVivoPlay != 0">
	
	<!-- vivo play  -->
	
	<div class="f12" style="width:776px;float:left;">
		<br></br>
		<b>Vivo Play</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<!-- por tipo 670T-->
	
	
	<xsl:for-each select="OPERATOR_CALL/PlayTotal">
		
		<div style="width:776;float:left;">
			<div class="f12" style="width:506px;float:left;">
				<b></b>
				<br></br>
			</div>
			<div class="f12" style="width:70px;float:left;text-align:right;">
				
			</div>
			<div class="f12" style="width:100px;float:left;text-align:right;">
				<b>Subtotal:</b>
			</div>
			<div class="f12" style="width:100px;float:left;text-align:right;">
				<b>
				<xsl:variable name="valorMonetarioVariavel6"
					select="sum(@Subtotal)"/>
				<xsl:call-template name="FORMAT-DOUBLE">
					<xsl:with-param name="number" select="$valorMonetarioVariavel6"/>
				</xsl:call-template>
				</b>
			</div>
		</div>
		
		<div style="width:776px;float:left;">
			<div class="f11" style="width:40px;float:left;">
				<b>Seq.:</b><br></br>
			</div>
						
			<div class="f11" style="width:81px;float:left;text-align:left;">
				<b>Data</b><br></br>
			</div>
			
			<div class="f11" style="width:80px;float:left;text-align:left;">
				<b>Hora Início</b><br></br>
			</div>
			
			<div class="f11" style="width:100px;float:left;text-align:left;">
				<b>Origem</b><br></br>
			</div>
			
			<div class="f11" style="width:150px;float:left;text-align:left;">
				<b>Serviço</b><br></br>
			</div>
			
			<div class="f11" style="width:125px;float:left;text-align:left;">
				<b>Quantidade</b><br></br>
			</div>
						
			<div class="f11" style="width:100px;float:left;text-align:left;">
				<b>Unidade</b><br></br>
			</div>
			
			<div class="f11" style="width:100px;float:left;text-align:right;">
				<b>Valor</b><br></br>
			</div>
			
		</div>
		
		<!-- 670D -->
		
		<xsl:for-each select="PlayDetail">
			
			<xsl:variable name="contador"><xsl:number /></xsl:variable>
	
			<div style="width:776px;float:left;">
				<span id="regraEstilo" title="R01-01">
				<span id="regraEstilo" title="R01-02">
				<span id="regraEstilo" title="R01-03">
				<span id="regraEstilo" title="R01-04">
				<span id="regraEstilo" title="R01-05">
				<span id="regraEstilo" title="R02-1">
				<span id="regraEstilo" title="R02-2">
				<span id="regraEstilo" title="R02-3">
				<span id="regraEstilo" title="R05-1">
				<span id="regraEstilo" title="R05-2">
				<span id="regraEstilo" title="R05-3">
				<span id="regraEstilo" title="R05-03">
				<span id="regraEstilo" title="R06-01">
				<span id="regraEstilo" title="R06-02">
				<span id="regraEstilo" title="R06-03">
				<span id="regraEstilo" title="R06-04">
				<span id="regraEstilo" title="R07-01">
				<span id="regraEstilo" title="R10-1">
				<span id="regraEstilo" title="R11-1">
				<span id="regraEstilo" title="R11-2">
				<span id="regraEstilo" title="R16-1">
				<span id="regraEstilo" title="R16-2">
				<span id="regraEstilo" title="R16-3">
				<span id="regraEstilo" title="R19-0">
				<span id="regraEstilo" title="R19-1">
				<span id="regraEstilo" title="R19-2">
				<span id="regraEstilo" title="R30-01">
				<span id="regraEstilo" title="R30-02">
				<span id="regraEstilo" title="R31-01">
				<span id="regraEstilo" title="R31-02">
				<span id="regraEstilo" title="R31-03">
				<span id="regraEstilo" title="R32-01">
				<span id="regraEstilo" title="R32-01c">
				<span id="regraEstilo" title="R32-02">
				<span id="regraEstilo" title="R32-03">
				<span id="regraEstilo" title="R32-04">
				<span id="regraEstilo" title="R32-05">
				<span id="regraEstilo" title="R32-06">
				<span id="regraEstilo" title="R50-01">
				<span id="regraEstilo" title="R50-02">
				<span id="regraEstilo" title="R50-03">
				<span id="regraEstilo" title="R56-01">
				<span id="regraEstilo" title="R83-01">
				<span id="regraEstilo" title="R83-02">
				<span id="regraEstilo" title="R83-03">
				<span id="regraEstilo" title="R83-04">
				<span id="regraEstilo" title="R83-05">
				<span id="regraEstilo" title="R83-06">
				<span id="regraEstilo" title="R83-07">
				<span id="regraEstilo" title="R83-08">
				<span id="regraEstilo" title="R83-09">
				<span id="regraEstilo" title="R83-10">
				<span id="regraEstilo" title="R83-11">
				<span id="regraEstilo" title="R83-12">
				<span id="regraEstilo" title="R83-13">
				<span id="regraEstilo" title="R83-14">
				<span id="regraEstilo" title="R83-15">
				<span id="regraEstilo" title="R83-16">
				<span id="regraEstilo" title="R83-17">
				
				<div class="f11" style="width:40px;float:left;">
					<xsl:value-of select="$contador"/><br></br>
				</div>
				
				<span id="R01_value1">
				<span id="R02_value1">
				<span id="R05_value1">
				<span id="R06_data">
				<span id="R10_data">
				<span id="R11_value1">
				<span id="R16_data">
				<span id="R19_data">
				<span id="R30_data">
				<span id="R31_data">
				<span id="R32_data">
				<span id="R50_value1">
				<span id="R56_value1">
				<span id="R83_data">
				<div class="f11" style="width:81px;float:left;">
					<xsl:value-of select="vivo:DateFormat.formatDDMMYY(@Date)" /><br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>

				<span id="R01_value2">
				<span id="R02_value2">
				<span id="R05_value2">
				<span id="R06_hora">
				<span id="R10_hora">
				<span id="R11_value2">
				<span id="R16_hora">
				<span id="R19_hora">
				<span id="R30_hora">
				<span id="R31_hora">
				<span id="R32_hora">
				<span id="R50_value2">
				<span id="R56_value2">
				<span id="R83_hora">
				<div class="f11" style="width:80px;float:left;">
					<xsl:call-template name="FORMAT-HMS-INTEIRO">
								<xsl:with-param name="number" select="@Time" />
							</xsl:call-template>
					<br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				<span id="R07_destino2">
				<div class="f11" style="width:100px;float:left;">
					<xsl:value-of select="@NumberCalled" /><br></br>
				</div>
				</span>
				
				<div class="f11" style="width:150px;float:left;">
					<xsl:value-of select="@captionPhrase" /><br></br>
				</div>
				<span id="R07_duracao2">
				<div class="f11" style="width:125px;float:left;">
					<xsl:call-template name="FORMAT-HMS">
						<xsl:with-param name="number" select="@Duration" />
					</xsl:call-template>
					<br></br>
				</div>
				</span>
				<div class="f11" style="width:100px;float:left;">
					<xsl:value-of select="@UnitDescription" /><br></br>
				</div>
				<span id="R07_valor2">
				<div class="f11" style="width:97px;float:left;text-align:right;">
					<xsl:call-template name="FORMAT-DOUBLE">
						<xsl:with-param name="number" select="@Amount"/>
					</xsl:call-template>
					<br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
			</div>
	
		</xsl:for-each>
	
	</xsl:for-each>
	
	<!-- fim vivo play  -->
	</xsl:if>
	<!--  fim verifica vivo play -->
	
	
	<!--  verifica vivo zap -->
	<xsl:if test="$verificaVivoZap != 0">
	
	<!-- vivo ZAP  -->
	
	<div class="f12" style="width:776px;float:left;">
		<br></br>
		<b>Vivo Zap</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<!-- por tipo 675T-->
	
	
	<xsl:for-each select="OPERATOR_CALL/ZAPTotal">
		
		<div style="width:776;float:left;">
			<div class="f12" style="width:506px;float:left;">
				<b></b>
				<br></br>
			</div>
			<div class="f12" style="width:70px;float:left;text-align:right;">
				
			</div>
			<div class="f12" style="width:100px;float:left;text-align:right;">
				<b>Subtotal:</b>
			</div>
			<div class="f12" style="width:100px;float:left;text-align:right;">
				<b>
				<xsl:variable name="valorMonetarioVariavel6"
					select="sum(@Subtotal)"/>
				<xsl:call-template name="FORMAT-DOUBLE">
					<xsl:with-param name="number" select="$valorMonetarioVariavel6"/>
				</xsl:call-template>
				</b>
			</div>
		</div>
		
		<div style="width:776px;float:left;">
			<div class="f11" style="width:40px;float:left;">
				<b>Seq.:</b><br></br>
			</div>
						
			<div class="f11" style="width:81px;float:left;text-align:left;">
				<b>Data</b><br></br>
			</div>
			
			<div class="f11" style="width:80px;float:left;text-align:left;">
				<b>Hora Início</b><br></br>
			</div>
			
			<div class="f11" style="width:100px;float:left;text-align:left;">
				<b>Origem</b><br></br>
			</div>
			
			<div class="f11" style="width:150px;float:left;text-align:left;">
				<b>Serviço</b><br></br>
			</div>
			
			<div class="f11" style="width:125px;float:left;text-align:left;">
				<b>Quantidade</b><br></br>
			</div>
						
			<div class="f11" style="width:100px;float:left;text-align:left;">
				<b>Unidade</b><br></br>
			</div>
			
			<div class="f11" style="width:100px;float:left;text-align:right;">
				<b>Valor</b><br></br>
			</div>
			
		</div>
		
		<!-- 675D -->
		
		<xsl:for-each select="ZAPDetail">
			
			<xsl:variable name="contador"><xsl:number /></xsl:variable>
	
			<div style="width:776px;float:left;">
				<span id="regraEstilo" title="R01-01">
				<span id="regraEstilo" title="R01-02">
				<span id="regraEstilo" title="R01-03">
				<span id="regraEstilo" title="R01-04">
				<span id="regraEstilo" title="R01-05">
				<span id="regraEstilo" title="R02-1">
				<span id="regraEstilo" title="R02-2">
				<span id="regraEstilo" title="R02-3">
				<span id="regraEstilo" title="R05-1">
				<span id="regraEstilo" title="R05-2">
				<span id="regraEstilo" title="R05-3">
				<span id="regraEstilo" title="R05-03">
				<span id="regraEstilo" title="R06-01">
				<span id="regraEstilo" title="R06-02">
				<span id="regraEstilo" title="R06-03">
				<span id="regraEstilo" title="R06-04">
				<span id="regraEstilo" title="R07-01">
				<span id="regraEstilo" title="R10-1">
				<span id="regraEstilo" title="R11-1">
				<span id="regraEstilo" title="R11-2">
				<span id="regraEstilo" title="R16-1">
				<span id="regraEstilo" title="R16-2">
				<span id="regraEstilo" title="R16-3">
				<span id="regraEstilo" title="R19-0">
				<span id="regraEstilo" title="R19-1">
				<span id="regraEstilo" title="R19-2">
				<span id="regraEstilo" title="R30-01">
				<span id="regraEstilo" title="R30-02">
				<span id="regraEstilo" title="R31-01">
				<span id="regraEstilo" title="R31-02">
				<span id="regraEstilo" title="R31-03">
				<span id="regraEstilo" title="R32-01">
				<span id="regraEstilo" title="R32-01c">
				<span id="regraEstilo" title="R32-02">
				<span id="regraEstilo" title="R32-03">
				<span id="regraEstilo" title="R32-04">
				<span id="regraEstilo" title="R32-05">
				<span id="regraEstilo" title="R32-06">
				<span id="regraEstilo" title="R50-01">
				<span id="regraEstilo" title="R50-02">
				<span id="regraEstilo" title="R50-03">
				<span id="regraEstilo" title="R56-01">
				<span id="regraEstilo" title="R83-01">
				<span id="regraEstilo" title="R83-02">
				<span id="regraEstilo" title="R83-03">
				<span id="regraEstilo" title="R83-04">
				<span id="regraEstilo" title="R83-05">
				<span id="regraEstilo" title="R83-06">
				<span id="regraEstilo" title="R83-07">
				<span id="regraEstilo" title="R83-08">
				<span id="regraEstilo" title="R83-09">
				<span id="regraEstilo" title="R83-10">
				<span id="regraEstilo" title="R83-11">
				<span id="regraEstilo" title="R83-12">
				<span id="regraEstilo" title="R83-13">
				<span id="regraEstilo" title="R83-14">
				<span id="regraEstilo" title="R83-15">
				<span id="regraEstilo" title="R83-16">
				<span id="regraEstilo" title="R83-17">
				<div class="f11" style="width:40px;float:left;">
					<xsl:value-of select="$contador"/><br></br>
				</div>
				<span id="R01_value1">
				<span id="R02_value1">
				<span id="R05_value1">
				<span id="R06_data">
				<span id="R10_data">
				<span id="R11_value1">
				<span id="R16_data">
				<span id="R19_data">
				<span id="R30_data">
				<span id="R31_data">
				<span id="R32_data">
				<span id="R50_value1">
				<span id="R56_value1">
				<span id="R83_data">
				<div class="f11" style="width:81px;float:left;">
					<xsl:value-of select="vivo:DateFormat.formatDDMMYY(@Date)" /><br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>

				<span id="R01_value2">
				<span id="R02_value2">
				<span id="R05_value2">
				<span id="R06_hora">
				<span id="R10_hora">
				<span id="R11_value2">
				<span id="R16_hora">
				<span id="R19_hora">
				<span id="R30_hora">
				<span id="R31_hora">
				<span id="R32_hora">
				<span id="R50_value2">
				<span id="R56_value2">
				<span id="R83_hora">
				<div class="f11" style="width:80px;float:left;">
					<xsl:call-template name="FORMAT-HMS-INTEIRO">
								<xsl:with-param name="number" select="@Time" />
							</xsl:call-template>
					<br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				<span id="R07_destino2">
				<div class="f11" style="width:100px;float:left;">
					<xsl:value-of select="@NumberCalled" /><br></br>
				</div>
				</span>
				<div class="f11" style="width:150px;float:left;">
					<xsl:value-of select="@captionPhrase" /><br></br>
				</div>
				<span id="R07_duracao2">
				<div class="f11" style="width:125px;float:left;">
					<xsl:call-template name="FORMAT-HMS">
						<xsl:with-param name="number" select="@Duration" />
					</xsl:call-template>
					<br></br>
				</div>
				</span>
				<div class="f11" style="width:100px;float:left;">
					<xsl:value-of select="@UnitDescription" /><br></br>
				</div>
				<span id="R07_valor2">
				<div class="f11" style="width:97px;float:left;text-align:right;">
					<xsl:call-template name="FORMAT-DOUBLE">
						<xsl:with-param name="number" select="@Amount"/>
					</xsl:call-template>
					<br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
			</div>
	
		</xsl:for-each>
	
	</xsl:for-each>
	
	<!-- fim vivo ZAP  -->
	</xsl:if>
	<!--  fim verifica vivo ZAP -->
	
	
	</xsl:if>
	<!--  fim verifica servicos dados -->
	
	
	<!--  verifica total outros servicos voz -->
	<xsl:if test="$verificaOutrosVoz != 0">
	
	
	<!-- Utilização de outros serviços de voz  -->
	
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Utilização de Outros Serviços de Voz</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<!-- Utilização de outros serviços de voz  -->
	
	<div class="f12" style="width:776px;float:left;">
		<b>Serviço de Voz</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<!-- por tipo 680T-->
		
		<div style="width:776;float:left;">
			<div class="f12" style="width:506px;float:left;">
				<b></b>
				<br></br>
			</div>
			<div class="f12" style="width:70px;float:left;text-align:right;">
				
			</div>
			<div class="f12" style="width:100px;float:left;text-align:right;">
				<b>Subtotal:</b>
			</div>
			<div class="f12" style="width:100px;float:left;text-align:right;">
				<b>
				<xsl:variable name="valorMonetarioVariavel6"
					select="sum(OPERATOR_CALL/VoiceServicesTotal/@Subtotal)"/>
				<xsl:call-template name="FORMAT-DOUBLE">
					<xsl:with-param name="number" select="$valorMonetarioVariavel6"/>
				</xsl:call-template>
				</b>
			</div>
		</div>
		
		<div style="width:776px;float:left;">
			<div class="f11" style="width:40px;float:left;">
				<b>Seq.:</b><br></br>
			</div>
						
			<div class="f11" style="width:81px;float:left;text-align:left;">
				<b>Data</b><br></br>
			</div>
			
			<div class="f11" style="width:80px;float:left;text-align:left;">
				<b>Hora Início</b><br></br>
			</div>
			
			<div class="f11" style="width:175px;float:left;text-align:left;">
				<b>Descrição</b><br></br>
			</div>
			
			<div class="f11" style="width:200px;float:left;text-align:left;">
				<b>Número Chamado</b><br></br>
			</div>
			
			<div class="f11" style="width:100px;float:left;text-align:left;">
				<b>Duração</b><br></br>
			</div>
			
			<div class="f11" style="width:100px;float:left;text-align:right;">
				<b>Valor</b><br></br>
			</div>
			
		</div>
		
		<!-- 680D -->
		
		<xsl:for-each select="OPERATOR_CALL/VoiceServicesTotal/VoiceServicesDetail">
			
			<xsl:variable name="contador"><xsl:number /></xsl:variable>
	
			<div style="width:776px;float:left;">
				<span id="regraEstilo" title="R01-01">
				<span id="regraEstilo" title="R01-01">
				<span id="regraEstilo" title="R01-02">
				<span id="regraEstilo" title="R01-03">
				<span id="regraEstilo" title="R01-04">
				<span id="regraEstilo" title="R01-05">
				<span id="regraEstilo" title="R02-1">
				<span id="regraEstilo" title="R02-2">
				<span id="regraEstilo" title="R02-3">
				<span id="regraEstilo" title="R05-1">
				<span id="regraEstilo" title="R05-2">
				<span id="regraEstilo" title="R05-3">
				<span id="regraEstilo" title="R05-03">
				<span id="regraEstilo" title="R06-01">
				<span id="regraEstilo" title="R06-02">
				<span id="regraEstilo" title="R06-03">
				<span id="regraEstilo" title="R06-04">
				<span id="regraEstilo" title="R07-01">
				<span id="regraEstilo" title="R10-1">
				<span id="regraEstilo" title="R11-1">
				<span id="regraEstilo" title="R11-2">
				<span id="regraEstilo" title="R16-1">
				<span id="regraEstilo" title="R16-2">
				<span id="regraEstilo" title="R16-3">
				<span id="regraEstilo" title="R19-0">
				<span id="regraEstilo" title="R19-1">
				<span id="regraEstilo" title="R19-2">
				<span id="regraEstilo" title="R30-01">
				<span id="regraEstilo" title="R30-02">
				<span id="regraEstilo" title="R31-01">
				<span id="regraEstilo" title="R31-02">
				<span id="regraEstilo" title="R31-03">
				<span id="regraEstilo" title="R32-01">
				<span id="regraEstilo" title="R32-01c">
				<span id="regraEstilo" title="R32-02">
				<span id="regraEstilo" title="R32-03">
				<span id="regraEstilo" title="R32-04">
				<span id="regraEstilo" title="R32-05">
				<span id="regraEstilo" title="R32-06">
				<span id="regraEstilo" title="R50-01">
				<span id="regraEstilo" title="R50-02">
				<span id="regraEstilo" title="R50-03">
				<span id="regraEstilo" title="R56-01">
				<span id="regraEstilo" title="R83-01">
				<span id="regraEstilo" title="R83-02">
				<span id="regraEstilo" title="R83-03">
				<span id="regraEstilo" title="R83-04">
				<span id="regraEstilo" title="R83-05">
				<span id="regraEstilo" title="R83-06">
				<span id="regraEstilo" title="R83-07">
				<span id="regraEstilo" title="R83-08">
				<span id="regraEstilo" title="R83-09">
				<span id="regraEstilo" title="R83-10">
				<span id="regraEstilo" title="R83-11">
				<span id="regraEstilo" title="R83-12">
				<span id="regraEstilo" title="R83-13">
				<span id="regraEstilo" title="R83-14">
				<span id="regraEstilo" title="R83-15">
				<span id="regraEstilo" title="R83-16">
				<span id="regraEstilo" title="R83-17">
				<div class="f11" style="width:40px;float:left;">
					<xsl:value-of select="$contador"/><br></br>
				</div>
				<span id="R01_value1">
				<span id="R02_value1">
				<span id="R05_value1">
				<span id="R06_data">
				<span id="R10_data">
				<span id="R11_value1">
				<span id="R16_data">
				<span id="R19_data">
				<span id="R30_data">
				<span id="R31_data">
				<span id="R32_data">
				<span id="R50_value1">
				<span id="R56_value1">
				<span id="R83_data">
				<div class="f11" style="width:81px;float:left;">
					<xsl:value-of select="vivo:DateFormat.formatDDMMYY(@Date)" /><br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>

				<span id="R01_value2">
				<span id="R02_value2">
				<span id="R05_value2">
				<span id="R06_hora">
				<span id="R10_hora">
				<span id="R11_value2">
				<span id="R16_hora">
				<span id="R19_hora">
				<span id="R30_hora">
				<span id="R31_hora">
				<span id="R32_hora">
				<span id="R50_value2">
				<span id="R56_value2">
				<span id="R83_hora">
				<div class="f11" style="width:80px;float:left;">
					<xsl:call-template name="FORMAT-HMS-INTEIRO">
								<xsl:with-param name="number" select="@Time" />
							</xsl:call-template>
					<br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				<div class="f11" style="width:175px;float:left;">
					<xsl:value-of select="@Destination" /><br></br>
				</div>
				<span id="R07_destino2">
				<div class="f11" style="width:200px;float:left;">
					<xsl:value-of select="@NumberCalled" /><br></br>
				</div>
				</span>
				<span id="R07_duracao2">
				<div class="f11" style="width:100px;float:left;">
					<xsl:call-template name="FORMAT-HMS">
						<xsl:with-param name="number" select="@Duration" />
					</xsl:call-template>
					<br></br>
				</div>
				</span>
				<span id="R07_valor2">
				<div class="f11" style="width:97px;float:left;text-align:right;">
					<xsl:call-template name="FORMAT-DOUBLE">
						<xsl:with-param name="number" select="@Amount"/>
					</xsl:call-template>
					<br></br>
				</div>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
			</div>
	
		</xsl:for-each>
	
	<!-- fim servicos de voz  -->
	
	</xsl:if>
	<!-- fim da verificacao servicos voz -->
	
	

	<!-- inclusao de somatoria para correcao de producao -->
	<!-- subtrair do total o valor equivalente ao detalhamento da proxima sessao -->

	<xsl:variable name="totalDetalhamento" select="$context/@TotalDueAmount" />



	<!-- soma das chamadas de longa distancia 535T, 540T, 570T, 575T, 545T, 550T, 580T (conferido)-->
	<!-- a soma informada eh referente a proxima sessao -->
	<xsl:variable name="valorMonetarioVariavel12_0"
		select="sum(OPERATOR_CALL/LD_INTRASTATE_CALLS_TOTAL/@Subtotal)"/>
	<xsl:variable name="valorMonetarioVariavel12_1"
		select="sum(OPERATOR_CALL/LD_INTERSTATE_CALLS_TOTAL/@Subtotal)"/>
	<xsl:variable name="valorMonetarioVariavel12_2"
		select="sum(OPERATOR_CALL/ROAM_MOC_LD_TOTAL/@Subtotal)"/>
	<xsl:variable name="valorMonetarioVariavel12_3"
		select="sum(OPERATOR_CALL/ROAM_MTC_LD_TOTAL/@Subtotal)"/>
	<xsl:variable name="valorMonetarioVariavel12_4"
		select="sum(OPERATOR_CALL/COLLECT_CALLS_TOTAL/@Subtotal)"/>
	<xsl:variable name="valorMonetarioVariavel12_5"
		select="sum(OPERATOR_CALL/INTERNATIONAL_CALLS_TOTAL/@Subtotal)"/>
	<xsl:variable name="valorMonetarioVariavel12_6"
		select="sum(OPERATOR_CALL/ROAM_MOC_INTERNATIONAL_TOTAL/@Subtotal)"/>
	<xsl:variable name="totalDetalhamentoProximo"
		select="$valorMonetarioVariavel12_0 + $valorMonetarioVariavel12_1 + $valorMonetarioVariavel12_2 + $valorMonetarioVariavel12_3 + $valorMonetarioVariavel12_4 + $valorMonetarioVariavel12_5 + $valorMonetarioVariavel12_6"/>


	<xsl:variable name="totalDetalhamentoAplicado" select="$totalDetalhamento - $totalDetalhamentoProximo" />

	<br></br>
	<br></br>
		<!-- detalhamento total -->
		
		<div class="f14" style="width:776px;float:left" >
		<div class="f14" style="width:500px;float:left;">
		<b>TOTAL DO DETALHAMENTO - VIVO S.A.</b>
		</div>
		<div class="f14" style="width:276px;float:left;text-align:right;">
			R$&#160;
			<xsl:call-template name="FORMAT-DOUBLE">
				<xsl:with-param name="number" select="$totalDetalhamentoAplicado"/>
			</xsl:call-template>
			</div>
		</div> 
	
		<div class="linhaDivisoria" />
		
		<!--  fim detalhamento total -->

	<!-- fim da inclusao de somatoria para correcao de producao -->





	<!-- fim do conteúdo da página 5 PF-->
	
</div>


<!-- fim página 5 PF -->

<!--
</div>
</div>
-->
</body>
</html>


</xsl:if>
<!-- fim verifica pagina -->


</xsl:for-each>

</xsl:template>   

</xsl:stylesheet>
