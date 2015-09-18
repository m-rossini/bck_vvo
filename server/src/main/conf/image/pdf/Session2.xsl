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
  
  <xsl:template name="Session2">
  
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
	
	<fo:root>
      <fo:layout-master-set>
        <fo:simple-page-master master-name="A4-portrait" page-height="29.7cm" page-width="21.0cm" margin="8mm">
          <fo:region-body/>
        </fo:simple-page-master>
      </fo:layout-master-set>
      
      <fo:page-sequence master-reference="A4-portrait">

	
	<fo:flow flow-name="xsl-region-body" space-before="100mm">
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
						Número da Conta:<xsl:value-of select="$accountNumber"/>
					</fo:block>
					<fo:block padding-after="5mm">
						Nome: <xsl:value-of select="$context/BILLING_ADDRESS/@AddressLine1"/>
					</fo:block>
					<fo:block  font-weight="bold" font-size="8pt" text-align="right">
						Página 0000002/0000006
					</fo:block>
				  </fo:block>
			    </fo:table-cell>
			  </fo:table-row>
			</fo:table-body>
		</fo:table>
	
		
		<fo:block space-after="1.5mm"/>
		
		
		<!-- 2.2.4	Grupo e Subgrupo  -->
		
		<!--  verifica se o grupo existe para exibir o titulo -->
		<xsl:if test="$verificaGrupoSubgrupo = '255Z'">
		
			<fo:block font-family="Helvetica" font-size="9px" font-weight="bold">
			DEMONSTRATIVO DO PLANO
			</fo:block>
			
			<fo:block space-after="1mm"/>
			
			<fo:block font-family="Helvetica" 
			font-size="8px" 
			border-bottom-style="solid" 
			border-width="0.5px">
				<fo:inline  font-weight="bold">
					Grupo:
				</fo:inline>
				<fo:inline>
					<xsl:value-of select="$context/DUMMY_INVOICE_SUMMARY/FATURA_CORPORATIVA_GRUPO_TOTAL/@GroupName" />
				</fo:inline>
			</fo:block>
			
			<fo:block space-after="1mm"/>
		
			<fo:table>
				<fo:table-column column-width="96mm" />
				<fo:table-column column-width="98mm" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block font-family="Helvetica" 
									  font-size="8px"
									  text-align="left">
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block font-family="Helvetica" 
									  font-size="8px"
									  text-align="right">
								<fo:inline font-weight="bold">
								Subtotal: 
								</fo:inline>
								<fo:inline>
									<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="$context/DUMMY_INVOICE_SUMMARY/FATURA_CORPORATIVA_GRUPO_TOTAL/@Amount" />
									</xsl:call-template>
								</fo:inline>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell>
							<fo:block font-family="Helvetica" 
									  font-size="8px"
									  text-align="left"
									  font-weight="bold">
								Plano
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block font-family="Helvetica" 
									  font-size="8px"
									  text-align="right"
									  font-weight="bold">
								Quantidade de celulares 
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell>
							<fo:block font-family="Helvetica" 
									  font-size="8px"
									  text-align="left">
								<xsl:value-of select="$context/DUMMY_INVOICE_SUMMARY/FATURA_CORPORATIVA_GRUPO_TOTAL/FATURA_CORPORATIVA_GRUPO_DETAIL/@ServicePlan" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block font-family="Helvetica" 
									  font-size="8px"
									  text-align="right">
								<xsl:value-of select="$context/DUMMY_INVOICE_SUMMARY/FATURA_CORPORATIVA_GRUPO_TOTAL/FATURA_CORPORATIVA_GRUPO_DETAIL/@QtdeCelulares" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		
			<fo:block space-after="1mm"/>
			
			<fo:table>
				<fo:table-column column-width="5mm" />
				<fo:table-column column-width="47mm" />
				<fo:table-column column-width="47mm" />
				<fo:table-column column-width="47mm" />
				<fo:table-column column-width="48mm" />
				<fo:table-body>
					
					<fo:table-row>
						<fo:table-cell><fo:block/></fo:table-cell>
						<fo:table-cell number-columns-spanned="4">
							<fo:block
								border-bottom-style="solid"
								border-width="0.5px"
								font-family="Helvetica"
								font-size="8px">
								<fo:inline font-weight="bold">
									Subgrupo:
								</fo:inline>
								<fo:inline>
									<xsl:value-of select="$context/DUMMY_INVOICE_SUMMARY/FATURA_CORPORATIVA_GRUPO_TOTAL/FATURA_CORPORATIVA_SUBGRUPO_TOTAL/@GroupName" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					
					<fo:table-row>
						<fo:table-cell><fo:block/></fo:table-cell>
						<fo:table-cell number-columns-spanned="4">
							<fo:block
								font-family="Helvetica"
								font-size="8px"
								text-align="right">
								<fo:inline font-weight="bold">
									Subtotal: 
								</fo:inline>
								<fo:inline>
									<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="$context/DUMMY_INVOICE_SUMMARY/FATURA_CORPORATIVA_GRUPO_TOTAL/FATURA_CORPORATIVA_SUBGRUPO_TOTAL/@Amount" />
									</xsl:call-template>
								</fo:inline>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					
					<fo:table-row>
						<fo:table-cell><fo:block/></fo:table-cell>
						<fo:table-cell>
							<fo:block
								font-family="Helvetica"
								font-size="8px"
								font-weight="bold">
								Número do Celular
							</fo:block>
						</fo:table-cell>
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
					
					<xsl:for-each select="$context/DUMMY_INVOICE_SUMMARY/FATURA_CORPORATIVA_GRUPO_TOTAL/FATURA_CORPORATIVA_SUBGRUPO_TOTAL/FATURA_CORPORATIVA_SUBGRUPO_DETAIL">
						<fo:table-row>
							<fo:table-cell><fo:block/></fo:table-cell>
							<fo:table-cell>
								<fo:block
									font-family="Helvetica"
									font-size="8px">
									<xsl:value-of select="@Subscription" />
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block
									font-family="Helvetica"
									font-size="8px">
									<xsl:value-of select="@ServicePlan" />
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block
									font-family="Helvetica"
									font-size="8px"
									text-align="center">
									<xsl:value-of select="vivo:DateFormat.formatDDMMYYYY(@DateStart)"/>
										a
									<xsl:value-of select="vivo:DateFormat.formatDDMMYYYY(@DateEnd)"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block
									font-family="Helvetica"
									font-size="8px"
									text-align="right">
									<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="@Amount" />
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:for-each>
				</fo:table-body>
			</fo:table>

		</xsl:if>
		
		<!--  FIM 2.2.4	Grupo e Subgrupo  -->

		<!--compartilhamento de franquia -->
		<xsl:for-each select="$context/DUMMY_INVOICE_SUMMARY/COMPARTILHAMENTO_FRANQUIA_TOTAL">
			<fo:block space-after="2mm"/>
			<fo:block 
				font-family="Helvetica" 
				font-size="9px" 
				font-weight="bold"
				border-bottom-style="solid"
				border-width="0.5px">
			COMPARTILHAMENTO DE FRANQUIA
			</fo:block>
			<fo:block
				font-family="Helvetica" 
				font-size="8px" >
				Descrição do compartilhamento: <xsl:value-of select="@shareName" />
			</fo:block>
			<fo:block space-after="1mm"/>
			<fo:table>
				<fo:table-column column-width="97mm"/>
				<fo:table-column column-width="97mm"/>
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell number-columns-spanned="2">
							<fo:block 
								font-family="Helvetica" 
								font-size="8px" 
								font-weight="bold"
								text-align="right">
									Subtotal: <xsl:value-of select="@usedMinutes"/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell>
							<fo:block 
								font-family="Helvetica" 
								font-size="8px">
									Número do celular
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block 
								font-family="Helvetica" 
								font-size="8px" 
								font-weight="bold"
								text-align="right">
									Minutos utilizados
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<xsl:for-each select="COMPARTILHAMENTO_FRANQUIA_DETAIL">
						<fo:table-row>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px" >
										<xsl:value-of select="@accessNumber"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									text-align="right">
										<xsl:value-of select="@usedShare"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:for-each>
				</fo:table-body>
			</fo:table>
		</xsl:for-each>
		
		<!--  fim do compartilhamento de franquia  -->
		<fo:block space-after="2mm"/>
		<!--  demonstrativo dos lancamentos diversos -->
		<fo:block 
			font-family="Helvetica" 
			font-size="9px" 
			font-weight="bold">
			DEMONSTRATIVO DOS LANÇAMENTOS DIVERSOS
		</fo:block>
		
		
		<!-- juros e multas 265T -->
		<xsl:for-each select="$context/DUMMY_INVOICE_SUMMARY/MULTAS_JUROS_TOTAL">
		<fo:block space-after="2mm"/>
			<fo:block 
				font-family="Helvetica" 
				font-size="8px" 
				font-weight="bold"
				border-bottom-style="solid"
				border-width="0.5px">
				JUROS E MULTAS
			</fo:block>
			<fo:block space-after="0.5mm"/>
			<fo:table>
				<fo:table-column column-width="64mm" />
				<fo:table-column column-width="65mm" />
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
								<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="@Amount"/>
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
								Referência
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
					
					<xsl:for-each select="MULTAS_JUROS_DETAIL">
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
									<xsl:value-of select="vivo:DateFormat.formatMMYYYY(@DataElemento)"/>
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
		</xsl:for-each>
		<!-- fim juros e multas -->
		
		<!-- descontos 270T 340T 401T -->
			<!--  verifica descontos 3 ifs 270 340 and 401 -->
			<xsl:if test="concat($context/DUMMY_INVOICE_SUMMARY/DISCOUNT_TOTAL/@key,
			 $subscription/PROMOTIONS_TOTAL/@key,
			 $subscription/OPERATOR_CALL/DiscountsTotal/@key) != ''">
			 
			 <fo:block space-after="2mm"/>
			 
			<fo:block 
				font-family="Helvetica" 
				font-size="8px" 
				font-weight="bold"
				border-bottom-style="solid"
				border-width="0.5px">
				DESCONTOS
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
					<xsl:for-each select="$context/DUMMY_INVOICE_SUMMARY/DISCOUNT_TOTAL/DISCOUNT_DETAIL">
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
					<xsl:for-each select="$subscription/PROMOTIONS_TOTAL/PROMOTIONS_DETAIL">
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
					<xsl:for-each select="$subscription/OPERATOR_CALL/DiscountsTotal/DiscountsDetail">
						<fo:table-row>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px">
									<xsl:value-of select="@captionPhrase"/>
								</fo:block>
							</fo:table-cell>
								<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
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
		</xsl:if>
		<!-- fim descontos -->
		
		
		<!-- debitos diversos 320T 600T 010D(232) 010D(218) -->
		<!--  verificacao dos debitos diversos -->
		<xsl:if test="(sum($subscription/ENTIRE_SUBSCRIPTION_TOTAL/SUBSCRIPTION_SRV_CHARGE_TOTAL/@ServiceChargeAmt) + sum($subscription/OPERATOR_CALL/PARTY_3RD_TOTAL/@Subtotal)) != 0" >
			
			<fo:block space-after="2mm"/>
			
			<fo:block 
				font-family="Helvetica" 
				font-size="8px" 
				font-weight="bold"
				border-bottom-style="solid"
				border-width="0.5px">
				DÉBITOS DIVERSOS
			</fo:block>
			<fo:block space-after="0.5mm"/>
			<fo:table>
				<fo:table-column column-width="64mm" />
				<fo:table-column column-width="65mm" />
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
								<xsl:variable name="valorMonetarioVariavel16_0"
									select="sum($subscription/ENTIRE_SUBSCRIPTION_TOTAL/SUBSCRIPTION_SRV_CHARGE_TOTAL/@ServiceChargeAmt)"/>
								<xsl:variable name="valorMonetarioVariavel16_1"
									select="sum($subscription/OPERATOR_CALL/PARTY_3RD_TOTAL/@Subtotal)"/>
								
								<xsl:variable name="valorMonetarioVariavelSoma16" select="$valorMonetarioVariavel16_0 + $valorMonetarioVariavel16_1" />
								
								<xsl:call-template name="FORMAT-DOUBLE">
									<xsl:with-param name="number" select="$valorMonetarioVariavelSoma16"/>
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
								Referência
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
					
					<!-- 320D -->
					<xsl:for-each select="$subscription/ENTIRE_SUBSCRIPTION_TOTAL/SUBSCRIPTION_SRV_CHARGE_TOTAL/SUBSCRIPTION_SRV_CHARGE_DETAIL">
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
									<xsl:value-of select="vivo:DateFormat.formatDDMMYYYY(@StartDate)"/>
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
					
					
					<!-- 600 T -->
					<xsl:for-each select="$subscription/OPERATOR_CALL/PARTY_3RD_TOTAL/PARTY_3RD_DETAIL">
						<fo:table-row>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px">
									<xsl:value-of select="@ServicePlan"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									text-align="right">
									<xsl:value-of select="vivo:DateFormat.formatDDMMYYYY(@Date)"/>
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
		<!-- fim debitos diversos -->
		
		
		<!-- parcelamento do aparelho -->
		<xsl:for-each select="$context/DUMMY_INVOICE_SUMMARY/EQUIPMENT_INSTALLMENT_TOTAL">
			
			<fo:block space-after="2mm"/>
			
			<fo:block 
				font-family="Helvetica" 
				font-size="8px" 
				font-weight="bold"
				border-bottom-style="solid"
				border-width="0.5px">
				PARCELAMENTO DO APARELHO
			</fo:block>
			<fo:block space-after="0.5mm"/>
			<fo:table>
				<fo:table-column column-width="64mm" />
				<fo:table-column column-width="65mm" />
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
								<xsl:variable name="valorMonetarioVariavel18"
										select="sum(EQUIPMENT_INSTALLMENT_DETAIL/@Amount)"/>
								<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="$valorMonetarioVariavel18"/>
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
								Parcelas
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
					
					<xsl:for-each select="EQUIPMENT_INSTALLMENT_DETAIL">
						<fo:table-row>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px">
									Parcela do aparelho
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block 
									font-family="Helvetica" 
									font-size="8px"
									text-align="right">
									<xsl:value-of select="@ParcelaAtual"/>/<xsl:value-of select="@Parcelas"/>
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
			
		</xsl:for-each>
		
		
		<!-- fim parcelamento do aparelho -->
		
		<!--  fim dodemonstrativo dos lancamentos diversos -->
		
	</fo:flow>


</fo:page-sequence>
</fo:root>
    
    

</xsl:template>   

	
	
<!-- Account number being processed -->

	

</xsl:stylesheet>
