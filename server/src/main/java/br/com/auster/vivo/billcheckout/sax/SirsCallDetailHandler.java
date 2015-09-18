package br.com.auster.vivo.billcheckout.sax;

import gnu.trove.THashSet;
import gnu.trove.TObjectIntHashMap;

import java.text.DecimalFormat;
import java.util.Arrays;

import org.w3c.dom.Element;
import org.xml.sax.Attributes;
import org.xml.sax.ContentHandler;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

import br.com.auster.common.lang.StringUtils;
import br.com.auster.dware.sax.ContentHandlerPipe;

/**
 * Java version of "conf/invoice/fatura-secao8.xsl".
 * 
 * @author Marcos Tengelmann
 * @version $Id: SirsCallDetailHandler.java 1598 2007-10-22 19:22:40Z mtengelm $
 */
public class SirsCallDetailHandler extends ContentHandlerPipe {

	// ##################################################
	// Class variables
	// ##################################################

	// Constants identifying the meaning of each occurrence in the output array
	protected static final int	             I_SECTION_CODE	          = 0;
	protected static final int	             I_CARRIER_CODE	          = 1;
	protected static final int	             I_CARRIER_STATE	        = 2;
	protected static final int	             I_ACCESS_NUMBER	        = 3;
	protected static final int	             I_SUBSECTION_NAME	      = 4;
	protected static final int	             I_CALL_DATE	            = 5;
	protected static final int	             I_CALL_TIME	            = 6;
	protected static final int	             I_ORIGIN_CITY	          = 7;
	protected static final int	             I_ORIGIN_STATE	          = 8;
	protected static final int	             I_DESTINATION_CITY	      = 9;
	protected static final int	             I_DESTINATION_STATE	    = 10;
	protected static final int	             I_CALL_TYPE	            = 11;
	protected static final int	             I_CALLING_NUMBER	        = 12;
	protected static final int	             I_CALLED_NUMBER	        = 13;
	protected static final int	             I_CALL_TARIFF	          = 14;
	protected static final int	             I_CALL_DURATION	        = 15;
	protected static final int	             I_CALL_VALUE	            = 16;
	protected static final int	             I_SECTION_DESCRIPTION	  = 17;
	protected static final int	             I_UNIT_OF_MEASURE	      = 18;
	protected static final int	             I_SERVICE_PRICE	        = 19;
	protected static final int	             I_AIR_TIME_RATE	        = 20;
	protected static final int	             I_PLAN_NAME	            = 21;
	protected static final int	             I_ACCOUNT_NUMBER	        = 22;
	protected static final int	             I_REGISTRATION_AREA	    = 23;
	protected static final int	             I_ORIGINATING_SID	      = 24;
	protected static final int	             I_DURATION_RATE	        = 25;
	protected static final int	             I_FREE_INDICATOR	        = 26;

	// Constantes com os nomes dos ELEMENTOS/ATRIBUTOS XML relevantes
	protected static final String	           N_CYCLE	                = "CYCLE_SUMMARY";
	protected static final String	           N_SINFO	                = "SUBSCRIPTION_INFO";
	protected static final String	           N_OCALL	                = "OPERATOR_CALL";
	protected static final String	           N_PHONE	                = "PhoneNumber";
	protected static final String	           N_ACCTN	                = "AccountNumber";
	protected static final String	           N_LABEL	                = "label";
	protected static final String	           N_DATE	                  = "Date";
	protected static final String	           N_TIME	                  = "Time";
	protected static final String	           N_ORIGN	                = "Origin";
	protected static final String	           N_DESTN	                = "Destination";
	protected static final String	           N_CALLED	                = "NumberCalled";
	protected static final String	           N_AMOUNT	                = "Amount";
	protected static final String	           N_DURAT	                = "Duration";
	protected static final String	           N_TARIF	                = "Tariff";
	protected static final String	           N_UNITS	                = "UnitsDescription";
	protected static final String	           N_C_CODE	                = "CarrierCode";
	protected static final String	           N_C_STATE	              = "CarrierState";
	protected static final String	           N_SERVICE_PRICE	        = "ServicePrice";
	protected static final String	           N_AIR_RATE	              = "ValorUnitario";
	protected static final String	           N_ACCOUNT	              = "AccountNumber";
	private static final String	             N_SID	                  = "SIDOrigem";
	private static final String	             N_CAPTION_PHRASE	        = "captionPhrase";
	private static final String	             N_FREE_INDICATOR	        = "freeIndicator";

