/*
 * Copyright (c) 2004-2005 Auster Solutions. All Rights Reserved.
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
 * Created on Sep 15, 2005
 */
package br.com.auster.vivo.billcheckout.pricing;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import javax.naming.NamingException;

import org.apache.commons.collections.map.LRUMap;
import org.apache.log4j.Logger;
import org.w3c.dom.Element;

import br.com.auster.common.interfaces.ResourceHolder;
import br.com.auster.common.log.LogFactory;
import br.com.auster.common.sql.SQLConnectionManager;
import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.om.invoice.Account;
import br.com.auster.om.invoice.ServiceDetail;
import br.com.auster.om.invoice.UsageDetail;
import br.com.auster.om.pricing.PricingException;
import br.com.auster.om.pricing.PricingInformationNotFoundException;
import br.com.auster.om.pricing.Service;
import br.com.auster.om.pricing.ServiceFreeUnits;
import br.com.auster.om.pricing.ServicePrice;
import br.com.auster.om.pricing.ServicePriceNegotiated;
import br.com.auster.om.pricing.SubscriptionFeeInformationNotFoundException;
import br.com.auster.om.pricing.TaxCategory;
import br.com.auster.om.pricing.TaxRate;
import br.com.auster.om.reference.ImportRecord;
import br.com.auster.om.reference.facade.ConfigurationException;
import br.com.auster.om.reference.facade.impl.SQLFacadeBase;
import br.com.auster.om.util.UnitConvertor;

/**
 * This is a base implementation of the <code>PricingEngine</code> interface, where the reference information for defining
 * 	the cost values for a unique <strong>usage + service</strong> scenario is stored in database tables, handled using
 * 	SQL statements. As a base class, it is defined <strong>abstract</strong> and all subclasses must implement methods to define
 *  the query to be used when looking up for pricing information, and to set the query parameters from the usage and/or service
 *  instances being handled.
 *  <p>
 * The information for connecting to such database is configured and initialized in the <code>configure()</code>
 *  method, which should be called previously to any other interface method. If its not called, then an <code>IllegalStateException</code>
 *  exception will be raised.
 *  <p>
 * In the calculatePriceFor() method, the formula used to define the final cost of a usage event is :
 * 		<br><center><code> cost = ( initCost + (max((usage.duration - initQuantity)/stepQuantity, 0) * stepCost) ) * taxRate </code></center><br>
 *  If its not applicable in some implementation, then the subclass should override the method.
 *  <p>
 * In order to improve performance, this class contains an internal cache structure to hold pricing information. This cache works with
 *  a LRU algorithm, mapping <code>ServicePrice</code> objects by <code>Service.serviceId</code>. For each <code>serviceId</code>, a
 *  <code>RangeMap</code> is created to organize the possible pricing scenarios by date-range.
 *
 * @author framos
 * @version $Id$
 */
public abstract class SQLPricingFacadeBase extends PricingFacadeBase implements ResourceHolder {

	// ---------------------------
	// Instance variables
	// ---------------------------

	protected String poolName;
	protected String negotPool;
	protected String negotPriceStatement;
	protected String negotSubscrStatement;

	// set system property import.history.needless=true if it is not required to load import history
	public static final boolean importHistoryRequired = !Boolean.getBoolean("import.history.needless");

	private static final Logger log = LogFactory.getLogger(SQLPricingFacadeBase.class);

	// table and fields names, for tax_category table
	public static final String TAX_CATEGORY_TABLENAME = "prc_tax_category";
	public static final String TAX_CATEGORY_UID = "objid";
	public static final String TAX_CATEGORY_IMPORT_ID = "import_id";
	public static final String TAX_CATEGORY_TAX_CODE = "tax_code";
	public static final String TAX_CATEGORY_UPDATED_DATE = "updated_date";
	public static final String TAX_CATEGORY_CUSTOM_1 = "custom_1";
	public static final String TAX_CATEGORY_CUSTOM_2 = "custom_2";
	public static final String TAX_CATEGORY_CUSTOM_3 = "custom_3";

	// table and fields names, for tax_rate table
	public static final String TAX_RATE_TABLENAME = "prc_tax_rate";
	public static final String TAX_RATE_UID = "objid";
	public static final String TAX_RATE_IMPORT_ID = "import_id";
	public static final String TAX_RATE_TAX_RATE = "tax_rate";
	public static final String TAX_RATE_TAX_CATEGORY_ID = "tax_category_id";
	public static final String TAX_RATE_EXTERNAL_ID = "rate_external_id";
	public static final String TAX_RATE_EFFECTIVE_DATE = "effective_date";
	public static final String TAX_RATE_EXPIRATION_DATE = "expiration_date";
	public static final String TAX_RATE_CUSTOM_1 = "custom_1";
	public static final String TAX_RATE_CUSTOM_2 = "custom_2";
	public static final String TAX_RATE_CUSTOM_3 = "custom_3";

//	 table and fields names, for service_free_units table
	public static final String SVC_FREEUNITS_TABLENAME = "prc_service_free_units";
	public static final String SVC_FREEUNITS_UID = "objid";
	public static final String SVC_FREEUNITS_IMPORT_ID = "import_id";
	public static final String SVC_FREEUNITS_EXTERNAL_ID = "free_units_external_id";
	public static final String SVC_FREEUNITS_SHAREMODE = "free_units_share_mode";
	public static final String SVC_FREEUNITS_QUANTITY = "free_units_qty";
	public static final String SVC_FREEUNITS_TYPE = "free_units_type";
	public static final String SVC_FREEUNITS_CUSTOM_1 = "custom_1";
	public static final String SVC_FREEUNITS_CUSTOM_2 = "custom_2";
	public static final String SVC_FREEUNITS_CUSTOM_3 = "custom_3";

