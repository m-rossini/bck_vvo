/*
 * Copyright (c) 2004-2005 Auster Solutions do Brasil. All Rights Reserved.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR 
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR 
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; 
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 
 * 
 * Created on Sep 30, 2005
 */
package br.com.auster.vivo.billcheckout.loader;

import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

import org.apache.commons.collections.map.LRUMap;
import org.apache.log4j.Logger;
import org.xml.sax.Attributes;
import org.xml.sax.ContentHandler;
import org.xml.sax.Locator;
import org.xml.sax.SAXException;

import br.com.auster.common.log.LogFactory;
import br.com.auster.common.util.I18n;

import br.com.auster.om.pricing.PricingFacade;
import br.com.auster.om.pricing.Service;
import br.com.auster.om.pricing.ServiceFreeUnits;
import br.com.auster.om.pricing.ServicePrice;

import br.com.auster.om.reference.ImportRecord;

/**
 * 
 * Handles each line from the dump file, with the pricing reference information
 * for VIVO pricing catalog. The list of fields, separated by a semi-colon, is
 * define bellow :
 * <ul>
 * svc_price_seq_nbr
 * <ul>
 * svc_name
 * <ul>
 * comm_svc_area_id
 * <ul>
 * charge_type_cd
 * <ul>
 * member_svc_name; empty if <code>null</code> in database
 * <ul>
 * svc_price_eff_dt
 * <ul>
 * svc_price_expr_dt; empty if <code>null</code> in database
 * <ul>
 * rate_factor_id; empty if <code>null</code> in database
 * <ul>
 * init_charge_period_qty; 0 if <code>null</code> in database
 * <ul>
 * init_incl_unit_amt
 * <ul>
 * init_period_unit_cd
 * <ul>
 * init_price_amt
 * <ul>
 * adtnl_charge_period_qty; 0 if <code>null</code> in database
 * <ul>
 * adtnl_incl_unit_amt
 * <ul>
 * adtnl_period_unit_cd
 * <ul>
 * adtnl_price_amt
 * <ul>
 * price_ngtbl_flag
 * <ul>
 * tax_cat_cd; empty if <code>null</code> in database
 * <ul>
 * usage_acum_seq_nbr; empty if <code>null</code> in database
 * <ul>
 * free_usage_across_acct_ind; empty if <code>null</code> in database
 * 
 * All fields are from <code>SVC_PRICE</code> table.
 * <p>
 * <br>
 * Rules for populating the reference database : <br>
 * 1- If service does not exist, then svc_name and member_svc_name will be set
 * as
 * <ul>
 * external_id - svc_name
 * <ul>
 * service_name - svc_name
 * <ul>
 * service_description - member_svc_name <br>
 * 2- If price is of type 'F' (for FREE UNITS), then
 * <ul>
 * init & step cost will be left empty
 * <ul>
 * if usage_acum_seq_nbr is null, init & step qty will be set with init & step
 * included unit amounts
 * <ul>
 * if usage_acum_seq_nbr is not null, then the free units record will be linked
 * to the group referenced by this value 3- If price is not of type 'F', then
 * <ul>
 * init & step cost will be set
 * <ul>
 * init & step qty will be set with init & step quantities
 * 
 * For all price rows, the rate factor will be stored in the first custom
 * column.
 * 
 * @author framos
 * @version $Id: ServicePriceContentHandler.java 354 2005-12-02 13:19:29Z framos $
 */
public class ServicePriceContentHandler implements ContentHandler {

	protected static final Logger	 log	                    = LogFactory
	                                                            .getLogger(ServicePriceContentHandler.class);
	protected static final I18n	   i18n	                    = I18n
	                                                            .getInstance(ServicePriceContentHandler.class);

	private ImportRecord	         importInfo;

	private PricingFacade	         pricing;

	private Session	               session;
	private Transaction	           transaction;

	private Timestamp	             effectiveDate;
	private Timestamp	             updatedDate;
	private Map	                   serviceCache;
	private Map	                   sfuCache;

	private int	                   counter;
	private int	                   commitControl;
	private boolean	               debugOn;