	// Contantes de valores de tarifas
	protected static final String	           C_TARIF_O	              = "Reduzida";
	protected static final String	           C_TARIF_P	              = "Normal";
	protected static final String	           C_TARIF_X	              = "Outra";

	// Global missing field constant
	protected static final String	           C_MISSING	              = "[MISSING]";

	// Output section code for each "call"
	protected static final String	           COD_SECAO	              = "07";

	// Current element position constants
	protected static final int	             P_SINFO	                = 0;
	protected static final int	             P_OCALL	                = 1;
	protected static final int	             P_TOTAL	                = 2;

	// Number of Distinct Call Types
	protected static final int	             Q_CALL_TYPES	            = 26;

	// Output tag names
	protected static final String	           ROOT_OUT_TAG	            = "CALLS";
	protected static final String	           SUBSCRIBER_OUT_TAG	      = "SUBSCRIBER";
	protected static final String	           SUBSCRIBER_PHONE_OUT_ATT	= "phone";

	// UF do Brasil
	protected static final THashSet	         UF	                      = new THashSet(Arrays
	                                                                      .asList(new String[] {
	    "RS", "SC", "PR", "SP", "RJ", "MG", "ES", "MS", "GO", "TO", "DF", "BA", "AL", "SE", "PE",
	    "PB", "RN", "CE", "PI", "MA", "MT", "PA", "AM", "AC", "RO", "RR", "AP" }));

	// Identifica qual o atributo para se obter uma subsecao nos elementos _TOTAL
	protected static final String[]	         N_TOTAL_SUBSECAO	        = { "ServicePlan",
	    "ServicePlan", "ServicePlan", "ServicePlan", "ServicePlan", "GroupID", "ServicePlan",
	    "ServicePlan", "GroupID", "ServicePlan", "ServicePlan", "ServicePlan", "GroupID",
	    "ServicePlan", "GroupID", "GroupID", "ServicePlan", "ServicePlan", "ServicePlan",
	    "ServicePlan","ServicePlan","ServicePlan","ServicePlan","ServicePlan","ServicePlan"
	    ,"ServicePlan"
	    };

	// Identifica qual o atributo para se obter uma subsecao nos elementos _DETAIL
	protected static final String[]	         N_DETAIL_SUBSECAO	      = { "GroupID", "GroupID",
	    "GroupID", "GroupID", "GroupID", "ServicePlan", "GroupID", "GroupID", "ServicePlan",
	    "GroupID", "GroupID", "GroupID", "ServicePlan", "GroupID", "GroupID", "ServicePlan",
	    "GroupID", "GroupID", "GroupID", "GroupID", "GroupID"	, "GroupID", "GroupID", "GroupID"
	    , "GroupID", "GroupID"
	    };

	// Identifica qual o atributo utilizado para se obter o Nro Destino de uma
	// chamada
	protected static final String[]	         N_DESTINO	              = { N_CALLED, "*", N_CALLED,
	    N_CALLED, N_CALLED, N_CALLED, "*", N_CALLED, N_CALLED, N_CALLED, N_CALLED, N_CALLED,
	    N_CALLED, N_CALLED, N_CALLED, N_CALLED, N_CALLED, N_CALLED, N_CALLED, N_CALLED, N_CALLED,
	    N_CALLED, N_CALLED, N_CALLED, N_CALLED, N_CALLED
	    };
	
	// Identifica qual o atributo utilizado para se obter um tipo de chamada
	protected static final String[]	         N_TIPO_CHAMADA	          = { "ServicePlan",
	    "ServicePlan", "ServicePlan", "ServicePlan", "ServicePlan", "ServicePlan", "ServicePlan",
	    "ServicePlan", "ServicePlan", "ServicePlan", "ServicePlan", "ServicePlan", "ServicePlan",
	    "ServicePlan", "ServicePlan", "ServicePlan", "ServicePlan", "ServicePlan", "ServicePlan",
	    "ServicePlan", "ServicePlan", "ServicePlan", "ServicePlan", "ServicePlan", "ServicePlan"
	    , "ServicePlan"
	    };

	// Identifica o nome do elemento DETAIL
	protected static final TObjectIntHashMap	N_DETAIL	              = new TObjectIntHashMap(
	                                                                      (int) (Q_CALL_TYPES / .5f) + 1);