	public static final String SVC_FREEUNITS_TABLE_PK = SVC_FREEUNITS_TABLENAME + "." + SVC_FREEUNITS_UID;

//	 table and fields names, for service_free_units table
	public static final String SVC_PRICE_TABLENAME = "prc_service_price";
	public static final String SVC_PRICE_UID = "objid";
	public static final String SVC_PRICE_IMPORT_ID = "import_id";
	public static final String SVC_PRICE_SPAREA_ID = "sp_area_id";
	public static final String SVC_PRICE_SERVICE_ID = "service_id";
	public static final String SVC_PRICE_SCENARIO_ID = "scenario_id";
	public static final String SVC_PRICE_CHARGE_TYPE= "charge_type";
	public static final String SVC_PRICE_EFFECTIVE_DATE = "effective_date";
	public static final String SVC_PRICE_EXPIRATION_DATE = "expiration_date";
	public static final String SVC_PRICE_FREE_UNITS_ID = "free_units_id";
	public static final String SVC_PRICE_INIT_UNIT_VALUE = "initial_unit_value";
	public static final String SVC_PRICE_INIT_UNIT_QTTY = "initial_unit_qty";
	public static final String SVC_PRICE_INIT_UNIT_TYPE = "initial_unit_type";
	public static final String SVC_PRICE_STEP_UNIT_VALUE = "step_unit_value";
	public static final String SVC_PRICE_STEP_UNIT_QTTY = "step_unit_qty";
	public static final String SVC_PRICE_STEP_UNIT_TYPE = "step_unit_type";
	public static final String SVC_PRICE_NEGOTIABLE_FLAG = "negotiable_flag";
	public static final String SVC_PRICE_UPDATED_DATE = "updated_date";
	public static final String SVC_PRICE_PASSTHROUGH_FLAG = "passthrough_flag";
	public static final String SVC_PRICE_INIT_QTY_INCLUDED = "initial_unit_incl_qty";
	public static final String SVC_PRICE_STEP_QTY_INCLUDED = "step_unit_incl_qty";
	public static final String SVC_PRICE_TAX_CODE = "tax_code";
	public static final String SVC_PRICE_CUSTOM_1 = "custom_1";
	public static final String SVC_PRICE_CUSTOM_2 = "custom_2";
	public static final String SVC_PRICE_CUSTOM_3 = "custom_3";
	public static final String SVC_CHARGE_TYPE_ID = "charge_type_id";

//	 table and fields names, for service table
	public static final String SERVICE_TABLENAME = "prc_service";
	public static final String SERVICE_UID = "objid";
	public static final String SERVICE_PARENT_UID = "parent_service_id";
	public static final String SERVICE_IMPORT_ID = "import_id";
	public static final String SERVICE_EXTERNAL_ID = "service_external_id";
	public static final String SERVICE_NAME = "service_name";
	public static final String SERVICE_DESCRIPTION = "service_description";
	public static final String SERVICE_TYPE = "service_type";
	public static final String SERVICE_CUSTOM_1 = "custom_1";
	public static final String SERVICE_CUSTOM_2 = "custom_2";
	public static final String SERVICE_CUSTOM_3 = "custom_3";



	public static final String TAX_CATEGORY_LOAD_QUERY =
		"select " +
		TAX_CATEGORY_TABLENAME + "." + TAX_CATEGORY_UID + "," +
		TAX_CATEGORY_TABLENAME + "." + TAX_CATEGORY_IMPORT_ID + "," +
		TAX_CATEGORY_TABLENAME + "." + TAX_CATEGORY_TAX_CODE + "," +
		TAX_CATEGORY_TABLENAME + "." + TAX_CATEGORY_UPDATED_DATE + "," +
		TAX_CATEGORY_TABLENAME + "." + TAX_CATEGORY_CUSTOM_1 + "," +
		TAX_CATEGORY_TABLENAME + "." + TAX_CATEGORY_CUSTOM_2 + "," +
		TAX_CATEGORY_TABLENAME + "." + TAX_CATEGORY_CUSTOM_3 + "," +
		TAX_RATE_TABLENAME + "." + TAX_RATE_UID + "," +
		TAX_RATE_TABLENAME + "." + TAX_RATE_IMPORT_ID + "," +
		TAX_RATE_TABLENAME + "." + TAX_RATE_TAX_RATE + "," +
		TAX_RATE_TABLENAME + "." + TAX_RATE_EXTERNAL_ID + "," +
		TAX_RATE_TABLENAME + "." + TAX_RATE_EFFECTIVE_DATE + "," +
		TAX_RATE_TABLENAME + "." + TAX_RATE_EXPIRATION_DATE + "," +
		TAX_RATE_TABLENAME + "." + TAX_RATE_CUSTOM_1 + "," +
		TAX_RATE_TABLENAME + "." + TAX_RATE_CUSTOM_2 + "," +
		TAX_RATE_TABLENAME + "." + TAX_CATEGORY_CUSTOM_3 + " from " +
		TAX_CATEGORY_TABLENAME +
			" join " + TAX_RATE_TABLENAME + " on " +
			TAX_CATEGORY_TABLENAME + "." + TAX_CATEGORY_UID + "=" + TAX_RATE_TABLENAME + "." + TAX_RATE_TAX_CATEGORY_ID;

	public static final String SERVICE_FREE_UNITS_LOAD_QUERY =
		"select " +
		SVC_FREEUNITS_TABLENAME + "." + SVC_FREEUNITS_UID + "," +
		SVC_FREEUNITS_TABLENAME + "." + SVC_FREEUNITS_IMPORT_ID + "," +
		SVC_FREEUNITS_TABLENAME + "." + SVC_FREEUNITS_EXTERNAL_ID + "," +
		SVC_FREEUNITS_TABLENAME + "." + SVC_FREEUNITS_SHAREMODE + "," +
		SVC_FREEUNITS_TABLENAME + "." + SVC_FREEUNITS_QUANTITY + "," +
		SVC_FREEUNITS_TABLENAME + "." + SVC_FREEUNITS_TYPE + "," +
		SVC_FREEUNITS_TABLENAME + "." + SVC_FREEUNITS_CUSTOM_1 + "," +
		SVC_FREEUNITS_TABLENAME + "." + SVC_FREEUNITS_CUSTOM_2 + "," +
		SVC_FREEUNITS_TABLENAME + "." + SVC_FREEUNITS_CUSTOM_3 + " from " + SVC_FREEUNITS_TABLENAME;

	public static final String SERVICE_LOAD_QUERY =
		"select " +
		SERVICE_TABLENAME + "." +SERVICE_UID + "," +
		SERVICE_TABLENAME + "." +SERVICE_PARENT_UID + "," +
		SERVICE_TABLENAME + "." +SERVICE_IMPORT_ID + "," +
		SERVICE_TABLENAME + "." +SERVICE_EXTERNAL_ID + "," +
		SERVICE_TABLENAME + "." +SERVICE_NAME + "," +
		SERVICE_TABLENAME + "." +SERVICE_DESCRIPTION + "," +
		SERVICE_TABLENAME + "." +SERVICE_TYPE + "," +
		SERVICE_TABLENAME + "." +SERVICE_CUSTOM_1 + "," +
		SERVICE_TABLENAME + "." +SERVICE_CUSTOM_2 + "," +
		SERVICE_TABLENAME + "." +SERVICE_CUSTOM_3 + " from " + SERVICE_TABLENAME;


	public static final String POOL_NAME_ATTR = "pool-name";
	public static final String NEGOT_SUBELEMENT = "negotiable-datasource";
	public static final String NEGOT_STMT_NAME_ATTR = "price-statement";
	public static final String NEGOT_SUBSC_NAME_ATTR = "subscription-statement";

	private Connection connection;
	private Map<String, PreparedStatement> statements = new HashMap<String, PreparedStatement>();

	private static final Map<Long, ServiceFreeUnits> freeUnitsCache = new LRUMap(2000);
	private static final Set<Long> notFoundFreeUnits = new HashSet<Long>();
	private static final Lock freeUnitsCacheLock = new ReentrantLock();
	private static final Lock notFoundFreeUnitsLock = new ReentrantLock();

	private Map<String, TaxCategory> taxCache;
	public SQLPricingFacadeBase() {
		super();
		this.taxCache = new LRUMap(100);
	}