	public static final int	       SERVICE_CACHE_SIZE	      = 10000;
	public static final int	       FREEUNITS_CACHE_SIZE	    = 10000;

	public static final int	       COMMIT_SIZE	            = 2000;

	public static final String	   SERVICE_PRICE_QUERY_STMT	= "from ServicePrice as sp where sp.scenario = :scenario and sp.expirationDate is null order by updatedDate desc";

	private final DecimalFormat	   formatter	              = new DecimalFormat("###.00000000");
	private final SimpleDateFormat	dateFormatter	          = new SimpleDateFormat("yyyyMMdd");

	public ServicePriceContentHandler(Session _session, ImportRecord _importInfo,
	    PricingFacade _pricing) throws HibernateException {

		if (_session == null) {
			throw new IllegalStateException();
		}

		session = _session;
		importInfo = _importInfo;
		serviceCache = new LRUMap(SERVICE_CACHE_SIZE);
		sfuCache = new HashMap(SERVICE_CACHE_SIZE);

		effectiveDate = new Timestamp(Calendar.getInstance().getTimeInMillis());
		updatedDate = new Timestamp(Calendar.getInstance().getTimeInMillis());

		pricing = _pricing;
		commitControl = 0;
		counter = 0;
	}

	public void debugMode(boolean _on) {
		this.debugOn = _on;
		log.info(i18n.getString("loader.debugOn", String.valueOf(_on)));
	}

	public void setEffectiveDate(Date _effectiveDate) {
		if (_effectiveDate != null) {
			effectiveDate = new Timestamp(_effectiveDate.getTime());
		}
	}

	/**
	 * @see org.xml.sax.ContentHandler#startDocument()
	 */
	public void startDocument() throws SAXException {
		try {
			transaction = session.beginTransaction();
			// saving import information
			if (importInfo.getUid() == 0L) {
				session.save(importInfo);
			} else {
				importInfo = (ImportRecord) session.get(ImportRecord.class, importInfo.getUid());
			}
			session.flush();
			log.info(i18n.getString("priceCH.start"));
		} catch (HibernateException he) {
			throw new SAXException(he);
		}
	}

	/**
	 * @see org.xml.sax.ContentHandler#endDocument()
	 */
	public void endDocument() throws SAXException {
		try {
			session.flush();
			transaction.commit();
			session.close();
			log.info(i18n.getString("priceCH.stop.OK", String.valueOf(importInfo.getUid()), String
			    .valueOf(this.counter + this.commitControl)));
		} catch (HibernateException he) {
			throw new SAXException(he);
		}
	}