	static {
		N_DETAIL.put("LOCAL_CALLS_DETAIL", 0);
		N_DETAIL.put("LOCAL_COLLECT_CALLS_DETAIL", 1);
		N_DETAIL.put("LOCAL_CALLS_DISCOUNTED_DETAIL", 2);
		N_DETAIL.put("LD_INTRASTATE_CALLS_DETAIL", 3);
		N_DETAIL.put("LD_INTERSTATE_CALLS_DETAIL", 4);
		N_DETAIL.put("INTERNATIONAL_CALLS_DETAIL", 5);
		N_DETAIL.put("COLLECT_CALLS_DETAIL", 6);
		N_DETAIL.put("ROAM_MOC_LOCAL_DETAIL", 7);
		N_DETAIL.put("ROAM_MOC_INTERNATIONAL_DETAIL", 8);
		N_DETAIL.put("ROAM_MTC_LOCAL_DETAIL", 9);
		N_DETAIL.put("ROAM_MTC_INTERNATIONAL_DETAIL", 10);
		N_DETAIL.put("DATA_2G_DETAIL", 11);
		N_DETAIL.put("DATA_3G1X_DETAIL", 12);
		N_DETAIL.put("VAS_DETAIL", 13);
		N_DETAIL.put("SMS_DETAIL", 14);
		N_DETAIL.put("PARTY_3RD_DETAIL", 15);
		N_DETAIL.put("AD_DETAIL", 16);
		N_DETAIL.put("ROAM_MOC_LD_DETAIL", 17);		
		N_DETAIL.put("ROAM_MTC_LD_DETAIL", 18);
		N_DETAIL.put("Calls0500Detail", 19);
		N_DETAIL.put("TonesAndImagesDetail", 20);
		N_DETAIL.put("GamesAndApplicationsDetail", 21);
		N_DETAIL.put("WAPDetail", 22);
		N_DETAIL.put("PlayDetail", 23);
		N_DETAIL.put("ZAPDetail", 24);
		N_DETAIL.put("VoiceServicesDetail", 25);			
	}

	// Identifica o nome do elemento TOTAL
	protected static final TObjectIntHashMap	N_TOTAL	                = new TObjectIntHashMap(
	                                                                      (int) (Q_CALL_TYPES / .5f) + 1);

	static {
		N_TOTAL.put("LOCAL_CALLS_TOTAL", 0);
		N_TOTAL.put("LOCAL_COLLECT_CALLS_TOTAL", 1);
		N_TOTAL.put("LOCAL_CALLS_DISCOUNTED_TOTAL", 2);
		N_TOTAL.put("LD_INTRASTATE_CALLS_TOTAL", 3);
		N_TOTAL.put("LD_INTERSTATE_CALLS_TOTAL", 4);
		N_TOTAL.put("INTERNATIONAL_CALLS_TOTAL", 5);
		N_TOTAL.put("COLLECT_CALLS_TOTAL", 6);
		N_TOTAL.put("ROAM_MOC_LOCAL_TOTAL", 7);
		N_TOTAL.put("ROAM_MOC_INTERNATIONAL_TOTAL", 8);
		N_TOTAL.put("ROAM_MTC_LOCAL_TOTAL", 9);
		N_TOTAL.put("ROAM_MTC_INTERNATIONAL_TOTAL", 10);
		N_TOTAL.put("DATA_2G_TOTAL", 11);
		N_TOTAL.put("DATA_3G1X_TOTAL", 12);
		N_TOTAL.put("VAS_TOTAL", 13);
		N_TOTAL.put("SMS_TOTAL", 14);
		N_TOTAL.put("PARTY_3RD_TOTAL", 15);
		N_TOTAL.put("AD_TOTAL", 16);
		N_TOTAL.put("ROAM_MOC_LD_TOTAL", 17);
		N_TOTAL.put("ROAM_MTC_LD_TOTAL", 18);
		N_TOTAL.put("Calls0500Total", 19);
		N_TOTAL.put("TonesAndImagesTotal", 20);
		N_TOTAL.put("GamesAndApplicationsTotal", 21);
		N_TOTAL.put("WAPTotal", 22);
		N_TOTAL.put("PlayTotal", 23);
		N_TOTAL.put("ZAPTotal", 24);
		N_TOTAL.put("VoiceServicesTotal", 25);				
	}

	// ##################################################
	// Instance variables
	// ##################################################

	// Output filter that will receive the resulting SAX events
	protected ContentHandler	               output;