	// ---------------------------
	// Public methods
	// ---------------------------

	/**
	 * @see br.com.auster.om.reference.facade.ReferenceFacades#configure(Element)
	 */
	public void configure(Element _configuration) throws ConfigurationException {
		super.configure(_configuration);
		synchronized (pricingCache) {
			if (this.poolName != null) { return; }
			// configures not found set and cache sizes
			// inits db pool
			Connection conn = null;
			try {
				this.poolName = DOMUtils.getAttribute(_configuration, POOL_NAME_ATTR, true);
				Element negotElement = DOMUtils.getElement(_configuration, NEGOT_SUBELEMENT, false);
				if (negotElement != null) {
					this.negotPool = DOMUtils.getAttribute(negotElement, POOL_NAME_ATTR, true);
					this.negotPriceStatement = DOMUtils.getAttribute(negotElement, NEGOT_STMT_NAME_ATTR, true);
					this.negotSubscrStatement = DOMUtils.getAttribute(negotElement, NEGOT_SUBSC_NAME_ATTR, true);
				}
				Element poolConfiguration = DOMUtils.getElement(_configuration,
						                                        SQLConnectionManager.SQL_NAMESPACE_URI,
						 										SQLConnectionManager.CONFIG_ELEMENT,
						                                        false);
				if (poolConfiguration != null) {
					SQLConnectionManager.init(_configuration);
				}
				// init. connection
				log.debug("connection established to database : " + this.poolName);
				// starting convertion instance
				convertion = UnitConvertor.getInstance(getConnection());
			} catch (Exception e) {
				throw new ConfigurationException(e);
			}
		}
	}

	/**
	 * @see br.com.auster.om.reference.facade.ReferenceFacades#configure(String, boolean)
	 */
	public void configure(String _configFile, boolean _encrypted) throws ConfigurationException {
		try {
			this.configure(DOMUtils.openDocument(_configFile, _encrypted));
		} catch (Exception e) {
			throw new ConfigurationException(e);
		}
	}

	/**
	 * Creates the <code>Query</code> object - using the <code>getServicePriceQuery</code> and <code>setServicePriceQueryParameters</code>
	 * 	implementations - and executes it to select the pricing information for the current scenario. If no information is found, then a
	 *  <code>PricingInformationNotFoundException</code> exception is raised.
	 *
	 * @see br.com.auster.billcheckout.pricing.PricingFacade#getPriceFor(br.com.auster.om.invoice.UsageDetail, br.com.auster.om.invoice.Service)
	 */
	public ServicePrice getPriceFor(UsageDetail _usage, Service _service) throws PricingInformationNotFoundException {
		if ((_usage == null) || (_service == null)) {
			throw new PricingInformationNotFoundException("getPriceFor(UsageDetail, Service)-cannot find service price: usage or service is null");
		}

//		if (log.isTraceEnabled()) {
//			Runtime rt = Runtime.getRuntime();
//			log.trace("ABM.SQLB.getPriceFor.Before;Free:" + rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:" + rt.maxMemory());
//		}

		PreparedStatement stmt = null;
		StatsMapping stats = ProcessingStats.starting(getClass(), "getPriceFor()");
		try {
			String cacheKey = buildCacheKey(_usage, _service);
			if (inNotFoundList(cacheKey, _usage.getDatetime())) {
//				log.debug("getPriceFor(UsageDetail, Service)-cannot find service price : found similar search in not-found list");
				throw new PricingInformationNotFoundException(_usage, _service);
			}
			ServicePrice p = findPriceInCache(cacheKey, _usage.getDatetime());
			if (p == null) {
//				log.debug("getPriceFor(UsageDetail, Service)-service price not found in cache... going to database:" + _service);
				String query = getServicePriceQuery(_usage, _service);
//				log.debug("getPriceFor(UsageDetail, Service)-Query:" + query);
				stmt = getPreparedStatement(query);
				setServicePriceQueryParameters(stmt, _usage, _service);
				p = this.loadAllAndReturnPrice(stmt, _service, cacheKey, _usage.getDatetime(), true, false);
				if (p == null) {
					throw new PricingInformationNotFoundException(_usage, _service);
				}
//			} else {
//				log.debug("getPriceFor(UsageDetail, Service)-service price found in cache:" + _service);
			}
			return p;

		} catch (PricingInformationNotFoundException pinfe) {
			throw pinfe;
		} catch (Exception ex) {
			PricingInformationNotFoundException e = new PricingInformationNotFoundException(_usage, _service);
			e.initCause(ex);
			throw e;
		} finally {
			stats.finished();
//			log.debug("spent " + (System.nanoTime() - start) + " getting service price information");
			try {
				if (stmt != null) { stmt.clearParameters(); }
			} catch (SQLException sqle) {
				PricingInformationNotFoundException e = new PricingInformationNotFoundException(_usage, _service);
				e.initCause(sqle);
				throw e;
			}
		}
	}

	/**
	 * @see br.com.auster.billcheckout.pricing.PricingFacade#getSubscriptionFeeFor(br.com.auster.om.invoice.ServiceDetail, br.com.auster.om.invoice.Service)
	 */


	public ServicePrice getSubscriptionFeeFor(ServiceDetail _charge, Service _service) throws SubscriptionFeeInformationNotFoundException {
		if ((_charge == null) || (_charge.getSvcId() == null)) {
			throw new SubscriptionFeeInformationNotFoundException("cannot find service price: charge or service_id is null");
		}
		PreparedStatement stmt = null;
		StatsMapping stats = ProcessingStats.starting(getClass(), "getSubscriptionFeeFor()");
		try {
			String cacheKey = buildCacheKey(_charge);
			if (inNotFoundList(cacheKey, _charge.getStartDate())) {
//				log.debug("cannot find service price : found similar search in not-found list:" + _service);
				throw new SubscriptionFeeInformationNotFoundException(_charge, _service);
			}
			ServicePrice p = findPriceInCache(cacheKey, _charge.getStartDate());
			if (p == null) {
//				log.debug("service price not found in cache... going to database.Service:" + _service + ".Detail:" + _charge.getCaption());
				String query = getSubscriptionFeeQuery(_charge, _service);
				stmt = getPreparedStatement(query);
				setSubscriptionFeeQueryParameters(stmt, _charge, _service);
				p = this.loadPriceAndTaxes(stmt, _charge, _service);
				if (p == null) {
					throw new SubscriptionFeeInformationNotFoundException(_charge, _service);
				}
				this.putPriceInCache(cacheKey, p);
//			} else {
//				log.trace("service price found in cache:" + _service);
			}
			return p;
		} catch (SubscriptionFeeInformationNotFoundException sfinfe) {
//			log.debug("Service not found:" + _service);
			throw sfinfe;
		} catch (Exception ex) {
//			log.error("caught persistence exception", ex);
			SubscriptionFeeInformationNotFoundException e = new SubscriptionFeeInformationNotFoundException(_charge, _service);
			e.initCause(ex);
			throw e;
		} finally {
			stats.finished();
			try {
				if (stmt != null) { stmt.clearParameters(); }
			} catch (SQLException sqle) {
//				log.error("caught persistence exception", sqle);
				SubscriptionFeeInformationNotFoundException e = new SubscriptionFeeInformationNotFoundException(_charge, _service);
				e.initCause(sqle);
				throw e;
			}
		}
	}

