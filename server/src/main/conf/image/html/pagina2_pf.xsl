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
 
  
	<xsl:template name="pagina2_pf" >
	
	<!--  variaveis de verificacao da sessao -->
	
	<xsl:variable name="verificaGrupoSubgrupo" select="$context/DUMMY_INVOICE_SUMMARY/FATURA_CORPORATIVA_GRUPO_TOTAL/@key" />
	<xsl:variable name="verificaCompartilhamento" select="$context/DUMMY_INVOICE_SUMMARY/COMPARTILHAMENTO_FRANQUIA_TOTAL/@key" />
	<xsl:variable name="verificaJurosMultas" select="$context/DUMMY_INVOICE_SUMMARY/MULTAS_JUROS_TOTAL/@key" />
	<xsl:variable name="verificaDescontos1" select="$context/DUMMY_INVOICE_SUMMARY/DISCOUNT_TOTAL/@key" />
	<xsl:variable name="verificaDescontos2" select="$subscription/PROMOTIONS_TOTAL/@key" />
	<xsl:variable name="verificaDescontos3" select="$subscription/OPERATOR_CALL/DiscountsTotal/@key" />
	<xsl:variable name="verificaDebitos1" select="sum($subscription/ENTIRE_SUBSCRIPTION_TOTAL/SUBSCRIPTION_SRV_CHARGE_TOTAL/@ServiceChargeAmt)" />
	<xsl:variable name="verificaDebitos2" select="sum($subscription/OPERATOR_CALL/PARTY_3RD_TOTAL/@Subtotal)" />
	<xsl:variable name="verificaPagamentos" select="$context/DUMMY_INVOICE_SUMMARY/EQUIPMENT_INSTALLMENT_TOTAL/@key" />
	
	<xsl:variable name="verificaSomaPagina" select="concat($verificaGrupoSubgrupo, $verificaCompartilhamento, $verificaJurosMultas, $verificaDescontos1, $verificaDescontos2, $verificaDescontos3, $verificaDebitos1, $verificaDebitos2, $verificaPagamentos)"/>
	
	<!--  fim das variaveis de verificacao da sessao -->
	
	<!-- verifica pagina -->
	<xsl:if test="$verificaSomaPagina != 0" >
		
<xsl:variable name="pageCounter"><xsl:number /></xsl:variable>		
<html id="session2_">'<xsl:value-of select="$pageCounter"/>'

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
<!-- inicio pagina 2 PF -->