	/**
	 * @see org.xml.sax.ContentHandler#startElement(java.lang.String,
	 *      java.lang.String, java.lang.String, org.xml.sax.Attributes)
	 */
	public void startElement(String _uri, String _localName, String _qName, Attributes _atts)
	    throws SAXException {
		// if not a service_and_price element
		if (!_localName.equals("service_and_price")) {
			return;
		}
		// selecting service object
		if (this.debugOn) {
			log.info(debugLine(_localName, _atts));
		}
		String svcExternalId = null;
		try {

			svcExternalId = _atts.getValue("service-external-id");
			//svcExternalId = _atts.getValue("service-external-id") + _atts.getValue("csa-code");
			if ((svcExternalId == null) || "".equals(svcExternalId)) {
				log.warn(i18n.getString("priceCH.emptyRow"));
				return;
			}
			commitControl++;
			// Service svc = handleService(svcExternalId,
			// _atts.getValue("service-type"), _atts.getValue("service-descr"));
			//log.info("Service External ID: " + svcExternalId + "Handling Invoice-Caption: " + _atts.getValue("invoice-caption") + " Charge-type: " + _atts.getValue("charge-type"));
		
			Service svc = handleService(svcExternalId, null, _atts.getValue("service-name"), _atts.getValue("invoice-caption"), _atts.getValue("charge-type"));
			// creates new service price information
			ServicePrice price = createNewPrice(svc, _atts);
			updatePrice(price, _atts);
			// flush changes to persistence storage
			if (commitControl >= COMMIT_SIZE) {
				session.flush();
				transaction.commit();
				transaction = session.beginTransaction();
				this.counter += commitControl;
				commitControl = 0;
				log.info(i18n.getString("priceCH.loadedCounter", new Integer(counter)));
			}
			// session.flush();
		} catch (HibernateException he) {
			log.fatal("Hibernate(Database) Error for element:" + _localName + ";CurrentCounter:"
			    + (counter + commitControl) + ";service-type:" + _atts.getValue("service-type")
			    + ";service:" + svcExternalId + ";desc=" + _atts.getValue("service-descr")
			    + ";csa-code:" + _atts.getValue("csa-code"));
			SAXException e = new SAXException("Problems during processing start element for element:"
			    + _localName);
			e.initCause(he);
			throw e;
		} catch (ParseException pe) {
			log.fatal("Parsing Error for element:" + _localName + ";CurrentCounter:"
			    + (counter + commitControl) + ";service-type:" + _atts.getValue("service-type")
			    + ";service:" + svcExternalId + ";desc=" + _atts.getValue("service-descr")
			    + ";csa-code:" + _atts.getValue("csa-code"));
			SAXException e = new SAXException("Problems during processing start element for element:"
			    + _localName);
			e.initCause(pe);
			throw e;
		} catch (IllegalArgumentException iae) {
			log.fatal("Convertion Error for element:" + _localName + ";CurrentCounter:"
			    + (counter + commitControl) + ";service-type:" + _atts.getValue("service-type")
			    + ";service:" + svcExternalId + ";desc=" + _atts.getValue("service-descr")
			    + ";csa-code:" + _atts.getValue("csa-code"));
			SAXException e = new SAXException("Problems during processing start element for element:"
			    + _localName);
			e.initCause(iae);
			throw e;
		}
	}

	public void rollbackImport() throws SAXException {
		try {
			transaction.rollback();
			session.close();
			log.info(i18n.getString("priceCH.stop.error"));
		} catch (HibernateException he) {
			throw new SAXException(he);
		}
	}

	public void endElement(String uri, String localName, String qName) throws SAXException {
	}

	public void setDocumentLocator(Locator locator) {
	}

	public void startPrefixMapping(String prefix, String uri) throws SAXException {
	}

	public void endPrefixMapping(String prefix) throws SAXException {
	}

	public void processingInstruction(String target, String data) throws SAXException {
	}

	public void ignorableWhitespace(char[] ch, int start, int length) throws SAXException {
	}

	public void characters(char[] ch, int start, int length) throws SAXException {
	}

	public void skippedEntity(String name) throws SAXException {
	}

	private final Service handleService(String _svcExternalId, String _serviceType,
	    String serviceName, String invoiceCaption, String chargeType) throws HibernateException {

		//log.info("Function handleService -> Service External ID: " + _svcExternalId + "Handling Invoice-Caption: " + invoiceCaption + " Charge-type: " + chargeType);
		
		// looking up in cache
		String cacheKey = _svcExternalId + ":" + serviceName + ":" + invoiceCaption;
		Service svc = (Service) serviceCache.get(cacheKey);

		// loading from database
		if (svc == null) {
			if (this.debugOn) {
				log.info(i18n.getString("priceCH.serviceNotInCache", _svcExternalId));
			}

//			if (chargeType.equals("R")) {
//				log.info("Service is null. Asking for load from Databse for:" + invoiceCaption);
//				svc = pricing.getService(invoiceCaption);
//			} else {
//				log.info("Service is null. Asking for load from Databse for:" + _svcExternalId);
//				svc = pricing.getService(serviceName, invoiceCaption);
//			}
			
			// garantia de chave única para a tabela prc_service (svcExternalId, serviceName, invoiceCaption)
			svc = pricing.getService(_svcExternalId, serviceName, invoiceCaption);
			
		} 
		// if service not found, save it to database
		if (svc == null) {
			svc = new Service();
			svc.setExternalId(_svcExternalId);
			svc.setServiceName(serviceName);
			svc.setServiceType(_serviceType);
			svc.setServiceDescription(invoiceCaption);
			svc.setImportInfo(importInfo);
			if (this.debugOn) {
				log.info(i18n.getString("priceCH.serviceAddedToDB", _svcExternalId));
			}
			session.save(svc);
		}
		// added to cache
		serviceCache.put(_svcExternalId + ":" + serviceName + ":" + invoiceCaption, svc);
		// returing service
		return svc;
	}