	// Formatador de Numeros
	protected DecimalFormat	                 formatter	              = new DecimalFormat(
	                                                                      "#,###,##0.0000");

	// Controles e Contadores
	protected int	                           currentElement	          = -1;
	protected boolean	                       missingFlag	            = false;

	// Variaveis para os Campos da Seção
	protected String	                       phone, label, subSecao, units;
	private boolean	                         printCalls;

	// Maior Data e Hora de Chamada
	// OK. I was LAZZY!!!!! Sorry for That
	protected int	                           highDate	                = 0;
	protected int	                           highTime	                = 0;
	protected final String	                 padDate	                = "00000000";
	protected final String	                 padTime	                = "000000";
	protected String	                       highDateString	          = padDate;
	protected String	                       highTimeString	          = padTime;

	// Holds additional information to produce an output.
	protected String	                       accountNumber;

	// ##################################################
	// Constructors
	// ##################################################

	public SirsCallDetailHandler(Element config) {
		// empty
	}

	// ##################################################
	// ContentHandlerPipe Methods
	// ##################################################

	public void setOutput(ContentHandler output) {
		this.output = output;
	}

	// ##################################################
	// SAX event handling
	// ##################################################

	public void startDocument() throws SAXException {
		this.output.startDocument();

		this.highDate = 0;
		this.highTime = 0;
		this.highDateString = padDate;
		this.highTimeString = padTime;

		this.output.startElement("", getRootOutTag(), getRootOutTag(), new AttributesImpl());

	}

	/*****************************************************************************
	 * Esse metodo Existe para cada classes que extendam esta, possam trocar o
	 * Elemento root do Output para o COntentHandler
	 * 
	 * @return
	 */
	public String getRootOutTag() {
		return ROOT_OUT_TAG;
	}

	/*****************************************************************************
	 * Retorna o Nome do Elemento(TAG) do Assinante
	 */
	public String getSubscriberOutTag() {
		return SUBSCRIBER_OUT_TAG;
	}

	public void endDocument() throws SAXException {
		// Creates a new Tag, before ending root, to output the max date and time of
		// all calls;
		String maxTag = "MaxValues";
		AttributesImpl attr = new AttributesImpl();

		String datename = "callDate";
		attr.addAttribute("", datename, datename, "", this.highDateString);

		String timename = "callTime";
		attr.addAttribute("", timename, timename, "", this.highTimeString);

		this.output.startElement("", maxTag, maxTag, attr);
		this.output.endElement("", maxTag, maxTag);

		this.output.endElement("", getRootOutTag(), getRootOutTag());
		this.output.endDocument();
	}

