<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:str="http://exslt.org/strings"
  xmlns:java="http://xml.apache.org/xalan/java"
  xmlns:number="xalan://br.com.auster.common.lang.NumberUtils"
  xmlns:cache="xalan://br.com.auster.common.cache.DOMCache"
  xmlns:vivo="xalan://br.com.auster.vivo.invoice.util.extensions" 
  version="1.0"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:output method="xml" indent="yes"/>
  
  <xsl:template name="Boleto">
  
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
			<fo:external-graphic src="conf/image/pdf/images/header.jpg" />
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
			    </fo:table-cell>
			  </fo:table-row>
			</fo:table-body>
		</fo:table>
	
		
		<fo:block space-after="15mm"/>
	
	
		<fo:table table-layout="fixed" width="191mm">
			<fo:table-column column-width="112mm"/>
			<fo:table-column column-width="4mm"/>
			<fo:table-column column-width="30mm"/>
			<fo:table-column column-width="4mm"/>
			<fo:table-column column-width="39mm"/>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell>
						<fo:block font-family="Helvetica" font-size="9px" font-weight="bold" 
						border-style="solid" border-width="0.5px" 
						padding-before="0.5mm" 
						padding-after="0.5mm" 
						padding-start="1mm">
						Conta: <xsl:value-of select="$accountNumber"/>
						</fo:block>
						<fo:block space-after="1.5mm"/>
						<fo:block>
							<fo:table table-layout="fixed">
								<fo:table-column column-width="30mm"/>
								<fo:table-column column-width="8mm"/>
								<fo:table-column column-width="30mm"/>
								<fo:table-column column-width="8mm"/>
								<fo:table-column column-width="32mm"/>
								<fo:table-body>
									<fo:table-row>
										<fo:table-cell>
											<fo:block font-family="Helvetica" 
											font-size="7px"
											border-style="solid" border-width="0.5px" 
											padding-before="0.3mm" 
											padding-after="1mm" 
											padding-start="1mm" 
											padding-end="4mm">
												<fo:block>Emissão</fo:block>
												<fo:block space-after="0.75mm"/>
												<fo:block text-align="right" font-size="8px">
													<xsl:value-of select="vivo:DateFormat.formatDDMMYYYY(/SIRS/CYCLE_SUMMARY/@BillingDate)"/>
												</fo:block>
												<fo:block space-after="0.75mm"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block />
										</fo:table-cell>
										<fo:table-cell>
											<fo:block font-family="Helvetica" 
											font-size="7px"
											border-style="solid" border-width="0.5px" 
											padding-before="0.3mm" 
											padding-after="1mm" 
											padding-start="1mm" 
											padding-end="4mm">
												<fo:block>Mês de referência</fo:block>
												<fo:block space-after="0.75mm"/>
												<fo:block text-align="right" font-size="8px">
													<xsl:value-of select="vivo:DateFormat.formatMMYYYY(/SIRS/CYCLE_SUMMARY/@BillingDate)"/>
												</fo:block>
												<fo:block space-after="0.75mm"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block />
										</fo:table-cell>
										<fo:table-cell>
											<fo:block font-family="Helvetica" 
											font-size="7px"
											border-style="ridge" border-width="0.5px" 
											padding-before="0.3mm" 
											padding-after="1mm" 
											padding-start="1mm" 
											padding-end="4mm">
												<fo:block>Período</fo:block>
												<fo:block space-after="0.75mm"/>
												<fo:block text-align="right" font-size="8px">
													<xsl:value-of select="$cycleStartDate"/> a <xsl:value-of select="$cycleEndDate"/>
												</fo:block>
												<fo:block space-after="0.75mm"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block />
					</fo:table-cell>
					<fo:table-cell>
						<fo:block font-family="Helvetica" font-size="9px" border-style="solid" border-width="1px" padding-before="1mm" padding-after="1mm" padding-start="1mm">
							<fo:block  font-weight="bold">VENCIMENTO</fo:block>
							<fo:block space-after="3.5mm"/>
							<fo:block font-size="12pt" text-align="center">
								<xsl:value-of select="vivo:DateFormat.formatDDMMYYYY($context/@DueDate)"/>
							</fo:block>
							<fo:block space-after="1mm"/>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block />
					</fo:table-cell>
					<fo:table-cell>
						<fo:block font-family="Helvetica" font-size="9px" 
							border-style="solid" border-width="1px" 
							padding-before="1mm" padding-after="1mm" 
							padding-start="1mm" padding-end="2mm">
							<fo:block text-align="right" font-weight="bold">
								TOTAL A PAGAR - R$
							</fo:block>
							<fo:block space-after="3.5mm"/>
							<fo:block font-size="12pt"  text-align="right">
							<xsl:call-template name="FORMAT-DOUBLE">
									<xsl:with-param name="number" select="$context/@TotalDueAmount"/>
							</xsl:call-template>
							</fo:block>
							<fo:block space-after="1mm"/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
		
		<fo:block space-after="1.5mm"/>
		
		<fo:table table-layout="fixed" width="191mm">
			<fo:table-column column-width="191mm"/>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell>
						<fo:block font-family="Helvetica" font-size="9px" 
							border-style="solid" border-width="0.5px" 
							padding-before="0.5mm" padding-after="0.5mm" 
							padding-start="1mm" >
							<fo:block font-weight="bold" >
								Número(s) do(s) Celular(es)
							</fo:block>
							<fo:block space-after="1mm"/>
							<fo:block width="191mm">
								
								<xsl:for-each select="/SIRS/CYCLE_SUMMARY/SUBSCRIPTION_INFO">
									
	   								<fo:block font-size="7px" padding-end="5mm">
	   									<xsl:value-of select="@PhoneNumber"/>
	   								
									</fo:block>

									
	   							</xsl:for-each>
								
							</fo:block>
							<fo:block space-after="1mm"/>
							<fo:block font-size="7px">
								Relação total de celulares está localizada na Seção Celulares que compõem sua fatura em página a seguir.
							</fo:block>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
		
		<fo:block space-after="1.5mm"/>
		
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
		
		<fo:table table-layout="fixed" width="191mm">
			<fo:table-column column-width="189mm"/>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell>
						<fo:block font-family="Helvetica" font-size="7px" 
							border-style="solid" border-width="0.5px" 
							padding-before="0.5mm" padding-after="0.5mm" 
							padding-start="1mm" padding-end="2mm"
							>
							<fo:table>
								<fo:table-column column-width="88mm"/>
								<fo:table-column column-width="9mm"/>
								<fo:table-column column-width="88mm"/>
								<fo:table-body>
									<fo:table-row>
									
										<!-- inicio coluna da esquerda -->
									
										<fo:table-cell>
											<fo:block>
												<fo:table>
													<fo:table-column column-width="54mm"/>
													<fo:table-column column-width="17mm"/>
													<fo:table-column column-width="17mm"/>
													<fo:table-body>
														<fo:table-row>
															<fo:table-cell>
																<fo:block font-weight="bold"
																	font-size="8px">
																	Resumo de Utilização
																</fo:block>
															</fo:table-cell>
															<fo:table-cell>
																<fo:block font-weight="bold">
																	Crédito R$
																</fo:block>
															</fo:table-cell>
															<fo:table-cell>
																<fo:block font-weight="bold"
																text-align="right">
																	Débito R$
																</fo:block>
															</fo:table-cell>
														</fo:table-row>
														
														<xsl:if test="$planosPacotes != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		Planos/Pacotes Contratados
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"/>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px" 
																		text-align="right">
																		<xsl:call-template name="FORMAT-DOUBLE">
																			<xsl:with-param name="number" select="$planosPacotes"/>
																		</xsl:call-template>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
														
														<xsl:if test="$servicosAdicionais != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		Serviços Adicionais
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"/>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"
																		text-align="right">
																		<xsl:call-template name="FORMAT-DOUBLE">
																			<xsl:with-param name="number" select="$servicosAdicionais"/>
																		</xsl:call-template>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
														
														<xsl:if test="$redebitosSoma != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		Redébitos
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"/>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"
																		text-align="right">
																		<xsl:call-template name="FORMAT-DOUBLE">
																			<xsl:with-param name="number" select="$redebitosSoma"/>
																		</xsl:call-template>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
														
														<xsl:if test="$originadasRecebidasCobrar != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		Chamadas Dentro da Área de Registro
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"/>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"/>
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
														
														<xsl:if test="$chamadasLocaisOriginadas != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		&#160;&#160;&#160;Chamadas Locais Originadas
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"/>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"
																		text-align="right">
																		<xsl:call-template name="FORMAT-DOUBLE">
																			<xsl:with-param name="number" select="$chamadasLocaisOriginadas"/>
																		</xsl:call-template>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
														
														<xsl:if test="$chamadasRecebidasCobrar != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		&#160;&#160;&#160;Chamadas Recebidas a Cobrar - Locais
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"/>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"
																		text-align="right">
																		<xsl:call-template name="FORMAT-DOUBLE">
																			<xsl:with-param name="number" select="$chamadasRecebidasCobrar"/>
																		</xsl:call-template>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
														
														<xsl:if test="$originadasForaRecebidas != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		Chamadas Fora da Área de Registro
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px" />
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px" />
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
														
														<xsl:if test="$chamadasLocaisOriginadasFora != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		&#160;&#160;&#160;Chamadas Locais Originadas
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"/>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"
																		text-align="right">
																		<xsl:call-template name="FORMAT-DOUBLE">
																			<xsl:with-param name="number" select="$chamadasLocaisOriginadasFora"/>
																		</xsl:call-template>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
														
														<xsl:if test="$chamadasLocaisRecebidas != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		&#160;&#160;&#160;Chamadas Locais Recebidas
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"/>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"
																		text-align="right">
																		<xsl:call-template name="FORMAT-DOUBLE">
																			<xsl:with-param name="number" select="$chamadasLocaisRecebidas"/>
																		</xsl:call-template>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
														
														<xsl:if test="$numerosEspecificos != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		Chamadas a Serviços Números Específicos
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"/>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"
																		text-align="right">
																		<xsl:call-template name="FORMAT-DOUBLE">
																			<xsl:with-param name="number" select="$numerosEspecificos"/>
																		</xsl:call-template>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
														
														<xsl:if test="$numeros0500 != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		Chamadas para Números - 0500
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"/>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"
																		text-align="right">
																		<xsl:call-template name="FORMAT-DOUBLE">
																			<xsl:with-param name="number" select="$numeros0500"/>
																		</xsl:call-template>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
														
														<xsl:if test="$exterior != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		Chamadas Realizadas / Recebidas no Exterior
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"/>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"
																		text-align="right">
																		<xsl:call-template name="FORMAT-DOUBLE">
																			<xsl:with-param name="number" select="$exterior"/>
																		</xsl:call-template>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
														
														<xsl:if test="$dados_soma != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		Utilização de Serviços de Dados
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"/>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"
																		text-align="right">
																		<xsl:call-template name="FORMAT-DOUBLE">
																			<xsl:with-param name="number" select="$dados_soma"/>
																		</xsl:call-template>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
														
														<xsl:if test="$outrosVoz != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		Utilização de Outros Serviços de Voz
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"/>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"
																		text-align="right">
																		<xsl:call-template name="FORMAT-DOUBLE">
																			<xsl:with-param name="number" select="$outrosVoz"/>
																		</xsl:call-template>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
														
														<xsl:if test="$longaDistancia_soma != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		Chamadas de Longa Distância
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"/>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-size="7px"
																		text-align="right">
																		<xsl:call-template name="FORMAT-DOUBLE">
																			<xsl:with-param name="number" select="$longaDistancia_soma"/>
																		</xsl:call-template>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
														
													</fo:table-body>
												</fo:table>
											</fo:block>
										</fo:table-cell>
										
										<!--  fim coluna da esquerda -->
										
										<fo:table-cell><fo:block/></fo:table-cell>
										
										<!--  inicio coluna da direita -->
										<fo:table-cell>
											<fo:block>
												<fo:table>
													<fo:table-column column-width="54mm"/>
													<fo:table-column column-width="17mm"/>
													<fo:table-column column-width="20mm"/>
													<fo:table-body>
													
													<!--  verificar o titulo -->
														<xsl:if test="$diversosTotal != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-weight="bold"
																		font-size="8px">
																		Lançamentos Diversos
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-weight="bold">
																		Crédito R$
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block font-weight="bold"
																	text-align="right">
																		Débito R$
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
													<!--  fim do titulo -->	
														
														<xsl:if test="$faturaRetida != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		Fatura Retida / Saldo Mínimo Fatura Anterior
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block/>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block text-align="right" 
																		font-size="7px">
																		<xsl:call-template name="FORMAT-DOUBLE">
																			<xsl:with-param name="number" select="$faturaRetida"/>
																		</xsl:call-template>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
														
														<xsl:if test="$multas != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		Multa e Juros
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block/>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block text-align="right" 
																		font-size="7px">
																		<xsl:call-template name="FORMAT-DOUBLE">
																			<xsl:with-param name="number" select="$multas"/>
																		</xsl:call-template>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
														
														<xsl:if test="$descontos_soma != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		Descontos
																	</fo:block>
																</fo:table-cell>
																
																<fo:table-cell>
																	<fo:block  
																		font-size="7px">
																		<xsl:call-template name="FORMAT-DOUBLE">
																		<xsl:with-param name="number" select="$descontos_soma"/>
																	</xsl:call-template>
																	</fo:block>
																</fo:table-cell>
																
																<fo:table-cell>
																	<fo:block/>
																</fo:table-cell>
																
															</fo:table-row>
														</xsl:if>
														
														<xsl:if test="$diversos_soma != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		Diversos
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block/>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block text-align="right" 
																		font-size="7px">
																		<xsl:call-template name="FORMAT-DOUBLE">
																			<xsl:with-param name="number" select="$diversos_soma"/>
																		</xsl:call-template>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
														
														<xsl:if test="$parcelamentoConta != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		Parcelament o de Conta
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block/>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block text-align="right" 
																		font-size="7px">
																		<xsl:call-template name="FORMAT-DOUBLE">
																			<xsl:with-param name="number" select="$parcelamentoConta"/>
																		</xsl:call-template>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
														
														<xsl:if test="$parcelamentoAparelho != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		Parcelamento de Aparelho
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block/>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block text-align="right" 
																		font-size="7px">
																		<xsl:call-template name="FORMAT-DOUBLE">
																			<xsl:with-param name="number" select="$parcelamentoAparelho"/>
																		</xsl:call-template>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
														
														<xsl:if test="$multaContrato != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		Multa de Cancelamento de Contrato
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block/>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block text-align="right" 
																		font-size="7px">
																		<xsl:call-template name="FORMAT-DOUBLE">
																			<xsl:with-param name="number" select="$multaContrato"/>
																		</xsl:call-template>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
														
														<xsl:if test="$multaEquipamento != '0'">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block font-size="7px">
																		Multa de Quebra de Parcelamento de Equipamento
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block/>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block text-align="right" 
																		font-size="7px">
																		<xsl:call-template name="FORMAT-DOUBLE">
																			<xsl:with-param name="number" select="$multaEquipamento"/>
																		</xsl:call-template>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</xsl:if>
														
														<fo:table-row>
															<fo:table-cell>
																<fo:block font-size="7px" space-after="8mm">
																&#160;&#160;
																</fo:block>
															</fo:table-cell>
															<fo:table-cell><fo:block/></fo:table-cell>
															<fo:table-cell><fo:block /></fo:table-cell>
														</fo:table-row>
														
														
														<fo:table-row>
															<fo:table-cell>
																<fo:block font-size="8px" font-weight="bold">
																	Total de Créditos / Débitos
																</fo:block>
															</fo:table-cell>
															<fo:table-cell>
																<fo:block/>
															</fo:table-cell>
															<fo:table-cell>
																<fo:block text-align="right" 
																	font-size="8px"  font-weight="bold">
																	<xsl:call-template name="FORMAT-DOUBLE">
																		<xsl:with-param name="number" select="$context/@TotalDueAmount"/>
																	</xsl:call-template>
																</fo:block>
															</fo:table-cell>
														</fo:table-row>
																												
														<fo:table-row>
															<fo:table-cell>
																<fo:block font-size="7px" space-after="4mm">
																&#160;&#160;
																</fo:block>
															</fo:table-cell>
															<fo:table-cell><fo:block/></fo:table-cell>
															<fo:table-cell><fo:block /></fo:table-cell>
														</fo:table-row>
														
														<fo:table-row>
															<fo:table-cell>
																<fo:block font-size="9px" 
																font-weight="bold" text-align="center">
																	TOTAL A PAGAR
																</fo:block>
															</fo:table-cell>
															<fo:table-cell>
																<fo:block/>
															</fo:table-cell>
															<fo:table-cell>
																<fo:block text-align="right" 
																	font-size="9px"  font-weight="bold">
																	<xsl:call-template name="FORMAT-DOUBLE">
																		<xsl:with-param name="number" select="$context/@TotalDueAmount"/>
																	</xsl:call-template>
																</fo:block>
															</fo:table-cell>
														</fo:table-row>
														
													</fo:table-body>
												</fo:table>
											</fo:block>
										</fo:table-cell>
										
										<!-- fim coluna da direita -->
										
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
		
		<!-- exibe pontos para pessoa fisica -->
		<xsl:if test="$context/@CustTypeInd = 'F'">
		
			<fo:block space-after="1.5mm"/>
			
			<fo:table table-layout="fixed" width="191mm">
				<fo:table-column column-width="191mm"/>
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block font-family="Helvetica" font-size="8px" 
								border-style="solid" border-width="0.5px" 
								padding-before="0.5mm" padding-after="0.5mm" 
								padding-start="1mm" >
								<fo:table>
									<fo:table-column column-width="100mm"/>
									<fo:table-column column-width="89mm"/>
									<fo:table-body>
										<fo:table-row>
											<fo:table-cell>
												<fo:block font-weight="bold" space-after="0.5mm">
												Programa de Pontos
												</fo:block>
												<fo:block font-size="7">
													Pontuação referente a conta: 
													<xsl:value-of select="$accountNumber" />
												</fo:block>
												<fo:block font-size="7">
													Posição em: 
													<xsl:value-of select="vivo:DateFormat.formatDDMMYYYY($context/RewardInformation/@rewardDate)" />
												</fo:block>
												<fo:block font-size="6">
													Saldo Total de pontos: 
													<xsl:value-of select="$context/RewardInformation/@rewardBalance" />
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block padding-end="2mm" text-align="justify">
													<xsl:value-of select="$context/RewardInformation/@messageLine1"/>
													<xsl:value-of select="$context/RewardInformation/@messageLine2"/>
													<xsl:value-of select="$context/RewardInformation/@messageLine3"/>
													<xsl:value-of select="$context/RewardInformation/@messageLine4"/>
													<xsl:value-of select="$context/RewardInformation/@messageLine5"/>
													<xsl:value-of select="$context/RewardInformation/@messageLine6"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</fo:table-body>
								</fo:table>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</xsl:if>
		
		
		<fo:block space-after="1.5mm"/>
		
		<!--  mensagem para vc -->
		<fo:table table-layout="fixed" width="191mm">
			<fo:table-column column-width="191mm"/>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell>
						<fo:block font-family="Helvetica" font-size="8px" 
							padding-before="1mm" padding-after="0.5mm" 
							padding-start="1mm"
							 background-color="#eaf7f8" >
							<fo:block font-weight="bold">
							Mensagem para você:
							</fo:block>
							<fo:block>
							Quer economizar nas suas ligações interurbanas? Adquira um dos pacotes para ligação DDD que a VIVO preparou para voçê e suas ligações
							</fo:block>
							<fo:block>
							de longa distância po ar até 40% mais baratas!
							</fo:block>
							<fo:block>
							Para mais informações ligue agora para *8486 ou vá até uma loja VIVO.
							</fo:block>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
		
		<!--  mensagem para vc -->
		
		<fo:block space-after="1.5mm"/>
		
		<!--  agradecimento -->
		<fo:table table-layout="fixed" width="191mm">
			<fo:table-column column-width="191mm"/>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell>
						<fo:block font-family="Helvetica" font-size="7px" 
							padding-before="1mm" padding-after="0.5mm" 
							padding-start="1mm">
							<fo:block>
							AGRADECEMOS O(S) PAGAMENTO(S) RECEBIDO(S) ATÉ A EMISSÃO DESTA FATURA. ESTE BOLETO NÃO QUITA DÉBITOS ANTERIORES.
							</fo:block>
							<fo:block>
							Prezado cliente, mantenha o pagamento em dia evitando a suspensão parcial/total dos serviços e a inclusão nos órgãos de proteção ao crédito. Para pagamentos
							</fo:block>
							<fo:block>
							realizados após a data de vencimento serão cobrados na próxima fatura multa de 2% e juros de 1% ao mês.
							</fo:block>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
		
		<!--  agradecimento -->
		
		<!--  linha de corte -->
		
		<fo:block space-after="1.5mm"/>
		<fo:block border-bottom-style="dashed" border-width="1px" border-color="#000000" padding="0pt"/>
		<fo:block text-align="right" font-family="Helvetica" font-size="6px" space-after="1.5mm">
		Autenticação Mecânica&#160;&#160;&#160;&#160;&#160;
		</fo:block>
		
		<!--  linha de corte -->

		<!--  logo e codigo  -->
		
		<fo:table table-layout="fixed" width="191mm">
			<fo:table-column column-width="38mm"/>
			<fo:table-column column-width="153mm"/>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell>
						<fo:block>
							<fo:external-graphic src="conf/image/pdf/images/logo_preto.jpg"/>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block font-family="Helvetica" font-size="15px" text-align="right">
							<xsl:value-of select="$context/BARCODE_LINE/@OcrScanLineRight" />
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
		
		<!--  logo e codigo -->
		
		<fo:block space-after="1.5mm"/>
		
		<!-- vencimento e total -->
		<fo:table table-layout="fixed" width="191mm">
			<fo:table-column column-width="112mm"/>
			<fo:table-column column-width="4mm"/>
			<fo:table-column column-width="30mm"/>
			<fo:table-column column-width="4mm"/>
			<fo:table-column column-width="39mm"/>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell>
						<fo:block/>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block />
					</fo:table-cell>
					<fo:table-cell>
						<fo:block font-family="Helvetica" font-size="9px" border-style="solid" border-width="1px" padding-before="1mm" padding-after="1mm" padding-start="1mm">
							<fo:block  font-weight="bold">VENCIMENTO</fo:block>
							<fo:block space-after="3.5mm"/>
							<fo:block font-size="12pt" text-align="center">
								<xsl:value-of select="vivo:DateFormat.formatDDMMYYYY($context/@DueDate)"/>
							</fo:block>
							<fo:block space-after="1mm"/>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block />
					</fo:table-cell>
					<fo:table-cell>
						<fo:block font-family="Helvetica" font-size="9px" 
							border-style="solid" border-width="1px" 
							padding-before="1mm" padding-after="1mm" 
							padding-start="1mm" padding-end="2mm">
							<fo:block text-align="right" font-weight="bold">
								TOTAL A PAGAR - R$
							</fo:block>
							<fo:block space-after="3.5mm"/>
							<fo:block font-size="12pt"  text-align="right">
							<xsl:call-template name="FORMAT-DOUBLE">
									<xsl:with-param name="number" select="$context/@TotalDueAmount"/>
							</xsl:call-template>
							</fo:block>
							<fo:block space-after="1mm"/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
		
		
		<!-- vencimento e total -->
		
		<fo:block space-after="1.5mm"/>
		
		<!-- identificador de debito automatico -->
		<fo:table>
			<fo:table-column column-width="8mm"/>
			<fo:table-column column-width="50mm"/>
			<fo:table-column column-width="4mm"/>
			<fo:table-column column-width="50mm"/>
			<fo:table-column column-width="4mm"/>
			<fo:table-column column-width="29mm"/>
			<fo:table-column column-width="4mm"/>
			<fo:table-column column-width="39mm"/>
			
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell>
						<fo:block />
					</fo:table-cell>
					<fo:table-cell>
						<fo:block font-family="Helvetica" 
							font-size="7px"
							border-style="solid" border-width="0.5px" 
							padding-before="0.3mm" 
							padding-after="1mm" 
							padding-start="1mm" 
							padding-end="1mm">
							<fo:block>Identificação de Débito Automático</fo:block>
							<fo:block space-after="0.75mm"/>
							<fo:block text-align="right" font-size="8px">
								0000000000000000000
							</fo:block>
							<fo:block space-after="0.75mm"/>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block />
					</fo:table-cell>
					<fo:table-cell>
						<fo:block font-family="Helvetica" 
							font-size="7px"
							border-style="solid" border-width="0.5px" 
							padding-before="0.3mm" 
							padding-after="1mm" 
							padding-start="1mm" 
							padding-end="1mm">
							<fo:block>Número da Conta</fo:block>
							<fo:block space-after="0.75mm"/>
							<fo:block text-align="right" font-size="8px">
								<xsl:value-of select="$accountNumber"/>
							</fo:block>
							<fo:block space-after="0.75mm"/>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block />
					</fo:table-cell>
					<fo:table-cell>
						<fo:block font-family="Helvetica" 
							font-size="7px"
							border-style="solid" border-width="0.5px" 
							padding-before="0.3mm" 
							padding-after="1mm" 
							padding-start="1mm" 
							padding-end="1mm">
							<fo:block>Mês de referência</fo:block>
							<fo:block space-after="0.75mm"/>
							<fo:block text-align="right" font-size="8px">
								<xsl:value-of select="vivo:DateFormat.formatMMYYYY(/SIRS/CYCLE_SUMMARY/@BillingDate)"/>
							</fo:block>
							<fo:block space-after="0.75mm"/>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block />
					</fo:table-cell>
					<fo:table-cell>
						<fo:block font-family="Helvetica" font-size="12px" >
							<fo:block text-align="center">Débito</fo:block>
							<fo:block text-align="center">Automático</fo:block>
						</fo:block>
					</fo:table-cell>
				
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell><fo:block/></fo:table-cell>
					<fo:table-cell number-columns-spanned="7">
						<fo:block font-family="Helvetica" font-size="8px">
							Verifiue se o débito foi efetuado em sua conta corrente. Caso não tenha ocorrido, utilizar esse boleto para pagamento.
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
		
		
		<!--  identificador de debito automatico -->
		
		<fo:block space-after="1.5mm"/>
		
		<!-- codigo de barras -->
		<fo:table>
			<fo:table-column column-width="90mm"/>
			<fo:table-column column-width="21mm"/>
			<fo:table-column column-width="79mm"/>
			
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell>
						<fo:block>
							<fo:inline>
								<xsl:call-template name="BAR_CODE"/>
							</fo:inline>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell><fo:block/></fo:table-cell>
					<fo:table-cell>
					<fo:block font-family="Helvetica" 
							font-size="7px"
							border-style="solid" border-width="0.5px" 
							padding-before="0.3mm" 
							padding-after="1mm" 
							padding-start="1mm" 
							padding-end="1mm">
							<fo:block padding-after="10mm" >Autenticação Mecânica</fo:block>
							
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
			
		</fo:table>
		<!-- codigo de barras -->
		
	</fo:flow>


</fo:page-sequence>
</fo:root>
    
    

</xsl:template>   


	
<!-- Account number being processed -->

	

</xsl:stylesheet>