<div id="pagina2" class="pagina2">
	
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
				<b>Plano: <xsl:value-of select="$subscription/ENTIRE_SUBSCRIPTION_TOTAL/ACTIVATION_TOTAL/ACTIVATION_DETAIL/@Descricao" /></b><br></br>
				Mês de Referência: <xsl:value-of select="vivo:DateFormat.formatMMYYYY(/SIRS/CYCLE_SUMMARY/@BillingDate)"/><br></br>
				<b>Número da Conta:<xsl:value-of select="$accountNumber"/></b><br></br>
				Nome: <xsl:value-of select="$context/BILLING_ADDRESS/@AddressLine1"/><br></br>
				<br></br>
				<span style="text-align:right;width:280px;"><b>Página 0000002/0000006</b></span>
				</span>
			</div>
		</div>
	</div>
	<!-- fim do sub cabecalho -->
	
	<!-- conteudo da pagina 2 -->
	
		<!-- 2.2.4	Grupo e Subgrupo  -->
		
		<!--  verifica se o grupo existe para exibir o titulo -->
		<xsl:if test="$verificaGrupoSubgrupo = '255Z'">
			<div class="f14" style="width:776px;float:left;">
				<b>DEMONSTRATIVO DO PLANO</b>
			</div>
			<br></br>
			<div class="f12" style="width:776px;float:left;">
				<b>Grupo: </b> <xsl:value-of select="$context/DUMMY_INVOICE_SUMMARY/FATURA_CORPORATIVA_GRUPO_TOTAL/@GroupName" />
			</div>
			
			<div class="linhaDivisoria" />
			
			<div class="f12" style="width:776px;float:left;text-align:right;margin-top:-17px;">
				<b>Subtotal: </b> 
				<xsl:call-template name="FORMAT-DOUBLE">
						<xsl:with-param name="number" select="$context/DUMMY_INVOICE_SUMMARY/FATURA_CORPORATIVA_GRUPO_TOTAL/@Amount" />
				</xsl:call-template>
				
			</div>
			
			<div style="width:776px;float:left;text-align:right;">
				<div  class="f12" style="width:400; float:left; text-align:left;"><b>Plano</b></div>
				<div  class="f12" style="width:376; float:left;text-align:right;"><b>Quantidade de celulares</b></div>
			</div>
			<div style="width:776px;float:left;text-align:right;">
				<div  class="f12" style="width:400; float:left; text-align:left;"><xsl:value-of select="$context/DUMMY_INVOICE_SUMMARY/FATURA_CORPORATIVA_GRUPO_TOTAL/FATURA_CORPORATIVA_GRUPO_DETAIL/@ServicePlan" /></div>
				<div  class="f12" style="width:376; float:left;text-align:right;"><xsl:value-of select="$context/DUMMY_INVOICE_SUMMARY/FATURA_CORPORATIVA_GRUPO_TOTAL/FATURA_CORPORATIVA_GRUPO_DETAIL/@QtdeCelulares" /></div>
			</div>
			<br></br>
			<div class="f12" style="width:776px;float:left;">
				<div style="float:left;width:20px;" />
				<div style="width:756px;float:left;">
					<b>Subgrupo: </b> <xsl:value-of select="$context/DUMMY_INVOICE_SUMMARY/FATURA_CORPORATIVA_GRUPO_TOTAL/FATURA_CORPORATIVA_SUBGRUPO_TOTAL/@GroupName" />
				</div>
			</div>
			
			<div class="f12" style="width:776px;float:left;">
				<div style="float:left;width:20px;" />
				<div style="width:756px;float:left;">
					<div class="linhaDivisoria" style="width:756px;"/>
				</div>
			</div>
			
			<div class="f12" style="width:776px;float:left;">
				<div style="float:left;width:20px;" />
				<div style="width:756px;float:left;text-align:right">
					<b>Subtotal: </b> 
					<xsl:call-template name="FORMAT-DOUBLE">
						<xsl:with-param name="number" select="$context/DUMMY_INVOICE_SUMMARY/FATURA_CORPORATIVA_GRUPO_TOTAL/FATURA_CORPORATIVA_SUBGRUPO_TOTAL/@Amount" />
					</xsl:call-template>
				</div>
			</div>
			
			<div class="f12" style="width:776px;float:left;">
				<div style="float:left;width:20px;" />
				<div style="width:756px;float:left;">
					<div class="f12" style="width:189px;float:left;"><b>Número do Celular</b></div>
					<div class="f12" style="width:189px;float:left;"><b>Plano</b></div>
					<div class="f12" style="width:189px;float:left;text-align:center;"><b>Período</b></div>
					<div class="f12" style="width:189px;float:left;text-align:right;"><b>Valor R$</b></div>
				</div>
			</div>
			
			<br></br>
			
			<xsl:for-each select="$context/DUMMY_INVOICE_SUMMARY/FATURA_CORPORATIVA_GRUPO_TOTAL/FATURA_CORPORATIVA_SUBGRUPO_TOTAL/FATURA_CORPORATIVA_SUBGRUPO_DETAIL">
				<div class="f12" style="width:776px;float:left;">
					<div style="float:left;width:20px;" />
					<div style="width:756px;float:left;">
						<div class="f12" style="width:189px;float:left;"><xsl:value-of select="@Subscription" /></div>
						<div class="f12" style="width:189px;float:left;"><xsl:value-of select="@ServicePlan" /></div>
						<div class="f12" style="width:189px;float:left;text-align:center;">
							<xsl:value-of select="vivo:DateFormat.formatDDMMYYYY(@DateStart)"/>
							a
							<xsl:value-of select="vivo:DateFormat.formatDDMMYYYY(@DateEnd)"/>
						</div>
						<div class="f12" style="width:189px;float:left;text-align:right;">
							<xsl:call-template name="FORMAT-DOUBLE">
								<xsl:with-param name="number" select="@Amount" />
							</xsl:call-template>
						</div>
					</div>
				</div>
			</xsl:for-each>
		
		</xsl:if>
		
		<!--  FIM 2.2.4	Grupo e Subgrupo  -->
	
		
		<!--compartilhamento de franquia -->
		
		<xsl:for-each select="$context/DUMMY_INVOICE_SUMMARY/COMPARTILHAMENTO_FRANQUIA_TOTAL">
		
		<div class="f14" style="width:776px;float:left;">
			<b>COMPARTILHAMENTO DE FRANQUIA</b>
		</div>
		
		<div class="linhaDivisoria" />
		
		<span id="regraEstilo" title="R65-04-3">
		<span id="regraEstilo" title="R74-01">
		
		<div class="f12" style="width:776px;float:left;margin-top:-17px;">
			Descrição do compartilhamento: <span id="R65-04-2_nome"><span id="R74_nomeServico"><xsl:value-of select="@shareName" /></span></span>
		</div>
		
		<div style="width:776px;float:left;">
			
			<div class="f12" style="width:500px;float:left;">
				Número do celular:<br></br><br></br>
			</div>
			<div class="f12" style="width:276px;float:left;text-align:right;">
				<b>Subtotal: <span id="R65-04-2_subTotal"><xsl:value-of select="@usedMinutes"/></span></b><br></br>
				<b>Minutos utilizados:</b><br></br>
			</div>
			
			<xsl:for-each select="COMPARTILHAMENTO_FRANQUIA_DETAIL">
				<div class="f12" style="width:500px;float:left;">
					<xsl:value-of select="@accessNumber"/><br></br>
				</div>
				<div class="f12" style="width:276px;float:left;text-align:right;">
					<xsl:value-of select="@usedShare"/><br></br>
				</div>
			</xsl:for-each>
		</div>
		</span>
		</span>
		</xsl:for-each>
		
		<!-- fim do compartilhamento de franquia -->
		
		<br></br><br></br><br></br>
		
		<!--DEMONSTRATIVO DOS LAN!AMENTOS DIVERSOS -->
		
		<div class="f14" style="width:776px;float:left;">
			<b>DEMONSTRATIVO DOS LANÇAMENTOS DIVERSOS</b>
		</div>
		
		<!-- juros e multas 265T -->
		
		<xsl:for-each select="$context/DUMMY_INVOICE_SUMMARY/MULTAS_JUROS_TOTAL">
		
			<div class="f12" style="width:776px;float:left;">
				<br></br>
				<b>JUROS E MULTAS</b>
			</div>
			
			<div class="linhaDivisoria" />
			
			<div style="width:776;float:left;margin-top:-17px;">
				<div class="f12" style="width:250px;float:left;">
					Descrição<br></br><br></br>
				</div>
				<div class="f12" style="width:125px;float:left;">
					Referência<br></br><br></br>
				</div>
				<div class="f12" style="width:125px;float:left;">
					<br></br><br></br>
				</div>
				<div class="f12" style="width:276px;float:left;text-align:right;">
					Subtotal:

					<xsl:call-template name="FORMAT-DOUBLE">
							<xsl:with-param name="number" select="@Amount"/>
					</xsl:call-template>
					
					<br></br>
					<b>Valor R$: </b><br></br>
				</div>
			</div>
			
			<xsl:for-each select="MULTAS_JUROS_DETAIL">
				<div style="width:776;float:left;">
						<span id="regraEstilo" title="R32-08">
						<span id="regraEstilo" title="R68-01">
						<span id="regraEstilo" title="R68-3">
						<span id="regraEstilo" title="R69_82-01">
						<span id="regraEstilo" title="R69_82-02">
						<span id="regraEstilo" title="R69_82-05">
						<span id="regraEstilo" title="R69_82-06">
						
					<span id="R32_nomeServico">	
					<span id="R68-01_nomeServico">
					<div class="f12" style="width:250px;float:left;">
							<xsl:value-of select="@Descricao"/><br></br>
					</div>
					</span>
					</span>
					<div class="f12" style="width:125px;float:left;">
						<xsl:value-of select="vivo:DateFormat.formatMMYYYY(@DataElemento)"/><br></br>
					</div>
					<div class="f12" style="width:125px;float:left;">
						<br></br>
					</div>
					<span id="R69_82-01_valorMultaSirs">
					<span id="R69_82-02_valorJurosSirs">
					<div class="f12" style="width:276px;float:left;text-align:right;">
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
			</div>
			</xsl:for-each>
		
		</xsl:for-each>
		
		<!-- fim juros e multas -->
		
		<!-- descontos 270T 340T 401T -->
		
			<!--  verifica descontos 3 ifs 270 340 and 401 -->
			<xsl:if test="concat($context/DUMMY_INVOICE_SUMMARY/DISCOUNT_TOTAL/@key,
			 $subscription/PROMOTIONS_TOTAL/@key,
			 $subscription/OPERATOR_CALL/DiscountsTotal/@key) != ''">
	
		
			<div class="f12" style="width:776px;float:left;">
				<br></br>
				<b>DESCONTOS</b>
			</div>
			
			<div class="linhaDivisoria" />
			
			<div style="width:776;float:left;margin-top:-17px;">
				<div class="f12" style="width:250px;float:left;">
					Descrição<br></br><br></br>
				</div>
				<div class="f12" style="width:125px;float:left;">
					Referência<br></br><br></br>
				</div>
				<div class="f12" style="width:125px;float:left;">
					<br></br><br></br>
				</div>
				<div class="f12" style="width:276px;float:left;text-align:right;">
					Subtotal:
					
					
					<xsl:variable name="valorMonetarioVariavel15_0"
						select="sum($context/DUMMY_INVOICE_SUMMARY/DISCOUNT_TOTAL/@Amount)"/>
					<xsl:variable name="valorMonetarioVariavel15_1"
						select="sum($subscription/PROMOTIONS_TOTAL/@Amount)"/>
					<xsl:variable name="valorMonetarioVariavel15_2"
						select="sum($subscription/OPERATOR_CALL/DiscountsTotal/@Amount)"/>
					
					<xsl:variable name="valorMonetarioVariavelSoma15" select="$valorMonetarioVariavel15_0 + $valorMonetarioVariavel15_1 + $valorMonetarioVariavel15_2" />
					
					<xsl:call-template name="FORMAT-DOUBLE">
						<xsl:with-param name="number" select="$valorMonetarioVariavelSoma15"/>
					</xsl:call-template>
					
					<br></br>
					<b>Valor R$: </b><br></br>
				</div>
			</div>
			
			<xsl:for-each select="$context/DUMMY_INVOICE_SUMMARY/DISCOUNT_TOTAL/DISCOUNT_DETAIL">
			<div style="width:776;float:left;">
						<span id="regraEstilo" title="R23-1">
						<span id="regraEstilo" title="R23-2">
						<span id="regraEstilo" title="R32-08">
						<span id="regraEstilo" title="R66-01c">
						<span id="regraEstilo" title="R66-01s">
						<span id="regraEstilo" title="R66-02c">
						<span id="regraEstilo" title="R66-02s">
						<span id="regraEstilo" title="R66-03c">
						<span id="regraEstilo" title="R66-03s">
						<span id="regraEstilo" title="R66-04a">
						<span id="regraEstilo" title="R66-04b">
						
					<span id="R32_nomeServico">	
					<span id="R66_nomePromocao">
					<div class="f12" style="width:250px;float:left;">
						<xsl:value-of select="@Descricao"/><br></br>
					</div>
					</span>
					</span>
					<div class="f12" style="width:125px;float:left;">
						<br></br>
					</div>
					<div class="f12" style="width:125px;float:left;">
						<br></br>
					</div>
					<span id="R23_valorDemonstrado">
					<div class="f12" style="width:276px;float:left;text-align:right;">
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
			</div>
			</xsl:for-each>
			
			<xsl:for-each select="$subscription/PROMOTIONS_TOTAL/PROMOTIONS_DETAIL">
			<div style="width:776;float:left;">
							<span id="regraEstilo" title="R23-1">
							<span id="regraEstilo" title="R23-2">
							<span id="regraEstilo" title="R32-08">
							
					<span id="R32_nomeServico">		
					<div class="f12" style="width:250px;float:left;">
						<xsl:value-of select="@Descricao"/><br></br>
					</div>
					</span>
					<div class="f12" style="width:125px;float:left;">
						<xsl:value-of select="vivo:DateFormat.formatDDMMYYYY(@DataElemento)"/><br></br>
					</div>
					<div class="f12" style="width:125px;float:left;">
						<br></br>
					</div>
					<span id="R23_valorDemonstrado">
					<div class="f12" style="width:276px;float:left;text-align:right;">
						<xsl:call-template name="FORMAT-DOUBLE">
							<xsl:with-param name="number" select="@Amount"/>
						</xsl:call-template>
						<br></br>
					</div>
					</span>
					</span>
					</span>
					</span>
			</div>
			</xsl:for-each>
			
			
			<xsl:for-each select="$subscription/OPERATOR_CALL/DiscountsTotal/DiscountsDetail">
			<div style="width:776;float:left;">
			<span id="regraEstilo" title="R23-1">
				<span id="regraEstilo" title="R23-2">
					<div class="f12" style="width:250px;float:left;">
						<xsl:value-of select="@captionPhrase"/><br></br>
					</div>
					<div class="f12" style="width:125px;float:left;">
						<br></br>
					</div>
					<div class="f12" style="width:125px;float:left;">
						<br></br>
					</div>
					<span id="R23_valorDemonstrado">
					<div class="f12" style="width:276px;float:left;text-align:right;">
						<xsl:call-template name="FORMAT-DOUBLE">
							<xsl:with-param name="number" select="@amount"/>
						</xsl:call-template>
						<br></br>
					</div>
					</span>
					</span>
					</span>
			</div>
			</xsl:for-each>
			
		</xsl:if>

		<!-- descontos  -->
		
		<!--debitos diversos 320T 600T 010D(232) 010D(218)  -->
		
		<!--  verificacao dos debitos diversos -->
		<xsl:if test="(sum($subscription/ENTIRE_SUBSCRIPTION_TOTAL/SUBSCRIPTION_SRV_CHARGE_TOTAL/@ServiceChargeAmt) + sum($subscription/OPERATOR_CALL/PARTY_3RD_TOTAL/@Subtotal)) != 0" >
		
		<div class="f12" style="width:776px;float:left;">
				<br></br>
				<b>DÉBITOS DIVERSOS</b>
			</div>
			
			<div class="linhaDivisoria" />
			
			<div style="width:776;float:left;margin-top:-17px;">
				<div class="f12" style="width:250px;float:left;">
					Descrição<br></br><br></br>
				</div>
				<div class="f12" style="width:125px;float:left;">
					Referência<br></br><br></br>
				</div>
				<div class="f12" style="width:125px;float:left;">
					<br></br><br></br>
				</div>
				<div class="f12" style="width:276px;float:left;text-align:right;">
					Subtotal:

					<xsl:variable name="valorMonetarioVariavel16_0"
						select="sum($subscription/ENTIRE_SUBSCRIPTION_TOTAL/SUBSCRIPTION_SRV_CHARGE_TOTAL/@ServiceChargeAmt)"/>
					<xsl:variable name="valorMonetarioVariavel16_1"
						select="sum($subscription/OPERATOR_CALL/PARTY_3RD_TOTAL/@Subtotal)"/>
					
					<xsl:variable name="valorMonetarioVariavelSoma16" select="$valorMonetarioVariavel16_0 + $valorMonetarioVariavel16_1" />
					
					<xsl:call-template name="FORMAT-DOUBLE">
						<xsl:with-param name="number" select="$valorMonetarioVariavelSoma16"/>
					</xsl:call-template>
					
					<br></br>
					<b>Valor R$: </b><br></br>
				</div>
			</div>
			
			<!-- 320D-->
			<xsl:for-each select="$subscription/ENTIRE_SUBSCRIPTION_TOTAL/SUBSCRIPTION_SRV_CHARGE_TOTAL/SUBSCRIPTION_SRV_CHARGE_DETAIL">
			<div style="width:776;float:left;">
						<span id="regraEstilo" title="R32-08">
						<span id="regraEstilo" title="R40-1">
						<span id="regraEstilo" title="R40-2">
						<span id="regraEstilo" title="R40-5">
						<span id="regraEstilo" title="R40-6">
						<span id="regraEstilo" title="R47-1">
						<span id="regraEstilo" title="R47-2">
						<span id="regraEstilo" title="R53-02">
						<span id="regraEstilo" title="R53-03">
						<span id="regraEstilo" title="R57-01">
						<span id="regraEstilo" title="R57-02">
						
					<span id="R32_nomeServico">	
					<span id="R57_nomeServico">
					<span id="R53_nomeServico">
					<div class="f12" style="width:250px;float:left;">
						<xsl:value-of select="@Descricao"/><br></br>
					</div>
					</span>
					</span>
					</span>
					<span id="R40_dataAtivacao">
					<span id="R47_dataAtivacao">
					<div class="f12" style="width:125px;float:left;">
						<xsl:value-of select="vivo:DateFormat.formatDDMMYYYY(@StartDate)"/><br></br>
					</div>
					</span>
					</span>
					<div class="f12" style="width:125px;float:left;">
						<br></br>
					</div>
					<div class="f12" style="width:276px;float:left;text-align:right;">
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
			</div>
			</xsl:for-each>
			
			<!-- 600T -->
			<xsl:for-each select="$subscription/OPERATOR_CALL/PARTY_3RD_TOTAL/PARTY_3RD_DETAIL">
			<div style="width:776;float:left;">
				<div class="f12" style="width:250px;float:left;">
					<xsl:value-of select="@ServicePlan"/><br></br>
				</div>
				<div class="f12" style="width:125px;float:left;">
					<xsl:value-of select="vivo:DateFormat.formatDDMMYYYY(@Date)"/><br></br>
				</div>
				<div class="f12" style="width:125px;float:left;">
					<br></br>
				</div>
				<div class="f12" style="width:276px;float:left;text-align:right;">
					<xsl:call-template name="FORMAT-DOUBLE">
						<xsl:with-param name="number" select="@Amount"/>
					</xsl:call-template>
					<br></br>
				</div>
			</div>
			</xsl:for-each>
			
		</xsl:if>
		
		<!-- fim  débitos diversos  -->
		
		
		<!-- reversoes de pagamentos -->
		<!-- fim reversoes de pagamentos -->
		
		<!--parcelamento do aparelho -->
		
		<xsl:for-each select="$context/DUMMY_INVOICE_SUMMARY/EQUIPMENT_INSTALLMENT_TOTAL">
		
			<div class="f12" style="width:776px;float:left;">
				<br></br>
				<b>PARCELAMENTO DO APARELHO</b>
			</div>
			
			<div class="linhaDivisoria" />
			
			<div style="width:776;float:left;margin-top:-17px;">
				<div class="f12" style="width:250px;float:left;">
					Descrição<br></br><br></br>
				</div>
				<div class="f12" style="width:125px;float:left;">
					Parcelas<br></br><br></br>
				</div>
				<div class="f12" style="width:125px;float:left;">
					<br></br><br></br>
				</div>
				<div class="f12" style="width:276px;float:left;text-align:right;">
					Subtotal:

					<xsl:variable name="valorMonetarioVariavel18"
							select="sum(EQUIPMENT_INSTALLMENT_DETAIL/@Amount)"/>
					<xsl:call-template name="FORMAT-DOUBLE">
							<xsl:with-param name="number" select="$valorMonetarioVariavel18"/>
					</xsl:call-template>
					
					<br></br>
					<b>Valor R$: </b><br></br>
				</div>
			</div>
			
			<xsl:for-each select="EQUIPMENT_INSTALLMENT_DETAIL">
			<div style="width:776;float:left;">
				<span id="regraEstilo" title="R62-01">
				
					<div class="f12" style="width:250px;float:left;">
						Parcela do aparelho<br></br>
					</div>
					<span id="R62_parcelas">
					<div class="f12" style="width:125px;float:left;">
						<xsl:value-of select="@ParcelaAtual"/>/<xsl:value-of select="@Parcelas"/><br></br>
					</div>
					</span>
					<div class="f12" style="width:125px;float:left;">
						<br></br>
					</div>
					<span id="R62_valorParcela">
					<div class="f12" style="width:276px;float:left;text-align:right;">
						<xsl:call-template name="FORMAT-DOUBLE">
							<xsl:with-param name="number" select="@Amount"/>
						</xsl:call-template>
						<br></br>
					</div>
					</span>
				</span>
			</div>
			</xsl:for-each>
		
		</xsl:for-each>
		
		<!-- fim parcelamento do aparelho -->
		
					
		<!-- fim do DEMONSTRATIVO DOS LAN!AMENTOS DIVERSOS-->
		
	
	<!-- fim do conteudo da pagina 2 -->
	
	
	
</div>



<!-- fim página 2 PF -->


<!--
</div>
</div>
-->
</body>
</html>

</xsl:if>
<!-- fim verifica pagina -->

</xsl:template>   

</xsl:stylesheet>
