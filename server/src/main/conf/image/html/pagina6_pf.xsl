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
 
  
	<xsl:template name="pagina6_pf" >
		
	<!-- cria uma página para cada numero de telefone -->	
	<xsl:for-each select="$subscription">
	
	<!-- variaveis de verificacao de todos os itens da pagina -->
	
	<xsl:variable name="verificaDescontos" select="sum(OPERATOR_CALL/DiscountsTotal/@Amount)"/>
	
	<xsl:variable name="verificaLongaDentro" select="sum(OPERATOR_CALL/LD_INTRASTATE_CALLS_TOTAL/@UsedUnits)" />
	<xsl:variable name="verificaLongaOutrosEstados" select="sum(OPERATOR_CALL/LD_INTERSTATE_CALLS_TOTAL/@UsedUnits)" />
	<xsl:variable name="verificaCobrarExcetoLocais" select="sum(OPERATOR_CALL/COLLECT_CALLS_TOTAL/@UsedUnits)" />
	<xsl:variable name="verificaLongaInternacionais" select="sum(OPERATOR_CALL/INTERNATIONAL_CALLS_TOTAL/@UsedUnits)" />
	
	<xsl:variable name="dentroRegistroTotal" select="$verificaLongaDentro + $verificaLongaOutrosEstados + $verificaCobrarExcetoLocais + $verificaLongaInternacionais" />
	
	<xsl:variable name="verificaForaLongaO" select="sum(OPERATOR_CALL/ROAM_MOC_LD_TOTAL/@UsedUnits)" />
	<xsl:variable name="verificaForaLongaR" select="sum(OPERATOR_CALL/ROAM_MTC_LD_TOTAL/@UsedUnits)" />
	<xsl:variable name="verificaForaLongaE" select="sum(OPERATOR_CALL/ROAM_MOC_INTERNATIONAL_TOTAL/@UsedUnits)" />
	
	<xsl:variable name="foraRegistroTotal" select="$verificaForaLongaO + $verificaForaLongaR + $verificaForaLongaE" />
	
	
	<xsl:variable name="totalDetalhamentoLonga" select="$verificaDescontos + $dentroRegistroTotal + $foraRegistroTotal" />
	
	
	<!-- total da pagina -->
	
	<!-- fim das variaveis de verificacao -->

<xsl:variable name="pageCounter"><xsl:number /></xsl:variable>		
<html id="session6_">'<xsl:value-of select="$pageCounter"/>'

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
<!-- inicio página 6 -->

