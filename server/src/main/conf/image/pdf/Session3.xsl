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

  <xsl:output method="xml" indent="yes"/>

<xsl:param name="req:request" />
  
  <xsl:template name="Session3">
  
<xsl:variable name="accountNumber" select="/SIRS/CYCLE_SUMMARY/@AccountNumber"/>
<xsl:variable name="operatorUF" select="/SIRS/CYCLE_SUMMARY/@AccountStateID"/>
<xsl:variable name="operatorCSP" select="'00'"/>
<xsl:variable name="cycleStartDate" select="vivo:DateFormat.formatDDMMYY(/SIRS/CYCLE_SUMMARY/@CycleStartDate)"/>
<xsl:variable name="cycleEndDate" select="vivo:DateFormat.formatDDMMYY(/SIRS/CYCLE_SUMMARY/@CycleEndDate)"/>
<xsl:variable name="context" select="/SIRS/CYCLE_SUMMARY"/>
<xsl:variable name="subscription" select="$context/SUBSCRIPTION_INFO" />
<xsl:variable name="phoneNumber" select="/SIRS/CYCLE_SUMMARY/SUBSCRIPTION_INFO"/>
<xsl:variable name="subscriptionName"/>
<xsl:variable name="opera" select="vivo:CarrierList.getOperadora($operatorUF,$operatorCSP)"/>
  	  
<!--  implementar variavel vinda do request-->
<!--  trocar o numero 4 pela variavel do request -->

<!-- parametro request -->
	

