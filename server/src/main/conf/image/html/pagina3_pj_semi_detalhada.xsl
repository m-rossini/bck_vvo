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
 
  
	<xsl:template name="pagina3_pj" >
		
	<!-- cria uma página para cada numero de telefone -->	
	<xsl:for-each select="$subscription">
		
<!--
<html>
<head>
<link href="../portal/css/aplicacao_interna.css" rel="stylesheet" type="text/css" />
<link href="../portal/css/fatura_css/fatura.css" rel="stylesheet" type="text/css" />
<script language="javascript">

if(navigator.appName == 'Microsoft Internet Explorer'){
	document.write('<link href="../portal/css/fatura_css/faturaIE.css" rel="stylesheet" type="text/css" />');
}

</script>
</head>

<body>
<div id="container_geral" class="container_geral">
<div id="container_fatura" class="container_fatura">
-->
<!-- página 3 PJ -->

<div id="pagina3" class="pagina3">
	
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
				<span style="text-align:right;width:280px;"><b>Página 0000003/0000006</b></span>
				</span>
			</div>
		</div>
	</div>
	<!-- fim do sub cabecalho -->
	
	<!-- conteúdo da página3 PJ -->
	
	
	
	<div class="f14" style="width:776px;float:left" >
		<b>DETALHAMENTO DE UTILIZAÇÃO:   VIVO S.A.</b>
	</div> 
	
	
	<!-- variaveis de verificacao de todos os itens da pagina -->
	
	<xsl:variable name="verificaAdesao" select="sum(ENTIRE_SUBSCRIPTION_TOTAL/SUBSCRIPTION_SRV_CHARGE_TOTAL/@ServiceChargeAmt)" />
	<xsl:variable name="verificaPlanosConstratados" select="sum(ENTIRE_SUBSCRIPTION_TOTAL/ACTIVATION_TOTAL/@ServiceChargeAmt)" />
	<xsl:variable name="verificaSevicosAdicionais" select="sum(ADDITIONAL_SERVICES_TOTAL/@ServiceChargeAmt)" />
	
	<xsl:variable name="verificaRedebitosServicos" select="sum(OPERATOR_CALL/REDEBITO_SERVICOS_IMPUGNADOS_TOTAL/@Amount)" />
	<xsl:variable name="verificaRedebitosChamadas" select="sum(OPERATOR_CALL/REDEBITO_CHAMADAS_IMPUGNADAS_TOTAL/@Amount)" />
	<xsl:variable name="verificaRedebitosMensagens" select="sum(OPERATOR_CALL/REDEBITO_MENSAGENS_IMPUGNADAS_TOTAL/@Amount)" />
	<xsl:variable name="verificaRedebitosDados" select="sum(OPERATOR_CALL/REDEBITO_DATA_2G_IMPUGNADAS_TOTAL/@Amount)" />
	<xsl:variable name="verificaSomaRedebitos" select="$verificaRedebitosServicos + $verificaRedebitosChamadas + $verificaRedebitosMensagens + $verificaRedebitosDados" />
	
	<xsl:variable name="verificaPlanosPacotes" select="sum(OPERATOR_CALL/CALLS_SUMMARY/@Amount)"/>
	
	<xsl:variable name="verificaChamadasLocaisOriginadas" select="sum(OPERATOR_CALL/LOCAL_CALLS_TOTAL/@Subtotal)"/>
	<xsl:variable name="verificaSomaChamadasArea" select="$verificaChamadasLocaisOriginadas" />
	
	<xsl:variable name="verificaSomaPagina" select="$verificaAdesao + $verificaPlanosConstratados + $verificaSevicosAdicionais + $verificaSomaRedebitos + $verificaPlanosPacotes + $verificaSomaChamadasArea" />	
	
	<!-- fim das variaveis de verificacao -->
	
	<!-- verifica pagina -->
	<xsl:if test="$verificaSomaPagina != 0" >
	
	<!-- adesao -->
	
	<!-- verificar se adesao não é vazio -->
	
	<xsl:if test="$verificaAdesao != 0">
	
	
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Adesão</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<div style="width:776;float:left;margin-top:-17px;">
		<div class="f12" style="width:250px;float:left;">
			Descrição<br></br><br></br>
		</div>
		<div class="f12" style="width:125px;float:left;">
			<br></br><br></br>
		</div>
		<div class="f12" style="width:125px;float:left;">
			<br></br><br></br>
		</div>
		<div class="f12" style="width:276px;float:left;text-align:right;">
			<b>Subtotal:</b>

			<xsl:variable name="valorMonetarioVariavel"
					select="sum(ENTIRE_SUBSCRIPTION_TOTAL/SUBSCRIPTION_SRV_CHARGE_TOTAL/@ServiceChargeAmt)"/>
			<xsl:call-template name="FORMAT-DOUBLE">
					<xsl:with-param name="number" select="$valorMonetarioVariavel"/>
			</xsl:call-template>
			
			<br></br>
			<b>Valor R$: </b><br></br>
		</div>
	</div>
	
	<xsl:for-each select="ENTIRE_SUBSCRIPTION_TOTAL/SUBSCRIPTION_SRV_CHARGE_TOTAL/SUBSCRIPTION_SRV_CHARGE_DETAIL">
	<div style="width:776;float:left;">
	<span id="regraEstilo" title="R13-01">
	<span id="regraEstilo" title="R13-02">
	<span id="regraEstilo" title="R13-03">
	<span id="regraEstilo" title="R32-08">
		
		<span id="R32_nomeServico">
		<span id="R13_servico">
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
			<span id="R13_valor">
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
	</div>
	</xsl:for-each>
	
	</xsl:if>
	
	<!-- fim verificacao adesao -->
	
	<!-- fim adesao -->
	
	<!-- 325D -->
	<!-- planos contratados -->
	
	<!-- verificar se planos contratados nao é vazio -->
	
	<xsl:if test="$verificaPlanosConstratados != 0">
	
	
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Planos Contratados</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<div style="width:776;float:left;margin-top:-17px;">
		<div class="f12" style="width:250px;float:left;">
			Descrição<br></br><br></br>
		</div>
		<div class="f12" style="width:250px;float:left;text-align:center;">
			Período<br></br><br></br>
		</div>
		<div class="f12" style="width:276px;float:left;text-align:right;">
			<b>Subtotal:</b>

			<xsl:variable name="valorMonetarioVariavel"
					select="sum(ENTIRE_SUBSCRIPTION_TOTAL/ACTIVATION_TOTAL/@ServiceChargeAmt)"/>
			<xsl:call-template name="FORMAT-DOUBLE">
					<xsl:with-param name="number" select="$valorMonetarioVariavel"/>
			</xsl:call-template>
			
			<br></br>
			<b>Valor R$: </b><br></br>
		</div>
	</div>
	
	<xsl:for-each select="ENTIRE_SUBSCRIPTION_TOTAL/ACTIVATION_TOTAL/ACTIVATION_DETAIL">
	<div style="width:776;float:left;">
				<span id="regraEstilo" title="R08-01">
				<span id="regraEstilo" title="R08-02">
				<span id="regraEstilo" title="R08-03">
				<span id="regraEstilo" title="R08-04">
				<span id="regraEstilo" title="R08-05">
				<span id="regraEstilo" title="R08-06">
				<span id="regraEstilo" title="R08-07">
				<span id="regraEstilo" title="R08-08">
				<span id="regraEstilo" title="R55-01">
				<span id="regraEstilo" title="R55-02">
				<span id="regraEstilo" title="R13-01">
				<span id="regraEstilo" title="R13-02">
				<span id="regraEstilo" title="R13-03">
				<span id="regraEstilo" title="R20-0">
				<span id="regraEstilo" title="R20-1">
				<span id="regraEstilo" title="R20-2">
				<span id="regraEstilo" title="R20-3">
				<span id="regraEstilo" title="R20-4">
				<span id="regraEstilo" title="R20-5">
				<span id="regraEstilo" title="R32-08">
				<span id="regraEstilo" title="R53-02">
				<span id="regraEstilo" title="R53-03">
				<span id="regraEstilo" title="R57-01">
				<span id="regraEstilo" title="R57-02">
				<span id="regraEstilo" title="R60-1">
				<span id="regraEstilo" title="R60-2">
				<span id="regraEstilo" title="R60-3">
				<span id="regraEstilo" title="R60-4">
				<span id="regraEstilo" title="R63-01">
				<span id="regraEstilo" title="R63-02">
				<span id="regraEstilo" title="R73-01">
				
			<span id="R20_nomeDoServico">
			<span id="R13_servico">
			<span id="R08-1_servico">
			<span id="R32_nomeServico">
			<span id="R55_produto">
			<span id="R53_nomeServico">
			<span id="R57_nomeServico">
			<span id="R63_captionAtivo">
			<span id="R73_nomeServico">
			<div class="f12" style="width:250px;float:left;">
				<xsl:value-of select="@Descricao"/><br></br>
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
			<span id="R08-1_periodo">
			<span id="R55_periodo">
			<span id="R73_periodo">
			<div class="f12" style="width:250px;float:left;text-align:center;">
				<xsl:value-of select="vivo:DateFormat.formatDDMMYYYY(@StartDate)"/> a<xsl:value-of select="vivo:DateFormat.formatDDMMYYYY(@ EndDate)"/><br></br>
			</div>
			</span>
			</span>
			</span>
			<span id="R13_valor">
			<span id="R20_valorCobrado">
			<span id="R60_valorItem">
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
	</span>	
	</span>
	</span>
	</span>
	</span>
	</span>
	</span>
	</span>
	</span>
	</span>
	</span>
	</span>
	</span>
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
	
	</xsl:if>
	
	<!-- fim da verificacao de planos contratados -->	
	
	<!-- fim planos contratados -->
	
	<!-- 330D -->
	<!-- serviços adicionais -->
	
	<!-- verificacar se servicos adiconais nao eh nulo -->
	
	<xsl:if test="$verificaSevicosAdicionais != 0">
	
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Serviços Adicionais</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<div style="width:776;float:left;margin-top:-17px;">
		<div class="f12" style="width:250px;float:left;">
			Descrição<br></br><br></br>
		</div>
		<div class="f12" style="width:250px;float:left;text-align:center;">
			Período<br></br><br></br>
		</div>
		<div class="f12" style="width:276px;float:left;text-align:right;">
			<b>Subtotal:</b>

			<xsl:variable name="valorMonetarioVariavel"
					select="sum(ADDITIONAL_SERVICES_TOTAL/@ServiceChargeAmt)"/>
			<xsl:call-template name="FORMAT-DOUBLE">
					<xsl:with-param name="number" select="$valorMonetarioVariavel"/>
			</xsl:call-template>
			
			<br></br>
			<b>Valor R$: </b><br></br>
		</div>
	</div>
	
	<xsl:for-each select="ADDITIONAL_SERVICES_TOTAL/ADDITIONAL_SERVICES_DETAIL">
	<div style="width:776;float:left;">
				<span id="regraEstilo" title="R08-01">
				<span id="regraEstilo" title="R08-02">
				<span id="regraEstilo" title="R08-03">
				<span id="regraEstilo" title="R08-04">
				<span id="regraEstilo" title="R08-05">
				<span id="regraEstilo" title="R08-06">
				<span id="regraEstilo" title="R08-07">
				<span id="regraEstilo" title="R08-08">
				<span id="regraEstilo" title="R55-01">
				<span id="regraEstilo" title="R55-02">
				<span id="regraEstilo" title="R13-01">
				<span id="regraEstilo" title="R13-02">
				<span id="regraEstilo" title="R13-03">
				<span id="regraEstilo" title="R20-0">
				<span id="regraEstilo" title="R20-1">
				<span id="regraEstilo" title="R20-2">
				<span id="regraEstilo" title="R20-3">
				<span id="regraEstilo" title="R20-4">
				<span id="regraEstilo" title="R20-5">
				<span id="regraEstilo" title="R32-08">
				<span id="regraEstilo" title="R53-02">
				<span id="regraEstilo" title="R53-03">
				<span id="regraEstilo" title="R57-01">
				<span id="regraEstilo" title="R57-02">
				<span id="regraEstilo" title="R60-1">
				<span id="regraEstilo" title="R60-2">
				<span id="regraEstilo" title="R60-3">
				<span id="regraEstilo" title="R60-4">
				<span id="regraEstilo" title="R63-01">
				<span id="regraEstilo" title="R63-02">
				<span id="regraEstilo" title="R73-01">
				
				<span id="R20_nomeDoServico">
				<span id="R55_produto">
				<span id="R13_servico">
				<span id="R08-1_servico">
				<span id="R32_nomeServico">
				<span id="R53_nomeServico">
				<span id="R57_nomeServico">
				<span id="R63_captionAtivo">
				<span id="R73_nomeServico">
			<div class="f12" style="width:250px;float:left;">
				<xsl:value-of select="@Descricao"/><br></br>
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
			<span id="R08-1_periodo">
			<span id="R55_periodo">
			<span id="R73_periodo">
			<div class="f12" style="width:250px;float:left;text-align:center;">
				<xsl:value-of select="vivo:DateFormat.formatDDMMYYYY(@StartDate)"/> a<xsl:value-of select="vivo:DateFormat.formatDDMMYYYY(@ EndDate)"/><br></br>
			</div>
			</span>
			</span>
			</span>
			<span id="R13_valor">
			<span id="R20_valorCobrado">
			<span id="R60_valorItem">
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
			</span>
			</span>
			</span>
			</span>
			</span>
			</span>
			</span>
			</span>
			</span>
			</span>
			</span>
			</span>
			</span>
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
	
	</xsl:if>
	
	<!-- fim da verificacao de servicos adicionais -->
	
	<!-- fim serviços adicionais -->
	
	<!-- descontos e promoçoes >
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Descontos</b>
	</div>
	
	<div class="linhaDivisoria" />
	< fim descontos e promocoes -->
	
	<!-- verifica soma de redebitos -->
	
	<xsl:if test="$verificaSomaRedebitos != 0" >
	
	
	<!-- redebitos -->
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Redébitos</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	
	<!-- verfica redebitos servicos -->
	<xsl:if test="$verificaRedebitosServicos != 0">
	
	<!-- 405T -->
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Redébitos de Serviços Impugnados</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<div style="width:776;float:left;margin-top:-17px;">
		<div class="f12" style="width:250px;float:left;">
			<b>Mês Ref.:
			
			<xsl:value-of select="vivo:DateFormat.formatMMYYYY(/SIRS/CYCLE_SUMMARY/@BillingDate)"/>
			
			</b><br></br>
			Descrição<br></br>
		</div>
		<div class="f12" style="width:250px;float:left;text-align:center;">
			<br></br><br></br>
		</div>
		<div class="f12" style="width:276px;float:left;text-align:right;">
			<b>Subtotal:</b>

			<xsl:variable name="valorMonetarioVariavel"
					select="sum(OPERATOR_CALL/REDEBITO_SERVICOS_IMPUGNADOS_TOTAL/@Amount)"/>
			<xsl:call-template name="FORMAT-DOUBLE">
					<xsl:with-param name="number" select="$valorMonetarioVariavel"/>
			</xsl:call-template>
			
			<br></br>
			<b>Valor R$: </b><br></br>
		</div>
	</div>
	
	<xsl:for-each select="OPERATOR_CALL/REDEBITO_SERVICOS_IMPUGNADOS_TOTAL/REDEBITO_SERVICOS_IMPUGNADOS_DETAIL">
	<div style="width:776;float:left;">
		<span id="regraEstilo" title="R32-08">
			<span id="R32_nomeServico">
			<div class="f12" style="width:250px;float:left;">
				<xsl:value-of select="@Descricao"/><br></br>
			</div>
			</span>
			<div class="f12" style="width:250px;float:left;text-align:center;">
				<br></br>
			</div>
			<div class="f12" style="width:276px;float:left;text-align:right;">
				<xsl:call-template name="FORMAT-DOUBLE">
					<xsl:with-param name="number" select="@Amount"/>
				</xsl:call-template>
				<br></br>
			</div>
		</span>
	</div>
	</xsl:for-each>
	
	</xsl:if>
	
	<!-- fim da verificacao de redebitos de servicos -->
	
	<!-- verificacao de redebitos de chamadas -->
	
	<xsl:if test="$verificaRedebitosChamadas != 0" >
	
	<!-- 406T -->
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Redébitos de Chamadas Impugnadas</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<div style="width:776;float:left;margin-top:-17px;">
		<div class="f12" style="width:586px;float:left;">
			<b>Mês Ref.:
				<xsl:value-of select="vivo:DateFormat.formatMMYYYY(/SIRS/CYCLE_SUMMARY/@BillingDate)"/>
			</b>
			<br></br>
		</div>
		<div class="f12" style="width:50px;float:left;text-align:center;">
			<b>Subtotal:</b>
		</div>
		<div class="f12" style="width:70px;float:left;text-align:right;">
			<xsl:value-of select="sum(OPERATOR_CALL/REDEBITO_CHAMADAS_IMPUGNADAS_TOTAL/@totalDuration)" />
		</div>
		<div class="f12" style="width:70px;float:left;text-align:right;">
			<xsl:value-of select="sum(OPERATOR_CALL/REDEBITO_CHAMADAS_IMPUGNADAS_TOTAL/@Amount)" />
		</div>
	</div>
	
	<div style="width:776px;float:left;">
		<div class="f12" style="width:70px;float:left;">
			<b>Seq.</b><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;">
			<b>Data</b><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;">
			<b>Hora Início</b><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;">
			<b>Destino</b><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;">
			<b>UF</b><br></br>
		</div>
		
		<div class="f12" style="width:286px;float:left;">
			<b>Num. Chamado</b><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;text-align:right;">
			<b>Duração</b><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;text-align:right;">
			<b>Valor R$</b><br></br>
		</div>
		
	</div>
	
	<xsl:for-each select="OPERATOR_CALL/REDEBITO_CHAMADAS_IMPUGNADAS_TOTAL/REDEBITO_CHAMADAS_IMPUGNADAS_DETAIL">
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
				
		<div class="f12" style="width:70px;float:left;">
			<xsl:value-of select="@GroupID" /><br></br>
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
		<div class="f12" style="width:70px;float:left;">
			<xsl:value-of select="@DataEvento" /><br></br>
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
		<div class="f12" style="width:70px;float:left;">
			<xsl:value-of select="@HoraEvento" /><br></br>
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
		<div class="f12" style="width:70px;float:left;">
			<xsl:value-of select="@CidadeDestino" /><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;">
			<xsl:value-of select="@EstadoDestino" /><br></br>
		</div>
		<div class="f12" style="width:286px;float:left;">
			<xsl:value-of select="@CalledNo" /><br></br>
		</div>
		<div class="f12" style="width:70px;float:left;text-align:right;">
			<xsl:value-of select="@Unidades" /><br></br>
		</div>
		
		<div class="f12" style="width:67px;float:left;text-align:right;">
			<xsl:value-of select="@Amount" /><br></br>
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
	
	</xsl:if>
	
	<!-- fim da verificacao de redebitos de chamadas -->
	
	
	<!-- verificacao de redebitos de mensagens -->
	
	<xsl:if test="$verificaRedebitosMensagens != 0" >
	
	<!-- 407T -->
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Redébitos de Mensagens Impugnadas</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<div style="width:776;float:left;margin-top:-17px;">
		<div class="f12" style="width:586px;float:left;">
			<b>Mês Ref.:
				<xsl:value-of select="vivo:DateFormat.formatMMYYYY(/SIRS/CYCLE_SUMMARY/@BillingDate)"/>
			</b>
			<br></br>
		</div>
		<div class="f12" style="width:50px;float:left;text-align:center;">
			
		</div>
		<div class="f12" style="width:70px;float:left;text-align:right;">
			<b>Subtotal:</b>
		</div>
		<div class="f12" style="width:70px;float:left;text-align:right;">
			<xsl:value-of select="sum(OPERATOR_CALL/REDEBITO_MENSAGENS_IMPUGNADAS_TOTAL/@Amount)" />
		</div>
	</div>
	
	<div style="width:776px;float:left;">
		<div class="f12" style="width:70px;float:left;">
			<b>Seq.</b><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;">
			<b>Data</b><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;">
			<b>Hora Início</b><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;">
			<b>Tipo</b><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;">
			<b>UF</b><br></br>
		</div>
		
		<div class="f12" style="width:286px;float:left;">
			<b>Num. Chamado</b><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;text-align:right;">
			<b></b><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;text-align:right;">
			<b>Valor R$</b><br></br>
		</div>
		
	</div>
	
	<xsl:for-each select="OPERATOR_CALL/REDEBITO_MENSAGENS_IMPUGNADAS_TOTAL/REDEBITO_MENSAGENS_IMPUGNADAS_DETAIL">
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
				
		<div class="f12" style="width:70px;float:left;">
			<xsl:value-of select="@GroupID" /><br></br>
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
		<div class="f12" style="width:70px;float:left;">
			<xsl:value-of select="@DataEvento" /><br></br>
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
		<div class="f12" style="width:70px;float:left;">
			<xsl:value-of select="@HoraEvento" /><br></br>
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
		<div class="f12" style="width:70px;float:left;">
			<xsl:value-of select="@CidadeDestino" /><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;">
			<xsl:value-of select="@EstadoDestino" /><br></br>
		</div>
		<span id="R06_destino">
		<div class="f12" style="width:286px;float:left;">
			<xsl:value-of select="@CalledNo" /><br></br>
		</div>
		</span>
		<div class="f12" style="width:70px;float:left;text-align:right;">
			<br></br>
		</div>
		
		<div class="f12" style="width:67px;float:left;text-align:right;">
			<xsl:value-of select="@Amount" /><br></br>
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
	
	
	</xsl:if>
	<!-- fim da verificacao de redebitos de mensagens -->
	
	
	<!-- verificacao de redebitos de dados -->
	
	<xsl:if test="$verificaRedebitosDados != 0"> 
	
	<!-- 408T -->
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Redébitos de Serviços de Dados Impugnados</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<div style="width:776;float:left;margin-top:-17px;">
		<div class="f12" style="width:586px;float:left;">
			<b>Mês Ref.:
				<xsl:value-of select="vivo:DateFormat.formatMMYYYY(/SIRS/CYCLE_SUMMARY/@BillingDate)"/>
			</b>
			<br></br>
		</div>
		<div class="f12" style="width:50px;float:left;text-align:center;">
			
		</div>
		<div class="f12" style="width:70px;float:left;text-align:right;">
			<b>Subtotal:</b>
		</div>
		<div class="f12" style="width:70px;float:left;text-align:right;">
			<xsl:value-of select="sum(OPERATOR_CALL/REDEBITO_DATA_2G_IMPUGNADAS_TOTAL/@Amount)" />
		</div>
	</div>
	
	<div style="width:776px;float:left;">
		<div class="f12" style="width:70px;float:left;">
			<b>Seq.</b><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;">
			<b>Data</b><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;">
			<b>Hora Início</b><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;">
			<b>Origem</b><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;">
			<b>Serviço</b><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;">
			<b>Quantidade</b><br></br>
		</div>
		
		<div class="f12" style="width:286px;float:left;text-align:right;">
			<b>Unidade</b><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;text-align:right;">
			<b>Valor R$</b><br></br>
		</div>
		
	</div>
	
	<xsl:for-each select="OPERATOR_CALL/REDEBITO_DATA_2G_IMPUGNADAS_TOTAL/REDEBITO_DATA_2G_IMPUGNADAS_DETAIL">
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
			
		<div class="f12" style="width:70px;float:left;">
			<xsl:value-of select="@GroupID" /><br></br>
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
		<div class="f12" style="width:70px;float:left;">
			<xsl:value-of select="@DataEvento" /><br></br>
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
		<div class="f12" style="width:70px;float:left;">
			<xsl:value-of select="@HoraEvento" /><br></br>
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
		<div class="f12" style="width:70px;float:left;">
			<xsl:value-of select="@CidadeDestino" /><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;">
			<xsl:value-of select="@ServicePlan" /><br></br>
		</div>
		
		<div class="f12" style="width:286px;float:left;">
			<xsl:value-of select="@Unidades" /><br></br>
		</div>
		
		<div class="f12" style="width:70px;float:left;text-align:right;">
			<xsl:value-of select="@CarrierCode" /><br></br>
		</div>
		
		<div class="f12" style="width:67px;float:left;text-align:right;">
			<xsl:value-of select="@Amount" /><br></br>
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
	
	</xsl:if>
	<!-- fim da verificacao de redebito de dados -->
	
	
	</xsl:if>
	
	<!-- fim da verificacao de soma de redebitos -->
	
	<!-- fim redebitos -->
	
	<!-- verificacao de planos pacotes -->
	<xsl:if test="$verificaPlanosPacotes != 0">
	
	<!-- plano pacote -->
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Utilização do Plano / Pacote</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<div style="width:776;float:left;margin-top:-17px;">
		<div class="f12" style="width:586px;float:left;">
			<b>Mês Ref.:
				<xsl:value-of select="vivo:DateFormat.formatMMYYYY(/SIRS/CYCLE_SUMMARY/@BillingDate)"/>
			</b>
			<br></br>
		</div>
		<div class="f12" style="width:70px;float:left;text-align:right;">
			<b>Subtotal:</b>
		</div>
		<div class="f12" style="width:120px;float:left;text-align:right;">
			<xsl:value-of select="sum(OPERATOR_CALL/CALLS_SUMMARY/@Amount)" />
		</div>
	</div>
	
	<div style="width:776px;float:left;">
		<div class="f12" style="width:216px;float:left;">
			<b>Plano</b><br></br>
		</div>
		
		
		<div class="f12" style="width:140px;float:left;text-align:right;">
			<b>Minutos Inclusos</b><br></br>
		</div>
		
		<div class="f12" style="width:140px;float:left;text-align:right;">
			<b>Minutos Utilizados</b><br></br>
		</div>
		
		<div class="f12" style="width:140px;float:left;text-align:right;">
			<b>Minutos Excedidos</b><br></br>
		</div>
		
		<div class="f12" style="width:140px;float:left;text-align:right;">
			<b>Valor Excedido R$</b><br></br>
		</div>
		
	</div>
	
	<xsl:for-each select="OPERATOR_CALL/CALLS_SUMMARY">
	<div style="width:776px;float:left;">
				<span id="regraEstilo" title="R05-4">
				<span id="regraEstilo" title="R20-0">
				<span id="regraEstilo" title="R20-1">
				<span id="regraEstilo" title="R20-2">
				<span id="regraEstilo" title="R20-3">
				<span id="regraEstilo" title="R20-4">
				<span id="regraEstilo" title="R20-5">
				<span id="regraEstilo" title="R32-07">
				<span id="regraEstilo" title="R32-08">
				
			<span id="R05-4_nomeServico">
			<span id="R20_nomeDoServico">
			<span id="R32_nomeServico">
			<div class="f12" style="width:216px;float:left;">
					<xsl:value-of select="@Caption" /><br></br>
			</div>
		</span>
		</span>
		</span>		
		<span id="R05-4_minutosFranqueados">
		<div class="f12" style="width:140px;float:left;text-align:right;">
			<xsl:call-template name="FORMAT-HMS">
				<xsl:with-param name="number" select="@IncludedUnits" />
			</xsl:call-template>
			<br></br>
		</div>
		</span>	
		<div class="f12" style="width:140px;float:left;text-align:right;">
						<xsl:call-template name="FORMAT-HMS">
							<xsl:with-param name="number" select="@UsedUnits" />
						</xsl:call-template>
			<br></br>
		</div>
		<div class="f12" style="width:140px;float:left;text-align:right;">
			<xsl:value-of select="@BilledUnits" /><br></br>
		</div>
		<span id="R20_valorCobrado">
		<span id="R32_valor">
		<div class="f12" style="width:140px;float:left;text-align:right;">
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
	
	</xsl:if>
	
	<!-- fim verifica planos pacotes -->

	<!-- verifica soma das chamadas dentro da area de registro -->
	<xsl:if test="$verificaSomaChamadasArea != 0" >
	
	<!-- Chamadas!dentro!da!+rea!de!Registro -->
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Chamadas dentro da área de Registro</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<!-- verifica chamadas locais originadas -->
	<xsl:if test="$verificaChamadasLocaisOriginadas != 0">
	
	<!-- Chamadas!Locais!Originadas  510T-->
	<div class="f14" style="width:776px;float:left;">
		<br></br>
		<b>Chamadas Locais Originadas</b>
	</div>
	
	<div class="linhaDivisoria" />
	
	<div style="width:776;float:left;margin-top:-17px;">
		<div class="f12" style="width:586px;float:left;">
			<b>Mês Ref.:
				<xsl:value-of select="vivo:DateFormat.formatMMYYYY(/SIRS/CYCLE_SUMMARY/@BillingDate)"/>
			</b>
			<br></br>
		</div>
		<div class="f12" style="width:70px;float:left;text-align:right;">
			<b>Subtotal:</b>
		</div>
		<div class="f12" style="width:120px;float:left;text-align:right;">
			<xsl:variable name="valorMonetarioVariavel6"
				select="sum(OPERATOR_CALL/LOCAL_CALLS_TOTAL/@Subtotal)"/>
			<xsl:call-template name="FORMAT-DOUBLE">
				<xsl:with-param name="number" select="$valorMonetarioVariavel6"/>
			</xsl:call-template>
		</div>
	</div>
	
	<div style="width:776px;float:left;">
		<div class="f12" style="width:216px;float:left;">
			<b></b><br></br>
		</div>
		
		
		<div class="f12" style="width:140px;float:left;text-align:right;">
			<b>Minutos Inclusos</b><br></br>
		</div>
		
		<div class="f12" style="width:140px;float:left;text-align:right;">
			<b>Minutos Utilizados</b><br></br>
		</div>
		
		<div class="f12" style="width:140px;float:left;text-align:right;">
			<b>Minutos Excedidos</b><br></br>
		</div>
		
		<div class="f12" style="width:140px;float:left;text-align:right;">
			<b>Valor Excedido R$</b><br></br>
		</div>
		
	</div>
	<xsl:for-each select="OPERATOR_CALL/LOCAL_CALLS_TOTAL">
	<div style="width:776px;float:left;">
		<span id="regraEstilo" title="R05-4">
		<span id="regraEstilo" title="R20-0">
				<span id="regraEstilo" title="R20-1">
				<span id="regraEstilo" title="R20-2">
				<span id="regraEstilo" title="R20-3">
				<span id="regraEstilo" title="R20-4">
				<span id="regraEstilo" title="R20-5">
				<span id="regraEstilo" title="R32-07">
				<span id="regraEstilo" title="R32-08">
				
		<span id="R05-4_nomeServico">
		<span id="R20_nomeDoServico">
		<span id="R32_nomeServico">
		<div class="f12" style="width:216px;float:left;">
			<xsl:value-of select="@ServicePlan" /><br></br>
		</div>
		</span>
		</span>
		</span>
		<span id="R05-4_minutosFranqueados">
		<div class="f12" style="width:140px;float:left;text-align:right;">
			<xsl:call-template name="FORMAT-HMS">
				<xsl:with-param name="number" select="@IncludedUnits" />
			</xsl:call-template>
			<br></br>
		</div>
		</span>
		<div class="f12" style="width:140px;float:left;text-align:right;">
						<xsl:call-template name="FORMAT-HMS">
							<xsl:with-param name="number" select="@UsedUnits" />
						</xsl:call-template>
					
			<br></br>
		</div>
		<div class="f12" style="width:140px;float:left;text-align:right;">
			<xsl:value-of select="@BilledUnits" /><br></br>
		</div>
		<span id="R20_valorCobrado">
		<div class="f12" style="width:140px;float:left;text-align:right;">
			<xsl:call-template name="FORMAT-DOUBLE">
				<xsl:with-param name="number" select="@Subtotal"/>
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
</div>
	</xsl:for-each>
	
	
	<!-- fim Chamadas!dentro!da!+rea!de!Registro -->
	
	</xsl:if>
	<!--fim de verifica chamadas locais originadas -->
	
	</xsl:if>
	<!-- fim de verifica soma chamadas dentro area -->
	
	<!-- fim do conteúdo da página3 PJ-->
	
	
	</xsl:if>
	<xsl:if test="$verificaSomaPagina = 0" >
	Esta sessão não possui dados a serem demonstrados.
	</xsl:if>
	<!-- fim verifica pagina -->
	
</div>
<!-- fim página 3 PJ -->




<!--
</div>
</div>
</body>
</html>
-->
</xsl:for-each>

</xsl:template>   

</xsl:stylesheet>