<div id="pagina6" class="pagina6">
	


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
				<span style="text-align:right;width:280px;"><b>Página 0000006/0000006</b></span>
				</span>
			</div>
		</div>
	</div>
	<!-- fim do sub cabecalho -->
	
	<!-- conteúdo da página6 PF -->
	
	<div class="f14" style="width:776px;float:left;">
		<b>DETALHAMENTO DE UTILIZAÇÃO:   VIVO S.A.</b>
	</div>
		
	<br></br><br></br>
	
	<!-- loop de detalhamento de longa distancia -->
	
		<!--  veririfcacao do total de longa distancia  -->
		<xsl:if test="$totalDetalhamentoLonga != 0 ">

		<div class="f14" style="width:776px;float:left;">
			<b>DETALHAMENTO DE UTILIZAÇÃO LONGA DISTÂNCIA</b>
		</div>
		
		<div class="linhaDivisoria" />
		
		
		<!--  verifica descontos -->
		<xsl:if test="$verificaDescontos != 0">
		
		
		<!--descontos -->
		<div class="f14" style="width:776px;float:left;">
			<b>Descontos</b>
		</div>
		
		<div class="linhaDivisoria" />
		
		<!-- 401T -->
			
			<xsl:for-each select="OPERATOR_CALL/DiscountsTotal">
				
				<div style="width:776;float:left;">
					<div class="f12" style="width:506px;float:left;">
						<b>Descrição</b>
					</div>
					<div class="f12" style="width:70px;float:left;text-align:right;">
						
					</div>
					<div class="f12" style="width:100px;float:left;text-align:right;">
						<b>Subtotal:</b>
					</div>
					<div class="f12" style="width:100px;float:left;text-align:right;">
						<b>
						<xsl:variable name="valorMonetarioVariavel6"
							select="sum(@Amount)"/>
						<xsl:call-template name="FORMAT-DOUBLE">
							<xsl:with-param name="number" select="$valorMonetarioVariavel6"/>
						</xsl:call-template>
						</b>
					</div>
				</div>
				
				<div style="width:776px;float:left;">
					<div class="f11" style="width:676px;float:left;">
						<b>Descrição</b><br></br>
					</div>

					<div class="f11" style="width:100px;float:left;text-align:right;">
						<b>Valor</b><br></br>
					</div>
					
				</div>
				
				<!-- 401D -->
				
				<xsl:for-each select="DiscountsDetail">
					
					<xsl:variable name="contador"><xsl:number /></xsl:variable>
			
					<div style="width:776px;float:left;">
						
						<div class="f11" style="width:40px;float:left;">
							<xsl:value-of select="@captionPhrase"/><br></br>
						</div>
												
						<div class="f11" style="width:100px;float:left;text-align:right;">
							<xsl:call-template name="FORMAT-DOUBLE">
								<xsl:with-param name="number" select="@amount"/>
							</xsl:call-template>
							<br></br>
						</div>
						
					</div>
			
				</xsl:for-each>
				<br></br>
			</xsl:for-each>
			
			<!-- fim de chamadas longa dentro do estado -->
		
		
		<!-- fim dos descontos -->
		</xsl:if>
		<!-- fim verifica descontos -->
		
		
		
		<!-- verifica  total chamadas dentro da area de registro -->
		<xsl:if test="$dentroRegistroTotal != 0">
		
		<!--chamadas dentro da area de registro -->
		<div class="f14" style="width:776px;float:left;">
			<b>Chamadas Dentro da Área de Registro</b>
		</div>
		<div class="linhaDivisoria" />
		
		
			<!-- veririfca chamadas longa distancia dentro -->
			<xsl:if test="$verificaLongaDentro != 0">
		
			<!-- chamadas de longa distancia para dentro do estado -->
			<div class="f12" style="width:776px;float:left;">
				<b>Chamadas de Longa Distância para Dentro do Estado</b>
			</div>
			<div class="linhaDivisoria" />
			
			<!-- 535T -->
			
			<xsl:for-each select="OPERATOR_CALL/LD_INTRASTATE_CALLS_TOTAL">
				
				<div style="width:776;float:left;">
					<div class="f12" style="width:506px;float:left;">
						Pacote de Ligações Longa Distância - <xsl:value-of select="@ServicePlan"/>
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
					
					<div class="f11" style="width:100px;float:left;text-align:left;">
						<b>Destino / UF</b><br></br>
					</div>
					
					<div class="f11" style="width:150px;float:left;text-align:left;">
						<b>Núm. Chamado</b><br></br>
					</div>
					
					<div class="f11" style="width:125px;float:left;text-align:left;">
						<b>Tarifa</b><br></br>
					</div>
								
					<div class="f11" style="width:100px;float:left;text-align:left;">
						<b>Duração</b><br></br>
					</div>
					
					<div class="f11" style="width:100px;float:left;text-align:right;">
						<b>Valor</b><br></br>
					</div>
					
				</div>
				
				<!-- 535D -->
				
				<xsl:for-each select="LD_INTRASTATE_CALLS_DETAIL">
					
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
						<div class="f11" style="width:100px;float:left;">
							<xsl:value-of select="@CarrierState" /><br></br>
						</div>
						<span id="R07_destino2">
						<div class="f11" style="width:150px;float:left;">
							<xsl:value-of select="@NumberCalled" /><br></br>
						</div>
						</span>
						<div class="f11" style="width:125px;float:left;">
							<xsl:call-template name="FORMAT-TARIFF">
								<xsl:with-param name="tarifa" select="@Tariff" />
							</xsl:call-template>
							<br></br>
						</div>
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
				<br></br>
			</xsl:for-each>
			
			<!-- fim de chamadas longa dentro do estado -->
			
	</xsl:if>
	<!--  fim verifica chamadas longa dentro -->
			
	
	<!--  verifica longa outros estados -->
	<xsl:if test="$verificaLongaOutrosEstados != 0">
			
			
			<!-- chamadas de longa distancia para outros estados -->
			<div class="f12" style="width:776px;float:left;">
				<b>Chamadas de Longa Distância para Outros Estados</b>
			</div>
			<div class="linhaDivisoria" />
			
			<!-- 540T -->
			
			<xsl:for-each select="OPERATOR_CALL/LD_INTERSTATE_CALLS_TOTAL">
				
				<div style="width:776;float:left;">
					<div class="f12" style="width:506px;float:left;">
						Pacote de Ligações Longa Distância - <xsl:value-of select="@ServicePlan"/>
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
					
					<div class="f11" style="width:100px;float:left;text-align:left;">
						<b>Destino / UF</b><br></br>
					</div>
					
					<div class="f11" style="width:150px;float:left;text-align:left;">
						<b>Núm. Chamado</b><br></br>
					</div>
					
					<div class="f11" style="width:125px;float:left;text-align:left;">
						<b>Tarifa</b><br></br>
					</div>
								
					<div class="f11" style="width:100px;float:left;text-align:left;">
						<b>Duração</b><br></br>
					</div>
					
					<div class="f11" style="width:100px;float:left;text-align:right;">
						<b>Valor</b><br></br>
					</div>
					
				</div>
				
				<!-- 540D -->
				
				<xsl:for-each select="LD_INTERSTATE_CALLS_DETAIL">
					
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
						<div class="f11" style="width:100px;float:left;">
							<xsl:value-of select="@CarrierState" /><br></br>
						</div>
						<span id="R07_destino2">
						<div class="f11" style="width:150px;float:left;">
							<xsl:value-of select="@NumberCalled" /><br></br>
						</div>
						</span>
						<div class="f11" style="width:125px;float:left;">
							<xsl:call-template name="FORMAT-TARIFF">
								<xsl:with-param name="tarifa" select="@Tariff" />
							</xsl:call-template>
							<br></br>
						</div>
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
				<br></br>
			</xsl:for-each>
			
			<!-- fim de chamadas longa outros estados -->
			
		</xsl:if>
		<!--  fim verifica chamadas fora outros estados -->	
		
		
		<!--  verifica cobrar exceto locais -->
		<xsl:if test="$verificaCobrarExcetoLocais != 0" >
			
			<!-- chamadas a cobrar exceto locais -->
			<div class="f12" style="width:776px;float:left;">
				<b>Chamadas Recebidas a Cobrar - Exceto Locais</b>
			</div>
			<div class="linhaDivisoria" />
			
			<!-- 545T -->
			
			<xsl:for-each select="OPERATOR_CALL/COLLECT_CALLS_TOTAL">
				
				<div style="width:776;float:left;">
					<div class="f12" style="width:506px;float:left;">
						
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
					
					<div class="f11" style="width:100px;float:left;text-align:left;">
						<b>Origem / UF</b><br></br>
					</div>
					
					<div class="f11" style="width:95px;float:left;text-align:left;">
						<b>Núm. Chamado</b><br></br>
					</div>
					
					<div class="f11" style="width:100px;float:left;text-align:left;">
						<b>Tipo de Chamada</b><br></br>
					</div>
					
					<div class="f11" style="width:80px;float:left;text-align:left;">
						<b>Tarifa</b><br></br>
					</div>
								
					<div class="f11" style="width:100px;float:left;text-align:left;">
						<b>Duração</b><br></br>
					</div>
					
					<div class="f11" style="width:100px;float:left;text-align:right;">
						<b>Valor</b><br></br>
					</div>
					
				</div>
				
				<!-- 545D -->
				
				<xsl:for-each select="COLLECT_CALLS_DETAIL">
					
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
						<div class="f11" style="width:100px;float:left;">
							<xsl:value-of select="@originState" /><br></br>
						</div>
						<span id="R07_destino2">
						<div class="f11" style="width:95px;float:left;">
							<xsl:value-of select="@NumberCalled" /><br></br>
						</div>
						</span>
						<div class="f11" style="width:100px;float:left;">
							<xsl:value-of select="@ServicePlan" /><br></br>
						</div>
						
						<div class="f11" style="width:80px;float:left;">
							<xsl:call-template name="FORMAT-TARIFF">
								<xsl:with-param name="tarifa" select="@Tariff" />
							</xsl:call-template>
							<br></br>
						</div>
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
				<br></br>
			</xsl:for-each>
			
			<!-- fim de chamadas a cobrar exceto locais -->
			<br></br>
		</xsl:if>
		<!--  fim verifica chamadas cobrar exceto locais -->
			
			
			
			
		<!--  verifica chamadas longa internacionais -->
		<xsl:if test="$verificaLongaInternacionais != 0">
		
			
			<!-- Chamadas de Longa Dist!ncia Efetuadas Internacionais -->
			<div class="f12" style="width:776px;float:left;">
				<b>Chamadas de Longa Distância Efetuadas Internacionais</b>
			</div>
			<div class="linhaDivisoria" />
			
			<!-- 550T -->
			
			<xsl:for-each select="OPERATOR_CALL/INTERNATIONAL_CALLS_TOTAL">
				
				<div style="width:776;float:left;">
					<div class="f12" style="width:506px;float:left;">
						
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
					
					<div class="f11" style="width:100px;float:left;text-align:left;">
						<b>Destino</b><br></br>
					</div>
					
					<div class="f11" style="width:150px;float:left;text-align:left;">
						<b>Núm. Chamado</b><br></br>
					</div>
					
					<div class="f11" style="width:125px;float:left;text-align:left;">
						<b>Tarifa</b><br></br>
					</div>
								
					<div class="f11" style="width:100px;float:left;text-align:left;">
						<b>Duração</b><br></br>
					</div>
					
					<div class="f11" style="width:100px;float:left;text-align:right;">
						<b>Valor</b><br></br>
					</div>
					
				</div>
				
				<!-- 550D -->
				
				<xsl:for-each select="INTERNATIONAL_CALLS_DETAIL">
					
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
						<div class="f11" style="width:100px;float:left;">
							<xsl:value-of select="@Destination" /><br></br>
						</div>
						<span id="R07_destino2">
						<div class="f11" style="width:150px;float:left;">
							<xsl:value-of select="@NumberCalled" /><br></br>
						</div>
						</span>
						<div class="f11" style="width:125px;float:left;">
							<xsl:call-template name="FORMAT-TARIFF">
								<xsl:with-param name="tarifa" select="@Tariff" />
							</xsl:call-template>
							<br></br>
						</div>
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
				<br></br>
			</xsl:for-each>
			
			<!-- fim de Chamadas de Longa Distância Efetuadas Internacionais-->
			
			</xsl:if>
			<!--  fim verifica longa internacionais  -->
		
		<!-- fim chamadas dentro da area de registro -->
		</xsl:if>
		<!--  fim verifica dentro totais -->
			
			
		
		<!--  veririfica chamas fora totais -->
		<xsl:if test="$foraRegistroTotal != 0">
			
			
			
		<!--Chamadas Fora da Área de Registro -->
		<div class="f14" style="width:776px;float:left;">
			<b>Chamadas Fora da Área de Registro</b>
		</div>
		<div class="linhaDivisoria" />
			
			
			<!-- verifica fora longa origicanda -->
			<xsl:if test="$verificaForaLongaO != 0">
			
			<!-- Chamadas de Longa Dist!ncia Originadas -->
			<div class="f12" style="width:776px;float:left;">
				<b>Chamadas de Longa Distância Originadas</b>
			</div>
			<div class="linhaDivisoria" />
			
			<!-- 570T -->
			
			<xsl:for-each select="OPERATOR_CALL/ROAM_MOC_LD_TOTAL">
				
				<div style="width:776;float:left;">
					<div class="f12" style="width:506px;float:left;">
						Operadora: <xsl:value-of select="@ServicePlan" />
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
					
					<div class="f11" style="width:100px;float:left;text-align:left;">
						<b>Local Visitado</b><br></br>
					</div>
					
					<div class="f11" style="width:150px;float:left;text-align:left;">
						<b>Núm. Chamado</b><br></br>
					</div>
					
					<div class="f11" style="width:125px;float:left;text-align:left;">
						<b>Tarifa</b><br></br>
					</div>
								
					<div class="f11" style="width:100px;float:left;text-align:left;">
						<b>Duração</b><br></br>
					</div>
					
					<div class="f11" style="width:100px;float:left;text-align:right;">
						<b>Valor</b><br></br>
					</div>
					
				</div>
				
				<!-- 570D -->
				
				<xsl:for-each select="ROAM_MOC_LD_DETAIL">
					
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
						<div class="f11" style="width:80px;float:left;">
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
						<span id="R07_destino2">
						<div class="f11" style="width:150px;float:left;">
							<xsl:value-of select="@NumberCalled" /><br></br>
						</div>
						</span>
						<div class="f11" style="width:125px;float:left;">
							<xsl:call-template name="FORMAT-TARIFF">
								<xsl:with-param name="tarifa" select="@Tariff" />
							</xsl:call-template>
							<br></br>
						</div>
						<span id="R07_duracao2">
						<div class="f11" style="width:100px;float:left;">
							<xsl:call-template name="FORMAT-HMS">
								<xsl:with-param name="number" select="@Duration" />
							</xsl:call-template>
							<br></br>
						</div>
						</span>
						<span id="R07_valor2">
						<div class="f11" style="width:98px;float:left;text-align:right;">
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
				<br></br>
			</xsl:for-each>
			
			<!-- fim de Chamadas de Longa Distância originadas -->
			
			</xsl:if>
			<!-- fim verifica fora longa  Originadas-->
			
			
			<!--  verifica fora longa recebidas -->
			<xsl:if test="$verificaForaLongaR != 0">
			
			<!-- Chamadas de Longa Distância Recebidas -->
			<div class="f12" style="width:776px;float:left;">
				<b>Chamadas de Longa Distância Recebidas</b>
			</div>
			<div class="linhaDivisoria" />
			
			<!-- 575T -->
			
			<xsl:for-each select="OPERATOR_CALL/ROAM_MTC_LD_TOTAL">
				
				<div style="width:776;float:left;">
					<div class="f12" style="width:506px;float:left;">
						Operadora: <xsl:value-of select="@ServicePlan" />
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
								
					<div class="f11" style="width:80px;float:left;text-align:left;">
						<b>Data</b><br></br>
					</div>
					
					<div class="f11" style="width:80px;float:left;text-align:left;">
						<b>Hora Início</b><br></br>
					</div>
					
					<div class="f11" style="width:100px;float:left;text-align:left;">
						<b>Local Visitado</b><br></br>
					</div>
					
					<div class="f11" style="width:95px;float:left;text-align:left;">
						<b>Núm. Chamado</b><br></br>
					</div>
					
					<div class="f11" style="width:100px;float:left;text-align:left;">
						<b>Tipo de Chamada</b><br></br>
					</div>
					
					<div class="f11" style="width:90px;float:left;text-align:left;">
						<b>Tarifa</b><br></br>
					</div>
								
					<div class="f11" style="width:100px;float:left;text-align:left;">
						<b>Duração</b><br></br>
					</div>
					
					<div class="f11" style="width:91px;float:left;text-align:right;">
						<b>Valor</b><br></br>
					</div>
					
				</div>
				
				<!-- 575D -->
				
				<xsl:for-each select="ROAM_MTC_LD_DETAIL">
					
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
						<div class="f11" style="width:80px;float:left;">
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
						<span id="R07_destino2">
						<div class="f11" style="width:95px;float:left;">
							<xsl:value-of select="@NumberCalled" /><br></br>
						</div>
						</span>
						<div class="f11" style="width:101px;float:left;">
							<xsl:value-of select="@ServicePlan" /><br></br>
						</div>
						
						<div class="f11" style="width:90px;float:left;">
							<xsl:call-template name="FORMAT-TARIFF">
								<xsl:with-param name="tarifa" select="@Tariff" />
							</xsl:call-template>
							<br></br>
						</div>
						<span id="R07_duracao2">
						<div class="f11" style="width:90px;float:left;">
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
				<br></br>
			</xsl:for-each>
			
			<!-- fim Chamadas de Longa Distância Recebidas -->
			
			</xsl:if>
			<!-- fim verifica chamadas fora longa recebidas -->
			
			
			<!--  verifica chmadas fora longa efetuadas -->
			<xsl:if test="$verificaForaLongaE !=0 ">
			
			
			<!-- Chamadas de Longa Dist!ncia Efetuadas Internacionais -->
			<div class="f12" style="width:776px;float:left;">
				<b>Chamadas de Longa Distância Efetuadas Internacionais</b>
			</div>
			<div class="linhaDivisoria" />
			
			<!-- 580T -->
			
			<xsl:for-each select="OPERATOR_CALL/ROAM_MOC_INTERNATIONAL_TOTAL">
				
				<div style="width:776;float:left;">
					<div class="f12" style="width:506px;float:left;">
						Operadora: <xsl:value-of select="@ServicePlan" />
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
					
					<div class="f11" style="width:100px;float:left;text-align:left;">
						<b>Destino</b><br></br>
					</div>
					
					<div class="f11" style="width:150px;float:left;text-align:left;">
						<b>Núm. Chamado</b><br></br>
					</div>
					
					<div class="f11" style="width:125px;float:left;text-align:left;">
						<b>Tarifa</b><br></br>
					</div>
								
					<div class="f11" style="width:100px;float:left;text-align:left;">
						<b>Duração</b><br></br>
					</div>
					
					<div class="f11" style="width:100px;float:left;text-align:right;">
						<b>Valor</b><br></br>
					</div>
					
				</div>
				
				<!-- 580D -->
				
				<xsl:for-each select="ROAM_MOC_INTERNATIONAL_DETAIL">
					
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
						<div class="f11" style="width:100px;float:left;">
							<xsl:value-of select="@Destination" /><br></br>
						</div>
						<span id="R07_destino2">
						<div class="f11" style="width:150px;float:left;">
							<xsl:value-of select="@NumberCalled" /><br></br>
						</div>
						</span>
						<div class="f11" style="width:125px;float:left;">
							<xsl:call-template name="FORMAT-TARIFF">
								<xsl:with-param name="tarifa" select="@Tariff" />
							</xsl:call-template>
							<br></br>
						</div>
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
				<br></br>
			</xsl:for-each>
			
			<!-- fim Chamadas de Longa Distância Efetuadas Internacionais -->
			
			</xsl:if>
			<!--  fim verifica fora longa efetuadas -->
	
		<!-- fim Chamadas Fora da Área de Registro -->
		</xsl:if>
		<!-- fim verifica total fora -->
		
		</xsl:if>
		<!--  fim veririfca total detalhamento -->
		
		
		
		
		
		
		<!-- total do detalhamento de longa distancia -->
		
		<div class="f14" style="width:776px;float:left;">
			<div class="f14" style="width:500px;float:left;">
			<b>TOTAL DO DETALHAMENTO DE LONGA DINSTÂNCIA</b>
			</div>
			<div class="f14" style="width:276px;float:left;text-align:right;">
				R$&#160;
				<!-- soma das chamadas de longa distancia 535T, 540T, 570T, 575T, 545T, 550T, 580T (conferido)-->
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
				<xsl:variable name="valorMonetarioVariavelSoma12"
					select="$valorMonetarioVariavel12_0 + $valorMonetarioVariavel12_1 + $valorMonetarioVariavel12_2 + $valorMonetarioVariavel12_3 + $valorMonetarioVariavel12_4 + $valorMonetarioVariavel12_5 + $valorMonetarioVariavel12_6"/>
				<xsl:call-template name="FORMAT-DOUBLE">
					<xsl:with-param name="number" select="$valorMonetarioVariavelSoma12"/>
				</xsl:call-template>
			</div>
		</div>
			
			<div class="linhaDivisoria" />
			
		<!-- FIM DO TOTAL DE DETALHAMENTO DE LONGA DISTÂNCIA -->
	
	
	
	<!-- fim do loop de longa distancia -->
	
	<!-- DETALHAMENTO TOTAL POR TELEFONE -->
	
	<!-- xsl:for-each select="/SIRS/CYCLE_SUMMARY/SUBSCRIPTION_INFO" -->
           								
		<div class="f14" style="width:776px;float:left;">
			<div class="f14" style="width:500px;float:left;">
			<b>TOTAL DO CELULAR:&#160;<xsl:value-of select="@PhoneNumber"/></b>
			</div>
			<div class="f14" style="width:276px;float:left;text-align:right;">
				R$&#160;
				<xsl:call-template name="FORMAT-DOUBLE">
					<xsl:with-param name="number" select="ENTIRE_SUBSCRIPTION_TOTAL/@SubscriptionAmount"/>
				</xsl:call-template>
			</div>
		</div>
		
		<div class="linhaDivisoria" />
	
	 <!-- /xsl:for-each -->
	<!-- FIM DO DETALHAMENTO TOTAL POR TELEFONE -->
		
	

</div>

<!-- fim página 6 -->


<!--
</div>
</div>
-->
</body>
</html>


</xsl:for-each>

</xsl:template> 

</xsl:stylesheet>