	@Deprecated
	protected ServicePrice loadAllAndReturnPrice(PreparedStatement _stmt, Service _service, String _cacheKey, Date _usageDate, boolean _deepLoad, boolean _fronNegotDS)
		throws SQLException, NamingException {

		ResultSet rset = null;
		boolean foundAtLeastOne = false;
		ServicePrice p = null;
		StatsMapping stats = ProcessingStats.starting(getClass(), "loadAllAndReturnPrice(deprecated)");
		try {
			rset = _stmt.executeQuery();
			while (true) {
				p = loadServicePriceInfo(rset);
				if (p == null) { break; }
				foundAtLeastOne = true;
				p.setService(_service);
				p.setPriceNegotiated(_fronNegotDS);
				// Will only load free units and tax information if deep load flag is set to true.
				// This flag is false when running negotaible prices query
				if (_deepLoad) {
					// loads the price tax information
					if (p.getTaxCategory() != null) {
						TaxCategory temp = loadSingleTax(TAX_CATEGORY_LOAD_QUERY,
								      					 TAX_CATEGORY_TABLENAME + "." + TAX_CATEGORY_UID,
								      					 Long.valueOf(p.getTaxCategory().getUid()));
						p.setTaxCategory(temp);
					}
					// loads the price freeunits information
					if (p.getFreeUnits() != null) {
						p.setFreeUnits(fillFreeUnitsByPK(SERVICE_FREE_UNITS_LOAD_QUERY, p.getFreeUnits()));
					}
				}
//				log.debug("Service price found in database... adding it to cache.Service:" + _service + ".Price Scenario:" + p.getScenario() + ".Price:" + p);
				putPriceInCache(_cacheKey, p);
//				if (log.isTraceEnabled()) {
//					Runtime rt = Runtime.getRuntime();
//					log.trace("ABM.SQLB.loadAllAndReturnPrice.After;Free:" + rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:" + rt.maxMemory());
//				}
			}
			if (! foundAtLeastOne) {
//				log.debug("Service price not found in database... adding search criteria to not-found list:" + _service);
				addToNotFoundList(_cacheKey, _usageDate);
				return null;
			} else {
				p = findPriceInCache(_cacheKey, _usageDate);
			}
		} finally {
			stats.finished();
			if (rset != null) { rset.close(); } 
		}
		return p;
	}

	protected ServicePrice loadPriceAndTaxes(PreparedStatement _stmt, ServiceDetail _serviceDetail, Service _service)
	throws SQLException, NamingException {

		ResultSet rset = null;
		ServicePrice p = null;
		StatsMapping stats = ProcessingStats.starting(getClass(), "loadPriceAndTaxes()");
		try {
			rset = _stmt.executeQuery();
				p = loadServicePriceInfo(rset);
				if (p != null) {
					p.setService(getService(p.getService().getUid()));

					// loads the price tax information
					if (p.getTaxCategory() != null) {
						TaxCategory temp = loadSingleTax(TAX_CATEGORY_LOAD_QUERY,
								TAX_CATEGORY_TABLENAME + "." + TAX_CATEGORY_UID,
								Long.valueOf(p.getTaxCategory().getUid()));
						p.setTaxCategory(temp);
					}

					// loads the price freeunits information
					if (p.getFreeUnits() != null) {
						p.setFreeUnits(fillFreeUnitsByPK(SERVICE_FREE_UNITS_LOAD_QUERY, p.getFreeUnits()));
					}

//					if (log.isTraceEnabled()) {
//						Runtime rt = Runtime.getRuntime();
//						log.trace("ABM.SQLB.loadAllAndReturnPrice.After;Free:" + rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:" + rt.maxMemory());
//					}
			}

		} finally {
			stats.finished();
			if (rset != null) { rset.close(); } 
		}
		return p;
	}

	/**
	 * @see br.com.auster.om.pricing.PricingFacade#getService(long)
	 */
	public Service getService(long _uid) {
		try {
			return loadSingleService(SERVICE_LOAD_QUERY,
					                 SERVICE_TABLENAME + "." + SERVICE_UID,
					                 new Long(_uid));
		} catch (Exception ex) {
			log.error("caught persistence exception", ex);
		}
		return null;
	}

	/**
	 * @see br.com.auster.om.pricing.PricingFacade#getService(String)
	 */
	public Service getService(String _externalId) {
		try {
			return loadSingleService(SERVICE_LOAD_QUERY,
					                 SERVICE_TABLENAME + "." + SERVICE_NAME, _externalId);
		} catch (Exception ex) {
			log.error("caught persistence exception", ex);
		}
		return null;
	}

	/**
	 * @see br.com.auster.om.pricing.PricingFacade#getService(String, String)
	 */
	public Service getService(String _externalId, String _serviceName, String _serviceDescription) {
		try {
			return loadSingleService(SERVICE_LOAD_QUERY, SERVICE_TABLENAME + "." + SERVICE_EXTERNAL_ID, SERVICE_TABLENAME + "."
					+ SERVICE_NAME, SERVICE_TABLENAME + "."	+ SERVICE_DESCRIPTION, _externalId, _serviceName, _serviceDescription);
		} catch (Exception ex) {
			log.error("caught persistence exception", ex);
		}
		return null;
	}

	/**
	 * @see br.com.auster.om.pricing.PricingFacade#getTaxCategory(long)
	 */
	public TaxCategory getTaxCategory(long _uid) {
		StatsMapping stats = ProcessingStats.starting(getClass(), "getTaxCategory(uid)");
		try {
			return loadSingleTax(TAX_CATEGORY_LOAD_QUERY,
					             TAX_CATEGORY_TABLENAME + "." + TAX_CATEGORY_UID,
					             Long.valueOf(_uid));
		} catch (Exception ex) {
			log.error("caught persistence exception", ex);
		} finally {
			stats.finished();
		}
		return null;
	}

	/**
	 * @see br.com.auster.om.pricing.PricingFacade#getTaxCategory(String)
	 */
	public TaxCategory getTaxCategory(String _taxCode) {
		StatsMapping stats = ProcessingStats.starting(getClass(), "getTaxCategory(taxCode)");
		try {
			return loadSingleTax(TAX_CATEGORY_LOAD_QUERY,
					             TAX_CATEGORY_TABLENAME + "." + TAX_CATEGORY_TAX_CODE,
					             _taxCode);
		} catch (Exception ex) {
			log.error("caught persistence exception", ex);
		} finally {
			stats.finished();
		}
		return null;
	}