<xsl:variable name="requestAtts" select="req:getAttributes($req:request)" />
<xsl:variable name="terminalNumber" select="map:get($requestAtts,'terminal')"/> 
  	  
	

	<fo:root>
      <fo:layout-master-set>
        <fo:simple-page-master master-name="A4-portrait" page-height="29.7cm" page-width="21.0cm" margin="8mm">
          <fo:region-body/>
        </fo:simple-page-master>
      </fo:layout-master-set>
      
      <fo:page-sequence master-reference="A4-portrait">

	
	<fo:flow flow-name="xsl-region-body" space-before="100mm">
	
		
	
	<xsl:for-each select="$subscription">
	<!-- contador de terminal -->
	<xsl:variable name="contadorTerminal"><xsl:number /></xsl:variable>
	<xsl:if test="$contadorTerminal = $terminalNumber">
	
	
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
	
	<xsl:variable name="verificaChamadasLocaisOriginadas" select="sum(OPERATOR_CALL/LOCAL_CALLS_TOTAL/@UsedUnits)"/>
	<xsl:variable name="verificaSomaChamadasArea" select="$verificaChamadasLocaisOriginadas" />
	
	<xsl:variable name="verificaSomaPagina" select="$verificaAdesao + $verificaPlanosConstratados + $verificaSevicosAdicionais + $verificaSomaRedebitos + $verificaPlanosPacotes + $verificaSomaChamadasArea" />	
	
	<!-- fim das variaveis de verificacao -->
	
		<fo:table table-layout="fixed"  width="195mm">
			<fo:table-column column-width="195mm"/>
			<fo:table-body>
			  <fo:table-row>
			    <fo:table-cell>
			     	<fo:block>
							<fo:external-graphic src="conf/image/pdf/images/header.jpg"/>
					</fo:block>
			    </fo:table-cell>
			  </fo:table-row>
			</fo:table-body>
		</fo:table>
	
		<fo:table table-layout="fixed" width="195mm">
			<fo:table-column column-width="25mm"/>
			<fo:table-column column-width="80mm"/>
			<fo:table-column column-width="41mm"/>
			<fo:table-column column-width="49mm"/>
			<fo:table-body>
			  <fo:table-row>
			    <fo:table-cell>
			      <fo:block />
			    </fo:table-cell>
			    <fo:table-cell>
			    	<fo:block space-after="11mm" />
			    	<fo:block font-family="Helvetica" font-size="8pt" >
			            <!-- cabecalho -->
						<fo:block><xsl:value-of select="$context/BILLING_ADDRESS/@CustomerName"/></fo:block>
						<fo:block><xsl:value-of select="$context/BILLING_ADDRESS/@AddressLine2"/></fo:block>
						<fo:block><xsl:value-of select="$context/BILLING_ADDRESS/@AddressLine3"/></fo:block>
						<fo:block><xsl:value-of select="$context/BILLING_ADDRESS/@AddressLine4"/></fo:block>
						<fo:block><xsl:value-of select="$context/BILLING_ADDRESS/@AddressLine5"/></fo:block>
						<!-- fim do sub cabecalho -->
					</fo:block>
			    </fo:table-cell>
			    <fo:table-cell>
			      <fo:block />
			    </fo:table-cell>
			    <fo:table-cell>
			      <fo:block font-family="Helvetica" font-size="6pt">
			      	<fo:block><xsl:value-of select="$opera/@NAME" /></fo:block>
					<fo:block><xsl:value-of select="$opera/@ADDRESS" /></fo:block>
					<fo:block>Ins.Mun. <xsl:value-of select="$opera/@INSC_MUNICIPAL" /></fo:block>
					<fo:block>CNPJ <xsl:value-of select="$opera/@CNPJ" /></fo:block>
			      </fo:block>
			      <fo:block font-family="Helvetica" font-size="7pt">
			      	<fo:block  font-weight="bold">
						Plano: <xsl:value-of select="$subscription/ENTIRE_SUBSCRIPTION_TOTAL/ACTIVATION_TOTAL/ACTIVATION_DETAIL/@Descricao" />
					</fo:block>
					<fo:block>
						Mês de Referência: <xsl:value-of select="vivo:DateFormat.formatMMYYYY(/SIRS/CYCLE_SUMMARY/@BillingDate)"/>
					</fo:block>
					<fo:block  font-weight="bold">
						Número da Conta: <xsl:value-of select="$accountNumber"/>
					</fo:block>
					<fo:block  font-weight="bold">
						Número do Telefone: <xsl:value-of select="@PhoneNumber"/>
					</fo:block>
					<fo:block padding-after="5mm">
						Nome: <xsl:value-of select="$context/BILLING_ADDRESS/@AddressLine1"/>
					</fo:block>
					<fo:block  font-weight="bold" font-size="8pt" text-align="right">
						Página 0000003/0000006
					</fo:block>
				  </fo:block>
			    </fo:table-cell>
			  </fo:table-row>
			</fo:table-body>
		</fo:table>
	
		
		<fo:block space-after="1.5mm"/>
		
		<fo:block
		font-family="Helvetica"
		font-size="9px"
		font-weight="bold">
			DETALHAMENTO DE UTILIZAÇÃO:   VIVO S.A.
		</fo:block>
		
		
		<!-- adesao -->
		<!-- verificar se adesao não é vazio -->
		<xsl:if test="$verificaAdesao != 0">
		
		<fo:block space-after="2mm"/>
		
		<fo:block
		font-family="Helvetica"
		font-size="9px"
		font-weight="bold"
		border-bottom-style="solid"
		border-width="0.5px">
			Adesão
		</fo:block>
		<fo:block space-after="0.5mm"/>
		<fo:table>
				<fo:table-column column-width="97mm" />
				<fo:table-column column-width="97mm" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="2">
							<fo:block 
								font-family="Helvetica" 
								font-size="8px"
								font-weight="bold"
								text-align="right">
								Subtotal: 
								<xsl:variable name="valorMonetarioVariavel"
										select="sum(ENTIRE_SUBSCRIPTION_TOTAL/SUBSCRIPTION_SRV_CHARGE_TOTAL/@ServiceChargeAmt)"/>
								<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="$valorMonetarioVariavel"/>
								</xsl:call-template>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell>
							<fo:block 
								font-family="Helvetica" 
								font-size="8px"
								font-weight="bold">
								Descrição
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block 
								font-family="Helvetica" 
								font-size="8px"
								font-weight="bold"
								text-align="right">
								Valor R$
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<xsl:for-each select="ENTIRE_SUBSCRIPTION_TOTAL/SUBSCRIPTION_SRV_CHARGE_TOTAL/SUBSCRIPTION_SRV_CHARGE_DETAIL">
						<fo:table-row>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px">
									<xsl:value-of select="@Descricao"/>
								</fo:block>
							</fo:table-cell>
								<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									text-align="right">
									<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="@Amount"/>
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:for-each>
				</fo:table-body>
			</fo:table>
		</xsl:if>
		
		<!-- fim adesao -->
		
		<!-- 325D -->
		<!-- planos contratados -->
		<!-- verificar se planos contratados nao é vazio -->
		<xsl:if test="$verificaPlanosConstratados != 0">
		
		<fo:block space-after="2mm"/>
		
			<fo:block
			font-family="Helvetica"
			font-size="9px"
			font-weight="bold"
			border-bottom-style="solid"
			border-width="0.5px">
				Planos Contratados 
			</fo:block>
			<fo:block space-after="0.5mm"/>
			<fo:table>
				<fo:table-column column-width="84mm" />
				<fo:table-column column-width="45mm" />
				<fo:table-column column-width="65mm" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="3">
							<fo:block 
								font-family="Helvetica" 
								font-size="8px"
								font-weight="bold"
								text-align="right">
								Subtotal: 
								<xsl:variable name="valorMonetarioVariavel"
										select="sum(ENTIRE_SUBSCRIPTION_TOTAL/ACTIVATION_TOTAL/@ServiceChargeAmt)"/>
								<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="$valorMonetarioVariavel"/>
								</xsl:call-template>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell>
							<fo:block 
								font-family="Helvetica" 
								font-size="8px"
								font-weight="bold">
								Descrição
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block 
								font-family="Helvetica" 
								font-size="8px"
								font-weight="bold"
								text-align="center">
								Período
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block 
								font-family="Helvetica" 
								font-size="8px"
								font-weight="bold"
								text-align="right">
								Valor R$
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<xsl:for-each select="ENTIRE_SUBSCRIPTION_TOTAL/ACTIVATION_TOTAL/ACTIVATION_DETAIL">
						<fo:table-row>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px">
									<xsl:value-of select="@Descricao"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									text-align="center">
									<xsl:value-of select="vivo:DateFormat.formatDDMMYYYY(@StartDate)"/> a <xsl:value-of select="vivo:DateFormat.formatDDMMYYYY(@ EndDate)"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									text-align="right">
									<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="@Amount"/>
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:for-each>
				</fo:table-body>
			</fo:table>
		</xsl:if>
		
		<!-- fim dos planos contratados  -->
		
		<!-- 330D -->
		<!-- serviços adicionais -->
		<!-- verificacar se servicos adiconais nao eh nulo -->
		<xsl:if test="$verificaSevicosAdicionais != 0">
			<fo:block space-after="2mm"/>
			<fo:block
			font-family="Helvetica"
			font-size="9px"
			font-weight="bold"
			border-bottom-style="solid"
			border-width="0.5px">
				Serviços Adicionais 
			</fo:block>
			<fo:block space-after="0.5mm"/>
			<fo:table>
				<fo:table-column column-width="84mm" />
				<fo:table-column column-width="45mm" />
				<fo:table-column column-width="65mm" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="3">
							<fo:block 
								font-family="Helvetica" 
								font-size="8px"
								font-weight="bold"
								text-align="right">
								Subtotal: 
								<xsl:variable name="valorMonetarioVariavel"
										select="sum(ADDITIONAL_SERVICES_TOTAL/@ServiceChargeAmt)"/>
								<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="$valorMonetarioVariavel"/>
								</xsl:call-template>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell>
							<fo:block 
								font-family="Helvetica" 
								font-size="8px"
								font-weight="bold">
								Descrição
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block 
								font-family="Helvetica" 
								font-size="8px"
								font-weight="bold"
								text-align="center">
								Período
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block 
								font-family="Helvetica" 
								font-size="8px"
								font-weight="bold"
								text-align="right">
								Valor R$
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<xsl:for-each select="ADDITIONAL_SERVICES_TOTAL/ADDITIONAL_SERVICES_DETAIL">
						<fo:table-row>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px">
									<xsl:value-of select="@Descricao"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									text-align="center">
									<xsl:value-of select="vivo:DateFormat.formatDDMMYYYY(@StartDate)"/> a <xsl:value-of select="vivo:DateFormat.formatDDMMYYYY(@ EndDate)"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									text-align="right">
									<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="@Amount"/>
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:for-each>
				</fo:table-body>
			</fo:table>
		
		</xsl:if>
		<!-- fim servicos adicionais -->
		
		
		<!-- REDEBITOS -->
		
		<!-- verifica soma de redebitos -->
	
		<xsl:if test="$verificaSomaRedebitos != 0">
			
			<fo:block space-after="2mm"/>
		
			<fo:block
			font-family="Helvetica"
			font-size="9px"
			font-weight="bold">
				Redébitos
			</fo:block>
			
			<!-- verfica redebitos servicos -->
			<xsl:if test="$verificaRedebitosServicos != 0">
				<fo:block space-after="2mm"/>
				<fo:block
				font-family="Helvetica"
				font-size="9px"
				font-weight="bold"
				border-bottom-style="solid"
				border-width="0.5px">
					Redébitos de Serviços Impugnados
				</fo:block>
				<fo:block space-after="0.5mm"/>
				<fo:table>
					<fo:table-column column-width="97mm" />
					<fo:table-column column-width="97mm" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="left">
									Mês Ref.: <xsl:value-of select="vivo:DateFormat.formatMMYYYY(/SIRS/CYCLE_SUMMARY/@BillingDate)"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="right">
									Subtotal: 
									<xsl:variable name="valorMonetarioVariavel"
											select="sum(OPERATOR_CALL/REDEBITO_SERVICOS_IMPUGNADOS_TOTAL/@Amount)"/>
									<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="$valorMonetarioVariavel"/>
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Descrição
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="right">
									Valor R$
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<xsl:for-each select="OPERATOR_CALL/REDEBITO_SERVICOS_IMPUGNADOS_TOTAL/REDEBITO_SERVICOS_IMPUGNADOS_DETAIL">
							<fo:table-row>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="8px">
										<xsl:value-of select="@Descricao"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="8px"
										text-align="right">
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="@Amount"/>
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:for-each>
					</fo:table-body>
				</fo:table>
			</xsl:if>
			<!-- fim da verificacao de redebitos de servicos -->
			
			
			<!-- redebitos de chamadas -->
			<xsl:if test="$verificaRedebitosChamadas != 0">
				<fo:block space-after="2mm"/>
				<fo:block
				font-family="Helvetica"
				font-size="9px"
				font-weight="bold"
				border-bottom-style="solid"
				border-width="0.5px">
					Redébitos de Chamadas Impugnadas
				</fo:block>
				<fo:block space-after="0.5mm"/>
				<fo:table>
					<fo:table-column column-width="12mm" />
					<fo:table-column column-width="16mm" />
					<fo:table-column column-width="20mm" />
					<fo:table-column column-width="48mm" />
					<fo:table-column column-width="14mm" />
					<fo:table-column column-width="32mm" />
					<fo:table-column column-width="25mm" />
					<fo:table-column column-width="25mm" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell number-columns-spanned="4">
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="left">
									Mês Ref.: <xsl:value-of select="vivo:DateFormat.formatMMYYYY(/SIRS/CYCLE_SUMMARY/@BillingDate)"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell number-columns-spanned="2">
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="right">
									Subtotal: 
								</fo:block>
							</fo:table-cell>
							<fo:table-cell >
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="right">
									<xsl:value-of select="sum(OPERATOR_CALL/REDEBITO_CHAMADAS_IMPUGNADAS_TOTAL/@totalDuration)" />
								</fo:block>
							</fo:table-cell>
							<fo:table-cell >
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="right">
									<xsl:value-of select="sum(OPERATOR_CALL/REDEBITO_CHAMADAS_IMPUGNADAS_TOTAL/@Amount)" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						
						
						
						<fo:table-row>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Seq.
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Data
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Hora Início
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Destino
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									UF
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Num. Chamado
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="right">
									Duração
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="right">
									Valor R$
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						
						<xsl:for-each select="OPERATOR_CALL/REDEBITO_CHAMADAS_IMPUGNADAS_TOTAL/REDEBITO_CHAMADAS_IMPUGNADAS_DETAIL">
							<fo:table-row>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="@GroupID" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="@DataEvento" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="@HoraEvento" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="@CidadeDestino" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="@EstadoDestino" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="@CalledNo" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px"
										text-align="right">
										<xsl:value-of select="@Unidades" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px"
										text-align="right">
										<xsl:value-of select="@Amount" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:for-each>
					</fo:table-body>
				</fo:table>
			</xsl:if>
			<!-- fim redebitos de chamadas -->
			
			<!-- verificacao de redebitos de mensagens -->
			<xsl:if test="$verificaRedebitosMensagens != 0">
				<fo:block space-after="2mm"/>
				<fo:block
				font-family="Helvetica"
				font-size="9px"
				font-weight="bold"
				border-bottom-style="solid"
				border-width="0.5px">
					Redébitos de Mensagens Impugnadas
				</fo:block>
				<fo:block space-after="0.5mm"/>
				<fo:table>
					<fo:table-column column-width="12mm" />
					<fo:table-column column-width="16mm" />
					<fo:table-column column-width="20mm" />
					<fo:table-column column-width="48mm" />
					<fo:table-column column-width="14mm" />
					<fo:table-column column-width="32mm" />
					<fo:table-column column-width="25mm" />
					<fo:table-column column-width="25mm" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell number-columns-spanned="4">
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="left">
									Mês Ref.: <xsl:value-of select="vivo:DateFormat.formatMMYYYY(/SIRS/CYCLE_SUMMARY/@BillingDate)"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell number-columns-spanned="2">
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="right">
									
								</fo:block>
							</fo:table-cell>
							<fo:table-cell >
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="right">
									Subtotal:
								</fo:block>
							</fo:table-cell>
							<fo:table-cell >
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="right">
									<xsl:value-of select="sum(OPERATOR_CALL/REDEBITO_MENSAGENS_IMPUGNADAS_TOTAL/@Amount)" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						
						
						
						<fo:table-row>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Seq.
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Data
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Hora Início
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Tipo
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									UF
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Num. Chamado
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="right">
									
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="right">
									Valor R$
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						
						<xsl:for-each select="OPERATOR_CALL/REDEBITO_MENSAGENS_IMPUGNADAS_TOTAL/REDEBITO_MENSAGENS_IMPUGNADAS_DETAIL">
							<fo:table-row>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="@GroupID" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="@DataEvento" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="@HoraEvento" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="@CidadeDestino" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="@EstadoDestino" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="@CalledNo" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px"
										text-align="right">
										
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px"
										text-align="right">
										<xsl:value-of select="@Amount" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:for-each>
					</fo:table-body>
				</fo:table>
			</xsl:if>
			<!-- fim dos redebitos de mensagens -->
			
			<!-- verificacao de redebitos de dados -->
			<xsl:if test="$verificaRedebitosDados != 0">
				<fo:block space-after="2mm"/>
				<fo:block
				font-family="Helvetica"
				font-size="9px"
				font-weight="bold"
				border-bottom-style="solid"
				border-width="0.5px">
					Redébitos de Serviços de Dados Impugnados
				</fo:block>
				<fo:block space-after="0.5mm"/>
				<fo:table>
					<fo:table-column column-width="12mm" />
					<fo:table-column column-width="16mm" />
					<fo:table-column column-width="20mm" />
					<fo:table-column column-width="43mm" />
					<fo:table-column column-width="31mm" />
					<fo:table-column column-width="20mm" />
					<fo:table-column column-width="25mm" />
					<fo:table-column column-width="25mm" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell number-columns-spanned="4">
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="left">
									Mês Ref.: <xsl:value-of select="vivo:DateFormat.formatMMYYYY(/SIRS/CYCLE_SUMMARY/@BillingDate)"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell number-columns-spanned="2">
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="right">
									
								</fo:block>
							</fo:table-cell>
							<fo:table-cell >
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="right">
									Subtotal:
								</fo:block>
							</fo:table-cell>
							<fo:table-cell >
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="right">
									<xsl:value-of select="sum(OPERATOR_CALL/REDEBITO_DATA_2G_IMPUGNADAS_TOTAL/@Amount)" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						
						
						
						<fo:table-row>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Seq.
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Data
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Hora Início
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Origem
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Servico
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Quantidade
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="right">
									Unidade
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="right">
									Valor R$
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						
						<xsl:for-each select="OPERATOR_CALL/REDEBITO_DATA_2G_IMPUGNADAS_TOTAL/REDEBITO_DATA_2G_IMPUGNADAS_DETAIL">
							<fo:table-row>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="@GroupID" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="@DataEvento" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="@HoraEvento" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="@CidadeDestino" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="@ServicePlan" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="@Unidades" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px"
										text-align="right">
										<xsl:value-of select="@CarrierCode" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px"
										text-align="right">
										<xsl:value-of select="@Amount" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:for-each>
					</fo:table-body>
				</fo:table>
			</xsl:if>
			<!-- fim dos redebitos de dados -->
		
		</xsl:if>
		<!-- fim redebitos -->
		
		
		<!-- verificacao de planos pacotes -->
		<xsl:if test="$verificaPlanosPacotes != 0">
			<fo:block space-after="2mm"/>
			<fo:block
			font-family="Helvetica"
			font-size="9px"
			font-weight="bold"
			border-bottom-style="solid"
			border-width="0.5px">
				Utilização do Plano / Pacote
			</fo:block>
			<fo:block space-after="0.5mm"/>
			<fo:table>
				<fo:table-column column-width="62mm" />
				<fo:table-column column-width="28mm" />
				<fo:table-column column-width="28mm" />
				<fo:table-column column-width="33mm" />
				<fo:table-column column-width="43mm" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="3">
							<fo:block 
								font-family="Helvetica" 
								font-size="8px"
								font-weight="bold"
								text-align="left">
								Mês Ref.: <xsl:value-of select="vivo:DateFormat.formatMMYYYY(/SIRS/CYCLE_SUMMARY/@BillingDate)"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell >
							<fo:block 
								font-family="Helvetica" 
								font-size="8px"
								font-weight="bold"
								text-align="right">
								Subtotal:
							</fo:block>
						</fo:table-cell>
						<fo:table-cell >
							<fo:block 
								font-family="Helvetica" 
								font-size="8px"
								font-weight="bold"
								text-align="right">
								<xsl:call-template name="FORMAT-DOUBLE">
									<xsl:with-param name="number" select="sum(OPERATOR_CALL/CALLS_SUMMARY/@Amount)"/>
								</xsl:call-template>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>

					<fo:table-row>
						<fo:table-cell>
							<fo:block 
								font-family="Helvetica" 
								font-size="8px"
								font-weight="bold">
								Plano
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block 
								font-family="Helvetica" 
								font-size="8px"
								font-weight="bold">
								Minutos Inclusos
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block 
								font-family="Helvetica" 
								font-size="8px"
								font-weight="bold">
								Minutos Utilizados
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block 
								font-family="Helvetica" 
								font-size="8px"
								font-weight="bold"
								text-align="right">
								Minutos Excedidos
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block 
								font-family="Helvetica" 
								font-size="8px"
								font-weight="bold"
								text-align="right">
								Valor Excedido R$
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					
					<xsl:for-each select="OPERATOR_CALL/CALLS_SUMMARY">
						<fo:table-row>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="7px">
									<xsl:value-of select="@Caption" />
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="7px">
									<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="@IncludedUnits" />
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="7px">
									<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="@UsedUnits" />
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="7px"
									text-align="right">
									<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="@BilledUnits" />
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="7px"
									text-align="right">
									<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="@Amount"/>
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:for-each>
				</fo:table-body>
			</fo:table>
		</xsl:if>
		<!-- fim planos pacotes -->
		
		
		
		<!-- verifica soma das chamadas dentro da area de registro -->
		<xsl:if test="$verificaSomaChamadasArea != 0" >
			<fo:block space-after="2mm"/>
		
			<fo:block
			font-family="Helvetica"
			font-size="9px"
			font-weight="bold">
				Chamadas dentro da área de Registro
			</fo:block>
			
			<!-- verifica chamadas locais originadas -->
			<xsl:if test="$verificaChamadasLocaisOriginadas != 0">
				<fo:block space-after="2mm"/>
				<fo:block
				font-family="Helvetica"
				font-size="9px"
				font-weight="bold"
				border-bottom-style="solid"
				border-width="0.5px">
					Chamadas Locais Originadas
				</fo:block>
				<fo:block space-after="0.5mm"/>
				
				<xsl:for-each select="OPERATOR_CALL/LOCAL_CALLS_TOTAL">
				
				<fo:table>
					<fo:table-column column-width="12mm" />
					<fo:table-column column-width="16mm" />
					<fo:table-column column-width="20mm" />
					<fo:table-column column-width="43mm" />
					<fo:table-column column-width="31mm" />
					<fo:table-column column-width="20mm" />
					<fo:table-column column-width="25mm" />
					<fo:table-column column-width="25mm" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell number-columns-spanned="5">
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="left">
									<xsl:value-of select="@ServicePlan" />
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="right">
									Subtotal:
								</fo:block>
							</fo:table-cell>
							<fo:table-cell >
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="right">
									<xsl:call-template name="FORMAT-HMS">
										<xsl:with-param name="number" select="@UsedUnits" />
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell >
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="right">
									<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="@Subtotal"/>
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						
						
						
						<fo:table-row>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Seq.
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Data
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Hora Início
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Destino
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Núm. Chamado
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Tarifa
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="right">
									Duração
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="right">
									Valor R$
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						
						<xsl:for-each select="LOCAL_CALLS_DETAIL">
						<xsl:variable name="contador"><xsl:number /></xsl:variable>
							<fo:table-row>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="$contador"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="vivo:DateFormat.formatDDMMYY(@Date)"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:call-template name="FORMAT-HMS-INTEIRO">
											<xsl:with-param name="number" select="@Time" />
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="@Destination"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="@NumberCalled"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:call-template name="FORMAT-TARIFF">
											<xsl:with-param name="tarifa" select="@Tariff" />
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px"
										text-align="right">
										<xsl:call-template name="FORMAT-HMS">
											<xsl:with-param name="number" select="@Duration" />
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px"
										text-align="right">
										<xsl:call-template name="FORMAT-DOUBLE">
											<xsl:with-param name="number" select="@Amount"/>
										</xsl:call-template>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:for-each>
					</fo:table-body>
				</fo:table>
				
				</xsl:for-each>
				
				<fo:block space-after="1mm"/>
				
			</xsl:if>
			
		</xsl:if>
		
	<!-- fo:block break-after="page" / -->
	
	
	<!-- fim contador de terminal -->
	</xsl:if>
	</xsl:for-each>	
		
	</fo:flow>

</fo:page-sequence>
</fo:root>
    
    

</xsl:template>   

	
	
<!-- Account number being processed -->

	

</xsl:stylesheet>