	private final ServicePrice createNewPrice(Service _service, Attributes _atts)
	    throws HibernateException, ParseException {
		ServicePrice price = new ServicePrice();

		// setting FK references
		price.setService(_service);
		price.setImportInfo(importInfo);
		price.setTaxCategory(pricing.getTaxCategory(_atts.getValue("tax-code")));
		// effective date
		Timestamp effDt = effectiveDate;
		if (_atts.getValue("effective-date") != null) {
			try {
				effDt = new Timestamp(dateFormatter.parse(_atts.getValue("effective-date")).getTime());
			} catch (ParseException pe) {
				log.warn(i18n.getString("loader.invalidFormat", _atts.getValue("effective-date")));
			}
		}
		price.setEffectiveDate(effDt);
		// expiration date
		Timestamp expDt = null;
		if (_atts.getValue("expiration-date") != null) {
			try {
				expDt = new Timestamp(dateFormatter.parse(_atts.getValue("expiration-date")).getTime());
			} catch (ParseException pe) {
				log.warn(i18n.getString("loader.invalidFormat", _atts.getValue("expiration-date")));
			}
		}
		price.setExpirationDate(expDt);

		price.setInitType(_atts.getValue("initial-type"));
		price.setStepType(_atts.getValue("step-type"));

		// checking for FREE UNITS

		Double tmp = toDouble(_atts.getValue("initial-unit"), false);
		double initUnits = (tmp == null ? 1D : tmp.doubleValue());
		tmp = toDouble(_atts.getValue("step-unit"), false);
		double stepUnits = (tmp == null ? 1D : tmp.doubleValue());

		String chargeType = _atts.getValue("charge-type");
		if (chargeType.equals("F")) {
			price.setFreeUnits(handleFreeUnitGroup(_atts));
			price.setInitQuantity(Double.valueOf(initUnits));
			price.setStepQuantity(Double.valueOf(stepUnits));
			price.setInitIncludedQuantity(toDouble(_atts.getValue("initial-qty"), false));
			price.setStepIncludedQuantity(toDouble(_atts.getValue("step-qty"), false));
		} else {
			// price.setInitCost(
			// Double.valueOf(formatter.parse(_atts.getValue("initial-cost")).doubleValue()));
			// price.setStepCost( Double.valueOf((_atts.getValue("step-cost") == null
			// ? null : )));
			price.setInitCost(toDouble(_atts.getValue("initial-cost"), true));
			price.setStepCost(toDouble(_atts.getValue("step-cost"), false));

			if (chargeType.equals("U")) {
				// price.setInitQuantity( Double.valueOf((_atts.getValue("initial-qty")
				// == null ? 30D :
				// formatter.parse(_atts.getValue("initial-qty")).doubleValue())) );
				// price.setStepQuantity( Double.valueOf((_atts.getValue("step-qty") ==
				// null ? 30D :
				// formatter.parse(_atts.getValue("step-qty")).doubleValue())) );
				price.setInitQuantity(toDouble(_atts.getValue("initial-qty"), true));
				price.setStepQuantity(toDouble(_atts.getValue("step-qty"), false));

				price.setInitIncludedQuantity(toDouble(_atts.getValue("initial-unit"), true));
				price.setStepIncludedQuantity(toDouble(_atts.getValue("step-unit"), false));
			} else {
				// price.setInitQuantity( Double.valueOf((_atts.getValue("initial-unit")
				// == null ? 1D :
				// formatter.parse(_atts.getValue("initial-unit")).doubleValue())) );
				// price.setStepQuantity( Double.valueOf((_atts.getValue("step-unit") ==
				// null ? 1D :
				// formatter.parse(_atts.getValue("step-unit")).doubleValue())) );
				price.setInitQuantity(toDouble(_atts.getValue("initial-unit"), true));
				price.setStepQuantity(toDouble(_atts.getValue("step-unit"), false));

				price.setInitIncludedQuantity(toDouble(_atts.getValue("initial-qty"), true));
				price.setStepIncludedQuantity(toDouble(_atts.getValue("step-qty"), false));
			}
		}
		// other info
		price.setPassThrough(_atts.getValue("pass-thru"));
		price.setNegotiable(_atts.getValue("negotiable-flag"));
		price.setPricingArea(_atts.getValue("csa-code"));
		price.setScenario(_atts.getValue("price-id"));
		price.setChargeType(chargeType);
		price.setCustom1(_atts.getValue("price-custom-1"));
		
		price.setCustom2(_atts.getValue("price-custom-2"));
		price.setCustom3(_atts.getValue("price-custom-3"));
		price.setChargeTypeId(_atts.getValue("charge-type-id"));
				
		// setting today as update date
		price.setUpdatedDate(updatedDate);
		return price;
	}