	/**
	 * @see br.com.auster.om.pricing.PricingFacade#getServiceFreeUnits(long)
	 */
	public ServiceFreeUnits getServiceFreeUnit(long _uid) {
		StatsMapping stats = ProcessingStats.starting(getClass(), "getServiceFreeUnit()");
		try {
			return getFreeUnitsByPK(SERVICE_FREE_UNITS_LOAD_QUERY, _uid);
		} catch (Exception ex) {
			log.error("caught persistence exception", ex);
		} finally {
			stats.finished();
		}
		return null;
	}

	/**
	 * @see br.com.auster.om.pricing.PricingFacade#getServiceFreeUnits(String)
	 */
	public List<ServiceFreeUnits> getServiceFreeUnits(String _externalId) {
		StatsMapping stats = ProcessingStats.starting(getClass(), "getServiceFreeUnits()");
		try {
			return loadFreeUnits(SERVICE_FREE_UNITS_LOAD_QUERY,
					             SVC_FREEUNITS_TABLENAME + "." + SVC_FREEUNITS_EXTERNAL_ID,
					             _externalId);
		} catch (Exception ex) {
			log.error("caught persistence exception", ex);
		} finally {
			stats.finished();
		}
		return null;
	}


	// ---------------------------
	// Protected methods
	// ---------------------------

	protected ServiceFreeUnits getFreeUnitsByPK(String sql, long freeUnitsId) throws SQLException, NamingException {
		ServiceFreeUnits serviceFreeUnits = getFromFreeUnitsCache(freeUnitsId);
		if (serviceFreeUnits != null) {
			return serviceFreeUnits;
		} else if (isNotFoundFreeUnits(freeUnitsId)) {
			return null;
		} else {
			return loadFreeUnitsByPK(sql, new ServiceFreeUnits(freeUnitsId));
		}
	}

	protected ServiceFreeUnits fillFreeUnitsByPK(String sql, ServiceFreeUnits freeUnits) throws SQLException, NamingException {
		long freeUnitsId = freeUnits.getUid();
		ServiceFreeUnits serviceFreeUnits = getFromFreeUnitsCache(freeUnitsId);
		if (serviceFreeUnits != null) {
			return serviceFreeUnits;
		} else if (isNotFoundFreeUnits(freeUnitsId)) {
			return null;
		} else {
			return loadFreeUnitsByPK(sql, freeUnits);
		}
	}

	protected ServiceFreeUnits loadFreeUnitsByPK(String sql, ServiceFreeUnits freeUnits) throws SQLException, NamingException {
		PreparedStatement stmt = null;
		ResultSet rset = null;
		StatsMapping stats = ProcessingStats.starting(getClass(), "loadFreeUnitsByPK(cache miss)");
		try {
			stmt = getPreparedStatement(sql + " where " + SVC_FREEUNITS_TABLE_PK + " = ?");
//			log.debug("executing query = " + (_sql + " where " + _property + " = ?"));
			long freeUnitsId = freeUnits.getUid();
			stmt.setLong(1, freeUnitsId);
			rset = stmt.executeQuery();
			if (rset.next()) {
				freeUnits = retrieveFreeUnits(rset, freeUnits);
				putIntoFreeUnitsCache(freeUnitsId, freeUnits);
				return freeUnits;
			} else {
				freeUnitsNotFound(freeUnitsId);
				return null;
			}
		} finally {
			stats.finished();
			if (rset != null) { rset.close(); }
			if (stmt != null) { stmt.clearParameters(); }
		}
	}

	private ServiceFreeUnits getFromFreeUnitsCache(long freeUnitsId) {
		freeUnitsCacheLock.lock();
		try {
			return freeUnitsCache.get(freeUnitsId);
		} finally {
			freeUnitsCacheLock.unlock();
		}
	}

	private void putIntoFreeUnitsCache(long freeUnitsId, ServiceFreeUnits freeUnits) {
		freeUnitsCacheLock.lock();
		try {
			freeUnitsCache.put(freeUnitsId, freeUnits);
		} finally {
			freeUnitsCacheLock.unlock();
		}
	}

	private boolean isNotFoundFreeUnits(long freeUnitsId) {
		notFoundFreeUnitsLock.lock();
		try {
			return notFoundFreeUnits.contains(freeUnitsId);
		} finally {
			notFoundFreeUnitsLock.unlock();
		}
	}

	private void freeUnitsNotFound(long freeUnitsId) {
		notFoundFreeUnitsLock.lock();
		try {
			notFoundFreeUnits.add(freeUnitsId);
		} finally {
			notFoundFreeUnitsLock.unlock();
		}
	}

	protected List<ServiceFreeUnits> loadFreeUnits(String _sql, String _property, Object _value) throws SQLException, NamingException {
		PreparedStatement stmt = null;
		ResultSet rset = null;
		List<ServiceFreeUnits> list = new ArrayList<ServiceFreeUnits>();
		StatsMapping stats = ProcessingStats.starting(getClass(), "loadFreeUnits(no cache)");
		try {
			stmt = getPreparedStatement(_sql + " where " + _property + " = ?");
//			log.debug("executing query = " + (_sql + " where " + _property + " = ?"));
			stmt.setObject(1, _value);
			rset = stmt.executeQuery();
			while (rset.next()) {
				list.add(retrieveFreeUnits(rset));
			}
		} finally {
			stats.finished();
			if (rset != null) { rset.close(); }
			if (stmt != null) { stmt.clearParameters(); }
		}
		return list;
	}

	private ServiceFreeUnits retrieveFreeUnits(ResultSet rs) throws SQLException, NamingException {
		return retrieveFreeUnits(rs, new ServiceFreeUnits());
	}

	private ServiceFreeUnits retrieveFreeUnits(ResultSet rs, ServiceFreeUnits freeUnits) throws SQLException, NamingException {
		// HINT: Field sequence in SQL follows SERVICE_FREE_UNITS_LOAD_QUERY statement
		freeUnits.setUid(rs.getLong(1));
		freeUnits.setImportInfo(loadImport(rs.getLong(2)));
		freeUnits.setExternalId(rs.getString(3));
		freeUnits.setShareMode(rs.getString(4));
		freeUnits.setFreeUnitsQuantity(Double.valueOf(rs.getDouble(5)));
		freeUnits.setUnitType(rs.getString(6));
		freeUnits.setCustom1(rs.getString(7));
		freeUnits.setCustom2(rs.getString(8));
		freeUnits.setCustom3(rs.getString(9));
		return freeUnits;
	}

	protected Service loadSingleService(String _sql, String _property, Object _value) throws SQLException, NamingException {
		PreparedStatement stmt = null;
		ResultSet rset = null;
		Service svc = null;
		StatsMapping stats = ProcessingStats.starting(getClass(), "loadSingleService()");
		try {
			stmt = getPreparedStatement(_sql + " where " + _property + " = ?");
//			log.debug("executing query = " + (_sql + " where " + _property + " = ?"));
			stmt.setObject(1, _value);
			rset = stmt.executeQuery();
			// HINT: Field sequence in SQL follows SERVICE_LOAD_QUERY statement
			if (rset.next()) {
				svc = new Service();
				svc.setUid(rset.getLong(1));
				// HINT: for now, always null
				svc.setParentService(null);
				svc.setImportInfo(loadImport(rset.getLong(3)));
				svc.setExternalId(rset.getString(4));
				svc.setServiceName(rset.getString(5));
				svc.setServiceDescription(rset.getString(6));
				svc.setServiceType(rset.getString(7));
				svc.setCustom1(rset.getString(8));
				svc.setCustom2(rset.getString(9));
				svc.setCustom3(rset.getString(10));
			}
		} finally {
			stats.finished();
			if (rset != null) { rset.close(); }
			if (stmt != null) { stmt.clearParameters(); }
		}
		return svc;
	}

