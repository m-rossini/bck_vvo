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
  
	<xsl:template name="pagina_nota_pf" >

<html id="nota">

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

<!-- inicio pagina NF PF -->

<div id="pagina1NFPF" class="pagina1NFPF">
	
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
				<span style="text-align:right;width:280px;"><b>Página 0000001/0000006</b></span>
				</span>
			</div>
		</div>
	</div>
	<!-- fim do sub cabecalho -->
	
	<!-- inicio do conteudo da pagina 12 nf pf -->
	
	
	
	
	<!-- looping de notas -->
	<xsl:for-each select="$context/DUMMY_INVOICE_SUMMARY/LD_GENERAL_INFO" >
		
		<div class="f14" style="width:776px;float:left;">
			<b>NOTA FISCAL DE SERVIÇOS DE TELECOMUNICAÇÕES</b>
		</div>
		
		<div class="detalheNota1">
			<div class="boxNota1_1">
				<div style="float:left;width:776px;margin:0px;padding:0px;">
					<div class="boxClara2PX_1"></div>
					<div class="boxClara2PX_2" style="width:772px;"></div>
					<div class="boxClara2PX_3"></div>
				</div>
				<div style="float:left;width:776px;margin:0px;padding:0px;">
					<div class="boxClara2PX_4" style="height:63px;"></div>
					<div class="boxClara2PX_conteudo" style="width:772px;height:63px;">
						<span class="f11" style="text-align:left;padding-left:5px;width:772px">
							
							<xsl:variable name="opera" 
								select="vivo:CarrierList.getOperadora(@LongDistanceCarrierUF,@LongDistanceCarrierID)"/>
										
							Nome da Empresa: <xsl:value-of select="$opera/@NAME" /><br></br>
							Endereço: <xsl:value-of select="$opera/@ADDRESS" /> CNPJ: <xsl:value-of select="$opera/@CNPJ" />
							I.E.: <xsl:value-of select="$opera/@INSC_MUNICIPAL" /><br></br>
							Nº Série: <xsl:value-of select="@InvoiceNumber" /> Período: 
							<xsl:value-of select="$cycleStartDate"/> a <xsl:value-of select="$cycleEndDate"/>
							Emissão:
							<xsl:value-of select="vivo:DateFormat.formatMMYYYY(@InvoiceIssueDate)"/><br></br>
							Atende o convênio 115/2003 CFOP: <xsl:value-of select="$opera/@CFOP" /> Descrição: PF/PJ - Outros
						</span>
					</div>
					<div class="boxClara2PX_5" style="height:63px;"></div>
				</div>
				<div style="float:left;width:776px;margin:0px;padding:0px;">
					<div class="boxClara2PX_6"></div>
					<div class="boxClara2PX_7" style="width:772px;"></div>
					<div class="boxClara2PX_8"></div>
				</div>
			</div>
		</div>
		
		<!-- cabecalho por empresa -->
		<div style="width:776px;float:left;">
					<div class="f11" style="width:40px;float:left;">
						<b>Seq.:</b>
					</div>
								
					<div class="f11" style="width:80px;float:left;text-align:left;">
						<b>Cód. Serviço</b>
					</div>
					
					<div class="f11" style="width:280px;float:left;text-align:left;">
						<b>Descrição</b>
					</div>
					
					<div class="f11" style="width:176px;float:left;text-align:left;">
						<b>Quantidade</b>
					</div>
								
					<div class="f11" style="width:80px;float:left;text-align:left;">
						<b>ICMS %</b>
					</div>
					
					<div class="f11" style="width:100px;float:left;text-align:right;">
						<b>Valor em R$</b>
					</div>
					
					<div class="f11" style="width:20px;float:left;text-align:right;">
						<b></b>
					</div>
					
		</div>
		<!-- fiom cabecalho por empresa -->
		<!-- looping do detalhamento por empresa, caso VIVO mais itens -->
		
		<!--caso vivo -->
		
		
		<!-- VARIAVEIS VIVO -->
					<!--DESCONTOS -->
					<xsl:variable name="valorMonetarioVariavel15_0"
						select="sum($context/DUMMY_INVOICE_SUMMARY/DISCOUNT_TOTAL/@Amount)"/>
					<xsl:variable name="valorMonetarioVariavel15_1"
						select="sum($subscription/PROMOTIONS_TOTAL/@Amount)"/>
					<xsl:variable name="valorMonetarioVariavel15_2"
						select="sum($subscription/OPERATOR_CALL/DiscountsTotal/@Amount)"/>
					<xsl:variable name="valorMonetarioVariavelSoma15" select="$valorMonetarioVariavel15_0 + $valorMonetarioVariavel15_1 + $valorMonetarioVariavel15_2" />
					<xsl:variable name="descontos" select="$valorMonetarioVariavelSoma15"/>
					
					<!-- DEBITOS DIVERSOS -->
					<xsl:variable name="debitosDiversos" select="0"/>
					
					<!-- DEBITOS CONSTESTACOES -->
					<xsl:variable name="debitosContestacoes" select="0"/>
					
					<!-- ADESAO -->
					<xsl:variable name="valorMonetario"
						select="sum($subscription/ENTIRE_SUBSCRIPTION_TOTAL/SUBSCRIPTION_SRV_CHARGE_TOTAL/@ServiceChargeAmt)"/>
					<xsl:variable name="adesao" select="$valorMonetario"/>
					
		<!-- FIM VARIAVEIS VIVO -->
		
		
		<xsl:if test="@LongDistanceCarrierID = 00">
			<!-- descontos -->
			<div style="width:776px;float:left;">
				<div class="f11" style="width:40px;float:left;">
					1<br></br>
				</div>
							
				<div class="f11" style="width:80px;float:left;text-align:left;">
					10001<br></br>
				</div>
				
				<div class="f11" style="width:280px;float:left;text-align:left;">
					Descontos
				</div>
				
				<div class="f11" style="width:176px;float:left;text-align:left;">
					1
				</div>
							
				<div class="f11" style="width:80px;float:left;text-align:left;">
					25
				</div>
				
				<div class="f11" style="width:100px;float:left;text-align:right;">
					
					
					<xsl:call-template name="FORMAT-DOUBLE">
						<xsl:with-param name="number" select="$descontos"/>
					</xsl:call-template>
				</div>
				
				<div class="f11" style="width:20px;float:left;text-align:right;">
					CR
				</div>
				
			</div>
			<!-- fim descontos -->
			<!-- debitos diversos -->
			<div style="width:776px;float:left;">
				<div class="f11" style="width:40px;float:left;">
					2<br></br>
				</div>
							
				<div class="f11" style="width:80px;float:left;text-align:left;">
					200021<br></br>
				</div>
				
				<div class="f11" style="width:280px;float:left;text-align:left;">
					Débitos Diversos
				</div>
				
				<div class="f11" style="width:176px;float:left;text-align:left;">
					1
				</div>
							
				<div class="f11" style="width:80px;float:left;text-align:left;">
					25
				</div>
				
				<div class="f11" style="width:100px;float:left;text-align:right;">
					<xsl:call-template name="FORMAT-DOUBLE">
						<xsl:with-param name="number" select="$debitosDiversos"/>
					</xsl:call-template>
				</div>
				
				<div class="f11" style="width:20px;float:left;text-align:right;"/>
				
			</div>
			<!-- fim debitos diversos -->
			<!-- debitos de contestações -->
			<div style="width:776px;float:left;">
				<div class="f11" style="width:40px;float:left;">
					3<br></br>
				</div>
							
				<div class="f11" style="width:80px;float:left;text-align:left;">
					301000<br></br>
				</div>
				
				<div class="f11" style="width:280px;float:left;text-align:left;">
					Débitos de Contestações
				</div>
				
				<div class="f11" style="width:176px;float:left;text-align:left;">
					1
				</div>
							
				<div class="f11" style="width:80px;float:left;text-align:left;">
					25
				</div>
				
				<div class="f11" style="width:100px;float:left;text-align:right;">
					<xsl:call-template name="FORMAT-DOUBLE">
						<xsl:with-param name="number" select="$debitosContestacoes"/>
					</xsl:call-template>
				</div>
				
				<div class="f11" style="width:20px;float:left;text-align:right;"/>
				
			</div>
			<!-- fim debitos de contestações -->
			
			<!-- adesao -->
			<div style="width:776px;float:left;">
				<div class="f11" style="width:40px;float:left;">
					4<br></br>
				</div>
							
				<div class="f11" style="width:80px;float:left;text-align:left;">
					512212<br></br>
				</div>
				
				<div class="f11" style="width:280px;float:left;text-align:left;">
					Adesão
				</div>
				
				<div class="f11" style="width:176px;float:left;text-align:left;">
					1
				</div>
							
				<div class="f11" style="width:80px;float:left;text-align:left;">
					25
				</div>
				
				<div class="f11" style="width:100px;float:left;text-align:right;">
					
					
					<xsl:call-template name="FORMAT-DOUBLE">
						<xsl:with-param name="number" select="$adesao"/>
					</xsl:call-template>
				</div>
				
				<div class="f11" style="width:20px;float:left;text-align:right;">
					
				</div>
				
			</div>
			<!-- fim adesao -->
			
		</xsl:if>
		<!-- fim caso VIVO -->
		<xsl:for-each select="SUMMARY_ACCUMULATION_TAXES">
			<div style="width:776px;float:left;">
				<span id="regraEstilo" title="R60-3">
				<span id="regraEstilo" title="R65-01-1">
				<span id="regraEstilo" title="R65-01-2">
				<span id="regraEstilo" title="R65-01-3">
				<span id="regraEstilo" title="R65-01-4">
				<span id="regraEstilo" title="R65-01-5">
				<span id="regraEstilo" title="R65-02">
				<div class="f11" style="width:40px;float:left;">
					<xsl:value-of select="@ItemNo"/>
				</div>
				<span id="R65-01_cfop">
				<div class="f11" style="width:80px;float:left;text-align:left;">
					<xsl:value-of select="@CodigoServico"/>
				</div>
				</span>
				<div class="f11" style="width:280px;float:left;text-align:left;">
					<xsl:value-of select="@NomeServico"/>
				</div>
				
				<div class="f11" style="width:176px;float:left;text-align:left;">
					<xsl:variable name="nomeServico" select='substring(@NomeServico,1,4)'/>
					<xsl:variable name="qtdServico" select='@Quantidade'/>
					<xsl:variable name="duraServico" select='@Duracao'/>
					
					<xsl:choose>
						<xsl:when test="$nomeServico = 'Cham'">
							<xsl:call-template name="FORMAT-HMS">
								<xsl:with-param name="number" select="$duraServico" />
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="$nomeServico != 'Cham'">
							<xsl:value-of select="$qtdServico"/>
						</xsl:when>
					</xsl:choose>
					
				</div>
				<div class="f11" style="width:80px;float:left;text-align:left;">
					<xsl:value-of select="@AliquotaICMS"/>
				</div>
				<span id="R60_valorItem">
				<span id="R65-01_valor">
				<span id="R65-02_totalItem">
				<div class="f11" style="width:100px;float:left;text-align:right;">
					<xsl:call-template name="FORMAT-DOUBLE">
							<xsl:with-param name="number" select="@TotalAmount"/>
					</xsl:call-template>
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

			
		</xsl:for-each>
		<!-- total -->
			<div style="width:776px;float:left;">
			<span id="regraEstilo" title="R65-02">
				<div class="f11" style="width:40px;float:left;" />
		
				<div class="f11" style="width:80px;float:left;text-align:left;"/>
				
				<div class="f11" style="width:280px;float:left;text-align:left;">
					TOTAL NOTA FISCAL
				</div>
				
				<div class="f11" style="width:176px;float:left;text-align:left;"/>
							
				<div class="f11" style="width:80px;float:left;text-align:left;"/>
				
				<div class="f11" style="width:100px;float:left;text-align:right;">
					
					<!-- variavel de total -->
						<xsl:variable name="variavelTotal" select ="sum(SUMMARY_ACCUMULATION_TAXES/@TotalAmount)" />
						
						
						<xsl:if test="@LongDistanceCarrierID = 00">
							<xsl:variable name="variavelTotal" select ="sum(SUMMARY_ACCUMULATION_TAXES/@TotalAmount)- $descontos + $debitosDiversos + $debitosContestacoes + $adesao" />
						</xsl:if>
						
					<!-- fim variavel de total -->
					<span id="R65-02_totalItem">
					<xsl:call-template name="FORMAT-DOUBLE">
							<xsl:with-param name="number" select="$variavelTotal"/>
					</xsl:call-template>
					</span>
				</div>
				
				<div class="f11" style="width:20px;float:left;text-align:right;">
					
				</div>
				</span>
			</div>
		
		<!--fim total -->
		<!-- informacoes complementares -->
		<div class="linhaDivisoria" />
		<div class="margemNota" style="width:776px;float:left;">
			<div class="f11" style="width:200px;float:left;">
				Informações Complementares
			</div>
	
			<div class="f11" style="width:80px;float:left;text-align:center;">
				<b>ICMS %</b>
			</div>
			
			<div class="f11" style="width:120px;float:left;text-align:right;">
				<b>Base de Cálculo - R$</b>
			</div>
			
			<div class="f11" style="width:100px;float:left;text-align:right;">
				<b>Valor ICMS - R$</b>
			</div>
			
			<div class="f11" style="width:276px;float:left;text-align:right;">
				<b>Serv.Isentos/Não Tributáveis - R$</b>
			</div>
		</div>
		<xsl:for-each select="ICMS_SUMMARY">
			<div style="width:776px;float:left;">
			<span id="regraEstilo" title="R54-1">
			<span id="regraEstilo" title="R54-2">
                     <span id="regraEstilo" title="R65-02">
			<span id="regraEstilo" title="R65-03-1.2">
			<span id="regraEstilo" title="R65-03-1.3">
			<span id="regraEstilo" title="R65-03-2">
			<span id="regraEstilo" title="R65-03-3">
			<span id="regraEstilo" title="R65-03-4-Match">
			
				<span id="R65-02_aliquota">
				<div class="f11" style="width:280px;float:left;text-align:right;">
					<xsl:call-template name="FORMAT-ICMS">
						<xsl:with-param name="number" select="@Aliquota"/>
					</xsl:call-template>
					&#160;&#160;&#160;&#160;&#160;&#160;
				</div>
				</span>
				<span id="R54_nfTotal">
				<span id="R65-02_baseCalculo">
				<div class="f11" style="width:120px;float:left;text-align:right;">
					<xsl:call-template name="FORMAT-DOUBLE">
							<xsl:with-param name="number" select="@BaseCalculo"/>
					</xsl:call-template>
				</div>
				</span>
				</span>
				<span id="R54_icmsTotal">
				<span id="R65-02_valorICMS">
				<div class="f11" style="width:100px;float:left;text-align:right;">
					<xsl:call-template name="FORMAT-DOUBLE">
							<xsl:with-param name="number" select="@TaxesAmt"/>
					</xsl:call-template>
				</div>
				</span>
				</span>
				<span id="R65-02_valorIsento">
				<span id="R65-02_totalItem">	
				<div class="f11" style="width:276px;float:left;text-align:right;">
					<xsl:call-template name="FORMAT-DOUBLE">
							<xsl:with-param name="number" select="@NonTaxableAmount"/>
					</xsl:call-template>
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
		</xsl:for-each>
		<!-- fim informações complementares -->
		
		<!-- contribuicao -->
		<xsl:for-each select="TOTAL_TAX" >
		<div class="linhaDivisoria" />
		<div class="margemNota" style="width:776px;float:left;">
			<spam class="f11">
			Contribuição para o FUST 1% 
			= R$
			<xsl:call-template name="FORMAT-DOUBLE">
				<xsl:with-param name="number" select="@TotalFUSTAmount"/>
			</xsl:call-template>
			 e FUNTTEL 0,5% = R$ 
			 <xsl:call-template name="FORMAT-DOUBLE">
				<xsl:with-param name="number" select="@TotalFUNTTELAmount"/>
			</xsl:call-template>
			 do valor dos serviços - não repassado às tarifas.
			<br></br>
			<br></br>
			</spam>
		</div>
		</xsl:for-each>
		<!-- fiom do detalhamento por empresa -->
	
	</xsl:for-each>
	<!-- fim do looping de notas -->
	
	
	<!-- celulares que compoe a nota -->
	<div class="f14" style="width:776px;float:left;">
		<b>CELULARES QUE COMPÕEM ESTA FATURA</b>
	</div>
	<div class="linhaDivisoria" />
	<div class="margemNota" style="width:776px;float:left;">
		<div class="f11" style="width:576px;float:left;" />
		<div class="f11" style="width:100px;float:left;" >
			<b>Subtotal:</b>
		</div>
		<div class="f11" style="width:100px;float:left;text-align:right;">
			<xsl:call-template name="FORMAT-DOUBLE">
				<xsl:with-param name="number" select="sum($subscription/ENTIRE_SUBSCRIPTION_TOTAL/@SubscriptionAmount)"/>
			</xsl:call-template>
		</div>
	</div>
	<div style="width:776px;float:left;">
		<div class="f11" style="width:376px;float:left;">
			<b>Número do Celular</b>
		</div>

		<div class="f11" style="width:250px;float:left;text-align:left;">
			<b>Plano</b>
		</div>
		
		<div class="f11" style="width:150px;float:left;text-align:right;">
			<b>Valor R$</b>
		</div>
	</div>
	<xsl:for-each select="$subscription">
	<div style="width:776px;float:left;">
	<span id="regraEstilo" title="R65-04-1">
	<span id="regraEstilo" title="R65-04-2">
		
		<span id="R65-04-1_phone">
		<div class="f11" style="width:376px;float:left;">
			<xsl:value-of select="@PhoneNumber" />
		</div>
		</span>

		<div class="f11" style="width:250px;float:left;text-align:left;">
			<xsl:value-of select="@planName" />
		</div>
		
		<span id="R65-04-1_totalSecao">
		<div class="f11" style="width:150px;float:left;text-align:right;">
			<xsl:call-template name="FORMAT-DOUBLE">
				<xsl:with-param name="number" select="ENTIRE_SUBSCRIPTION_TOTAL/@SubscriptionAmount"/>
			</xsl:call-template>
		</div>
		</span>
		</span>
		</span>
	</div>
	</xsl:for-each>
	
	<!-- fim dos celulares que compoe a nota -->
	
	<!-- operadoras -->
	<div class="detalheNota2">
			<div class="boxNota2_1">
				<div style="float:left;width:776px;margin:0px;padding:0px;">
					<div class="boxClara2PX_1"></div>
					<div class="boxClara2PX_2" style="width:772px;"></div>
					<div class="boxClara2PX_3"></div>
				</div>
				<div style="float:left;width:776px;margin:0px;padding:0px;">
					<div class="boxClara2PX_4" style="height:18px;"></div>
					<div class="boxClara2PX_conteudo" style="width:772px;height:18px;">
						<span class="f12" style="text-align:left;padding-left:5px;width:772px">
							Operadoras de Longa Distância - 15 - Telefônica 21 - Embratel 23 - Intelig 31 - Telemar 14 - Brasil Telecom 12 - CTBC 41 - TIM
						</span>
					</div>
					<div class="boxClara2PX_5" style="height:18px;"></div>
				</div>
				<div style="float:left;width:776px;margin:0px;padding:0px;">
					<div class="boxClara2PX_6"></div>
					<div class="boxClara2PX_7" style="width:772px;"></div>
					<div class="boxClara2PX_8"></div>
				</div>
			</div>
		</div>
	<!-- fim operadoras -->
	
	<!-- autorizacao debito automatico -->
	<div class="detalheNota3">
			<div class="boxNota3_1">
				<div style="float:left;width:776px;margin:0px;padding:0px;">
					<div class="boxClara2PX_1"></div>
					<div class="boxClara2PX_2" style="width:772px;"></div>
					<div class="boxClara2PX_3"></div>
				</div>
				<div style="float:left;width:776px;margin:0px;padding:0px;">
					<div class="boxClara2PX_4" style="height:203px;"></div>
					<div class="boxClara2PX_conteudo" style="width:772px;height:203px;">
						<div class="f14" style="text-align:center;width:772px;float:left;">
							<b>Autorização de Débito Automático em Conta Corrente</b>
						</div>
						<div class="f10" style="text-align:left;padding-left:5px;width:772px;float:left;">
							* Autorizo que o pagamento da minha conta telefônica seja efetuado de acordo 
							com os valores informados pela VIVO através do serviço de débito 
							automático em conta corrente no
							
							banco, agência e conta corrente por mim abaixo indicados. Fico ciente de que qualquer 
							alteração nos mesmos poderá implicar na descontinuidade do serviço
							de débito automático, cabendo a mim realizar a solicitação de um novo cadastramento.
							No caso de insulficiência de saldo, estou ciente de que o débito ficará em aberto
							sendo da minha responsabilidade a sua quitação.
						</div>
						<div class="f12" style="text-align:left;padding-left:5px;width:772px;float:left;">
							Identificador de Débito Automático:<br></br>
							Nome do Cliente:
						</div>
						<div class="f12" style="text-align:left;padding-left:5px;width:772px;float:left;">
							<div class="f12" style="text-align:left;width:140px;float:left;">
							Nome do Correntista:
							</div>
							<div class="f12" style="text-align:left;width:622px;float:left;border-bottom:1px solid;"/>
						</div>
						
						<div class="f12" style="text-align:left;padding-left:5px;width:772px;float:left;">
							<div class="f12" style="text-align:left;width:70px;float:left;">
							CPF/CNPJ:
							</div>
							<div class="f12" style="text-align:left;width:180px;float:left;border-bottom:1px solid;"/>
							<div class="f12" style="text-align:left;width:40px;float:left;">
							RG:
							</div>
							<div class="f12" style="text-align:left;width:180px;float:left;border-bottom:1px solid;"/>
							<div class="f12" style="text-align:left;width:102px;float:left;">
							Órgão Emissor:
							</div>
							<div class="f12" style="text-align:left;width:190px;float:left;border-bottom:1px solid;"/>
						</div>
						
						<div class="f12" style="text-align:left;padding-left:5px;width:772px;float:left;">
							<div class="f12" style="text-align:left;width:60px;float:left;">
							Banco:
							</div>
							<div class="f12" style="text-align:left;width:180px;float:left;border-bottom:1px solid;"/>
							<div class="f12" style="text-align:left;width:60px;float:left;">
							Agência:
							</div>
							<div class="f12" style="text-align:left;width:170px;float:left;border-bottom:1px solid;"/>
							<div class="f12" style="text-align:left;width:102px;float:left;">
							Conta Corrente:
							</div>
							<div class="f12" style="text-align:left;width:190px;float:left;border-bottom:1px solid;"/>
						</div>
						
						<div class="f12" style="text-align:left;padding-left:5px;width:772px;float:left;">
							<div class="f12" style="text-align:left;width:180px;height:25px;float:left;border-bottom:1px solid;"/>
							<div class="f12" style="text-align:left;width:5px;height:25px;float:left;padding-top:13px">,</div>
							<div class="f12" style="text-align:left;width:15px;height:25px;float:left;border-bottom:1px solid;"/>
							<div class="f12" style="text-align:left;width:5px;height:25px;float:left;padding-top:13px">/</div>
							<div class="f12" style="text-align:left;width:15px;height:25px;float:left;border-bottom:1px solid;"/>
							<div class="f12" style="text-align:left;width:5px;height:25px;float:left;padding-top:13px">/</div>
							<div class="f12" style="text-align:left;width:35px;height:25px;float:left;border-bottom:1px solid;"/>
							
							<div class="f12" style="text-align:left;width:260px;height:30px;float:left;"/>
							
							<div class="f12" style="text-align:left;width:242px;height:30px;float:left;border-bottom:1px solid;"/>
						</div>
						
						<div class="f12" style="text-align:left;padding-left:5px;width:772px;float:left;">
							<div class="f12" style="text-align:center;width:260px;float:left;">
							Local e data
							</div>
							<div class="f12" style="text-align:left;width:260px;float:left;"/>
							<div class="f12" style="text-align:center;width:242px;float:left;">
							Assinatura do titular da conta corrente
							</div>
						</div>
					</div>
					<div class="boxClara2PX_5" style="height:203px;"></div>
				</div>
				<div style="float:left;width:776px;margin:0px;padding:0px;">
					<div class="boxClara2PX_6"></div>
					<div class="boxClara2PX_7" style="width:772px;"></div>
					<div class="boxClara2PX_8"></div>
				</div>
			</div>
		</div>
	<!-- fim de autorizacao debito automatico -->
	
	<!-- fim do conteudo -->

	
</div>



<!-- fim pagina NF PF -->
<!--
</div>
</div>
-->
</body>
</html>


</xsl:template>   

</xsl:stylesheet>