	public void startElement(String namespaceURI, String localName, String qName, Attributes atts)
	    throws SAXException {

		// Verifica Cycle_summary para BARRAR geração de detalhe de chamadas
		// no caso do Invoice ser utilizado para Projetos outros que o Fatura
		// Eletronica
		// (Projeto FATELE ASSUME que CustTypeInd = (V,Z)
		String typeCustomer = "";
		if (localName.equals("CYCLE_SUMMARY")) {
			this.accountNumber = atts.getValue(N_ACCOUNT);
			this.printCalls = false;
			typeCustomer = atts.getValue("CustTypeInd");
			if (typeCustomer.equals("Z"))
				this.printCalls = true;
			if (typeCustomer.equals("V"))
				this.printCalls = true;
			if (!this.printCalls) {
				// log.error("Cliente não é fatura eletrônica. Detalhamento de Chamadas
				// NÃO será realizado.Customer Type Indicator = " + typeCustomer + "
				// Customer=" + atts.getValue("AccountNumber"));
			}
		}

		if (!this.printCalls) {
			// Return foi comentado para que possa gerar Chamadas mesmo para clientes
			// não fatura eletronica.
			// Esse comentario é Provisorio. Ao descomentar, verificar tb. o metodo
			// endElement.
			// return;
		}

		// Achou Subscrição.Obtem o Numero do Telefone.
		if (this.currentElement < P_SINFO && localName.equals(N_SINFO)) {

			this.phone = atts.getValue(N_PHONE);
      this.phone = this.phone == null ? "" : this.phone.replaceAll("-", "");
      
      
			final AttributesImpl outAtts = new AttributesImpl();
			outAtts.addAttribute("", SUBSCRIBER_PHONE_OUT_ATT, SUBSCRIBER_PHONE_OUT_ATT, "CDATA",
			    this.phone);

			this.output.startElement("", getSubscriberOutTag(), getSubscriberOutTag(), outAtts);
			this.currentElement++;

		} else if (this.currentElement == P_SINFO && localName.equals(N_OCALL)) {

			// Achou um OPERATOR_CALL.
			this.currentElement++;
			startOperatorCall(atts);

		} else if (this.currentElement == P_OCALL && N_TOTAL.contains(localName)) {

			// Achou um Elemento _TOTAL da seção de OPERATOR_CALL. Obtem os dados.
			startTotalCallTag(localName, atts);
			this.label = atts.getValue(N_LABEL);
			this.subSecao = getAtributoSubSecao(N_TOTAL_SUBSECAO[N_TOTAL.get(localName)]);
			this.units = atts.getValue(N_UNITS);

			// START Marcos T - getSubSecao, retorna o nome do atributo e não o valor
			// do mesmo
			// Portanto foi incluido o codigo abaixo
			if (!this.subSecao.equals(C_MISSING)) {
				this.subSecao = atts.getValue(this.subSecao);
			}
			if (this.subSecao == null || this.subSecao.equals("") || this.subSecao.trim().length() == 0) {
				this.subSecao = C_MISSING;
			} else if (this.subSecao.trim().equals("0")) {
				this.subSecao = C_MISSING;
			}
			// END Marcos T

			this.missingFlag = this.subSecao.equals(C_MISSING);
			this.currentElement++;

		} else if (this.currentElement == P_TOTAL && N_DETAIL.containsKey(localName)) {

			int detailIndex = N_DETAIL.get(localName);

			if (this.missingFlag) {
				this.subSecao = getAtributoSubSecao(N_DETAIL_SUBSECAO[detailIndex]);
				// START Marcos T - getSubSecao, retorna o nome do atributo e não o
				// valor do mesmo
				// Portanto foi incluido o codigo abaixo
				if (!this.subSecao.equals(C_MISSING)) {
					this.subSecao = atts.getValue(this.subSecao);
				}
				// END Marcos T
			}

			// START
			// Marcos T 15-Junho-2004
			// No caso de Chamadas Recebidas a CObrar (Local e Não Local,
			// O Telefone de Origem deve ser invertido com o Telefone de Destino.
			// O Codigo abaixo foi incluido porisso
			String phoneO = "";
			String phoneD = "";

			String[] cidadeAndEstadoOrign;
			String[] cidadeAndEstadoDestn;

			String invert = N_DESTINO[detailIndex];
			if (invert.equals("*")) { // Se ="*" deve inverter
				phoneO = getDado(atts.getValue(N_CALLED));
				phoneD = phone;
				cidadeAndEstadoOrign = getCidadeAndEstado(atts.getValue(N_DESTN));
				cidadeAndEstadoDestn = getCidadeAndEstado(atts.getValue(N_ORIGN));
			} else {
				phoneO = phone;
				phoneD = getDado(atts.getValue(N_CALLED));
				cidadeAndEstadoOrign = getCidadeAndEstado(atts.getValue(N_ORIGN));
				cidadeAndEstadoDestn = getCidadeAndEstado(atts.getValue(N_DESTN));
			}

			phoneO = (phoneO != null) ? phoneO.replaceAll("-", "") : "";
			phoneD = (phoneD != null) ? phoneD.replaceAll("-", "") : "";

			String temp = atts.getValue(N_DATE);
			temp = ((temp == null) || (temp.length() == 0)) ? "0" : temp;
			int tempDate = Integer.parseInt(temp);
			if (tempDate > highDate) {
				highDate = tempDate;
				highDateString = StringUtils.alignToRight(atts.getValue(N_DATE), 8, '0');
			}

			temp = atts.getValue(N_TIME);
			temp = ((temp == null) || (temp.length() == 0)) ? "0" : temp;
			int tempTime = Integer.parseInt(temp);
			if (tempTime > highTime) {
				highTime = tempTime;
				highTimeString = StringUtils.alignToRight(atts.getValue(N_TIME), 6, '0');
			}

			String SIDOrigem = atts.getValue(N_SID);
			if (SIDOrigem == null) {
				SIDOrigem = "";
			}

			temp = atts.getValue(N_AMOUNT);
			temp = ((temp == null) || (temp.length() == 0)) ? "0" : temp;
			double val = Double.parseDouble( temp );
			
			temp = atts.getValue(N_DURAT);
			temp = ((temp == null) || (temp.length() == 0)) ? "0" : temp;			
			double dur = Double.parseDouble(temp);
			String durationRate;
			if (dur == 0) {
				durationRate = formatter.format(0.00).toString();
			} else {
				durationRate = formatter.format((val / dur)).toString();
			}

			String captionPhrase = atts.getValue(N_CAPTION_PHRASE);
			if (captionPhrase == null) {
				captionPhrase = "";
			}

			// handling NULL values for 'subSecao'
			if (this.subSecao == null) {
				this.subSecao = "";
			}

			String[] fields = new String[] {
			// [0] Codigo da Secao (07)
			    COD_SECAO,
			    // [1] Carrier Code
			    StringUtils.alignToLeft(atts.getValue(N_C_CODE), 2, '0'),
			    // [2] Carrier State
			    StringUtils.alignToLeft(atts.getValue(N_C_STATE), 2, '0'),
			    // [3] Numero do Assinante
			    StringUtils.alignToLeft(this.phone, 32, ' '),
			    // [4] Nome da SubSeção
			    StringUtils.alignToLeft(this.subSecao, 34, ' '),
			    // [5] Data da Chamada
			    atts.getValue(N_DATE),
			    // [6] Hora da Chamada
			    StringUtils.alignToLeft(atts.getValue(N_TIME), 8, '0'),
			    // [7] Cidade de Origem
			    StringUtils.alignToLeft(cidadeAndEstadoOrign[0], 30, ' '),
			    // [8] Estado de Origem
			    StringUtils.alignToLeft(cidadeAndEstadoOrign[1], 2, ' '),
			    // [9] Cidade de Destino
			    StringUtils.alignToLeft(cidadeAndEstadoDestn[0], 30, ' '),
			    // [10] Estado de Destino
			    StringUtils.alignToLeft(cidadeAndEstadoDestn[1], 2, ' '),
			    // [11] Tipo de Chamada
			    StringUtils.alignToLeft(getTipoChamada(atts.getValue(N_TIPO_CHAMADA[detailIndex])), 40,
			        ' '),
			    // [12] Numero Chamador
			    StringUtils.alignToLeft(phoneO, 20, ' '),
			    // [13] Numero Chamado
			    StringUtils.alignToLeft(phoneD, 20, ' '),
			    // [14] Tarifa
			    StringUtils.alignToLeft(getTariff(atts.getValue(N_TARIF)), 8, ' '),
			    // [15] Duração da Chamada
			    // SirsCallDetailHandler.formatNumber(
			    // getDado( atts.getValue(N_DURAT) ), "0000000000.00;-#", 14),
			    StringUtils.alignToRight(getDado(atts.getValue(N_DURAT)), 14, '0'),
			    // [16] Valor da Chamada
			    // SirsCallDetailHandler.formatNumber(
			    // getDado( atts.getValue(N_AMOUNT) ), "0000000000.00;-#", 14),
			    StringUtils.alignToRight(getDado(atts.getValue(N_AMOUNT)), 14, '0'),
			    // [17] Descrição da Secao
			    StringUtils.alignToLeft(this.label, 64, ' '),
			    // [18] Unidade de Medida
			    StringUtils.alignToLeft(this.units, 10, ' '),
			    // [19] ServicePrice
			    StringUtils.alignToLeft(atts.getValue(N_SERVICE_PRICE), 40, ' '),
			    // [20] AirTime Rate
			    // SirsCallDetailHandler.formatNumber(
			    // getDado( atts.getValue(N_AIR_RATE) ), "0000000000.00;-#", 14)
			    StringUtils.alignToRight(getDado(atts.getValue(N_AIR_RATE)), 14, '0'),
			    // [21] PLAN NAME
			    captionPhrase,
			    // [22] ACCOUNT NUMBER
			    this.accountNumber,
			    // [23] Registration Area
			    StringUtils.alignToRight(StringUtils.substring(this.phone, 0, 2), 2, ' '),
//			    this.phone.substring(0, 2),
			    // [24] SID of originating call
			    SIDOrigem,
			    // [25] Duration Rate
			    durationRate,
			    // [26]Free Indicator
			    StringUtils.alignToLeft(atts.getValue(N_FREE_INDICATOR), 2, ' ')
			    };
		
			doOutput(fields);

		}
	}