	protected Service loadSingleService(String _sql, String _property1,	String _property2, String _property3, Object _value1,
			Object _value2, Object _value3) throws SQLException, NamingException {
		PreparedStatement stmt = null;
		ResultSet rset = null;
		Service svc = null;
		StatsMapping stats = ProcessingStats.starting(getClass(), "loadSingleService()");
		try {
			stmt = getPreparedStatement(_sql + " where " + _property1 + " = ? and " + _property2 + " = ? and " + _property3 + " = ?");
//			log.debug("executing query = " + (_sql + " where " + _property + " = ?"));
			stmt.setObject(1, _value1);
			stmt.setObject(2, _value2);
			stmt.setObject(3, _value3);
			rset = stmt.executeQuery();
			// HINT: Field sequence in SQL follows SERVICE_LOAD_QUERY statement
			if (rset.next()) {
				svc = new Service();
				svc.setUid(rset.getLong(1));
				// HINT: for now, always null
				svc.setParentService(null);
				svc.setImportInfo(loadImport(rset.getLong(3)));
				svc.setExternalId(rset.getString(4));
				svc.setServiceName(rset.getString(5));
				svc.setServiceDescription(rset.getString(6));
				svc.setServiceType(rset.getString(7));
				svc.setCustom1(rset.getString(8));
				svc.setCustom2(rset.getString(9));
				svc.setCustom3(rset.getString(10));
			}
		} finally {
			stats.finished();
			if (rset != null) { rset.close(); }
			if (stmt != null) { stmt.clearParameters(); }
		}
		return svc;
	}

	protected TaxCategory loadSingleTax(String _sql, String _property, Object _value) throws SQLException, NamingException {
		PreparedStatement stmt = null;
		ResultSet rset = null;
		if (_value == null) {
			return null;
		}
		TaxCategory tax = this.taxCache.get(_value.toString());
		if (tax != null) {
//			log.trace("tax found in cache.Tax:" + tax);
			return tax;
		}
//		log.trace("tax not found in cache... going to database,Tax:" + _value.toString());
		StatsMapping stats = ProcessingStats.starting(getClass(), "loadSingleTax()");
		try {
			stmt = getPreparedStatement(_sql + " where " + _property + " = ?");
//			log.debug("For accessing tax in database executing query = " + (_sql + " where " + _property + " = ?"));
//			log.debug("Parameter for above query:" + _value);
			stmt.setObject(1, _value);
			rset = stmt.executeQuery();
			// HINT:Field sequence in SQL follows TAX_CATEGORY_LOAD_QUERY statement
			if (rset.next()) {
//				log.debug("tax found in database... adding it to cache.Tax:" + tax + ".Value:" + _value);
				tax = new TaxCategory();
				tax.setUid(rset.getLong(1));
				tax.setImportInfo(loadImport(rset.getLong(2)));
				tax.setTaxCode(rset.getString(3));
				tax.setUpdatedDate(rset.getTimestamp(4));
				tax.setCustom1(rset.getString(5));
				tax.setCustom2(rset.getString(6));
				tax.setCustom3(rset.getString(7));
				Set<TaxRate> rates = new HashSet<TaxRate>();
				do {
					TaxRate rate = new TaxRate();
					rate.setUid(rset.getLong(8));
					rate.setImportInfo(loadImport(rset.getLong(9)));
					rate.setTaxRate(rset.getDouble(10));
					rate.setExternalId(rset.getString(11));
					rate.setEffectiveDate(rset.getDate(12));
					rate.setExpirationDate(rset.getDate(13));
					rate.setCustom1(rset.getString(14));
					rate.setCustom2(rset.getString(15));
					rate.setCustom3(rset.getString(16));
					rates.add(rate);
				} while (rset.next());
				tax.setTaxRates(rates);
//			} else {
//				log.debug("tax not found in database. There is no not-found list for this cache:" + _value);
			}
		} finally {
			stats.finished();
			if (rset != null) { rset.close(); }
			if (stmt != null) { stmt.clearParameters(); }
	}
		this.taxCache.put(_value.toString(), tax);
		return tax;
	}

	protected ImportRecord loadImport(long _uid) throws SQLException, NamingException {
		if (importHistoryRequired) {
			PreparedStatement stmt = null;
			ResultSet rset = null;
			ImportRecord r = new ImportRecord();
			StatsMapping stats = ProcessingStats.starting(getClass(), "loadImport()");
			try {
				stmt = getPreparedStatement(SQLFacadeBase.IMPORT_HISTORY_LOAD_QUERY);
				stmt.setLong(1, _uid);
				rset = stmt.executeQuery();
				if (rset.next()) {
					r.setUid(_uid);
					r.setFilename(rset.getString(SQLFacadeBase.IMPORT_HISTORY_FILENAME));
					r.setImportDate(rset.getTimestamp(SQLFacadeBase.IMPORT_HISTORY_DATE));
					r.setCustom1(rset.getString(SQLFacadeBase.IMPORT_HISTORY_CUSTOM_1));
					r.setCustom2(rset.getString(SQLFacadeBase.IMPORT_HISTORY_CUSTOM_2));
					r.setCustom3(rset.getString(SQLFacadeBase.IMPORT_HISTORY_CUSTOM_3));
				}
			} finally {
				stats.finished();
				if (rset != null) { rset.close(); }
				if (stmt != null) { stmt.clearParameters(); }
			}
			return r;
		} else {
			return null;
		}
	}

