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
 
  
	<xsl:template name="pagina4_pj" >
		
	<!-- cria uma p�gina para cada numero de telefone -->	
	<xsl:for-each select="$subscription">
	
	
	<!-- variaveis de verificacao de todos os itens da pagina -->
	
	<xsl:variable name="verificaCobrar" select="sum(OPERATOR_CALL/LOCAL_COLLECT_CALLS_TOTAL/@UsedUnits)" />
	
	<xsl:variable name="verificaForaOriginadas" select="sum(OPERATOR_CALL/ROAM_MOC_LOCAL_TOTAL/@UsedUnits)" />
	<xsl:variable name="verificaForaRecebidas" select="sum(OPERATOR_CALL/ROAM_MTC_LOCAL_TOTAL/@UsedUnits)" />
	<xsl:variable name="verificaForaMundo" select="sum(OPERATOR_CALL/ROAM_MTC_INTERNATIONAL_TOTAL/@UsedUnits)" />
	
	<xsl:variable name="verificaSomaFora" select="$verificaForaOriginadas + $verificaForaRecebidas + $verificaForaMundo" />
	
	<xsl:variable name="verificaSomaPagina" select="$verificaCobrar + $verificaSomaFora"/>
	<!--  fim das variaveis do sistema -->
	
	<!-- verifica pagina -->
	<xsl:if test="$verificaSomaPagina != 0" >

<xsl:variable name="pageCounter"><xsl:number /></xsl:variable>		
<html id="session4_">'<xsl:value-of select="$pageCounter"/>'

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
<!-- p�gina 4 PJ -->

