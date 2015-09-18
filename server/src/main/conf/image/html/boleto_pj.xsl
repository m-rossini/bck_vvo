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
 
  
	<xsl:template name="pagina_boleto_pj" match="/SIRS/CYCLE_SUMMARY">

<html id="boleto">

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



<!-- pagina 1 -->
<div id="pagina1" class="pagina1">
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
			<div class="subCabecalho2_1">
				<xsl:value-of select="$opera/@NAME" /><br></br>
				<xsl:value-of select="$opera/@ADDRESS" /><br></br>
				Ins.Mun. <xsl:value-of select="$opera/@INSC_MUNICIPAL" />
				CNPJ <xsl:value-of select="$opera/@CNPJ" /><br></br>
			</div>
		</div>
	</div>
	<!-- fim do sub cabecalho -->
	<!-- detalhe do boleto -->
	<div class="detalheBoleto">
		<div class="detalheBoleto1">
			<div class="detalheBoleto1_1">
				<div class="boxBoleto1_1_1">
					<div style="float:left;width:488px;margin:0px;padding:0px;">
						<div class="boxClara2PX_1"></div>
						<div class="boxClara2PX_2" style="width:484px;"></div>
						<div class="boxClara2PX_3"></div>
					</div>
					<div style="float:left;width:488px;margin:0px;padding:0px;">
						<div class="boxClara2PX_4" style="height:22px;"></div>
						<div class="boxClara2PX_conteudo" style="width:484px;height:22px;">
							<span class="f14" style="padding-left:5px;width:484px"><b>Conta: <xsl:value-of select="$accountNumber"/></b></span>
						</div>
						<div class="boxClara2PX_5" style="height:22px;"></div>
					</div>
					<div style="float:left;width:488px;margin:0px;padding:0px;">
						<div class="boxClara2PX_6"></div>
						<div class="boxClara2PX_7" style="width:484px;"></div>
						<div class="boxClara2PX_8"></div>
					</div>
				</div>
				<span id="regraEstilo" title="R64-1">
				<span id="regraEstilo" title="R64-2">
				<span id="regraEstilo" title="R64-3">
				<div class="boxBoleto1_1_2">
					<div style="float:left;width:156px;margin:0px;padding:0px;">
						<div class="boxClara2PX_1"></div>
						<div class="boxClara2PX_2" style="width:152px;"></div>
						<div class="boxClara2PX_3"></div>
					</div>
					<div style="float:left;width:156px;margin:0px;padding:0px;">
						<div class="boxClara2PX_4" style="height:32px;"></div>
						<div class="boxClara2PX_conteudo" style="width:152px;height:32px;">
							<span class="f12" style="width:145px;height:10px;padding-left:5px;"><b>Emissão</b><br></br>
							<span id="R64_emissao">
							<span class="f12" style="width:145px;text-align:right;padding-right:5px;">
								<xsl:value-of select="vivo:DateFormat.formatDDMMYYYY(/SIRS/CYCLE_SUMMARY/@BillingDate)"/>
							</span></span></span>
						</div>
						<div class="boxClara2PX_5" style="height:32px;"></div>
					</div>
					<div style="float:left;width:156px;margin:0px;padding:0px;">
						<div class="boxClara2PX_6"></div>
						<div class="boxClara2PX_7" style="width:152px;"></div>
						<div class="boxClara2PX_8"></div>
					</div>
				</div>
				
				<div class="boxBoleto1_1_3">
					<div style="float:left;width:156px;margin:0px;padding:0px;">
						<div class="boxClara2PX_1"></div>
						<div class="boxClara2PX_2" style="width:152px;"></div>
						<div class="boxClara2PX_3"></div>
					</div>
					<div style="float:left;width:156px;margin:0px;padding:0px;">
						<div class="boxClara2PX_4" style="height:32px;"></div>
						<div class="boxClara2PX_conteudo" style="width:152px;height:32px;">
							<span class="f12" style="width:145px;height:10px;padding-left:5px;"><b>Mês de Referência</b><br></br>
							<span id="R64_referencia">
							<span class="f12" style="width:145px;text-align:right;padding-right:5px;">
								<xsl:value-of select="vivo:DateFormat.formatMMYYYY(/SIRS/CYCLE_SUMMARY/@BillingDate)"/>
							</span></span></span>
						</div>
						<div class="boxClara2PX_5" style="height:32px;"></div>
					</div>
					<div style="float:left;width:156px;margin:0px;padding:0px;">
						<div class="boxClara2PX_6"></div>
						<div class="boxClara2PX_7" style="width:152px;"></div>
						<div class="boxClara2PX_8"></div>
					</div>
				</div>
				</span>
				</span>
				</span>
				<div class="boxBoleto1_1_4">
					<div style="float:left;width:156px;margin:0px;padding:0px;">
						<div class="boxClara2PX_1"></div>
						<div class="boxClara2PX_2" style="width:152px;"></div>
						<div class="boxClara2PX_3"></div>
					</div>
					<div style="float:left;width:156px;margin:0px;padding:0px;">
						<div class="boxClara2PX_4" style="height:32px;"></div>
						<div class="boxClara2PX_conteudo" style="width:152px;height:32px;">
							<span class="f12" style="width:145px;height:10px;padding-left:5px;"><b>Período</b><br></br>
							<span class="f12" style="width:145px;text-align:right;padding-right:5px;">
								<xsl:value-of select="$cycleStartDate"/> a <xsl:value-of select="$cycleEndDate"/>
							</span></span>
						</div>
						<div class="boxClara2PX_5" style="height:32px;"></div>
					</div>
					<div style="float:left;width:156px;margin:0px;padding:0px;">
						<div class="boxClara2PX_6"></div>
						<div class="boxClara2PX_7" style="width:152px;"></div>
						<div class="boxClara2PX_8"></div>
					</div>
				</div>
			</div>
			
			
			<div class="detalheBoleto1_2">
				<div class="boxBoleto1_2">
					<div style="float:left;width:137px;margin:0px;padding:0px;">
						<div class="boxEscura2PX_1"></div>
						<div class="boxEscura2PX_2" style="width:132px;"></div>
						<div class="boxEscura2PX_3"></div>
					</div>
					<div style="float:left;width:137px;margin:0px;padding:0px;">
						<div class="boxEscura2PX_4" style="height:63px;"></div>
						<div class="boxEscura2PX_conteudo" style="width:132px;height:63px;">
							<span title="R47-1" id="regraEstilo">
							<span title="R47-2" id="regraEstilo">
							<span id="regraEstilo" title="espaco_livre_para_nova_regra">
							<span class="f12" style="padding-left:5px;width:132px"><b>VENCIMENTO</b></span>
							<span id="R47_dataAtivacao">
							<span class="f20" style="text-align:center;padding-right:5px;padding-top:15px;width:132px">
								<xsl:value-of select="vivo:DateFormat.formatDDMMYYYY($context/@DueDate)"/>
							</span>
							</span>
							</span>
							</span>
							</span>
						</div>
						<div class="boxEscura2PX_5" style="height:63px;"></div>
					</div>
					<div style="float:left;width:137px;margin:0px;padding:0px;">
						<div class="boxEscura2PX_6"></div>
						<div class="boxEscura2PX_7" style="width:132px;"></div>
						<div class="boxEscura2PX_8"></div>
					</div>
				</div>
			</div>
			<div class="detalheBoleto1_3">
				<div class="boxBoleto1_3">
					<div style="float:left;width:137px;margin:0px;padding:0px;">
						<div class="boxEscura2PX_1"></div>
						<div class="boxEscura2PX_2" style="width:132px;"></div>
						<div class="boxEscura2PX_3"></div>
					</div>
					<div style="float:left;width:137px;margin:0px;padding:0px;">
						<div class="boxEscura2PX_4" style="height:63px;"></div>
						<div class="boxEscura2PX_conteudo" style="width:132px;height:63px;">
							<span id="regraEstilo" title="R04">
							<span id="regraEstilo" title="espaco_livre_para_nova_regra">
							<span class="f12" style="text-align:right;padding-right:5px;width:132px"><b>TOTAL A PAGAR - R$</b></span>	
							<span id="R04_demonstrado">
							<span class="f20" style="text-align:right;padding-right:5px;padding-top:15px;width:132px">
								<xsl:call-template name="FORMAT-DOUBLE">
									<xsl:with-param name="number" select="$context/@TotalDueAmount"/>
								</xsl:call-template>
							</span>
							</span>
							</span>
							</span>
						</div>
						<div class="boxEscura2PX_5" style="height:63px;"></div>
					</div>
					<div style="float:left;width:137px;margin:0px;padding:0px;">
						<div class="boxEscura2PX_6"></div>
						<div class="boxEscura2PX_7" style="width:132px;"></div>
						<div class="boxEscura2PX_8"></div>
					</div>
				</div>
			</div>
		</div>
		
		
		<div class="detalheBoleto2">
			<div class="boxBoleto2_1">
					<div style="float:left;width:776px;margin:0px;padding:0px;">
						<div class="boxClara2PX_1"></div>
						<div class="boxClara2PX_2" style="width:772px;"></div>
						<div class="boxClara2PX_3"></div>
					</div>
					<div style="float:left;width:776px;margin:0px;padding:0px;">
						<div class="boxClara2PX_4" style="padding-bottom: 32767px;margin-bottom: -32767px;"></div>
						<div class="boxClara2PX_conteudo" style="width:772px;padding-bottom: 32767px;margin-bottom: -32767px;">
							<span class="f14" style="text-align:left;padding-left:5px;width:772px"><b>Número(s) do(s) Celular(es)</b></span>
							<span class="f12" style="text-align:left;padding-left:5px;width:772px;">
								<xsl:for-each select="/SIRS/CYCLE_SUMMARY/SUBSCRIPTION_INFO">
									<span id="regraEstilo" title="R71-1">
									<span id="regraEstilo" title="R71-2">
									<span id="regraEstilo" title="R71-3">
									<span id="regraEstilo" title="R40-3">
									<span id="regraEstilo" title="R59-1">
										<span id="R71_terminal">
										<span id="R40_terminal">
           								<xsl:value-of select="@PhoneNumber"/></span></span>&#160;&#160;&#160;&#160;&#160;
	    							</span>
	    							</span>
	    							</span>
	    							</span>
	    							</span>
    							</xsl:for-each>
							<br></br>
							<span class="f10" style="text-align:left;padding-left:1px;padding-top:2px;width:750px;">Relação total de celulares está localizada na Seção Celulares que compõem sua fatura em página a seguir.
							</span>
							</span>
						</div>
						<div class="boxClara2PX_5" style="padding-bottom: 32767px;margin-bottom: -32767px;"></div>
					</div>
					<div style="float:left;width:776px;margin:0px;padding:0px;">
						<div class="boxClara2PX_6"></div>
						<div class="boxClara2PX_7" style="width:772px;"></div>
						<div class="boxClara2PX_8"></div>
					</div>
				</div>
		</div>
		
		<!-- VARIAVEIS PARA ESCONDER OS VALORES ZERADOS DA PAGINA BOLETO -->
		<!-- coluna da esquerda -->
		<!--planosPacotes Contratados-->
		<xsl:variable name="planosPacotes"
			select="sum($subscription/ENTIRE_SUBSCRIPTION_TOTAL/ACTIVATION_TOTAL/@ServiceChargeAmt)"/>
		<!--serviçosAdicionais-->
		<xsl:variable name="servicosAdicionais"
			select="sum($subscription/ADDITIONAL_SERVICES_TOTAL/@ServiceChargeAmt)"/>
		<!--redebitos-->
		<xsl:variable name="redebitos_0"
			select="sum($context/DISPUTE_CREDIT_TOTAL/@Amount)"/>
		<xsl:variable name="redebitos_1"
			select="sum($subscription/OPERATOR_CALL/REDEBITO_SERVICOS_IMPUGNADOS_TOTAL/@Amount)"/>
		<xsl:variable name="redebitos_2"
			select="sum($subscription/OPERATOR_CALL/REDEBITO_CHAMADAS_IMPUGNADAS_TOTAL/@Amount)"/>
		<xsl:variable name="redebitos_3"
			select="sum($subscription/OPERATOR_CALL/REDEBITO_MENSAGENS_IMPUGNADAS_TOTAL/@Amount)"/>
		<xsl:variable name="redebitos_4"
			select="sum($subscription/OPERATOR_CALL/REDEBITO_DATA_2G_IMPUGNADAS_TOTAL/@Amount)"/>
		<xsl:variable name="redebitosSoma" select="$redebitos_0 + $redebitos_1 + $redebitos_2 + $redebitos_3 + $redebitos_4" />
		<!--chamadasLocaisOriginadas -->
		<xsl:variable name="chamadasLocaisOriginadas"
			select="sum($subscription/OPERATOR_CALL/LOCAL_CALLS_TOTAL/@Subtotal)"/>
		<!--chamadasRecebidasCobrar -->
		<xsl:variable name="chamadasRecebidasCobrar"
			select="sum($subscription/OPERATOR_CALL/LOCAL_COLLECT_CALLS_TOTAL/@Subtotal)"/>
		<!-- soma de chamadasLocaisOriginadas + chamadasRecebidasCobrar -->
		<xsl:variable name="originadasRecebidasCobrar"
			select="$chamadasLocaisOriginadas + $chamadasRecebidasCobrar"/>
		<!--chamadasLocaisOriginadasFora -->
		<xsl:variable name="chamadasLocaisOriginadasFora"
			select="sum($subscription/OPERATOR_CALL/ROAM_MOC_LOCAL_TOTAL/@Subtotal)"/>
		<!--chamadasLocaisRecebidas -->
		<xsl:variable name="chamadasLocaisRecebidas"
			select="sum($subscription/OPERATOR_CALL/ROAM_MTC_LOCAL_TOTAL/@Subtotal)"/>
		<!-- soma de chamadasLocaisOriginadasFora + chamadasLocaisRecebidas -->
		<xsl:variable name="originadasForaRecebidas"
			select="$chamadasLocaisOriginadasFora + $chamadasLocaisRecebidas"/>
		<!--numerosEspecificos-->
		<xsl:variable name="numerosEspecificos"
			select="sum($subscription/OPERATOR_CALL/VAS_TOTAL/@Subtotal)"/>
		<!-- numeros0500 -->
		<xsl:variable name="numeros0500"
			select="sum($subscription/OPERATOR_CALL/Calls0500Total/@Subtotal)"/>
		<!-- exterior -->
		<xsl:variable name="exterior"
			select="sum($subscription/OPERATOR_CALL/ROAM_MTC_INTERNATIONAL_TOTAL/@Subtotal)"/>
		<!-- dados_soma -->
		<xsl:variable name="dados_0"
				select="sum($subscription/OPERATOR_CALL/SMS_TOTAL/@Subtotal)"/>
		<xsl:variable name="dados_1"
				select="sum($subscription/OPERATOR_CALL/TonesAndImagesTotal/@Subtotal)"/>
		<xsl:variable name="dados_2"
				select="sum($subscription/OPERATOR_CALL/GamesAndApplicationsTotal/@Subtotal)"/>
		<xsl:variable name="dados_3"
				select="sum($subscription/OPERATOR_CALL/WAPTotal/@Subtotal)"/>
		<xsl:variable name="dados_4"
				select="sum($subscription/OPERATOR_CALL/PlayTotal/@Subtotal)"/>
		<xsl:variable name="dados_5"
				select="sum($subscription/OPERATOR_CALL/ZAPTotal/@Subtotal)"/>					
		<xsl:variable name="dados_soma"
				select="$dados_0 + $dados_1 + $dados_2 + $dados_3 + $dados_4 + $dados_5"/>
		<!-- outrosVoz-->
		<xsl:variable name="outrosVoz"
				select="sum($subscription/OPERATOR_CALL/VoiceServicesTotal/@Subtotal)"/>
		<!-- longaDistancia -->
		<xsl:variable name="longaDistancia_0"
			select="sum($subscription/OPERATOR_CALL/LD_INTRASTATE_CALLS_TOTAL/@Subtotal)"/>
		<xsl:variable name="longaDistancia_1"
			select="sum($subscription/OPERATOR_CALL/LD_INTERSTATE_CALLS_TOTAL/@Subtotal)"/>
		<xsl:variable name="longaDistancia_2"
			select="sum($subscription/OPERATOR_CALL/ROAM_MOC_LD_TOTAL/@Subtotal)"/>
		<xsl:variable name="longaDistancia_3"
			select="sum($subscription/OPERATOR_CALL/ROAM_MTC_LD_TOTAL/@Subtotal)"/>
		<xsl:variable name="longaDistancia_4"
			select="sum($subscription/OPERATOR_CALL/COLLECT_CALLS_TOTAL/@Subtotal)"/>
		<xsl:variable name="longaDistancia_5"
			select="sum($subscription/OPERATOR_CALL/INTERNATIONAL_CALLS_TOTAL/@Subtotal)"/>
		<xsl:variable name="longaDistancia_6"
			select="sum($subscription/OPERATOR_CALL/ROAM_MOC_INTERNATIONAL_TOTAL/@Subtotal)"/>
			
		<xsl:variable name="longaDistancia_soma"
			select="$longaDistancia_0 + $longaDistancia_1 + $longaDistancia_2 + $longaDistancia_3 + $longaDistancia_4 + $longaDistancia_5 + $longaDistancia_6"/>
		<!-- fim da coluna da esquerda -->
		<!-- coluna da direita -->
		<!-- faturaRetida -->
		<xsl:variable name="faturaRetida"
			select="sum($context/@HeldBill)"/>
		<!-- multas -->
		<xsl:variable name="multas"
			select="sum($context/DUMMY_INVOICE_SUMMARY/MULTAS_JUROS_TOTAL/@Amount)"/>
		<!--descontos-->
		<xsl:variable name="descontos_0"
			select="sum($context/DUMMY_INVOICE_SUMMARY/DISCOUNT_TOTAL/@Amount)"/>
		<xsl:variable name="descontos_1"
			select="sum($subscription/PROMOTIONS_TOTAL/@Amount)"/>
		<xsl:variable name="descontos_2"
			select="sum($subscription/OPERATOR_CALL/DiscountsTotal/@Amount)"/>						
		<xsl:variable name="descontos_soma" select="$descontos_0 + $descontos_1 + $descontos_2" />
		<!-- diversos -->
		<xsl:variable name="diversos_0"
			select="sum($subscription/ENTIRE_SUBSCRIPTION_TOTAL/SUBSCRIPTION_SRV_CHARGE_TOTAL/@ServiceChargeAmt)"/>
		<xsl:variable name="diversos_1"
			select="sum($subscription/OPERATOR_CALL/PARTY_3RD_TOTAL/@Subtotal)"/>
		<xsl:variable name="diversos_2"
			select="sum($context/@AdjustmentsTotal)"/>
		<xsl:variable name="diversos_3"
			select="sum($context/@PaymentsTotal)"/>							
		<xsl:variable name="diversos_soma" select="$diversos_0 + $diversos_1 + $diversos_2 + $diversos_3" />
		<!-- parcelamentoConta -->
		<xsl:variable name="parcelamentoConta"
			select="sum($context/PARCELAMENTO_CONTA_TOTAL/PARCELAMENTO_CONTA_DETAIL/@Amount)"/>
		<!-- parcelamentoAparelho -->
		<xsl:variable name="parcelamentoAparelho"
			select="sum($context/DUMMY_INVOICE_SUMMARY/EQUIPMENT_INSTALLMENT_TOTAL/EQUIPMENT_INSTALLMENT_DETAIL/@Amount)"/>
		<!-- multa contrato-->
		<xsl:variable name="multaContrato"
			select="sum($context/CONTRACT_CANCEL_TOTAL/CONTRACT_CANCEL_DETAIL/@Amount)"/>
		<!-- multa equipamento -->
		<xsl:variable name="multaEquipamento"
			select="sum($context/EquipementInstallmentBreakTotal/EquipementInstallmentBreakDetail/@Amount)"/>
		<!-- diversos total -->
		<xsl:variable name="diversosTotal"
			select="$multaEquipamento + $multaContrato + $parcelamentoAparelho + $parcelamentoConta + $diversos_soma + $descontos_soma + $multas + $faturaRetida"/>
		
		<!-- FIM DAS VARIAVEIS -->

		
		
		<div class="detalheBoleto3">
			<div class="boxBoleto2_1">
					<div style="float:left;width:776px;margin:0px;padding:0px;">
						<div class="boxClara2PX_1"></div>
						<div class="boxClara2PX_2" style="width:772px;"></div>
						<div class="boxClara2PX_3"></div>
					</div>
					<div style="float:left;width:776px;margin:0px;padding:0px;">
						<div class="boxClara2PX_4" style="padding-bottom: 32767px;margin-bottom: -32767px;"></div>
						<div class="boxClara2PX_conteudo" style="width:772px;padding-bottom: 32767px;margin-bottom: -32767px;">
							
							<div style="float:left; width:376px;height:250px;">
								<div style="width:255px;float:left;height:250px;">
								<span class="f11" style="text-align:left;padding-left:5px;width:255px;">
									<b>Resumo de Utilização</b><br></br>
									<xsl:if test="$planosPacotes != '0'">
										Planos/Pacotes Contratados<br></br>
									</xsl:if>
									<xsl:if test="$servicosAdicionais != '0'">
										Serviços Adicionais<br></br>
									</xsl:if>
									<xsl:if test="$redebitosSoma != '0'">
										Redébitos<br></br>
									</xsl:if>
									<xsl:if test="$originadasRecebidasCobrar != '0'">
										Chamadas Dentro da Área de Registro<br></br>
									</xsl:if>
										<xsl:if test="$chamadasLocaisOriginadas != '0'">
											&#160;&#160;&#160;Chamadas Locais Originadas <br></br>
										</xsl:if>
										<xsl:if test="$chamadasRecebidasCobrar != '0'">
											&#160;&#160;&#160;Chamadas Recebidas a Cobrar - Locais<br></br>
										</xsl:if>
									<xsl:if test="$originadasForaRecebidas != '0'">
										Chamadas Fora da Área de Registro<br></br>
									</xsl:if>
										<xsl:if test="$chamadasLocaisOriginadasFora != '0'">
											&#160;&#160;&#160;Chamadas Locais Originadas<br></br>
										</xsl:if>
										<xsl:if test="$chamadasLocaisRecebidas != '0'">
											&#160;&#160;&#160;Chamadas Locais Recebidas<br></br>
										</xsl:if>
									<xsl:if test="$numerosEspecificos != '0'">
										Chamadas a Serviços Números Específicos<br></br>
									</xsl:if>
									<xsl:if test="$numeros0500 != '0'">
										Chamadas para Números - 0500<br></br>
									</xsl:if>
									<xsl:if test="$exterior != '0'">
										Chamadas Realizadas / Recebidas no Exterior<br></br>
									</xsl:if>
									<xsl:if test="$dados_soma != '0'">
										Utilização de Serviços de Dados<br></br>
									</xsl:if>
									<xsl:if test="$outrosVoz != '0'">
										Utilização de Outros Serviços de Voz<br></br>
									</xsl:if>
									<xsl:if test="$longaDistancia_soma != '0'">
										Chamadas de Longa Distância
									</xsl:if>
								</span>
								</div>
								<div style="width:63px;float:left;height:250px;">
								<span class="f11" style="text-align:right;width:63px;">
									<b>Crédito R$</b><br></br>
									<xsl:if test="$planosPacotes != '0'"><br></br></xsl:if>
									<xsl:if test="$servicosAdicionais != '0'"><br></br></xsl:if>
									<xsl:if test="$redebitosSoma != '0'"><br></br></xsl:if>
									<xsl:if test="$originadasRecebidasCobrar != '0'"><br></br></xsl:if>
									<xsl:if test="$chamadasLocaisOriginadas != '0'"><br></br></xsl:if>
									<xsl:if test="$chamadasRecebidasCobrar != '0'"><br></br></xsl:if>
									<xsl:if test="$originadasForaRecebidas != '0'"><br></br></xsl:if>
									<xsl:if test="$chamadasLocaisOriginadasFora != '0'"><br></br></xsl:if>
									<xsl:if test="$chamadasLocaisRecebidas != '0'"><br></br></xsl:if>
									<xsl:if test="$numerosEspecificos != '0'"><br></br></xsl:if>
									<xsl:if test="$numeros0500 != '0'"><br></br></xsl:if>
									<xsl:if test="$exterior != '0'"><br></br></xsl:if>
									<xsl:if test="$dados_soma != '0'"><br></br></xsl:if>
									<xsl:if test="$outrosVoz != '0'"><br></br></xsl:if>
									
									
								</span>
								</div>
								<div style="width:58px;float:left;height:250px;">
								<span class="f11" style="text-align:right;width:58px;">
									<b>Débito R$</b><br></br>
									
									<!-- soma do pacotes contratados de todos os telefones 325T (conferido)-->
									
									<xsl:if test="$planosPacotes != '0'">
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$planosPacotes"/>
										</xsl:call-template>
										<br></br>
									</xsl:if>
									
									<!-- soma do servicos adicionais de todos os telefones 330T (conferido)-->
									
									<xsl:if test="$servicosAdicionais != '0'">
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$servicosAdicionais"/>
										</xsl:call-template>
										<br></br>
									</xsl:if>

									<!-- soma de todos redebitos 080T, 405T, 406T, 407T, 408T (conferido)-->
									
									<xsl:if test="$redebitosSoma != '0'">
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$redebitosSoma"/>
										</xsl:call-template>
										<br></br>
									</xsl:if>
									
									<!-- nulo -->
									<xsl:if test="$originadasRecebidasCobrar != '0'">
										<br></br>
									</xsl:if>
									
									<!-- soma de todas as ligacoes locais 510T (conferido) -->
									<xsl:if test="$chamadasLocaisOriginadas != '0'">
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$chamadasLocaisOriginadas"/>
										</xsl:call-template>
										<br></br>
									</xsl:if>
									
									<!-- soma de todas as ligacoes locais a cobrar 520T (conferido)-->
									<xsl:if test="$chamadasRecebidasCobrar != '0'">
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$chamadasRecebidasCobrar"/>
										</xsl:call-template>
										<br></br>
									</xsl:if>
									
									<!-- nulo -->
									<xsl:if test="$originadasForaRecebidas != '0'">							
										<br></br>
									</xsl:if>
									
									<!-- soma de todas as chamadas locais originadas  555T (conferido) -->
									<xsl:if test="$chamadasLocaisOriginadasFora != '0'">
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$chamadasLocaisOriginadasFora"/>
										</xsl:call-template>
										<br></br>
									</xsl:if>
									
									<!-- soma de todas as Chamadas Locais Recebidas em Roaming 560T (conferido) -->
									<xsl:if test="$chamadasLocaisRecebidas != '0'">
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$chamadasLocaisRecebidas"/>
										</xsl:call-template>
										<br></br>
									</xsl:if>
									
									<!-- soma de todas numero especificos 590T (conferido)-->
									<xsl:if test="$numerosEspecificos != '0'">
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$numerosEspecificos"/>
										</xsl:call-template>
										<br></br>
									</xsl:if>
									
									<!-- soma de todas numero 0500 595T (conferido)-->
									
									<xsl:if test="$numeros0500 != '0'">
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$numeros0500"/>
										</xsl:call-template>
										<br></br>
									</xsl:if>
									
									<!-- soma de todas realizadas / recebidas exterior 585T (conferido) -->
									
									<xsl:if test="$exterior != '0'">
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$exterior"/>
										</xsl:call-template>
										<br></br>
									</xsl:if>
									
									<!-- soma de todos os dados 650T, 655T, 660T, 665T, 670T, 675T (conferido) -->
									
									<xsl:if test="$dados_soma != '0'">
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$dados_soma"/>
										</xsl:call-template>
										<br></br>
									</xsl:if>
									
									<!-- soma da utilizacao do servico de voz 680T (conferido) -->
									<xsl:if test="$outrosVoz != '0'">
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$outrosVoz"/>
										</xsl:call-template>
										<br></br>
									</xsl:if>
									
									<!-- soma das chamadas de longa distancia 535T, 540T, 570T, 575T, 545T, 550T, 580T (conferido)-->
									<xsl:if test="$longaDistancia_soma != '0'">										
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$longaDistancia_soma"/>
										</xsl:call-template>
										<br></br>
									</xsl:if>
									
								</span>
								</div>
								
							</div>
							<div style="float:left; width:396px">
								<div style="width:265px;float:left;">
								<span class="f11" style="text-align:left;padding-left:15px;width:265px;">
									
									<xsl:if test="$diversosTotal != '0'">
										<span class="f12"><b>Lançamentos Diversos</b></span>
									</xsl:if>
									
									<br></br>
									
									<xsl:if test="$faturaRetida != '0'">
										Fatura Retida / Saldo Mínimo Fatura Anterior
									</xsl:if>
									<br></br>
									<xsl:if test="$multas != '0'">
										Multa e Juros
									</xsl:if>
									<br></br>
									<xsl:if test="$descontos_soma != '0'">
										Descontos
									</xsl:if>
									<br></br>
									<xsl:if test="$diversos_soma != '0'">
										Diversos
									</xsl:if>
									<br></br>
									<xsl:if test="$parcelamentoConta != '0'">
										Parcelament o de Conta
									</xsl:if>
									<br></br>
									<xsl:if test="$parcelamentoAparelho != '0'">
										Parcelamento de Aparelho
									</xsl:if>
									<br></br>
									<xsl:if test="$multaContrato != '0'">
										Multa de Cancelamento de Contrato
									</xsl:if>
									<br></br>
									<xsl:if test="$multaEquipamento != '0'">
										Multa de Quebra de Parcelamento de Equipamento
									</xsl:if>
									<br></br>
									<br></br>
									<br></br>
									<br></br>
									<span class="f12"><b>Total de Créditos / Débitos</b></span><br></br>
									<br></br>
									<br></br>
									<span class="f12"><b>TOTAL A PAGAR</b></span><br></br>
								</span>
								</div>
								<div style="width:63px;float:left;">
								<span class="f11" style="text-align:right;width:63px;">
									
									<xsl:if test="$diversosTotal != '0'">
										<b>Crédito R$</b>
									</xsl:if>
									<br></br>
									<br></br>
									<br></br>
									<br></br>
									<br></br>
									<br></br>
									<br></br>
									<br></br>
									<br></br>
									<!-- retencao da lei -->
									<br></br>
									<br></br>

									
								</span>
								</div>
								<div style="width:58px;float:left;">
								<span class="f11" style="text-align:right;width:58px;">
									<!--total-->
									<xsl:if test="$diversosTotal != '0'">
										<b>Débito R$</b>
									</xsl:if>
									<br></br>
									
									<!-- soma da fatura retida 010D coluna 1078 -->
									<xsl:if test="$faturaRetida != '0'">
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$faturaRetida"/>
										</xsl:call-template>
									</xsl:if>
									<br></br>
									
									<!-- soma da multas e juros 265T -->
									<xsl:if test="$multas != '0'">
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$multas"/>
										</xsl:call-template>
									</xsl:if>
									<br></br>
									
									<!-- soma dos descontos 270T 340T 401T  -->
									
									<xsl:if test="$descontos_soma != '0'">
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$descontos_soma"/>
										</xsl:call-template>
									</xsl:if>
									<br></br>
									
									<!-- soma dos diversos 320T 600T 010D(232) 010D(218)-->
									
									<xsl:if test="$diversos_soma != '0'">
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$diversos_soma"/>
										</xsl:call-template>
									</xsl:if>
									<br></br>
									
									<!-- parcelamento da conta -->
									
									<xsl:if test="$parcelamentoConta != '0'">
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$parcelamentoConta"/>
										</xsl:call-template>
									</xsl:if>
									<br></br>
									
									<!-- parcelamento do aparelho -->
									<xsl:if test="$parcelamentoAparelho != '0'">
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$parcelamentoAparelho"/>
										</xsl:call-template>
									</xsl:if>
									<br></br>
									
									<!-- multa de cancelamento -->
									<span id="regraEstilo" title="R68-02" style="text-align:right;width:58px;margin-left:0px;">
									<span id="regraEstilo" title="R68-04" style="text-align:right;width:58px;margin-left:0px;">
									<span id="R68-02_multaFatura">
										<xsl:if test="$multaContrato != '0'">
											<xsl:call-template name="FORMAT-DOUBLE">
												<xsl:with-param name="number" select="$multaContrato"/>
											</xsl:call-template>
										</xsl:if>
									</span>
									</span>
									</span>
									<br></br>
									
									<!-- multa de quebra -->
									<xsl:if test="$multaEquipamento != '0'">
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$multaEquipamento"/>
										</xsl:call-template>
									</xsl:if>
									<br></br>
									<br></br>
									<br></br>
									<br></br>
									<br></br>
									<!-- total creditos e debitos -->
									<span class="f12"><b>
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$context/@TotalDueAmount"/>
										</xsl:call-template>
									</b></span><br></br>
									<br></br>
									<br></br>
									<!-- total a pagar -->
									<span class="f12"><b>
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$context/@TotalDueAmount"/>
										</xsl:call-template>
									</b></span>
								</span>
								</div>
							</div>
						</div>
						<div class="boxClara2PX_5" style="padding-bottom: 32767px;margin-bottom: -32767px;"></div>
					</div>
					<div style="float:left;width:776px;margin:0px;padding:0px;">
						<div class="boxClara2PX_6"></div>
						<div class="boxClara2PX_7" style="width:772px;"></div>
						<div class="boxClara2PX_8"></div>
					</div>
			</div>
		</div>

	</div>
	<!-- fim do detalhe do boleto -->
	<div style="float:left; height:5px;width:776px;margin-bottom:-15px"></div>
	<div class="mensagemPV" >
		<b>Mensagem para você:</b><br></br>
		Quer economizar nas suas ligações interurbanas? Adquira um dos pacotes para ligação DDD que a VIVO preparou para voçê e suas ligações
		de longa distância po ar até 40% mais baratas!
		Para mais informações ligue agora para *8486 ou vá até uma loja VIVO.
	</div>
	<div style="float:left; height:5px;width:776px;margin-bottom:-10px"></div>
	<div class="agradecimento">
		<b>AGRADECEMOS O(S) PAGAMENTO(S) RECEBIDO(S) ATÉ A EMISSÃO DESTA FATURA. ESTE BOLETO NÃO QUITA DÉBITOS ANTERIORES.</b><br></br>
		Prezado cliente, mantenha o pagamento em dia evitando a suspensão parcial/total dos serviços e a inclusão nos órgãos de proteção ao crédito. Para pagamentos
		realizados após a data de vencimento serão cobrados na próxima fatura multa de 2% e juros de 1% ao mês.
	</div>
	
	<div class="recorte"></div>
	
	<div class="rodapeFatura1">
		<div class="rodapeFatura1_1"></div>
		<div class="rodapeFatura1_2">
							<span id="regraEstilo" title="R09-00">
							<span id="regraEstilo" title="R09-1">
							<span id="regraEstilo" title="R09-2">
							<span id="regraEstilo" title="R09-3">
							<span id="regraEstilo" title="R09-4">
							<span id="regraEstilo" title="R09-5">
							<span id="regraEstilo" title="R09-6">
					<span id="R9_barCode">
						<span class="f22"><xsl:value-of select="$context/BARCODE_LINE/@OcrScanLineRight" /></span>
					</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
				</span>
		</div>
	</div>
		
		
	<div class="rodapeFatura2">
		<div class="rodapeFatura2_1">
			<div class="rodapeFatura2_1_1"/>
			
			<div class="rodapeFatura2_1_2">
				<div class="boxRodape2_1_2">
					<div style="float:left;width:137px;margin:0px;padding:0px;">
						<div class="boxEscura2PX_1"></div>
						<div class="boxEscura2PX_2" style="width:132px;"></div>
						<div class="boxEscura2PX_3"></div>
					</div>
					<div style="float:left;width:137px;margin:0px;padding:0px;">
						<div class="boxEscura2PX_4" style="height:63px;"></div>
						<div class="boxEscura2PX_conteudo" style="width:132px;height:63px;">
							<span class="f12" style="padding-left:5px;width:132px"><b>VENCIMENTO</b></span>
							<span class="f20" style="text-align:center;padding-right:5px;padding-top:15px;width:132px">
								<xsl:value-of select="vivo:DateFormat.formatDDMMYYYY($context/@DueDate)"/>
							</span>
						</div>
						<div class="boxEscura2PX_5" style="height:63px;"></div>
					</div>
					<div style="float:left;width:137px;margin:0px;padding:0px;">
						<div class="boxEscura2PX_6"></div>
						<div class="boxEscura2PX_7" style="width:132px;"></div>
						<div class="boxEscura2PX_8"></div>
					</div>
				</div>
			</div>
			<div class="rodapeFatura2_1_3">
				<div class="boxRodape2_1_3">
					<div style="float:left;width:137px;margin:0px;padding:0px;">
						<div class="boxEscura2PX_1"></div>
						<div class="boxEscura2PX_2" style="width:132px;"></div>
						<div class="boxEscura2PX_3"></div>
					</div>
					<div style="float:left;width:137px;margin:0px;padding:0px;">
						<div class="boxEscura2PX_4" style="height:63px;"></div>
						<div class="boxEscura2PX_conteudo" style="width:132px;height:63px;">
							<span class="f12" style="text-align:right;padding-right:5px;width:132px"><b>TOTAL A PAGAR - R$</b></span>
							<span id="regraEstilo" title="R04">
							<span id="regraEstilo" title="espaco_livre_para_nova_regra">
							<span id="R04_demonstrado">
							<span class="f20" style="text-align:right;padding-right:5px;padding-top:15px;width:132px">
								<xsl:call-template name="FORMAT-DOUBLE">
									<xsl:with-param name="number" select="$context/@TotalDueAmount"/>
								</xsl:call-template>
							</span>
							</span>
							</span>
							</span>
						</div>
						<div class="boxEscura2PX_5" style="height:63px;"></div>
					</div>
					<div style="float:left;width:137px;margin:0px;padding:0px;">
						<div class="boxEscura2PX_6"></div>
						<div class="boxEscura2PX_7" style="width:132px;"></div>
						<div class="boxEscura2PX_8"></div>
					</div>
				</div>
			</div>
			
		</div>
		
		
		
		
		<div class="rodapeFatura2_2">
			<div class="rodapeFatura2_2_1">
				<div class="boxRodape2_2_1">
					<div style="float:left;width:250px;margin:0px;padding:0px;">
						<div class="boxClara2PX_1"></div>
						<div class="boxClara2PX_2" style="width:245px;"></div>
						<div class="boxClara2PX_3"></div>
					</div>
					<div style="float:left;width:250px;margin:0px;padding:0px;">
						<div class="boxClara2PX_4" style="height:36px;"></div>
						<div class="boxClara2PX_conteudo" style="width:245px;height:36px;">
							<span class="f11" style="padding-left:5px;width:245px"><b>Identificação de Débito Automático</b></span>
							<span class="f11" style="padding-left:5px;width:245px">0000000000000000000</span>
						</div>
						<div class="boxClara2PX_5" style="height:36px;"></div>
					</div>
					<div style="float:left;width:250px;margin:0px;padding:0px;">
						<div class="boxClara2PX_6"></div>
						<div class="boxClara2PX_7" style="width:245px;"></div>
						<div class="boxClara2PX_8"></div>
					</div>
				</div>
			</div>
			
			<div class="rodapeFatura2_2_2">
				<div class="boxRodape2_2_2">
					<div style="float:left;width:201px;margin:0px;padding:0px;">
						<div class="boxClara2PX_1"></div>
						<div class="boxClara2PX_2" style="width:196px;"></div>
						<div class="boxClara2PX_3"></div>
					</div>
					<div style="float:left;width:201px;margin:0px;padding:0px;">
						<div class="boxClara2PX_4" style="height:36px;"></div>
						<div class="boxClara2PX_conteudo" style="width:196px;height:36px;">
							<span class="f11" style="padding-left:5px;width:196px"><b>Número de Conta</b></span>
							<span class="f11" style="padding-left:5px;width:196px"><xsl:value-of select="$accountNumber"/></span>
						</div>
						<div class="boxClara2PX_5" style="height:36px;"></div>
					</div>
					<div style="float:left;width:201px;margin:0px;padding:0px;">
						<div class="boxClara2PX_6"></div>
						<div class="boxClara2PX_7" style="width:196px;"></div>
						<div class="boxClara2PX_8"></div>
					</div>
				</div>
			</div>
			<div class="rodapeFatura2_2_3">
				<div class="boxRodape2_2_3">
					<div style="float:left;width:137px;margin:0px;padding:0px;">
						<div class="boxClara2PX_1"></div>
						<div class="boxClara2PX_2" style="width:132px;"></div>
						<div class="boxClara2PX_3"></div>
					</div>
					<div style="float:left;width:137px;margin:0px;padding:0px;">
						<div class="boxClara2PX_4" style="height:36px;"></div>
						<div class="boxClara2PX_conteudo" style="width:132px;height:36px;">
							<span class="f11" style="text-align:left;padding-left:5px;width:132px"><b>Mês de Referência</b></span>
							<span class="f11" style="text-align:left;padding-left:5px;width:132px"><xsl:value-of select="vivo:DateFormat.formatMMYYYY(/SIRS/CYCLE_SUMMARY/@BillingDate)"/></span>
						</div>
						<div class="boxEscura2PX_5" style="height:36px;"></div>
					</div>
					<div style="float:left;width:137px;margin:0px;padding:0px;">
						<div class="boxClara2PX_6"></div>
						<div class="boxClara2PX_7" style="width:132px;"></div>
						<div class="boxClara2PX_8"></div>
					</div>
				</div>
			</div>
			
			<div class="rodapeFatura2_2_4">
				<div class="boxRodape2_2_4" style="text-align:center;">
					<span class="f16"><b>Débito<br></br>Automático</b></span>
				</div>
			</div>
			
		</div>
		
		<div class="f11" style="float:left; height:20px;width:776px;text-align:center;">
			Verifique se o débito foi efetuado em sua conta corrente. Caso não tenha ocorrido, utilizar esse boleto para pagamento.
		</div>
		
		<div class="rodapeFatura2_3">

			<div class="rodapeFatura2_3_1">	
				<xsl:call-template name="BAR_CODE"/>
			</div>
			
			<div class="rodapeFatura2_3_2">
				<div class="boxRodape2_3_2">
					<div style="float:left;width:359px;margin:0px;padding:0px;">
						<div class="boxClara2PX_1"></div>
						<div class="boxClara2PX_2" style="width:354px;"></div>
						<div class="boxClara2PX_3"></div>
					</div>
					<div style="float:left;width:359px;margin:0px;padding:0px;">
						<div class="boxClara2PX_4" style="height:56px;"></div>
						<div class="boxClara2PX_conteudo" style="width:354px;height:56px;">
							<span class="f10" style="text-align:left;padding-left:5px;width:354px">Autenticação Mecânica</span>
						</div>
						<div class="boxEscura2PX_5" style="height:56px;"></div>
					</div>
					<div style="float:left;width:359px;margin:0px;padding:0px;">
						<div class="boxClara2PX_6"></div>
						<div class="boxClara2PX_7" style="width:354px;"></div>
						<div class="boxClara2PX_8"></div>
					</div>
				</div>
			</div>
			
		</div>

	</div>	
</div>
<!-- fim pagina 1 -->
<!--
</div>
</div>
-->
</body>
</html>

</xsl:template>   

</xsl:stylesheet>