	protected ServicePrice loadServicePriceInfo(ResultSet _rset) throws SQLException {
		ServicePrice p = null;
//		REMOVED SINCE THIS METHOD WILL BE CALLED MORE THEN ONCE, NOW
//		try {
			if (_rset.next()) {
				p = new ServicePrice();
				p.setUid(_rset.getLong(SVC_PRICE_UID));
				p.setChargeType(_rset.getString(SVC_PRICE_CHARGE_TYPE));
				p.setEffectiveDate(_rset.getTimestamp(SVC_PRICE_EFFECTIVE_DATE));
				p.setExpirationDate(_rset.getTimestamp(SVC_PRICE_EXPIRATION_DATE));
				p.setScenario(_rset.getString(SVC_PRICE_SCENARIO_ID));
				if (_rset.getLong(SVC_PRICE_SERVICE_ID) > 0) {
					p.setService(new Service());
					p.getService().setUid(_rset.getLong(SVC_PRICE_SERVICE_ID));
				}
				if (_rset.getLong(SVC_PRICE_FREE_UNITS_ID) > 0) {
					p.setFreeUnits(new ServiceFreeUnits());
					p.getFreeUnits().setUid(_rset.getLong(SVC_PRICE_FREE_UNITS_ID));
				}
				p.setInitCost(Double.valueOf(_rset.getDouble(SVC_PRICE_INIT_UNIT_VALUE)));
				p.setInitQuantity(Double.valueOf(_rset.getDouble(SVC_PRICE_INIT_UNIT_QTTY)));
				p.setInitType(_rset.getString(SVC_PRICE_INIT_UNIT_TYPE));
				p.setInitIncludedQuantity(Double.valueOf(_rset.getDouble(SVC_PRICE_INIT_QTY_INCLUDED)));
				p.setStepCost(Double.valueOf(_rset.getDouble(SVC_PRICE_STEP_UNIT_VALUE)));
				p.setStepQuantity(Double.valueOf(_rset.getDouble(SVC_PRICE_STEP_UNIT_QTTY)));
				p.setStepType(_rset.getString(SVC_PRICE_STEP_UNIT_TYPE));
				p.setStepIncludedQuantity(Double.valueOf(_rset.getDouble(SVC_PRICE_STEP_QTY_INCLUDED)));

				p.setNegotiable(_rset.getString(SVC_PRICE_NEGOTIABLE_FLAG));
				p.setPassThrough(_rset.getString(SVC_PRICE_PASSTHROUGH_FLAG));
				p.setPricingArea(_rset.getString(SVC_PRICE_SPAREA_ID));
				if (_rset.getLong(SVC_PRICE_TAX_CODE) > 0) {
					p.setTaxCategory(new TaxCategory());
					p.getTaxCategory().setUid(_rset.getLong(SVC_PRICE_TAX_CODE));
				}
				p.setUpdatedDate(_rset.getTimestamp(SVC_PRICE_UPDATED_DATE));
				p.setCustom1(_rset.getString(SVC_PRICE_CUSTOM_1));
				p.setCustom2(_rset.getString(SVC_PRICE_CUSTOM_2));
				p.setCustom3(_rset.getString(SVC_PRICE_CUSTOM_3));
				p.setChargeTypeId(_rset.getString(SVC_CHARGE_TYPE_ID));
			}
//		} finally {
//			if (_rset != null) { _rset.close(); }
//		}
		return p;
	}



	/* (non-Javadoc)
   * @see br.com.auster.om.pricing.PricingFacade#getAccountNegotiatedPrices(br.com.auster.om.invoice.Account)
   */
  public List<?> getAccountNegotiatedPrices(Account account) throws UnsupportedOperationException {
  	throw new UnsupportedOperationException("This class does not support this method. You should use: getAccountNegotiatedPricesBySubscription" );
  }



	/* (non-Javadoc)
   * @see br.com.auster.om.pricing.PricingFacade#getAccountNegotiatedPricesBySubscription(br.com.auster.om.invoice.Account)
   */
  public Map<? extends Object, ? extends Object> getAccountNegotiatedPricesBySubscription(Account account) throws PricingException {

//	log.debug("Getting negotiated prices for this account: " + account.getAccountNumber());
  	this.negotUsagePricesMap = new HashMap<String, List<ServicePriceNegotiated>>();

  	Map<String, List<ServicePriceNegotiated>> results = null;
  	Connection conn = null;
  	PreparedStatement stmt = null;
  	ResultSet rs = null;
  	SQLConnectionManager mann=null;

  	try {
  		mann = SQLConnectionManager.getInstance(this.negotPool);
  	} catch (NullPointerException npe) {
	    PricingException ex = new PricingException("Problems getting Connection Pool.");
	    ex.initCause(npe);
//	    log.fatal("Error acessing Negotiated Prices data.", ex);
	    throw ex;
  	} catch (NamingException e) {
	    PricingException ex = new PricingException("Problems getting price query.");
	    ex.initCause(e);
//	    log.fatal("Error acessing Negotiated Prices data.", ex);
	    throw ex;
    }

	StatsMapping stats = ProcessingStats.starting(getClass(), "getAccountNegotiatedPricesBySubscription()");
  	try {
//  		mann = SQLConnectionManager.getInstance(this.negotPool);
	    conn = mann.getConnection();
	    stmt = mann.getStatement(negotPriceStatement).prepareStatement(conn, new Object[] {account.getAccountNumber()});
	    rs = stmt.executeQuery();

	    results = buildNegotiatedPricesBySubscription(rs);
	    this.negotUsagePricesMap = (results==null)? Collections.emptyMap() : results;
    } catch (SQLException e) {
	    PricingException ex = new PricingException("Problems getting price data.QueryName:" + negotPriceStatement);
	    ex.initCause(e);
//	    log.fatal("Error acessing Negotiated Prices data.", ex);
	    throw ex;
    } catch (NamingException e) {
	    PricingException ex = new PricingException("Problems getting price query.");
	    ex.initCause(e);
//	    log.fatal("Error acessing Negotiated Prices data.", ex);
	    throw ex;
    } finally {
    		stats.finished();
			try {
				if (rs != null) { rs.close(); }
				if (stmt != null) { stmt.close(); }
				if (conn != null) { conn.close(); }
			} catch (SQLException sqle) {
				PricingException e = new PricingException("Error during Database resources release.");
//				log.error("Error during getAccountNegotiatedPricesBySubscription", sqle );
				e.initCause(sqle);
				throw e;
			}
    }
    return this.negotUsagePricesMap;
  }

  protected Map <String, List<ServicePriceNegotiated>> buildNegotiatedPricesBySubscription(ResultSet rs) throws SQLException, NamingException {
  	Map<String, List<ServicePriceNegotiated>> results = new HashMap<String, List<ServicePriceNegotiated>>();

  	List<ServicePriceNegotiated> serviceList=null;
//	log.trace("Started building NegotiatedPricesBySubscription.");
	boolean foundNegotiation = false;
  	while (rs.next()) {
  		foundNegotiation = true;
  		String subId = rs.getString("SBSCRP_ID");
//  		log.trace("Found negotiation for subId: " + subId);
  		serviceList = results.get(subId);
  		if (serviceList == null) {
  			//No services for this sub yet.
  			serviceList = new ArrayList<ServicePriceNegotiated>();
  		}

  		serviceList.add(buildServicePriceNegotiated(rs));
  		results.put(subId, serviceList);
  	}
//	log.trace("Finished building NegotiatedPricesBySubscription.");

//	if (!foundNegotiation) {
//  		log.trace("No negotiation found for this account.");
//  	}

  	return results;
  }