<div id="pagina4" class="pagina4">
	
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
				M�s de Refer�ncia: <xsl:value-of select="vivo:DateFormat.formatMMYYYY(/SIRS/CYCLE_SUMMARY/@BillingDate)"/><br></br>
				<b>N�mero da Conta:<xsl:value-of select="$accountNumber"/></b><br></br>
				<b>N�mero do Telefone:<xsl:value-of select="@PhoneNumber"/></b><br></br>
				Nome: <xsl:value-of select="$context/BILLING_ADDRESS/@AddressLine1"/><br></br>
				<br></br>
				<span style="text-align:right;width:280px;"><b>P�gina 0000004/0000006</b></span>
				</span>
			</div>
		</div>
	</div>
	<!-- fim do sub cabecalho -->
	
	<!-- conte�do da p�gina4 PF -->
	<div class="f14" style="width:776px;float:left" >
		<b>DETALHAMENTO DE UTILIZA��O:   VIVO S.A.</b>
	</div> 
	
	
	<!--  verifica chamda dentro da area de rigistro e chamadas a cobrar  -->
	
	<xsl:if test="$verificaCobrar != 0" >
	
	<!-- Chamadas dentro da area de registro -->
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Chamadas Dentro da �rea de Registro (continua��o)</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<!-- Chamadas!Locais! recebidas a cobrar 520T-->
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Chamadas Recebidas a Cobrar - Locais</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<xsl:for-each select="OPERATOR_CALL/LOCAL_COLLECT_CALLS_TOTAL">
	
	<!-- para vivo -->
	<div style="width:776;float:left;margin-top:-17px;">
		

		<span id="regraEstilo" title="R20-0" >
		<span id="regraEstilo" title="R20-1" >
		<span id="regraEstilo" title="R20-2" >
		<span id="regraEstilo" title="R20-3" >
		<span id="regraEstilo" title="R20-4" >
		<span id="regraEstilo" title="R20-5" >
		<span id="regraEstilo" title="R32-07" >
		<span id="regraEstilo" title="R32-08" >
		

		<!--  para vivo  -->
		

		<span id="R20_nomeDoServico" >
		<span id="R32_nomeServico" >		
		<div class="f12" style="width:496px;float:left;">
			<b>
				<xsl:value-of select="@ServicePlan" />
			</b>
			<br></br>
		</div>
		</span>
		</span>
		


		<div class="f12" style="width:100px;float:left;text-align:left;">
			<b>Subtotal:</b>
			<br></br>
		</div>
		
		<!--  minutos  -->
		<div class="f12" style="width:100px;float:left;text-align:left;">
			<b>
			<xsl:call-template name="FORMAT-HMS">
				<xsl:with-param name="number" select="@UsedUnits" />
			</xsl:call-template>
			</b>
			<br></br>
		</div>
		<!--  valor  -->

		<span id="R20_valorCobrado">
		<span id="R32_valor">
		<div class="f12" style="width:80px;float:left;text-align:right;">
			<b>
			<xsl:call-template name="FORMAT-DOUBLE">
				<xsl:with-param name="number" select="@Subtotal"/>
			</xsl:call-template>
			</b>
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

	</div>
	<!--  para vivo  -->
	
	
	<div style="width:776px;float:left;">
		<div class="f12" style="width:56px;float:left;text-align:left;">
			<b>Seq.</b><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;text-align:left;">
			<b>Data</b><br></br>
		</div>
		
		<div class="f12" style="width:90px;float:left;text-align:left;">
			<b>Hora In�cio</b><br></br>
		</div>
		
		<div class="f12" style="width:180px;float:left;text-align:left;">
			<b>Origem</b><br></br>
		</div>
		
		<div class="f12" style="width:100px;float:left;text-align:left;">
			<b>N�m. Origem</b><br></br>
		</div>
		
		<div class="f12" style="width:100px;float:left;text-align:center;">
			<b>Tarifa</b><br></br>
		</div>
		
		<div class="f12" style="width:100px;float:left;text-align:left;">
			<b>Dura��o</b><br></br>
		</div>
		
		<div class="f12" style="width:80px;float:left;text-align:right;">
			<b>Valor R$</b><br></br>
		</div>
	</div>
	
	<xsl:for-each select="LOCAL_COLLECT_CALLS_DETAIL">
	<xsl:variable name="contador"><xsl:number /></xsl:variable>
	
		<div style="width:776px;float:left;">
			<div class="f12" style="width:56px;float:left;text-align:left;">
				<xsl:value-of select="$contador"/>
			</div>
			
			<div class="f12" style="width:70px;float:left;text-align:left;">
				<xsl:value-of select="vivo:DateFormat.formatDDMMYY(@Date)"/>
			</div>
			
			<div class="f12" style="width:90px;float:left;text-align:left;">
				<xsl:call-template name="FORMAT-HMS-INTEIRO">
					<xsl:with-param name="number" select="@Time" />
				</xsl:call-template>
			</div>
			
			<div class="f12" style="width:180px;float:left;text-align:left;">
				<xsl:value-of select="@Origin"/>
			</div>
			
			<div class="f12" style="width:100px;float:left;text-align:left;">
				<xsl:value-of select="@NumberCalled"/>
			</div>
			
			<div class="f12" style="width:100px;float:left;text-align:center;">
				<xsl:call-template name="FORMAT-TARIFF">
					<xsl:with-param name="tarifa" select="@Tariff" />
				</xsl:call-template>
			</div>
			
			<div class="f12" style="width:100px;float:left;text-align:left;">
				<xsl:call-template name="FORMAT-HMS">
					<xsl:with-param name="number" select="@Duration" />
				</xsl:call-template>
			</div>
			
			<div class="f12" style="width:80px;float:left;text-align:right;">
				<xsl:call-template name="FORMAT-DOUBLE">
					<xsl:with-param name="number" select="@Amount"/>
				</xsl:call-template>
			</div>
		</div>
		
	</xsl:for-each>
	<br></br><br></br>
	
	</xsl:for-each>

	<!-- fim Chamadas recebidas a cobrar -->
	<!-- fim de Chamadas dentro da area de registro -->
	</xsl:if>
	<!--  fim da verificacao de chamadas dentro da area de registro e chamadas a cobrar -->
	
	
	<!--  verificacao da soma de chamadas fora da area de registro -->
	<xsl:if test="$verificaSomaFora != 0 " >
	
	<!-- Chamadas fora da area de registro -->
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Chamadas Fora da �rea de Registro</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	
	<!--  verificacao de chamadas locais originadas -->
	
	<xsl:if test="$verificaForaOriginadas != 0 ">
	
	<!-- Chamadas locais originadas 555T-->
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Chamadas Locais Originadas</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	
	<!-- por operadora -->
	
	
	<xsl:for-each select="OPERATOR_CALL/ROAM_MOC_LOCAL_TOTAL">
		<br></br>
		<div style="width:776;float:left;">
			<div class="f12" style="width:506px;float:left;">
				<b>Operadora:
					<xsl:value-of select="@ServicePlan" />
				</b>
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
			<div class="f11" style="width:30px;float:left;">
				<b>Seq.:</b><br></br>
			</div>
						
			<div class="f11" style="width:56px;float:left;text-align:left;">
				<b>Data</b><br></br>
			</div>
			
			<div class="f11" style="width:70px;float:left;text-align:left;">
				<b>Hora In�cio</b><br></br>
			</div>
			
			<div class="f11" style="width:90px;float:left;text-align:left;">
				<b>Local Visitado</b><br></br>
			</div>
			
			<div class="f11" style="width:80px;float:left;text-align:left;">
				<b>Destino</b><br></br>
			</div>
			
			<div class="f11" style="width:95px;float:left;text-align:left;">
				<b>N�m. Chamado</b><br></br>
			</div>
			
			<div class="f11" style="width:105px;float:left;text-align:left;">
				<b>Tipo de Chamada</b><br></br>
			</div>
			
			<div class="f11" style="width:70px;float:left;text-align:left;">
				<b>Tarifa</b><br></br>
			</div>
			
			<div class="f11" style="width:80px;float:left;text-align:left;">
				<b>Dura��o</b><br></br>
			</div>
			
			<div class="f11" style="width:100px;float:left;text-align:right;">
				<b>Valor</b><br></br>
			</div>
			
		</div>
		
		<!-- 555D -->
		
		<xsl:for-each select="ROAM_MOC_LOCAL_DETAIL">
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
				<div class="f11" style="width:30px;float:left;">
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
				<div class="f11" style="width:56px;float:left;">
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
				<div class="f11" style="width:70px;float:left;">
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
				
				<div class="f11" style="width:90px;float:left;">
					<xsl:value-of select="@Origin" /><br></br>
				</div>
				
				<div class="f11" style="width:80px;float:left;">
					<xsl:value-of select="@Destination" /><br></br>
				</div>
				<span id="R07_destino2">
				<div class="f11" style="width:95px;float:left;">
					<xsl:value-of select="@NumberCalled" /><br></br>
				</div>
				</span>
				
				<div class="f11" style="width:105px;float:left;">
					<xsl:value-of select="@ServicePlan" /><br></br>
				</div>
				
				<div class="f11" style="width:70px;float:left;">
					<xsl:call-template name="FORMAT-TARIFF">
								<xsl:with-param name="tarifa" select="@Tariff" />
							</xsl:call-template>
							<br></br>
				</div>
				<span id="R07_duracao2">
				<div class="f11" style="width:80px;float:left;">
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
	<!--  fim verificacao fora originadas -->
	
	<!--fim por operadora -->
	
	<!-- fim Chamadas  -->
	
	
	<!--  verifica chamadas locais recebidas fora -->
	<xsl:if test="$verificaForaRecebidas != 0" >
	
	<!-- Chamadas locais recebidas 560T-->
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Chamadas Locais Recebidas</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	
	<!-- por operadora -->
	
	
	<xsl:for-each select="OPERATOR_CALL/ROAM_MTC_LOCAL_TOTAL">
		<br></br>
		<div style="width:776;float:left;">
			<div class="f12" style="width:506px;float:left;">
				<b>Operadora:
					<xsl:value-of select="@ServicePlan" />
				</b>
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
			<div class="f11" style="width:30px;float:left;">
				<b>Seq.:</b><br></br>
			</div>
						
			<div class="f11" style="width:56px;float:left;text-align:left;">
				<b>Data</b><br></br>
			</div>
			
			<div class="f11" style="width:70px;float:left;text-align:left;">
				<b>Hora In�cio</b><br></br>
			</div>
			
			<div class="f11" style="width:90px;float:left;text-align:left;">
				<b>Local Visitado</b><br></br>
			</div>
			
			<div class="f11" style="width:175px;float:left;text-align:left;">
				<b>N�mero de Origem</b><br></br>
			</div>
			
			<div class="f11" style="width:105px;float:left;text-align:left;">
				<b>Tipo de Chamada</b><br></br>
			</div>
			
			<div class="f11" style="width:70px;float:left;text-align:left;">
				<b>Tarifa</b><br></br>
			</div>
			
			<div class="f11" style="width:80px;float:left;text-align:left;">
				<b>Dura��o</b><br></br>
			</div>
			
			<div class="f11" style="width:100px;float:left;text-align:right;">
				<b>Valor</b><br></br>
			</div>
			
		</div>
		
		<!-- 560D -->
		
		<!-- teste de regra 83-13-->
		
		<xsl:for-each select="ROAM_MTC_LOCAL_DETAIL">
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
							<div class="f11" style="width:30px;float:left;">
								&#160;&#160;<xsl:value-of select="$contador" /><br></br>
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
								<div class="f11" style="width:56px;float:left;">
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
								<div class="f11" style="width:70px;float:left;">
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
							<div class="f11" style="width:90px;float:left;">
								<xsl:value-of select="@Origin" /><br></br>
							</div>
							<span id="R07_destino2">
							<div class="f11" style="width:175px;float:left;">
								<xsl:value-of select="@ChannelID" /><br></br>
							</div>
							</span>
							<div class="f11" style="width:105px;float:left;">
								<xsl:value-of select="@ServicePlan" /><br></br>
							</div>
							
							<div class="f11" style="width:70px;float:left;">
								<xsl:call-template name="FORMAT-TARIFF">
											<xsl:with-param name="tarifa" select="@Tariff" />
										</xsl:call-template>
										<br></br>
							</div>
							<span id="R07_duracao2">
								<div class="f11" style="width:80px;float:left;">
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
	<!--  fim verifica fora recebidas  -->
	<!--fim por operadora -->
	<!-- fim Chamadas  -->
	

	
	
	<!--  verifica chamadas realizadas/recebidas mundo -->
	
	<xsl:if test="$verificaForaMundo != 0 ">
	
	<!-- inicio Chamadas Realizadas/Recebidas no Exterior - Vivo no Mundo 585T -->
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Chamadas Realizadas/Recebidas no Exterior - Vivo no Mundo</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	
	<!-- por operadora -->
	
	
	<xsl:for-each select="OPERATOR_CALL/ROAM_MTC_INTERNATIONAL_TOTAL">
		<br></br>
		<div style="width:776;float:left;">
			<div class="f12" style="width:506px;float:left;">
				<b>Operadora:
					<xsl:value-of select="@ServicePlan" />
				</b>
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
			<div class="f11" style="width:30px;float:left;">
				<b>Seq.:</b><br></br>
			</div>
						
			<div class="f11" style="width:56px;float:left;text-align:left;">
				<b>Data</b><br></br>
			</div>
			
			<div class="f11" style="width:70px;float:left;text-align:left;">
				<b>Hora In�cio</b><br></br>
			</div>
			
			<div class="f11" style="width:90px;float:left;text-align:left;">
				<b>Destino</b><br></br>
			</div>
			
			<div class="f11" style="width:175px;float:left;text-align:left;">
				<b>N�mero Chamado</b><br></br>
			</div>
			
			<div class="f11" style="width:105px;float:left;text-align:left;">
				<b>Tipo de Chamada</b><br></br>
			</div>
			
			<div class="f11" style="width:70px;float:left;text-align:left;">
				<b>Tarifa</b><br></br>
			</div>
			
			<div class="f11" style="width:80px;float:left;text-align:left;">
				<b>Dura��o</b><br></br>
			</div>
			
			<div class="f11" style="width:100px;float:left;text-align:right;">
				<b>Valor</b><br></br>
			</div>
			
		</div>
		
		<!-- 585D -->
		
		
		
		<xsl:for-each select="ROAM_MTC_INTERNATIONAL_DETAIL">
	
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
				<div class="f11" style="width:30px;float:left;">
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
				<div class="f11" style="width:56px;float:left;">
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
				<div class="f11" style="width:70px;float:left;">
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
				
				<div class="f11" style="width:90px;float:left;">
					<xsl:value-of select="@Destination" /><br></br>
				</div>
				<span id="R07_destino2">
				<div class="f11" style="width:175px;float:left;">
					<xsl:value-of select="@NumberCalled" /><br></br>
				</div>
				</span>
				<div class="f11" style="width:105px;float:left;">
					<xsl:value-of select="@ServicePlan" /><br></br>
				</div>
				
				<div class="f11" style="width:70px;float:left;">
					<xsl:call-template name="FORMAT-TARIFF">
								<xsl:with-param name="tarifa" select="@Tariff" />
							</xsl:call-template>
							<br></br>
				</div>
				<span id="R07_duracao2">
				<div class="f11" style="width:80px;float:left;">
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
			</div>
	
		</xsl:for-each>
	
	</xsl:for-each>
	
	</xsl:if>
	<!--  fim verifica mundo  -->
	
	<!--fim por operadora -->
	
	<!-- fim Chamadas  -->
	

	</xsl:if>
	<!-- fim de Chamadas fora -->
	
	
	<!-- fim do conte�do da p�gina4 PJ-->
	
</div>


<!-- fim p�gina 4 PJ -->
<!--
</div>
</div>
-->

</body>
</html>

</xsl:if>

<!-- pagina nao exibida -->
<!--  verificar se ira exibir o cabecalho -->
<!-- fim de pagina nao exibida -->

<!-- fim verifica pagina -->

</xsl:for-each>

</xsl:template>   

</xsl:stylesheet>
