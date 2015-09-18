<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:str="http://exslt.org/strings"
  xmlns:java="http://xml.apache.org/xalan/java"
  xmlns:number="xalan://br.com.auster.common.lang.NumberUtils"
  xmlns:cache="xalan://br.com.auster.common.cache.DOMCache"
  xmlns:vivo="xalan://br.com.auster.vivo.invoice.util.extensions" 
  exclude-result-prefixes="str number cache java vivo" 
  version="1.0"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:output method="xml" indent="yes"/>
  
  <xsl:template name="Nota">
  
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
						Página 0000001/0000006
					</fo:block>
				  </fo:block>
			    </fo:table-cell>
			  </fo:table-row>
			</fo:table-body>
		</fo:table>
	
		
		<fo:block space-after="1.5mm"/>
		
		<!-- looping de notas -->
		<xsl:for-each select="$context/DUMMY_INVOICE_SUMMARY/LD_GENERAL_INFO" >
			
			<fo:block font-family="Helvetica" font-size="9px" font-weight="bold">
			NOTA FISCAL DE SERVIÇOS DE TELECOMUNICAÇÕES
			</fo:block>
			
			<fo:block space-after="1mm"/>
			
			<fo:block border-style="solid" border-width="0.5px" padding-start="1mm">
				<fo:block padding-start="1mm" padding-end="1mm" 
				padding-after="1mm"  padding-before="1mm" 
				font-family="Helvetica" font-size="7px">
					
					<xsl:variable name="opera" 
								select="vivo:CarrierList.getOperadora(@LongDistanceCarrierUF,@LongDistanceCarrierID)"/>
					
					<fo:block  padding-start="1mm">
					Nome da Empresa: <xsl:value-of select="$opera/@NAME" />
					</fo:block>
					<fo:block padding-start="1mm">
					Endereço: <xsl:value-of select="$opera/@ADDRESS" /> CNPJ: <xsl:value-of select="$opera/@CNPJ" />
					I.E.: <xsl:value-of select="$opera/@INSC_MUNICIPAL" />
					</fo:block>
					<fo:block padding-start="1mm">
					Nº Série: <xsl:value-of select="@InvoiceNumber" /> Período: 
					<xsl:value-of select="$cycleStartDate"/> a <xsl:value-of select="$cycleEndDate"/>
					Emissão:
					</fo:block>
					<fo:block padding-start="1mm">
					<xsl:value-of select="vivo:DateFormat.formatMMYYYY(@InvoiceIssueDate)"/>
					Atende o convênio 115/2003 CFOP: <xsl:value-of select="$opera/@CFOP" /> Descrição: PF/PJ - Outros
					</fo:block>
				</fo:block>
			</fo:block>
			
			<fo:block space-after="1mm"/>
			
			<fo:table>
				<fo:table-column column-width="10mm"/>
				<fo:table-column column-width="20mm"/>
				<fo:table-column column-width="70mm"/>
				<fo:table-column column-width="40mm"/>
				<fo:table-column column-width="25mm"/>
				<fo:table-column column-width="24mm"/>
				<fo:table-column column-width="5mm"/>
				
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block font-family="Helvetica" font-size="7px" font-weight="bold">
							Seq.:
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block font-family="Helvetica" font-size="7px" font-weight="bold">
							Cód. Serviço
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block font-family="Helvetica" font-size="7px" font-weight="bold">
							Descrição
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block font-family="Helvetica" font-size="7px" font-weight="bold">
							Quantidade
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block font-family="Helvetica" font-size="7px" font-weight="bold">
							ICMS %
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block font-family="Helvetica" font-size="7px" font-weight="bold" text-align="right">
							Valor em R$
							</fo:block>
						</fo:table-cell>
						<fo:table-cell >
							<fo:block  text-align="right" />
						</fo:table-cell>
					</fo:table-row>
					
					
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
						
						<fo:table-row>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
								1
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
								1001
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
								Descontos
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
								1
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
								25
								</fo:block>
							</fo:table-cell>
							<fo:table-cell  text-align="right">
								<fo:block font-family="Helvetica" font-size="7px">
									<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="$descontos"/>
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px"  text-align="right">CR</fo:block>
							</fo:table-cell>
						</fo:table-row>
						
						
						<fo:table-row>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
								2
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
								200021
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
								Débitos Diversos
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
								1
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
								25
								</fo:block>
							</fo:table-cell>
							<fo:table-cell  text-align="right">
								<fo:block font-family="Helvetica" font-size="7px">
									<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="$debitosDiversos"/>
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block />
							</fo:table-cell>
						</fo:table-row>
						
						
						<fo:table-row>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
								3
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
								301000
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
								Débitos de Contestações
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
								1
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
								25
								</fo:block>
							</fo:table-cell>
							<fo:table-cell  text-align="right">
								<fo:block font-family="Helvetica" font-size="7px">
									<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="$debitosContestacoes"/>
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block />
							</fo:table-cell>
						</fo:table-row>
						
						
						<fo:table-row>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
								4
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
								512212
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
								Adesão
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
								1
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
								25
								</fo:block>
							</fo:table-cell>
							<fo:table-cell  text-align="right">
								<fo:block font-family="Helvetica" font-size="7px">
									<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="$adesao"/>
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block />
							</fo:table-cell>
						</fo:table-row>
						
					</xsl:if>
					
					
					<!--  fim exclusivo vivo -->
					
					<xsl:for-each select="SUMMARY_ACCUMULATION_TAXES">
					
						<fo:table-row>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
									<xsl:value-of select="@ItemNo"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
									<xsl:value-of select="@CodigoServico"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
									<xsl:value-of select="@NomeServico"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
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
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block font-family="Helvetica" font-size="7px">
									<xsl:value-of select="@AliquotaICMS"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell  text-align="right">
								<fo:block font-family="Helvetica" font-size="7px">
									<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="@TotalAmount"/>
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block />
							</fo:table-cell>
						</fo:table-row>
					
					</xsl:for-each>
					
					<fo:table-row>
						<fo:table-cell>
							<fo:block font-family="Helvetica" font-size="7px"/>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block font-family="Helvetica" font-size="7px"/>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block font-family="Helvetica" font-size="7px">
								TOTAL NOTA FISCAL
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block font-family="Helvetica" font-size="7px"/>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block font-family="Helvetica" font-size="7px"/>
						</fo:table-cell>
						<fo:table-cell  text-align="right">
							<fo:block font-family="Helvetica" font-size="7px">
								<!-- variavel de total -->
								<xsl:variable name="variavelTotal" select ="sum(SUMMARY_ACCUMULATION_TAXES/@TotalAmount)" />
								<xsl:if test="@LongDistanceCarrierID = 00">
									<xsl:variable name="variavelTotal" select ="sum(SUMMARY_ACCUMULATION_TAXES/@TotalAmount)- $descontos + $debitosDiversos + $debitosContestacoes + $adesao" />
								</xsl:if>
								<!-- fim variavel de total -->
								<xsl:call-template name="FORMAT-DOUBLE">
									<xsl:with-param name="number" select="$variavelTotal"/>
								</xsl:call-template>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block />
						</fo:table-cell>
					</fo:table-row>
					
				</fo:table-body>
			</fo:table>
			
			<fo:block space-after="1mm" border-bottom-style="solid" border-width="0.5px" />
			
			
			<fo:table>
				<fo:table-column column-width="66mm"/>
				<fo:table-column column-width="20mm"/>
				<fo:table-column column-width="29mm"/>
				<fo:table-column column-width="29mm"/>
				<fo:table-column column-width="50mm"/>
				
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block  font-family="Helvetica" font-size="7px">
								Informações Complementares
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block  font-family="Helvetica" font-size="7px" font-weight="bold">
								ICMS %
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-align="right"  font-family="Helvetica" font-size="7px" font-weight="bold">
								Base de Cálculo - R$
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-align="right"  font-family="Helvetica" font-size="7px" font-weight="bold">
								Valor ICMS - R$ 
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-align="right"  font-family="Helvetica" font-size="7px" font-weight="bold">
								Serv.Isentos/Não Tributáveis - R$
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					
					<xsl:for-each select="ICMS_SUMMARY">
					
						<fo:table-row>
							<fo:table-cell>
								<fo:block />
							</fo:table-cell>
							<fo:table-cell>
								<fo:block  font-family="Helvetica" font-size="7px">
									<xsl:call-template name="FORMAT-ICMS">
										<xsl:with-param name="number" select="@Aliquota"/>
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block text-align="right"  font-family="Helvetica" font-size="7px">
									<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="@BaseCalculo"/>
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block text-align="right"  font-family="Helvetica" font-size="7px">
									<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="@TaxesAmt"/>
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block text-align="right"  font-family="Helvetica" font-size="7px">
									<xsl:call-template name="FORMAT-DOUBLE">
										<xsl:with-param name="number" select="@NonTaxableAmount"/>
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						
					</xsl:for-each>
					
				</fo:table-body>
			
			</fo:table>
			
			<fo:block space-after="1mm" border-bottom-style="solid" border-width="0.5px" />
			
			
			<fo:block font-family="Helvetica" font-size="7px" space-after="2.5mm">
				<xsl:for-each select="TOTAL_TAX" >
					Contribuição para o FUST 1% = R$
					<xsl:call-template name="FORMAT-DOUBLE">
						<xsl:with-param name="number" select="@TotalFUSTAmount"/>
					</xsl:call-template>
					 e FUNTTEL 0,5% = R$ 
					 <xsl:call-template name="FORMAT-DOUBLE">
						<xsl:with-param name="number" select="@TotalFUNTTELAmount"/>
					</xsl:call-template>
			 		do valor dos serviços - não repassado às tarifas.
				</xsl:for-each>
			</fo:block>
			
			
		</xsl:for-each>
		<!-- fim do looping de notas -->
		
		
		<!--  celulares que compoe esta fatura -->
		
		<fo:block font-family="Helvetica" 
			font-size="9px" 
			font-weight="bold"  
			border-bottom-style="solid" 
			border-width="1px">
			CELULARES QUE COMPÕEM ESTA FATURA
		</fo:block>
		
		<fo:block padding-after="0.5mm" />
		
		<fo:table>
			<fo:table-column column-width="64mm" />
			<fo:table-column column-width="64mm" />
			<fo:table-column column-width="65mm" />
			
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell number-columns-spanned="3">
						<fo:block font-family="Helvetica" font-size="7px" text-align="right">
							<fo:inline font-weight="bold">Subtotal:</fo:inline>
							<fo:inline>
								<xsl:call-template name="FORMAT-DOUBLE">
									<xsl:with-param name="number" select="sum($subscription/ENTIRE_SUBSCRIPTION_TOTAL/@SubscriptionAmount)"/>
								</xsl:call-template>
							</fo:inline>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
				
				<fo:table-row>
					<fo:table-cell>
						<fo:block font-family="Helvetica" font-size="7px" font-weight="bold">
							Número do Celular
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block font-family="Helvetica" font-size="7px" font-weight="bold">
							Plano
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block font-family="Helvetica" font-size="7px" font-weight="bold" text-align="right">
							Valor R$
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
				
				<xsl:for-each select="$subscription">
					<fo:table-row>
						<fo:table-cell>
							<fo:block font-family="Helvetica" font-size="7px">
								<xsl:value-of select="@PhoneNumber" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block font-family="Helvetica" font-size="7px" >
								<xsl:value-of select="@planName" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block font-family="Helvetica" font-size="7px" text-align="right">
								<xsl:call-template name="FORMAT-DOUBLE">
									<xsl:with-param name="number" select="ENTIRE_SUBSCRIPTION_TOTAL/@SubscriptionAmount"/>
								</xsl:call-template>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:for-each>
			</fo:table-body>
			
		</fo:table>
		
		
		<fo:block padding-after="2mm" />
		
		<fo:block font-family="Helvetica" 
			font-size="8px" 
			border-style="solid" 
			border-width="0.5px"
			padding-before="0.5mm"
			padding-after="0.5mm"
			padding-start="1mm"
			text-align="center"
			>
			
			Operadoras de Longa Distância - 15 - Telefônica 21 - Embratel 23 - Intelig 31 - Telemar 14 - Brasil Telecom 12 - CTBC 41 - TIM
			
		</fo:block>
		
		<!-- fim dos celulares que compoe a fatura -->
		<fo:block padding-after="2mm" />
		
		<!-- autorizacao debito automatico -->
		
		<fo:block font-family="Helvetica" 
			border-style="solid" 
			border-width="0.5px"
			padding-before="0.5mm"
			padding-after="0.5mm"
			padding-start="1mm">
			
			<fo:block text-align="center" font-weight="bold" font-size="9px" >
			Autorização de Débito Automático em Conta Corrente
			</fo:block>
			
			<fo:block font-size="6px" >
			* Autorizo que o pagamento da minha conta telefônica seja efetuado de acordo 
				com os valores informados pela VIVO através do serviço de débito 
				automático em conta corrente no	
				banco, agência e conta corrente por mim abaixo indicados. Fico ciente de que qualquer 
				alteração nos mesmos poderá implicar na descontinuidade do serviço
				de débito automático, cabendo a mim realizar a solicitação de um novo cadastramento.
				No caso de insulficiência de saldo, estou ciente de que o débito ficará em aberto
				sendo da minha responsabilidade a sua quitação.
			</fo:block>
			
			<fo:block font-size="7px" >
				Identificador de Débito Automático:
			</fo:block>
			
			<fo:block>
				<fo:table>
					<fo:table-column column-width="25mm" />
					<fo:table-column column-width="165mm" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell>
								<fo:block  font-size="7px">
									Nome do Cliente:
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block border-bottom-style="solid" border-width="0.5px" padding-before="2mm" />
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
			
			<fo:block>
				<fo:table>
					<fo:table-column column-width="25mm" />
					<fo:table-column column-width="165mm" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell>
								<fo:block  font-size="7px">
									Nome do Correntista:
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block border-bottom-style="solid" border-width="0.5px" padding-before="2mm" />
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
			
			
			<fo:block>
				<fo:table>
					<fo:table-column column-width="15mm" />
					<fo:table-column column-width="50mm" />
					<fo:table-column column-width="10mm" />
					<fo:table-column column-width="50mm" />
					<fo:table-column column-width="20mm" />
					<fo:table-column column-width="45mm" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell>
								<fo:block  font-size="7px">
									CPF/CNPJ:
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block border-bottom-style="solid" border-width="0.5px" padding-before="2mm" />
							</fo:table-cell>
							<fo:table-cell>
								<fo:block  font-size="7px"  text-align="center">
									RG:
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block border-bottom-style="solid" border-width="0.5px" padding-before="2mm" />
							</fo:table-cell>
							<fo:table-cell>
								<fo:block  font-size="7px" text-align="center">
									Órgão Emissor:
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block border-bottom-style="solid" border-width="0.5px" padding-before="2mm" />
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
			
			<fo:block>
				<fo:table>
					<fo:table-column column-width="10mm" />
					<fo:table-column column-width="50mm" />
					<fo:table-column column-width="15mm" />
					<fo:table-column column-width="50mm" />
					<fo:table-column column-width="20mm" />
					<fo:table-column column-width="45mm" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell>
								<fo:block  font-size="7px">
									Banco:
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block border-bottom-style="solid" border-width="0.5px" padding-before="2mm" />
							</fo:table-cell>
							<fo:table-cell>
								<fo:block  font-size="7px"  text-align="center">
									Agência:
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block border-bottom-style="solid" border-width="0.5px" padding-before="2mm" />
							</fo:table-cell>
							<fo:table-cell>
								<fo:block  font-size="7px" text-align="center">
									Conta Corrente:
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block border-bottom-style="solid" border-width="0.5px" padding-before="2mm" />
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
			
			
			<fo:block>
				<fo:table>
					<fo:table-column column-width="64mm" />
					<fo:table-column column-width="64mm" />
					<fo:table-column column-width="62mm" />
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell>
								<fo:block  font-size="7px" 
								border-bottom-style="solid" 
								border-width="0.5px" 
								padding-before="2mm"
								text-align="right">
									&#160;&#160;,
									&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;/
									&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;/
									&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block  />
							</fo:table-cell>
							<fo:table-cell>
								<fo:block  border-bottom-style="solid" 
								border-width="0.5px" 
								padding-before="2mm"
								font-size="7px">
								&#160;&#160;
								</fo:block>
							</fo:table-cell>
							
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell>
								<fo:block  font-size="7px" 
								padding-before="1mm"
								text-align="center">
									Local e data
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block  />
							</fo:table-cell>
							<fo:table-cell>
								<fo:block  font-size="7px" 
								padding-before="1mm"
								text-align="center">
								Assinatura do titular da conta corrente
								</fo:block>
							</fo:table-cell>
							
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
		
		</fo:block>
		
		<!--  fim autorizacao debito automatico -->
		
	</fo:flow>


</fo:page-sequence>
</fo:root>
    
    

</xsl:template>   


	
<!-- Account number being processed -->

	

</xsl:stylesheet>
