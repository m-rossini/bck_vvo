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

import java.sql.Date;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.xml.sax.Attributes;
import org.xml.sax.ContentHandler;
import org.xml.sax.Locator;
import org.xml.sax.SAXException;

import br.com.auster.common.log.LogFactory;
import br.com.auster.common.util.I18n;
import br.com.auster.om.pricing.PricingFacade;
import br.com.auster.om.pricing.TaxCategory;
import br.com.auster.om.pricing.TaxRate;
import br.com.auster.om.reference.ImportRecord;

/**
 * 
 *       
 * @author framos
 * @version $Id: TaxContentHandler.java 354 2005-12-02 13:19:29Z framos $
 */
public class TaxContentHandler implements ContentHandler {

	
	
	protected static final Logger log = LogFactory.getLogger(TaxContentHandler.class); 
	protected static final I18n i18n =  I18n.getInstance(TaxContentHandler.class);
	
	private ImportRecord importInfo;
	
	private PricingFacade pricing;	
	private Session session;
	private Transaction transaction;
	private Timestamp updatedDate;	

	private SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyyMMdd");
	


	public TaxContentHandler(Session _session, ImportRecord _importInfo, PricingFacade _pricing) throws HibernateException {
		
		if (_session == null) {
			throw new IllegalStateException();
		}
		session = _session;
		importInfo = _importInfo;
		updatedDate = new Timestamp(Calendar.getInstance().getTimeInMillis());
		pricing = _pricing;
	}

	public void debugMode(boolean _on) {
		if (_on) {
			log.setLevel(Level.DEBUG);
		} else {
			log.setLevel(Level.INFO);
		}
	}	
	
	/**
	 * @see org.xml.sax.ContentHandler#startDocument()
	 */
	public void startDocument() throws SAXException {			
		try {
			transaction = session.beginTransaction();
			//saving import information
			session.save(importInfo);			
			log.info(i18n.getString("taxCH.start"));
		} catch (HibernateException he) {
			throw new SAXException(he);
		}
	}

	/**
	 * @see org.xml.sax.ContentHandler#endDocument()
	 */
	public void endDocument() throws SAXException {
		try {
			transaction.commit();
			session.close();
			log.info(i18n.getString("taxCH.stop.OK"));
		} catch (HibernateException he) {
			throw new SAXException(he);
		}
	}

	/**
	 * @see org.xml.sax.ContentHandler#startElement(java.lang.String, java.lang.String, java.lang.String, org.xml.sax.Attributes)
	 */
	public void startElement(String _uri, String _localName, String _qName, Attributes _atts) throws SAXException {

		if (! _localName.equals("tax-info")) {
			return;
		}
		try {
			String taxCode = _atts.getValue("tax-code");
			if (taxCode == null) {
				return;
			}
			TaxCategory tax = createTax(_atts);
			session.saveOrUpdate(tax);
			session.flush();
			transaction.commit();
			transaction = session.beginTransaction();
			session.evict(tax);
		} catch (HibernateException he) {
			throw new SAXException(he);
		} catch (ParseException pe) {
			throw new SAXException(pe);
		}
	}

	public void rollbackImport() throws SAXException {
		try {
			transaction.rollback();
			session.close();
			log.info(i18n.getString("taxCH.stop.error"));
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

	
	private TaxCategory createTax(Attributes _atts) throws HibernateException, ParseException {
		// tax category
		String taxCode = _atts.getValue("tax-code");
		TaxCategory tax = pricing.getTaxCategory(taxCode);
		if (tax == null) {
			tax = new TaxCategory();
			tax.setTaxCode(taxCode);
			tax.setImportInfo(importInfo);
		}
		tax.setUpdatedDate(updatedDate);
		// tax rate
		TaxRate rate = tax.getTaxRate(_atts.getValue("state-id"));
		Calendar cal = Calendar.getInstance();
		cal.setTime(dateFormatter.parse(_atts.getValue("effective-date")));
		// if found, update its expiration date
		if (rate != null) {
			cal.add(Calendar.DATE, -1);
			rate.setExpirationDate(new Date(cal.getTimeInMillis()));
			cal.add(Calendar.DATE, +1);
		}
		// creating new rate, dispite of having a previous record for this state-id
		rate = new TaxRate();
		rate.setImportInfo(this.importInfo);
		rate.setEffectiveDate(new Date(cal.getTimeInMillis()));
		rate.setExternalId(_atts.getValue("state-id"));
		rate.setTaxRate(Double.valueOf(_atts.getValue("rate-factor")).doubleValue());
		tax.getTaxRates().add(rate);
		return tax;
	}
}