	/*****************************************************************************
	 * Metodo Dummy para sofrer Override por subclasses quando encontrar TAG
	 * Operator_call
	 * 
	 * @throws SAXException
	 * 
	 */
	protected void startOperatorCall(Attributes atts) throws SAXException {
		return;
	}

	/*****************************************************************************
	 * Metodo Dummy para sofrer Override por subclasses quando terminar TAG
	 * Operator_call
	 * 
	 * @throws SAXException
	 * 
	 */
	protected void endOperatorCall() throws SAXException {
		return;
	}

	/*****************************************************************************
	 * Metodo Dummy para sofrer Override por subclasses quando iniciar Qualquer
	 * ...TOTAL
	 * 
	 * @throws SAXException
	 * 
	 */
	protected void startTotalCallTag(String localName, Attributes atts) {
		return;
	}

	/*****************************************************************************
	 * Faz o Output dos dados já trabalhados
	 * 
	 * @param fields
	 * @throws SAXException
	 */
	protected void doOutput(String[] fields) throws SAXException {
		String record = buildOutputRecord(fields) + "\n";
		this.output.characters(record.toCharArray(), 0, record.length());
	}

	public void endElement(String namespaceURI, String localName, String qName) throws SAXException {

		if (!this.printCalls) {
			// return;
		}

		if (localName.equals(N_OCALL)) {
			endOperatorCall();
		}
		if ((this.currentElement == P_TOTAL && N_TOTAL.containsKey(localName))
		    || (this.currentElement == P_OCALL && localName.equals(N_OCALL))) {
			this.currentElement--;
		} else if (this.currentElement == P_SINFO && localName.equals(N_SINFO)) {
			this.output.endElement("", SUBSCRIBER_OUT_TAG, SUBSCRIBER_OUT_TAG);
			this.currentElement--;
		}
	}