  protected ServicePriceNegotiated buildServicePriceNegotiated(ResultSet rs) throws SQLException, NamingException {
  	Service svc = new Service();
  	svc.setExternalId(rs.getString("SVC_NAME"));

  	ServicePriceNegotiated spn = new ServicePriceNegotiated();

  	spn.setAccountNumber(rs.getString("ACCT_NBR"));
  	spn.setSubscriptionId(rs.getString("SBSCRP_ID"));
  	spn.setDiscountPercent(rs.getDouble("NEGOT_PCT"));
  	spn.setTaxIncludedFlag(rs.getString("NEGOT_TAX_INCL_FLAG"));
  	spn.setAbsolutePriceFlag(rs.getString("NEGOT_TYPE_CD"));

  	spn.setService(svc);

  	//WE DO NOT SET FREE UNITS HERE

		spn.setChargeType(rs.getString(SVC_PRICE_CHARGE_TYPE));
		spn.setEffectiveDate(rs.getTimestamp(SVC_PRICE_EFFECTIVE_DATE));
		spn.setExpirationDate(rs.getTimestamp(SVC_PRICE_EXPIRATION_DATE));
		spn.setScenario(rs.getString(SVC_PRICE_SCENARIO_ID));

		spn.setInitCost(Double.valueOf(rs.getDouble(SVC_PRICE_INIT_UNIT_VALUE)));
		spn.setInitQuantity(Double.valueOf(rs.getDouble(SVC_PRICE_INIT_UNIT_QTTY)));
		spn.setInitType(rs.getString(SVC_PRICE_INIT_UNIT_TYPE));
		spn.setInitIncludedQuantity(Double.valueOf(rs.getDouble(SVC_PRICE_INIT_QTY_INCLUDED)));
		spn.setStepCost(Double.valueOf(rs.getDouble(SVC_PRICE_STEP_UNIT_VALUE)));
		spn.setStepQuantity(Double.valueOf(rs.getDouble(SVC_PRICE_STEP_UNIT_QTTY)));
		spn.setStepType(rs.getString(SVC_PRICE_STEP_UNIT_TYPE));
		spn.setStepIncludedQuantity(Double.valueOf(rs.getDouble(SVC_PRICE_STEP_QTY_INCLUDED)));

		spn.setNegotiable(rs.getString(SVC_PRICE_NEGOTIABLE_FLAG));
		spn.setPassThrough(rs.getString(SVC_PRICE_PASSTHROUGH_FLAG));
		spn.setPricingArea(rs.getString(SVC_PRICE_SPAREA_ID));
		long taxCategoryCode = rs.getLong(SVC_PRICE_TAX_CODE);
		if (taxCategoryCode > 0) {

			spn.setTaxCategory(this.getTaxCategory(Long.toString(taxCategoryCode)));
//			spn.getTaxCategory().setUid();

//			TaxCategory temp = loadSingleTax(TAX_CATEGORY_LOAD_QUERY,	 TAX_CATEGORY_TABLENAME + "." + TAX_CATEGORY_UID,
//					 Long.valueOf(rs.getLong(SVC_PRICE_TAX_CODE)));
//			p.setTaxCategory(temp);
		}
		spn.setUpdatedDate(rs.getTimestamp(SVC_PRICE_UPDATED_DATE));
		spn.setCustom1(rs.getString(SVC_PRICE_CUSTOM_1));
		spn.setCustom2(rs.getString(SVC_PRICE_CUSTOM_2));
		spn.setCustom3(rs.getString(SVC_PRICE_CUSTOM_3));
		spn.setChargeTypeId(rs.getString(SVC_CHARGE_TYPE_ID));

  	return spn;
  }
	// ---------------------------
	// Abstract methods
	// ---------------------------

	/* (non-Javadoc)
   * @see br.com.auster.vivo.billcheckout.pricing.PricingFacadeBase#getServicePriceQuery(br.com.auster.om.invoice.UsageDetail, br.com.auster.om.pricing.Service)
   */
  @Override
  protected String getServicePriceQuery(UsageDetail _usage, Service _service) {
	  // TODO Auto-generated method stub
	  return null;
  }



	/* (non-Javadoc)
   * @see br.com.auster.vivo.billcheckout.pricing.PricingFacadeBase#getSubscriptionFeeQuery(br.com.auster.om.invoice.ServiceDetail, br.com.auster.om.pricing.Service)
   */
  @Override
  protected String getSubscriptionFeeQuery(ServiceDetail _usage, Service _service) {
	  // TODO Auto-generated method stub
	  return null;
  }



	/* (non-Javadoc)
   * @see br.com.auster.vivo.billcheckout.pricing.PricingFacadeBase#inNotFoundList(java.lang.String, java.util.Date)
   */
  @Override
  protected boolean inNotFoundList(String _cacheKey, Date _usageDate) {
//  	log.trace("TKT318-inNotFoundList.CacheKey:[" + _cacheKey + "].Date:" + _usageDate);
//  	log.trace("TKT318-inNotFoundList.Returns:true");
	  return false;
  }

	/**
	 * Sets the variable parameters in the SQL statement. Theses values, as previously stated, must be <i>reachable</i>
	 * 	inside the usage or service incoming parameters, or as constants in the subclass implementation.
	 *
	 * @param _query the query created with the previously defined JDBC SQL sentence
	 * @param _usage the usage event data
	 * @param _service the service related to such event
	 */
	protected abstract void setServicePriceQueryParameters(PreparedStatement _query, UsageDetail _usage, Service _service) throws SQLException ;

	/**
	 * Sets the variable parameters in the SQL statement. Theses values, as previously stated, must be <i>reachable</i>
	 * 	inside the charge or service incoming parameters, or as constants in the subclass implementation.
	 *
	 * @param _query the query created with the previously defined JDBC SQL sentence
	 * @param _charge the service charge
	 * @param _service the service related to such event
	 */
	protected abstract void setSubscriptionFeeQueryParameters(PreparedStatement _query, ServiceDetail _charge, Service _service) throws SQLException ;

	protected PreparedStatement getPreparedStatement(String query) throws SQLException, NamingException {
		PreparedStatement stmt = this.statements.get(query);
		if (stmt == null) {
			stmt = getConnection().prepareStatement(query);
			this.statements.put(query, stmt);
			showStatus();
		}
		return stmt;
	}

	private Connection getConnection() throws SQLException, NamingException {
		if (this.connection == null) {
			this.connection = SQLConnectionManager.getInstance(this.poolName).getConnection();
		}
		return this.connection;
	}

	/**
	 * This method is called by AbstractRulesEngineProcessor.clear()
	 * whenever a request has finished processing.
	 * 
	 * @see br.com.auster.billcheckout.rules.ResourceHolder#releaseResources()
	 */
	public void releaseResources() {
		releaseAllStatements();
		releaseConnection();
		showStatus();
	}

	private void showStatus() {
		log.debug("Conexao " + (this.connection == null ? "fechada" : "aberta")
				+ " e " + this.statements.size() + " statement(s) no cache.");
	}

	private void releaseAllStatements() {
		try {
			for (PreparedStatement stmt : this.statements.values()) {
				try {
					stmt.close();
				} catch (SQLException e) {
					log.warn("Error closing PreparedStatement.", e);
				}
			}
		} finally {
			this.statements.clear();
		}
	}

	private void releaseConnection() {
		try {
			if (this.connection != null) {
				this.connection.close();
				this.connection = null;
			}
		} catch (SQLException e) {
			log.warn("Error releasing DB connection.", e);
		}
	}
}
