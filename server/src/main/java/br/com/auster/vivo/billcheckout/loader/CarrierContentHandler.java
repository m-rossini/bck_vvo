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

import java.sql.SQLException;
import java.util.Iterator;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.xml.sax.Attributes;
import org.xml.sax.ContentHandler;
import org.xml.sax.Locator;
import org.xml.sax.SAXException;

import br.com.auster.common.log.LogFactory;
import br.com.auster.common.util.I18n;
import br.com.auster.om.reference.ImportRecord;
import br.com.auster.om.reference.facade.CarrierFacade;
import br.com.auster.om.reference.model.CarrierAddress;
import br.com.auster.om.reference.model.CarrierCompany;
import br.com.auster.om.reference.model.FiscalOpCode;

/**
 * @author framos
 * @version $Id$
 */
public class CarrierContentHandler implements ContentHandler {

	
	
	protected static final Logger log = LogFactory.getLogger(CarrierContentHandler.class); 
	protected static final I18n i18n =  I18n.getInstance(CarrierContentHandler.class);
	
	
	private ImportRecord importInfo;
	private CarrierFacade carrier;
	
	private Session session;
	
	
	
	public CarrierContentHandler(Session _session, ImportRecord _importInfo, CarrierFacade _carrier) throws HibernateException {
		
		if (_session == null) {
			throw new IllegalStateException();
		}
		session = _session;
		importInfo = _importInfo;
		carrier = _carrier;
	}

	public void debugMode(boolean _on) {
		if (_on) {
			log.setLevel(Level.DEBUG);
		} else {
			log.setLevel(Level.INFO);
		}
		log.info(i18n.getString("loader.debugOn", String.valueOf(_on)));
	}	
	
	/**
	 * @see org.xml.sax.ContentHandler#startDocument()
	 */
	public void startDocument() throws SAXException {			
		try {
			//saving import information
			session.save(importInfo);
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
			session.connection().commit();
			session.close();
			log.info(i18n.getString("priceCH.stop.OK"));
		} catch (SQLException sqle) {
			throw new SAXException(sqle);
		} catch (HibernateException he) {
			throw new SAXException(he);
		}
	}

	/**
	 * @see org.xml.sax.ContentHandler#startElement(java.lang.String, java.lang.String, java.lang.String, org.xml.sax.Attributes)
	 */
	public void startElement(String _uri, String _localName, String _qName, Attributes _atts) throws SAXException {

		// selecting service object
		if (log.getLevel().equals(Level.DEBUG)) {
			log.debug(debugLine(_localName, _atts));
		}
		try {
			if (_localName.equals("carrier")) {
				handleCarrier(_atts);
			} else if (_localName.equals("carrier_code")) {
				handleFiscalCode(_atts);
			}
			session.flush();
			session.connection().commit();
		} catch (SQLException sqle) {
			SAXException saxe = new SAXException();
			saxe.initCause(sqle);
			throw saxe;
		} catch (HibernateException he) {
			SAXException saxe = new SAXException();
			saxe.initCause(he);
			throw saxe;
		}
	}

	public void rollbackImport() throws SAXException {
		try {
			session.close();
			log.info(i18n.getString("priceCH.stop.error"));
		} catch (HibernateException he) {
			throw new SAXException(he);
		}
	}

	public void endElement(String uri, String localName, String qName) throws SAXException {}

	public void setDocumentLocator(Locator locator) {}
	public void startPrefixMapping(String prefix, String uri) throws SAXException {}
	public void endPrefixMapping(String prefix) throws SAXException {}
	public void processingInstruction(String target, String data) throws SAXException {}
	public void ignorableWhitespace(char[] ch, int start, int length) throws SAXException {}
	public void characters(char[] ch, int start, int length) throws SAXException {}
	public void skippedEntity(String name) throws SAXException {}	

	

	private final String debugLine(String _localName, Attributes _attrs) {
		String xml = "<" + _localName;
		for (int i=0; i < _attrs.getLength(); i++) {
			xml += " " + _attrs.getLocalName(i) + "=\"" + _attrs.getValue(i) + "\"";
		}
		xml += "</" + _localName + ">";
		return xml;
	}
	
	private final void handleCarrier(Attributes _attrs) throws HibernateException {
		String code = _attrs.getValue("code");
		CarrierCompany cc = carrier.getCarrier("55", code);
		if (cc == null) {
			cc = new CarrierCompany();
			cc.setCountryCode("55");
			cc.setNationalCode(code);
			cc.setName((_attrs.getValue("name")==null?null:_attrs.getValue("name").toUpperCase()));
			cc.setMarketingName((_attrs.getValue("marketName")==null?null:_attrs.getValue("marketName").toUpperCase()));
			cc.setRegistrationNumber(_attrs.getValue("regNumber"));
			cc.setImportInfo(importInfo);
			session.saveOrUpdate(cc);
			session.flush();
		}
		
		if (cc.getCompanyAddresses() != null) {
			for (Iterator it=cc.getCompanyAddresses().iterator(); it.hasNext();) {
				CarrierAddress ca = (CarrierAddress)it.next();
				if ((ca.getState() != null) && (ca.getState().equals(_attrs.getValue("uf")))) {
					return;
				}
			}
		}
		cc.addCompanyAddress(createCompanyAddress(_attrs));
		session.saveOrUpdate(cc);
	}
	
	private final CarrierAddress createCompanyAddress(Attributes _attrs) {
		CarrierAddress ca = new CarrierAddress();
		ca.setStreetName((_attrs.getValue("streetName")==null?null:_attrs.getValue("streetName").toUpperCase()));
		ca.setAddressNumber(_attrs.getValue("streetNbr"));
		ca.setZipCode(_attrs.getValue("zipCode"));
		ca.setCity((_attrs.getValue("city")==null?null:_attrs.getValue("city").toUpperCase()));
		ca.setState((_attrs.getValue("uf")==null?null:_attrs.getValue("uf").toUpperCase()));
		ca.setCountry((_attrs.getValue("country")==null?null:_attrs.getValue("country").toUpperCase()));
		ca.setImportInfo(importInfo);
		return ca;
	}
	
	private final void handleFiscalCode(Attributes _attrs) throws HibernateException {

		String fiscalCode = _attrs.getValue("fiscalCode");
		FiscalOpCode fc = carrier.getFiscalCode(fiscalCode);
		if (fc == null) {
			fc = new FiscalOpCode();
			fc.setOpCode(fiscalCode);
			fc.setOpDescription((_attrs.getValue("description")==null?null:_attrs.getValue("description").toUpperCase()));
			fc.setImportInfo(importInfo);
			session.save(fc);
			session.flush();
		}
		CarrierCompany cc = carrier.getCarrier("55", _attrs.getValue("carrier"));
		if (cc == null) {
			throw new IllegalStateException(i18n.getString("loader.carrierMustExist", _attrs.getValue("carrier")));
		}
		cc.allowFiscalOpCode(fc);
		session.update(cc);
	}
}