	// ##################################################
	// Data Values Parsing and CHecking Methods
	// ##################################################

	protected static final String getDado(String field) {
		return (field == null ? "" : field);
	}

	protected static final String formatNumber(String number, String format, int length) {
		if (number == null || number.length() == 0) {
			number = "0";
		}
		if (format == null || format.length() == 0) {
			format = "#0.00;-#";
		}

		final DecimalFormat df = new DecimalFormat(format);

		String retVal = df.format(new Double(number));
		if (retVal.length() < length) {
			retVal = StringUtils.alignToRight(retVal, length, '0');
		}
		return retVal;
	}

	protected static final boolean isValidUF(String uf) {
		return UF.contains(uf);
	}

	protected static final String[] getCidadeAndEstado(String field) {
		StringBuffer cidade = new StringBuffer();
		String estado = "";
		if (field != null && field.length() > 0) {
			field = field.replaceAll("-", "");
			field = field.replaceAll("/", "");
			String[] subFields = field.split("\\s", -1);
			if (subFields.length > 1) {
				for (int i = 0; i < subFields.length - 1; i++) {
					cidade.append(subFields[i]).append(" ");
				}
				String lastSubField = subFields[subFields.length - 1];
				if (isValidUF(lastSubField)) {
					estado = lastSubField;
				} else {
					cidade.append(lastSubField);
				}
			} else {
				cidade.append(field);
			}
		}
		return new String[] { cidade.toString(), estado };
	}

	protected static final String getTipoChamada(String field) {
		return (field == null ? C_MISSING : field);
	}

	protected static final String getAtributoSubSecao(String field) {
		return (field.equals("*") ? C_MISSING : field);
	}

	protected static final String getTariff(String field) {
		if (field == null) {
			field = "";
		} else if (field.equals("P")) {
			field = C_TARIF_P;
		} else if (field.equals("O")) {
			field = C_TARIF_O;
		} else {
			field = C_TARIF_X;
		}
		return field;
	}

	protected String buildOutputRecord(String[] fields) {
		StringBuffer retVal = new StringBuffer();
		/*
		 * int limit foi incluido para limitar o numero de campos texto que serão
		 * "outputed" O Motivo disto é que deseja-se formatar por exemplo 20 campos,
		 * mas na saida em texto, deseja-se apenas o output dos 18 primeiros, mas no
		 * XML de todos. A Variavel Limit, limita a saida para o arquivo tetxo
		 */
		// int limit=fields.length;
		int limit = 19;
		for (int i = 0; i < limit; i++) {
			retVal.append(fields[i]);
		}
		return retVal.toString();
	}

}
