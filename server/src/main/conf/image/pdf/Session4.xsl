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
  
  <xsl:template name="Session4">
  
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
	
	<xsl:variable name="verificaCobrar" select="sum(OPERATOR_CALL/LOCAL_COLLECT_CALLS_TOTAL/@UsedUnits)" />
	
	<xsl:variable name="verificaForaOriginadas" select="sum(OPERATOR_CALL/ROAM_MOC_LOCAL_TOTAL/@UsedUnits)" />
	<xsl:variable name="verificaForaRecebidas" select="sum(OPERATOR_CALL/ROAM_MTC_LOCAL_TOTAL/@UsedUnits)" />
	<xsl:variable name="verificaForaMundo" select="sum(OPERATOR_CALL/ROAM_MTC_INTERNATIONAL_TOTAL/@UsedUnits)" />
	
	<xsl:variable name="verificaSomaFora" select="$verificaForaOriginadas + $verificaForaRecebidas + $verificaForaMundo" />
	
	<xsl:variable name="verificaSomaPagina" select="$verificaCobrar + $verificaSomaFora"/>
	<!--  fim das variaveis do sistema -->
	
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
						Página 0000004/0000006
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
		
		<!-- verifica soma das chamadas dentro da area de registro -->
		<xsl:if test="$verificaCobrar != 0" >
			<fo:block space-after="2mm"/>
		
			<fo:block
			font-family="Helvetica"
			font-size="9px"
			font-weight="bold">
				Chamadas Dentro da Área de Registro (continuação)
			</fo:block>
			
			<fo:block space-after="2mm"/>
			
			<fo:block
			font-family="Helvetica"
			font-size="9px"
			font-weight="bold"
			border-bottom-style="solid"
			border-width="0.5px">
				Chamadas Recebidas a Cobrar - Locais
			</fo:block>
			
			<fo:block space-after="0.5mm"/>
			
			<xsl:for-each select="OPERATOR_CALL/LOCAL_COLLECT_CALLS_TOTAL">
				
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
									Origem
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Núm. Origem
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
						
						<xsl:for-each select="LOCAL_COLLECT_CALLS_DETAIL">
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
			
				<fo:block space-after="1mm"/>
			</xsl:for-each>
	
		</xsl:if>
		
		<!--  fim a cobrar -->
		
		<!--  verificacao da soma de chamadas fora da area de registro -->
		<xsl:if test="$verificaSomaFora != 0 " >
			<fo:block space-after="2mm"/>
		
			<fo:block
			font-family="Helvetica"
			font-size="9px"
			font-weight="bold">
				Chamadas Fora da Área de Registro 
			</fo:block>
				
				<!--  verificacao de chamadas locais originadas -->
				<xsl:if test="$verificaForaOriginadas != 0 ">
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
					
					<xsl:for-each select="OPERATOR_CALL/ROAM_MOC_LOCAL_TOTAL">
				
						<fo:table>
							<fo:table-column column-width="7mm" />
							<fo:table-column column-width="16mm" />
							<fo:table-column column-width="20mm" />
							<fo:table-column column-width="20mm" />
							<fo:table-column column-width="20mm" />
							<fo:table-column column-width="28mm" />
							<fo:table-column column-width="29mm" />
							<fo:table-column column-width="12mm" />
							<fo:table-column column-width="20mm" />
							<fo:table-column column-width="20mm" />
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell number-columns-spanned="7">
										<fo:block 
											font-family="Helvetica" 
											font-size="8px"
											font-weight="bold"
											text-align="left">
											Operadora: <xsl:value-of select="@ServicePlan" />
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
											<xsl:variable name="valorMonetarioVariavel6"
						select="sum(@Subtotal)"/>
					<xsl:call-template name="FORMAT-DOUBLE">
						<xsl:with-param name="number" select="$valorMonetarioVariavel6"/>
					</xsl:call-template>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								
								
								
								<fo:table-row>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold">
											Seq.
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold">
											Data
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold">
											Hora Início
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold">
											Local Visitado
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold">
											Destino
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold">
											Núm. Chamado
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold">
											Tipo de Chamada
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold">
											Tarifa
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold"
											text-align="right">
											Duração
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold"
											text-align="right">
											Valor R$
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								
								<xsl:for-each select="ROAM_MOC_LOCAL_DETAIL">
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
												<xsl:value-of select="vivo:DateFormat.formatDDMMYY(@Date)" />
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
												<xsl:value-of select="@Origin" />
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block 
												font-family="Helvetica" 
												font-size="7px">
												<xsl:value-of select="@Destination" />
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block 
												font-family="Helvetica" 
												font-size="7px">
												<xsl:value-of select="@NumberCalled" />
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
					
						<fo:block space-after="1mm"/>
					</xsl:for-each>
				
				</xsl:if>
				<!--  fim verificacao fora originadas -->
				
				<!--  verifica chamadas locais recebidas fora -->
				<xsl:if test="$verificaForaRecebidas != 0" >
					<fo:block space-after="2mm"/>
					<fo:block
					font-family="Helvetica"
					font-size="9px"
					font-weight="bold"
					border-bottom-style="solid"
					border-width="0.5px">
						Chamadas Locais Recebidas
					</fo:block>
				
					<fo:block space-after="0.5mm"/>
					
					<xsl:for-each select="OPERATOR_CALL/ROAM_MTC_LOCAL_TOTAL">
				
						<fo:table>
							<fo:table-column column-width="7mm" />
							<fo:table-column column-width="16mm" />
							<fo:table-column column-width="20mm" />
							<fo:table-column column-width="30mm" />
							<fo:table-column column-width="38mm" />
							<fo:table-column column-width="29mm" />
							<fo:table-column column-width="12mm" />
							<fo:table-column column-width="20mm" />
							<fo:table-column column-width="20mm" />
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell number-columns-spanned="6">
										<fo:block 
											font-family="Helvetica" 
											font-size="8px"
											font-weight="bold"
											text-align="left">
											Operadora: <xsl:value-of select="@ServicePlan" />
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
											<xsl:variable name="valorMonetarioVariavel6"
												select="sum(@Subtotal)"/>
											<xsl:call-template name="FORMAT-DOUBLE">
												<xsl:with-param name="number" select="$valorMonetarioVariavel6"/>
											</xsl:call-template>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								
								
								
								<fo:table-row>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold">
											Seq.
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold">
											Data
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold">
											Hora Início
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold">
											Local Visitado
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold">
											Número de Origem
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold">
											Tipo de Chamada
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold">
											Tarifa
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold"
											text-align="right">
											Duração
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold"
											text-align="right">
											Valor R$
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								
								<xsl:for-each select="ROAM_MTC_LOCAL_DETAIL">
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
												<xsl:value-of select="vivo:DateFormat.formatDDMMYY(@Date)" />
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
												<xsl:value-of select="@Origin" />
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block 
												font-family="Helvetica" 
												font-size="7px">
												<xsl:value-of select="@ChannelID" />
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
					
						<fo:block space-after="1mm"/>
					</xsl:for-each>
				</xsl:if>
				<!--  fim chamadas recebidas fora -->
		</xsl:if>
		<!-- fim verifica fora -->
		
		
		<!--  verifica chamadas realizadas/recebidas mundo -->
		<xsl:if test="$verificaForaMundo != 0 ">
			<fo:block space-after="2mm"/>
			<fo:block
			font-family="Helvetica"
			font-size="9px"
			font-weight="bold"
			border-bottom-style="solid"
			border-width="0.5px">
				Chamadas Realizadas/Recebidas no Exterior - Vivo no Mundo
			</fo:block>
		
			<fo:block space-after="0.5mm"/>
			
			<xsl:for-each select="OPERATOR_CALL/ROAM_MTC_INTERNATIONAL_TOTAL">
		
				<fo:table>
					<fo:table-column column-width="7mm" />
					<fo:table-column column-width="16mm" />
					<fo:table-column column-width="20mm" />
					<fo:table-column column-width="30mm" />
					<fo:table-column column-width="38mm" />
					<fo:table-column column-width="29mm" />
					<fo:table-column column-width="12mm" />
					<fo:table-column column-width="20mm" />
					<fo:table-column column-width="20mm" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell number-columns-spanned="6">
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="left">
									Operadora: <xsl:value-of select="@ServicePlan" />
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
									<xsl:variable name="valorMonetarioVariavel6"
										select="sum(@Subtotal)"/>
									<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="$valorMonetarioVariavel6"/>
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						
						
						
						<fo:table-row>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="7px"
									font-weight="bold">
									Seq.
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="7px"
									font-weight="bold">
									Data
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="7px"
									font-weight="bold">
									Hora Início
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="7px"
									font-weight="bold">
									Destino
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="7px"
									font-weight="bold">
									Número Chamado
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="7px"
									font-weight="bold">
									Tipo de Chamada
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="7px"
									font-weight="bold">
									Tarifa
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="7px"
									font-weight="bold"
									text-align="right">
									Duração
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="7px"
									font-weight="bold"
									text-align="right">
									Valor R$
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
				
						
						<xsl:for-each select="ROAM_MTC_INTERNATIONAL_DETAIL">
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
										<xsl:value-of select="vivo:DateFormat.formatDDMMYY(@Date)" />
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
										<xsl:value-of select="@Destination" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="7px">
										<xsl:value-of select="@NumberCalled" />
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
			
				<fo:block space-after="1mm"/>
			</xsl:for-each>
		
		</xsl:if>
		
		<!--  fim internacionais -->
		
		
	<!-- fo:block break-after="page" / -->
	
	<!-- fim do terminal -->
	</xsl:if>
	</xsl:for-each>	
		
	</fo:flow>

</fo:page-sequence>
</fo:root>
    
    

</xsl:template>   

	
<!-- Account number being processed -->

	

</xsl:stylesheet>
