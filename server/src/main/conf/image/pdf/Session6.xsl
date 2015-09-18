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
  
  <xsl:template name="Session6">
  
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
						Página 0000006/0000006
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

		<!--  veririfcacao do total de longa distancia  -->
		<xsl:if test="$totalDetalhamentoLonga != 0 ">
		
			<fo:block space-after="2mm"/>
		
			<fo:block
			font-family="Helvetica"
			font-size="9px"
			font-weight="bold"
			border-bottom-style="solid"
			border-width="0.5px">
				DETALHAMENTO DE UTILIZAÇÃO LONGA DISTÂNCIA
			</fo:block>
		
			
			<!-- descontos -->
			<xsl:if test="$verificaDescontos != 0">
			
				<fo:block space-after="2mm"/>
				
				<fo:block
				font-family="Helvetica"
				font-size="9px"
				font-weight="bold"
				border-bottom-style="solid"
				border-width="0.5px">
					Descontos
				</fo:block>
				
				<xsl:for-each select="OPERATOR_CALL/DiscountsTotal">
				
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
										<xsl:variable name="valorMonetarioVariavel6"
											select="sum(@Amount)"/>
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
							
							<xsl:for-each select="DiscountsDetail">
							
							<xsl:variable name="contador"><xsl:number /></xsl:variable>
								<fo:table-row>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px">
											<xsl:value-of select="@captionPhrase"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											text-align="right">
											<xsl:call-template name="FORMAT-DOUBLE">
												<xsl:with-param name="number" select="@amount"/>
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
			<!-- fim descontos -->
			
			
			<!-- verifica  total chamadas dentro da area de registro -->
			<xsl:if test="$dentroRegistroTotal != 0">
			
				<fo:block space-after="2mm"/>
				
				<fo:block
				font-family="Helvetica"
				font-size="9px"
				font-weight="bold"
				border-bottom-style="solid"
				border-width="0.5px">
					Chamadas Dentro da Área de Registro
				</fo:block>
				
				
				<!-- veririfca chamadas longa distancia dentro -->
				<xsl:if test="$verificaLongaDentro != 0">
					<fo:block space-after="2mm"/>

					<fo:block
					font-family="Helvetica"
					font-size="8px"
					font-weight="bold"
					border-bottom-style="solid"
					border-width="0.5px">
						Chamadas de Longa Distância para Dentro do Estado
					</fo:block>
				
					<xsl:for-each select="OPERATOR_CALL/LD_INTRASTATE_CALLS_TOTAL">
					
						<fo:block space-after="0.5mm"/>
						
						<fo:table>
							<fo:table-column column-width="12mm" />
							<fo:table-column column-width="16mm" />
							<fo:table-column column-width="20mm" />
							<fo:table-column column-width="30mm" />
							<fo:table-column column-width="30mm" />
							<fo:table-column column-width="32mm" />
							<fo:table-column column-width="26mm" />
							<fo:table-column column-width="26mm" />
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell number-columns-spanned="5">
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold"
											text-align="left">
											Pacote de Ligações Longa Distância - <xsl:value-of select="@ServicePlan"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold"
											text-align="right">
											Subtotal:
										</fo:block>
									</fo:table-cell>
									<fo:table-cell >
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
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
											font-size="7px"
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
											Destino / UF
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
											Tarifa
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold">
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
								
								<xsl:for-each select="LD_INTRASTATE_CALLS_DETAIL">
								
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
												<xsl:value-of select="@CarrierState" />
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
												<xsl:call-template name="FORMAT-TARIFF">
													<xsl:with-param name="tarifa" select="@Tariff" />
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block 
												font-family="Helvetica" 
												font-size="7px">
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
				<!-- fim verifica chamadas longa distancia dentro -->
			
			
			
				<!-- veririfca chamadas longa distancia outros estados -->
				<xsl:if test="$verificaLongaOutrosEstados != 0">
					<fo:block space-after="2mm"/>

					<fo:block
					font-family="Helvetica"
					font-size="8px"
					font-weight="bold"
					border-bottom-style="solid"
					border-width="0.5px">
						Chamadas de Longa Distância para Outros Estados
					</fo:block>
				
					<xsl:for-each select="OPERATOR_CALL/LD_INTERSTATE_CALLS_TOTAL">
					
						<fo:block space-after="0.5mm"/>
						
						<fo:table>
							<fo:table-column column-width="12mm" />
							<fo:table-column column-width="16mm" />
							<fo:table-column column-width="20mm" />
							<fo:table-column column-width="30mm" />
							<fo:table-column column-width="30mm" />
							<fo:table-column column-width="32mm" />
							<fo:table-column column-width="26mm" />
							<fo:table-column column-width="26mm" />
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell number-columns-spanned="5">
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold"
											text-align="left">
											Pacote de Ligações Longa Distância - <xsl:value-of select="@ServicePlan"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold"
											text-align="right">
											Subtotal:
										</fo:block>
									</fo:table-cell>
									<fo:table-cell >
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
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
											font-size="7px"
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
											Destino / UF
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
											Tarifa
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold">
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
								
								<xsl:for-each select="LD_INTERSTATE_CALLS_DETAIL">
								
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
												<xsl:value-of select="@CarrierState" />
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
												<xsl:call-template name="FORMAT-TARIFF">
													<xsl:with-param name="tarifa" select="@Tariff" />
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block 
												font-family="Helvetica" 
												font-size="7px">
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
				<!-- fim verifica chamadas longa distancia outros estados -->
			
			
				<!-- veririfca chamadas cobrar exceto locais -->
				<xsl:if test="$verificaCobrarExcetoLocais != 0" >
				
				
					<fo:block space-after="2mm"/>

					<fo:block
					font-family="Helvetica"
					font-size="8px"
					font-weight="bold"
					border-bottom-style="solid"
					border-width="0.5px">
						Chamadas Recebidas a Cobrar - Exceto Locais
					</fo:block>
				
					<xsl:for-each select="OPERATOR_CALL/COLLECT_CALLS_TOTAL">
					
						<fo:block space-after="0.5mm"/>
						
						<fo:table>
							<fo:table-column column-width="12mm" />
							<fo:table-column column-width="16mm" />
							<fo:table-column column-width="20mm" />
							<fo:table-column column-width="20mm" />
							<fo:table-column column-width="20mm" />
							<fo:table-column column-width="42mm" />
							<fo:table-column column-width="22mm" />
							<fo:table-column column-width="20mm" />
							<fo:table-column column-width="20mm" />
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell number-columns-spanned="6">
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold"
											text-align="left">
											
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold"
											text-align="right">
											Subtotal:
										</fo:block>
									</fo:table-cell>
									<fo:table-cell >
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
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
											font-size="7px"
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
											Origem / UF
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
											font-weight="bold">
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
								
								<xsl:for-each select="COLLECT_CALLS_DETAIL">
								
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
												<xsl:value-of select="@originState" />
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
												font-size="7px">
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
				<!-- fim chamadas cobrar exceto locais -->
			
				
				
				<!-- veririfca chamadas longa distancia internacionais -->
				<xsl:if test="$verificaLongaInternacionais != 0">
					<fo:block space-after="2mm"/>

					<fo:block
					font-family="Helvetica"
					font-size="8px"
					font-weight="bold"
					border-bottom-style="solid"
					border-width="0.5px">
						Chamadas de Longa Distância Efetuadas Internacionais
					</fo:block>
				
					<xsl:for-each select="OPERATOR_CALL/INTERNATIONAL_CALLS_TOTAL">
					
						<fo:block space-after="0.5mm"/>
						
						<fo:table>
							<fo:table-column column-width="12mm" />
							<fo:table-column column-width="16mm" />
							<fo:table-column column-width="20mm" />
							<fo:table-column column-width="40mm" />
							<fo:table-column column-width="30mm" />
							<fo:table-column column-width="22mm" />
							<fo:table-column column-width="26mm" />
							<fo:table-column column-width="26mm" />
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell number-columns-spanned="5">
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold"
											text-align="left">
											
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold"
											text-align="right">
											Subtotal:
										</fo:block>
									</fo:table-cell>
									<fo:table-cell >
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
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
											font-size="7px"
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
											Núm. Chamado
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
											font-weight="bold">
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
								
								<xsl:for-each select="INTERNATIONAL_CALLS_DETAIL">
								
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
												<xsl:call-template name="FORMAT-TARIFF">
													<xsl:with-param name="tarifa" select="@Tariff" />
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block 
												font-family="Helvetica" 
												font-size="7px">
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
				<!-- fim verifica chamadas longa distancia internacionais -->

			</xsl:if>
			<!--  fim verifica total chamadas dentro da area de registro -->
			
			
			
			<!-- verifica total  chamdas fora area de registro -->
			<xsl:if test="$foraRegistroTotal != 0">
			
				<fo:block space-after="2mm"/>
				
				<fo:block
				font-family="Helvetica"
				font-size="9px"
				font-weight="bold"
				border-bottom-style="solid"
				border-width="0.5px">
					Chamadas Fora da Área de Registro
				</fo:block>
				
				<!-- veririfca fora longa originada -->
				<xsl:if test="$verificaForaLongaO != 0">
					<fo:block space-after="2mm"/>

					<fo:block
					font-family="Helvetica"
					font-size="8px"
					font-weight="bold"
					border-bottom-style="solid"
					border-width="0.5px">
						Chamadas de Longa Distância Originadas
					</fo:block>
				
					<xsl:for-each select="OPERATOR_CALL/ROAM_MOC_LD_TOTAL">
					
						<fo:block space-after="0.5mm"/>
						
						<fo:table>
							<fo:table-column column-width="12mm" />
							<fo:table-column column-width="16mm" />
							<fo:table-column column-width="20mm" />
							<fo:table-column column-width="40mm" />
							<fo:table-column column-width="30mm" />
							<fo:table-column column-width="22mm" />
							<fo:table-column column-width="26mm" />
							<fo:table-column column-width="26mm" />
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell number-columns-spanned="5">
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold"
											text-align="left">
											Operadora: <xsl:value-of select="@ServicePlan" />
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold"
											text-align="right">
											Subtotal:
										</fo:block>
									</fo:table-cell>
									<fo:table-cell >
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
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
											font-size="7px"
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
											Núm. Chamado
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
											font-weight="bold">
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
								
								<xsl:for-each select="ROAM_MOC_LD_DETAIL">
								
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
												<xsl:value-of select="@NumberCalled" />
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
												font-size="7px">
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
				<!-- fim verifica fora longa originada -->
				
				
				<!-- veririfca fora longa recebidas -->
				<xsl:if test="$verificaForaLongaR != 0">
					<fo:block space-after="2mm"/>

					<fo:block
					font-family="Helvetica"
					font-size="8px"
					font-weight="bold"
					border-bottom-style="solid"
					border-width="0.5px">
						Chamadas de Longa Distância Recebidas
					</fo:block>
				
					<xsl:for-each select="OPERATOR_CALL/ROAM_MTC_LD_TOTAL">
					
						<fo:block space-after="0.5mm"/>
						
						<fo:table>
							<fo:table-column column-width="12mm" />
							<fo:table-column column-width="16mm" />
							<fo:table-column column-width="20mm" />
							<fo:table-column column-width="30mm" />
							<fo:table-column column-width="28mm" />
							<fo:table-column column-width="35mm" />
							<fo:table-column column-width="17mm" />
							<fo:table-column column-width="17mm" />
							<fo:table-column column-width="17mm" />
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell number-columns-spanned="6">
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold"
											text-align="left">
											Operadora: <xsl:value-of select="@ServicePlan" />
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold"
											text-align="right">
											Subtotal:
										</fo:block>
									</fo:table-cell>
									<fo:table-cell >
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
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
											font-size="7px"
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
											font-weight="bold">
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
								
								<xsl:for-each select="ROAM_MTC_LD_DETAIL">
								
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
												font-size="7px">
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
				<!-- fim verifica fora longa recebida -->
				
				
				<!-- veririfca fora longa internacionais -->
				<xsl:if test="$verificaForaLongaE !=0 ">
					<fo:block space-after="2mm"/>

					<fo:block
					font-family="Helvetica"
					font-size="8px"
					font-weight="bold"
					border-bottom-style="solid"
					border-width="0.5px">
						Chamadas de Longa Distância Efetuadas Internacionais
					</fo:block>
				
					<xsl:for-each select="OPERATOR_CALL/ROAM_MOC_INTERNATIONAL_TOTAL">
					
						<fo:block space-after="0.5mm"/>
						
						<fo:table>
							<fo:table-column column-width="12mm" />
							<fo:table-column column-width="16mm" />
							<fo:table-column column-width="20mm" />
							<fo:table-column column-width="40mm" />
							<fo:table-column column-width="30mm" />
							<fo:table-column column-width="22mm" />
							<fo:table-column column-width="26mm" />
							<fo:table-column column-width="26mm" />
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell number-columns-spanned="5">
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold"
											text-align="left">
											Operadora: <xsl:value-of select="@ServicePlan" />
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
											font-weight="bold"
											text-align="right">
											Subtotal:
										</fo:block>
									</fo:table-cell>
									<fo:table-cell >
										<fo:block 
											font-family="Helvetica" 
											font-size="7px"
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
											font-size="7px"
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
											Núm. Chamado
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
											font-weight="bold">
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
								
								<xsl:for-each select="ROAM_MOC_INTERNATIONAL_DETAIL">
								
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
												<xsl:call-template name="FORMAT-TARIFF">
													<xsl:with-param name="tarifa" select="@Tariff" />
												</xsl:call-template>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block 
												font-family="Helvetica" 
												font-size="7px">
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
				<!-- fim verifica fora longa internacionais -->
						
			</xsl:if>	
			<!-- fim verifica total chamadas fora area de registro -->
	
		</xsl:if>
		<!--  fim verificacao do total de longa distancia -->

		
		
		
		
		
		<fo:block space-after="2mm"/>
		<fo:block
		font-family="Helvetica"
		font-size="9px"
		border-bottom-style="solid"
		border-width="0.5px">
			<fo:table>
				<fo:table-column column-width="97mm" />
				<fo:table-column column-width="97mm" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block font-weight="bold">
								TOTAL DO DETALHAMENTO DE LONGA DINSTÂNCIA
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-align="right">
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
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
		
		
		
		
		<fo:block space-after="2mm"/>
		<fo:block
		font-family="Helvetica"
		font-size="9px"
		border-bottom-style="solid"
		border-width="0.5px">
			<fo:table>
				<fo:table-column column-width="97mm" />
				<fo:table-column column-width="97mm" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block font-weight="bold">
								TOTAL DO CELULAR:&#160;<xsl:value-of select="@PhoneNumber"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-align="right">
								R$&#160;
								<xsl:call-template name="FORMAT-DOUBLE">
									<xsl:with-param name="number" select="ENTIRE_SUBSCRIPTION_TOTAL/@SubscriptionAmount"/>
								</xsl:call-template>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
		
		
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