	private final ServiceFreeUnits handleFreeUnitGroup(Attributes _atts) throws HibernateException,
	    ParseException {
		ServiceFreeUnits free = null;
		String sfuKey = _atts.getValue("free-units-id") + ":" + _atts.getValue("csa-code");
		double qty = toDouble(_atts.getValue("initial-cost"), true).doubleValue();

		List list = (List) sfuCache.get(sfuKey);

		if (list == null) {
			list = pricing.getServiceFreeUnits(sfuKey);
			if ((list != null) && (list.size() > 0)) {
				sfuCache.put(sfuKey, list);
			}
		}
		// if already exists, increment the amount to the current value
		if ((list != null) && (list.size() > 0)) {
			for (Iterator it = list.iterator(); it.hasNext();) {
				ServiceFreeUnits sfu = (ServiceFreeUnits) it.next();
				if (sfu.getImportInfo().getUid() == importInfo.getUid()) {
					qty += sfu.getFreeUnitsQuantity().doubleValue();
					sfu.setFreeUnitsQuantity(Double.valueOf(qty));
					session.update(sfu);
					return sfu;
				}
				// else : SKIP!!! The FreeUnits found belongs to a previous import
				// operation
			}
		}
		// free units record not found... creating a new one
		free = new ServiceFreeUnits();
		free.setFreeUnitsQuantity(Double.valueOf(qty));
		free.setShareMode(_atts.getValue("share-mode"));
		free.setUnitType(_atts.getValue("initial-type"));
		free.setExternalId(_atts.getValue("free-units-id") + ":" + _atts.getValue("csa-code"));
		free.setCustom1(_atts.getValue("free-units-id"));
		free.setImportInfo(importInfo);
		session.save(free);
		// adding to cache
		list = new ArrayList();
		list.add(free);
		sfuCache.put(sfuKey, list);
		return free;
	}

	private final void updatePrice(ServicePrice _price, Attributes _attrs) throws HibernateException {
		session.save(_price);
	}

	private final String debugLine(String _localName, Attributes _attrs) {
		String xml = "<" + _localName;
		for (int i = 0; i < _attrs.getLength(); i++) {
			xml += " " + _attrs.getLocalName(i) + "=\"" + _attrs.getValue(i) + "\"";
		}
		xml += "</" + _localName + ">";
		return xml;
	}

	private final Double toDouble(String _double, boolean _mandatory) {
		Double dbl = null;
		try {
			if (_double != null) {
				Number n = formatter.parse(_double);
				dbl = Double.valueOf(n.doubleValue());
			}
		} catch (ParseException pe) {
			log.warn(i18n.getString("loader.invalidFormat", _double));
		}

		if ((dbl == null) && (_mandatory)) {
			log.fatal("Value is null BUT it is mandatory");
			throw new IllegalArgumentException();
		}
		return dbl;
	}

}
