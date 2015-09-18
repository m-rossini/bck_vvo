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
  
  <xsl:template name="Session5">
  
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
						Página 0000005/0000006
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
		
		<!-- verifica numeros especificos -->
		<xsl:if test="$verificaNumerosEspecificos != 0">
			<fo:block space-after="2mm"/>
			<fo:block
			font-family="Helvetica"
			font-size="9px"
			font-weight="bold"
			border-bottom-style="solid"
			border-width="0.5px">
				Chamadas a Serviços de Números Específicos
			</fo:block>
			
			<fo:block space-after="0.5mm"/>
			<xsl:for-each select="OPERATOR_CALL/VAS_TOTAL">
				<fo:table>
					<fo:table-column column-width="12mm" />
					<fo:table-column column-width="16mm" />
					<fo:table-column column-width="20mm" />
					<fo:table-column column-width="43mm" />
					<fo:table-column column-width="31mm" />
					<fo:table-column column-width="35mm" />
					<fo:table-column column-width="35mm" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell number-columns-spanned="4">
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="left">
									
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
									Descrição
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Número Chamado
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
						
						<xsl:for-each select="VAS_DETAIL">
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
		<!--  fim numeros especificos -->

		
		<!-- chamadas numeros 0500 -->
		<xsl:if test="$verificaNumeros0500 != 0" >
			
			<fo:block space-after="2mm"/>
			
			<fo:block
			font-family="Helvetica"
			font-size="9px"
			font-weight="bold"
			border-bottom-style="solid"
			border-width="0.5px">
				Chamadas para Números - 0500
			</fo:block>
			
			<fo:block space-after="0.5mm"/>
			
			<xsl:for-each select="OPERATOR_CALL/Calls0500Total">
				
				<fo:table>
					<fo:table-column column-width="12mm" />
					<fo:table-column column-width="16mm" />
					<fo:table-column column-width="20mm" />
					<fo:table-column column-width="43mm" />
					<fo:table-column column-width="31mm" />
					<fo:table-column column-width="35mm" />
					<fo:table-column column-width="35mm" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell number-columns-spanned="4">
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="left">
									
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
									Descrição
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Número Chamado
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
						
						<xsl:for-each select="Calls0500Detail">
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
		<!-- fim chamadas 0500 -->
		
		
		
		<!-- servicos prestados por terceiros -->
		<xsl:if test="$verificaServicosTerceiros != 0">
			
			<fo:block space-after="2mm"/>
			
			<fo:block
			font-family="Helvetica"
			font-size="9px"
			font-weight="bold"
			border-bottom-style="solid"
			border-width="0.5px">
				Serviços Prestados por Terceiros
			</fo:block>
			
			<fo:block space-after="0.5mm"/>
			
			<xsl:for-each select="OPERATOR_CALL/PARTY_3RD_TOTAL">
				
				<fo:table>
					<fo:table-column column-width="12mm" />
					<fo:table-column column-width="16mm" />
					<fo:table-column column-width="20mm" />
					<fo:table-column column-width="43mm" />
					<fo:table-column column-width="31mm" />
					<fo:table-column column-width="35mm" />
					<fo:table-column column-width="35mm" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell number-columns-spanned="4">
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold"
									text-align="left">
									
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
									Descrição
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									font-weight="bold">
									Número Chamado
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
						
						<xsl:for-each select="PARTY_3RD_DETAIL">
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
										<xsl:value-of select="@ServicePlan" />
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
		
		<!-- fim servicos prestados por terceiros-->
		
		
		<!--  verifica servicos de dados totais -->
		<xsl:if test="$verificaSomaServicosDados != 0 ">

			<fo:block space-after="2mm"/>
			
			<fo:block
			font-family="Helvetica"
			font-size="9px"
			font-weight="bold"
			border-bottom-style="solid"
			border-width="0.5px">
				Utilização de Serviços de Dados
			</fo:block>
			
			
			<!-- torpedos -->
			<xsl:if test="$verificaTorpedos != 0">
				
				<fo:block space-after="2mm"/>
				
				<fo:block
				font-family="Helvetica"
				font-size="8px"
				font-weight="bold"
				border-bottom-style="solid"
				border-width="0.5px">
					Torpedos
				</fo:block>
				
				<fo:block space-after="0.5mm"/>
					
					<fo:table>
						<fo:table-column column-width="12mm" />
						<fo:table-column column-width="16mm" />
						<fo:table-column column-width="20mm" />
						<fo:table-column column-width="46mm" />
						<fo:table-column column-width="24mm" />
						<fo:table-column column-width="46mm" />
						<fo:table-column column-width="14mm" />
						<fo:table-column column-width="14mm" />
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell number-columns-spanned="5">
									<fo:block 
										font-family="Helvetica" 
										font-size="8px"
										font-weight="bold"
										text-align="left">
										
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
										<xsl:variable name="valorMonetarioVariavel6"
											select="sum(OPERATOR_CALL/SMS_TOTAL/@Subtotal)"/>
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
										Núm. Chamado
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="8px"
										font-weight="bold">
										Serviço
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="8px"
										font-weight="bold">
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
							
							<xsl:for-each select="OPERATOR_CALL/SMS_TOTAL/SMS_DETAIL">
							
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
											<xsl:value-of select="@UnitDescription" />
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
		
			</xsl:if>
			<!-- fim torpedos -->
			
			
			
			<!-- tons e imagens -->
			<xsl:if test="verificaTonsImagens != 0 ">
				
				<fo:block space-after="2mm"/>
				
				<fo:block
				font-family="Helvetica"
				font-size="8px"
				font-weight="bold"
				border-bottom-style="solid"
				border-width="0.5px">
					Tons e Imagens
				</fo:block>
				
				<xsl:for-each select="OPERATOR_CALL/TonesAndImagesTotal">
				
				<fo:block space-after="0.5mm"/>
					
					<fo:table>
						<fo:table-column column-width="12mm" />
						<fo:table-column column-width="16mm" />
						<fo:table-column column-width="20mm" />
						<fo:table-column column-width="46mm" />
						<fo:table-column column-width="46mm" />
						<fo:table-column column-width="24mm" />
						<fo:table-column column-width="14mm" />
						<fo:table-column column-width="14mm" />
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell number-columns-spanned="5">
									<fo:block 
										font-family="Helvetica" 
										font-size="8px"
										font-weight="bold"
										text-align="left">
										
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
										Serviço
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
										font-weight="bold">
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
							
							<xsl:for-each select="TonesAndImagesDetail">
							
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
											<xsl:call-template name="FORMAT-HMS">
												<xsl:with-param name="number" select="@Duration" />
											</xsl:call-template>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px">
											<xsl:value-of select="@UnitDescription" />
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
			<!-- fim tons e imagens -->
			
			
			<!-- jogos e aplicacoes -->
			<xsl:if test="$verificaJogosAplicacoes != 0" >
				
				<fo:block space-after="2mm"/>
				
				<fo:block
				font-family="Helvetica"
				font-size="8px"
				font-weight="bold"
				border-bottom-style="solid"
				border-width="0.5px">
					Jogos e Aplicações
				</fo:block>
				
				<xsl:for-each select="OPERATOR_CALL/GamesAndApplicationsTotal">
				
				<fo:block space-after="0.5mm"/>
					
					<fo:table>
						<fo:table-column column-width="12mm" />
						<fo:table-column column-width="16mm" />
						<fo:table-column column-width="20mm" />
						<fo:table-column column-width="46mm" />
						<fo:table-column column-width="46mm" />
						<fo:table-column column-width="24mm" />
						<fo:table-column column-width="14mm" />
						<fo:table-column column-width="14mm" />
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell number-columns-spanned="5">
									<fo:block 
										font-family="Helvetica" 
										font-size="8px"
										font-weight="bold"
										text-align="left">
										
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
										Serviço
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
										font-weight="bold">
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
							
							<xsl:for-each select="GamesAndApplicationsDetail">
							
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
											<xsl:call-template name="FORMAT-HMS">
												<xsl:with-param name="number" select="@Duration" />
											</xsl:call-template>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px">
											<xsl:value-of select="@UnitDescription" />
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
			<!-- fim jogos e aplicacoes -->
			
			
			
			<!-- wap -->
			<xsl:if test="$verificaWap != 0" >
				
				<fo:block space-after="2mm"/>
				
				<fo:block
				font-family="Helvetica"
				font-size="8px"
				font-weight="bold"
				border-bottom-style="solid"
				border-width="0.5px">
					Vivo Wap
				</fo:block>
				
				<xsl:for-each select="OPERATOR_CALL/WAPTotal">
				
				<fo:block space-after="0.5mm"/>
					
					<fo:table>
						<fo:table-column column-width="12mm" />
						<fo:table-column column-width="16mm" />
						<fo:table-column column-width="20mm" />
						<fo:table-column column-width="46mm" />
						<fo:table-column column-width="46mm" />
						<fo:table-column column-width="24mm" />
						<fo:table-column column-width="14mm" />
						<fo:table-column column-width="14mm" />
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell number-columns-spanned="5">
									<fo:block 
										font-family="Helvetica" 
										font-size="8px"
										font-weight="bold"
										text-align="left">
										
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
										Serviço
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
										font-weight="bold">
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
							
							<xsl:for-each select="WAPDetail">
							
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
											<xsl:value-of select="@ServicePlan" />
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
											font-size="7px">
											<xsl:value-of select="@UnitDescription" />
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
			<!-- fim wap -->
			
			
			
			<!-- vivo play -->
			<xsl:if test="$verificaVivoPlay != 0">
				
				<fo:block space-after="2mm"/>
				
				<fo:block
				font-family="Helvetica"
				font-size="8px"
				font-weight="bold"
				border-bottom-style="solid"
				border-width="0.5px">
					Vivo Play
				</fo:block>
				
				<xsl:for-each select="OPERATOR_CALL/PlayTotal">
				
				<fo:block space-after="0.5mm"/>
					
					<fo:table>
						<fo:table-column column-width="12mm" />
						<fo:table-column column-width="16mm" />
						<fo:table-column column-width="20mm" />
						<fo:table-column column-width="46mm" />
						<fo:table-column column-width="46mm" />
						<fo:table-column column-width="24mm" />
						<fo:table-column column-width="14mm" />
						<fo:table-column column-width="14mm" />
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell number-columns-spanned="5">
									<fo:block 
										font-family="Helvetica" 
										font-size="8px"
										font-weight="bold"
										text-align="left">
										
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
										Serviço
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
										font-weight="bold">
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
							
							<xsl:for-each select="PlayDetail">
							
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
											<xsl:value-of select="@NumberCalled" />
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px">
											<xsl:value-of select="@captionPhrase" />
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
											font-size="7px">
											<xsl:value-of select="@UnitDescription" />
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
			<!-- fim vivo play -->
			
			
			
			<!-- vivo zap -->
			<xsl:if test="$verificaVivoZap != 0">
				
				<fo:block space-after="2mm"/>
				
				<fo:block
				font-family="Helvetica"
				font-size="8px"
				font-weight="bold"
				border-bottom-style="solid"
				border-width="0.5px">
					Vivo Zap
				</fo:block>
				
				<xsl:for-each select="OPERATOR_CALL/ZAPTotal">
				
				<fo:block space-after="0.5mm"/>
					
					<fo:table>
						<fo:table-column column-width="12mm" />
						<fo:table-column column-width="16mm" />
						<fo:table-column column-width="20mm" />
						<fo:table-column column-width="46mm" />
						<fo:table-column column-width="46mm" />
						<fo:table-column column-width="24mm" />
						<fo:table-column column-width="14mm" />
						<fo:table-column column-width="14mm" />
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell number-columns-spanned="5">
									<fo:block 
										font-family="Helvetica" 
										font-size="8px"
										font-weight="bold"
										text-align="left">
										
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
										Serviço
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
										font-weight="bold">
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
							
							<xsl:for-each select="ZAPDetail">
							
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
											<xsl:value-of select="@NumberCalled" />
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block 
											font-family="Helvetica" 
											font-size="7px">
											<xsl:value-of select="@captionPhrase" />
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
											font-size="7px">
											<xsl:value-of select="@UnitDescription" />
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
			<!-- fim vivo zap -->

		</xsl:if>
		<!-- fim de dados totais -->
		
		
		<!--  verifica total outros servicos voz -->
		<xsl:if test="$verificaOutrosVoz != 0">
		
			<fo:block space-after="2mm"/>
			
			<fo:block
			font-family="Helvetica"
			font-size="9px"
			font-weight="bold"
			border-bottom-style="solid"
			border-width="0.5px">
				Utilização de Outros Serviços de Voz
			</fo:block>
			
			<!-- servico de voz -->
				<fo:block space-after="2mm"/>
				
				<fo:block
				font-family="Helvetica"
				font-size="8px"
				font-weight="bold"
				border-bottom-style="solid"
				border-width="0.5px">
					Serviço de Voz
				</fo:block>
				
				<fo:block space-after="0.5mm"/>
					
					<fo:table>
						<fo:table-column column-width="12mm" />
						<fo:table-column column-width="16mm" />
						<fo:table-column column-width="20mm" />
						<fo:table-column column-width="46mm" />
						<fo:table-column column-width="46mm" />
						<fo:table-column column-width="26mm" />
						<fo:table-column column-width="26mm" />
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell number-columns-spanned="4">
									<fo:block 
										font-family="Helvetica" 
										font-size="8px"
										font-weight="bold"
										text-align="left">
										
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
										<xsl:variable name="valorMonetarioVariavel6"
											select="sum(OPERATOR_CALL/VoiceServicesTotal/@Subtotal)"/>
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
										Descrição
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="8px"
										font-weight="bold">
										Número Chamado
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block 
										font-family="Helvetica" 
										font-size="8px"
										font-weight="bold">
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
							
							<xsl:for-each select="OPERATOR_CALL/VoiceServicesTotal/VoiceServicesDetail">
							
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
			<!-- fim servico de voz -->
			
			
		</xsl:if>
		<!-- fim verifica total outros voz -->
		
		
	<!-- fo:block break-after="page" / -->
	<!-- fim do terminal -->
	</xsl:if>
	</xsl:for-each>	
	



	<!-- inclusao para somatoria em correcao de producao -->



	<!-- subtrair do total o valor equivalente ao detalhamento da proxima sessao -->

	<xsl:variable name="totalDetalhamento" select="$context/@TotalDueAmount" />



	<!-- soma das chamadas de longa distancia 535T, 540T, 570T, 575T, 545T, 550T, 580T (conferido)-->
	<!-- a soma informada eh referente a proxima sessao -->
	<xsl:variable name="valorMonetarioVariavel12_0"
		select="sum($subscription/OPERATOR_CALL/LD_INTRASTATE_CALLS_TOTAL/@Subtotal)"/>
	<xsl:variable name="valorMonetarioVariavel12_1"
		select="sum($subscription/OPERATOR_CALL/LD_INTERSTATE_CALLS_TOTAL/@Subtotal)"/>
	<xsl:variable name="valorMonetarioVariavel12_2"
		select="sum($subscription/OPERATOR_CALL/ROAM_MOC_LD_TOTAL/@Subtotal)"/>
	<xsl:variable name="valorMonetarioVariavel12_3"
		select="sum($subscription/OPERATOR_CALL/ROAM_MTC_LD_TOTAL/@Subtotal)"/>
	<xsl:variable name="valorMonetarioVariavel12_4"
		select="sum($subscription/OPERATOR_CALL/COLLECT_CALLS_TOTAL/@Subtotal)"/>
	<xsl:variable name="valorMonetarioVariavel12_5"
		select="sum($subscription/OPERATOR_CALL/INTERNATIONAL_CALLS_TOTAL/@Subtotal)"/>
	<xsl:variable name="valorMonetarioVariavel12_6"
		select="sum($subscription/OPERATOR_CALL/ROAM_MOC_INTERNATIONAL_TOTAL/@Subtotal)"/>
	<xsl:variable name="totalDetalhamentoProximo"
		select="$valorMonetarioVariavel12_0 + $valorMonetarioVariavel12_1 + $valorMonetarioVariavel12_2 + $valorMonetarioVariavel12_3 + $valorMonetarioVariavel12_4 + $valorMonetarioVariavel12_5 + $valorMonetarioVariavel12_6"/>


	<xsl:variable name="totalDetalhamentoAplicado" select="$totalDetalhamento - $totalDetalhamentoProximo" />


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
								TOTAL DO DETALHAMENTO - VIVO S.A. 
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-align="right">
								R$ 
								<xsl:call-template name="FORMAT-DOUBLE">
									<xsl:with-param name="number" select="$totalDetalhamentoAplicado"/>
								</xsl:call-template>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>



	<!-- inclusao para somatoria em correcao de producao -->






	
	</fo:flow>

</fo:page-sequence>
</fo:root>
    
    

</xsl:template>   

	
	
<!-- Account number being processed -->

	

</xsl:stylesheet>
