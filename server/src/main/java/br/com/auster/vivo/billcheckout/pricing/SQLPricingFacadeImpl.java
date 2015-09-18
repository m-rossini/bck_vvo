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
 * Created on Sep 19, 2005
 */
package br.com.auster.vivo.billcheckout.pricing;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.naming.NamingException;

import org.apache.commons.collections.map.LRUMap;
import org.apache.log4j.Logger;

import br.com.auster.common.log.LogFactory;
import br.com.auster.common.sql.SQLConnectionManager;
import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;
import br.com.auster.om.invoice.ServiceDetail;
import br.com.auster.om.invoice.UsageDetail;
import br.com.auster.om.pricing.InvalidPricingCalculationStateException;
import br.com.auster.om.pricing.PricingInformationNotFoundException;
import br.com.auster.om.pricing.Service;
import br.com.auster.om.pricing.ServicePrice;
import br.com.auster.om.pricing.ServicePriceNegotiated;
import br.com.auster.om.pricing.TaxRate;
import br.com.auster.om.util.ParserUtils;

/**
 * @author framos
 * @version $Id: PricingEngineImpl.java 211 2005-10-14 19:13:58Z framos $
 */
public class SQLPricingFacadeImpl extends SQLPricingFacadeBase {

	public static final int				QUERY_PARAMETER_SVC_PRICE_SEQ_NUMBER	= 1;
	public static final int				QUERY_PARAMETER_SVC_PRICE_DESCRIPTION	= 1;
	public static final int				QUERY_PARAMETER_EFFECTIVE_DATE				= 2;
	public static final int				QUERY_PARAMETER_EXPIRATION_DATE				= 3;

	public static final int				QUERY_PARAMETER_SVC_NAME							= 1;

	public static final String	SERVICE_QUERY		         = "SELECT objid, service_description, service_name, service_type, service_external_id, custom_1, custom_2, custom_3, import_id "
																+ "FROM prc_service where service_external_id = ?";

	public static final String	SERVICE_QUERY_BY_DESC	     = "SELECT objid, service_description, service_name, service_type, service_external_id, custom_1, custom_2, custom_3, import_id "
																+ "FROM prc_service where service_description = ?";


	public static final String  SERVICE_PRICE_QUERY		     = "SELECT * FROM prc_service_price "
																+ "WHERE scenario_id = ? "
																+ "ORDER BY updated_date desc";

	public static final String	SERVICE_PRICE_QUERY_BY_DESC	 = "SELECT prc_service_price.*, prc_service.service_name FROM prc_service_price "
																+ "JOIN prc_service on prc_service.objid = prc_service_price.service_id "
																+ "WHERE prc_service.service_description = ? "
																+ "AND prc_service_price.charge_type = 'R' "
																+ "AND prc_service_price.sp_area_id ";


	private String								whereAreaForSubscriptionStateQuery		= "";

	protected static final Logger log = LogFactory.getLogger(SQLPricingFacadeImpl.class);

	private static Map states = new HashMap();
	static {
		states.put("RS", "RS,CELULARCRT,EMPRESA");
		states.put("SC", "SC,GLOBAL TEL,EMPRESA");
		states.put("PR", "PR,GLOBAL TEL,EMPRESA");
		states.put("SP", "SP,TELESP,EMPRESA");
		states.put("RJ", "RJ,TELERJ,EMPRESA");
		states.put("ES", "ES,TELEST,EMPRESA");
		states.put("MG", "MG,EMPRESA");
		states.put("MT", "MT,TELEMAT,EMPRESA");
		states.put("MS", "MS,TELEMS,EMPRESA");
		states.put("DF", "DF,TCODF,EMPRESA");
		states.put("GO", "GO,TCOGO,EMPRESA");
		states.put("GF", "GO,TCOGO,EMPRESA");
		states.put("TO", "TO,EMPRESA");
		states.put("AC", "AC,TELEACRE,EMPRESA");
		states.put("AM", "AM,NBT AM,EMPRESA");
		states.put("RO", "RO,TELERON,EMPRESA");
		states.put("RR", "RR,NBT RR,EMPRESA");
		states.put("PA", "PA,NBT PA,EMPRESA");
		states.put("AP", "AP,NBT AP,EMPRESA");
		states.put("MA", "MA,NBT MA,EMPRESA");
		states.put("CE", "CE");
		states.put("PI", "PI");
		states.put("RN", "RN");
		states.put("PB", "PB");
		states.put("PE", "PE");
		states.put("AL", "AL");
		states.put("SE", "SE,TELERGIPE,TELELEST,AJU79,EMPRESA");
		states.put("BA", "BA,TELEBAHIA,TELELEST,SDR79,ITB73,JBN74,FSA75,VCA77,EMPRESA");
	}

	public SQLPricingFacadeImpl() {
		super();
		serviceCache = new LRUMap(1000);
	}

	/**
	 * @see br.com.auster.billcheckout.pricing.HibernatePricingEngineBase#calculatePriceFor(UsageDetail,
	 *      Service, ServicePrice)
	 */
	public double calculatePriceFor(UsageDetail _usage, Service _service,
			ServicePrice _price) throws PricingInformationNotFoundException,
			InvalidPricingCalculationStateException {
//		if (_price == null) {
//			log.warn("calculatePriceFor-service price information not set:"
//					+ _service);
//			throw new PricingInformationNotFoundException(_usage, _service);
//		}
		if (_price.isNegotiable() && this.skipNegotiables) {
//			log.trace("Skipping price calculation due to skip-negotiables flag.");
			return 0D;
		}
		// UnitCounter duration = _usage.getUsageDuration();
		String duration = _usage.getOriginalUsageDuration();
//		log.trace("Usage...." + _usage.getOriginalDatetime() + ".Duration is:" + duration);
		if (duration == null) {
//			log.trace("CallClass:" + _usage.getCallClass() + ".ObjType:"
//					+ _usage.getObjectType());
//			log.warn("SQLI-cannot calculate price with NULL duration for usage event");
			throw new InvalidPricingCalculationStateException(_usage, _service);
		}
		double taxRate = 1;
		boolean decOrIncNegot = false;
		double decOrIncFactor = 1;
		long start = System.nanoTime();
		try {
			String taxIncludedFlag = "N"; // default taxIncluded is N

			if (_price instanceof ServicePriceNegotiated) {
				// Negotiated Price
				ServicePriceNegotiated spn = (ServicePriceNegotiated) _price;

				taxIncludedFlag = spn.getTaxIncludedFlag();
				if (spn.getAbsolutePriceFlag().equalsIgnoreCase(ServicePriceNegotiated.PRICE_DISCOUNTED)) {
					// negotiated and discounted
					decOrIncNegot = true;
					decOrIncFactor = 1 - (spn.getDiscountPercent() / 100.0D);
//					log.trace("ServicePriceNegotiated.Discounted.discountOnNegot:" + decOrIncFactor);
				}
				else if (spn.getAbsolutePriceFlag().equalsIgnoreCase(ServicePriceNegotiated.PRICE_INCREASED)) {
					// negotiated and increased
					decOrIncNegot = true;
					decOrIncFactor = 1 + (spn.getDiscountPercent() / 100.0D);
//					log.trace("ServicePriceNegotiated.Discounted.discountOnNegot:" + decOrIncFactor);
				}

			} else {
				if (_price.getCustom3() != null){
					taxIncludedFlag = _price.getCustom3();
				}

				// Change due to new CSAs. The ADs of the plan VIVO EMPRESAS FLEX must
				// have their tax calculated, no matter what is the tax_incl_flag value.
				if (_service.getServiceName().contains("VIVO EMPRESAS FLEX")) {
					if ((_price.getChargeTypeId() != null) &&
						(_price.getChargeTypeId().startsWith("AD"))) {
						taxIncludedFlag = "N";
					}
				}
			}
			if (!taxIncludedFlag.equalsIgnoreCase("Y")) {
				// Tax Not Included (If the above flag is Y, then Tax is Included In
				// the Price
				taxRate = getTaxRate(_price, _usage, _service);
//				log.trace("ServicePriceNegotiated.Tax is NOT Included.Tax Rate Found is:" + taxRate);
			}
		} catch (PricingInformationNotFoundException pinfe) {
//			log.trace("calculatePriceFor-tax rate not found... defaulting to rate 1.0:" + _service);
		}
		try {
			if (_price.getChargeType().equals("U")) {
//				log.trace("calculatePriceFor-===>For service:" + _service + ".Price:" + _price + ".Tax:" + taxRate + ".Duration:" + duration);
				double addUsage = (_price.getInitType().equals("FLAT")) ? _price
						.getInitIncludedQuantity().doubleValue() : ParserUtils
						.getDouble(duration)
						- _price.getInitIncludedQuantity().doubleValue();
				// double addUsage = ParserUtils.getDouble(duration) -
				// _price.getInitIncludedQuantity().doubleValue();
				// compute initial cost
				double finalCost = _price.getInitCost().doubleValue();
				// compute step additional cost

				if (!_price.getInitType().equals("FLAT")) {
					if ((addUsage > 0) && (_price.getStepIncludedQuantity() != null)
							&& (_price.getStepIncludedQuantity().doubleValue() > 0)) {

						finalCost += (addUsage / _price.getStepIncludedQuantity()
								.doubleValue())
								* _price.getStepCost().doubleValue();
					} else if ((addUsage < 0)
							&& (_price.getStepIncludedQuantity() != null)

					) {
						// discard initial cost, overriding the final cost with only the
						// step
						// part
						finalCost = (ParserUtils.getDouble(duration) / _price
								.getStepIncludedQuantity().doubleValue());
						if (_price.getStepCost().doubleValue() != 0.0D) {
							finalCost *= _price.getStepCost().doubleValue();
						}

					}
				}
				// return final cost + taxes
				finalCost = (!decOrIncNegot) ? (finalCost * taxRate) : (finalCost * taxRate) * decOrIncFactor;
//				log.trace("FinalCost:" + finalCost + ".TaxRate:" + taxRate);
				return finalCost;
			} else if (_price.getChargeType().equals("F")) {
				return 0D;
			}
			return _price.getInitCost().doubleValue();
		} finally {
//			log.debug("calculatePriceFor-spent " + (System.nanoTime() - start) + " calculating service price information");
		}
	}

	/**
	 * Returns the tax rate for the current pricing information, based on the
	 * state id of the usage detail. This state id should be configured as the
	 * <code>TAX_KEY</code> in the <code>BCK_TAX_RATE</code> table.
	 *
	 * @see br.com.auster.billcheckout.pricing.PricingEngine#getTaxRate(br.com.auster.billcheckout.pricing.catalog.ServicePrice,
	 *      br.com.auster.om.invoice.UsageDetail,
	 *      br.com.auster.om.invoice.Service)
	 */
	public double getTaxRate(ServicePrice _price, UsageDetail _usage,
			Service _service) throws PricingInformationNotFoundException {

		String taxState = null;
		if (this.useSate == USE_STATE_ACCOUNT) {
			taxState = _usage.getInvoice().getAccount().getAccountState();
//			log.trace("Using as State for tax rate. Account. State:" + taxState);
		} else if (this.useSate == USE_STATE_USAGE) {
			taxState = _usage.getCarrierState();
//			log.trace("Using as State for tax rate. Usage. State:" + taxState);
		} else {
			// Relies to 300D record.
			taxState = _usage.getSection().getParentSection().getParentSection().getSubscriptionState();
//			log.trace("Using as State for tax rate. Service(Subscription). State:" + taxState);
		}
		return getTax(_price, taxState, _usage.getDatetime(), _service);
	}

	public double getTaxRate(ServicePrice _price, ServiceDetail _charge,
			Service _service) throws PricingInformationNotFoundException {
		// return getTax(_price, _charge.getInvoice().getAccount(),
		// _charge.getStartDate(), _service);

		String taxState = null;
		if (this.useSate == USE_STATE_ACCOUNT) {
			taxState = _charge.getInvoice().getAccount().getAccountState();
//			log.trace("Using as State for tax rate. Account. State:" + taxState);
		} else if (this.useSate == USE_STATE_USAGE) {
			// Here we use service any way
			taxState = _charge.getSection().getParentSection().getSubscriptionState();
//			log.trace("Using as State for tax rate. Usage. State:" + taxState);
		} else {
			taxState = _charge.getSection().getParentSection().getSubscriptionState();
//			log.trace("Using as State for tax rate. Service (Subscription). State:" + taxState);
		}
		return getTax(_price, taxState, _charge.getInvoice().getCycleEndDate(),	_service);
	}


	public double getTaxRate(ServiceDetail _charge) throws PricingInformationNotFoundException {
		String taxState = null;
		if (this.useSate == USE_STATE_ACCOUNT) {
			taxState = _charge.getInvoice().getAccount().getAccountState();
//			log.trace("Using as State for tax rate. Account. State:" + taxState);
		} else if (this.useSate == USE_STATE_USAGE) {
			// Here we use service any way
			taxState = _charge.getSection().getParentSection().getSubscriptionState();
//			log.trace("Using as State for tax rate. Usage. State:" + taxState);
		} else {
			taxState = _charge.getSection().getParentSection().getSubscriptionState();
//			log.trace("Using as State for tax rate. Service (Subscription). State:" + taxState);
		}
		return getTaxForService(_charge.getServicePrice(), taxState);
	}

	/**
	 * Loads a <code>Service</code> object to represent the service information,
	 * related to the current usage event. This relation is expressed in the
	 * <code>svcId</code> attribute in the <code>UsageDetail</code> class.
	 *
	 * @see br.com.auster.billcheckout.pricing.PricingEngine#getService(br.com.auster.om.invoice.UsageDetail)
	 */
	public Service getServiceFor(UsageDetail _usage) {
		Service s = loadService(SERVICE_QUERY, _usage.getSvcPlan(), _usage.getSection().getParentSection().getParentSection().getSubscriptionState());

		//SETS THE SERVICE NOT FOUND FLAG
		_usage.setServiceExists( (s != null) );

		return s;
	}

	/**
	 * @see br.com.auster.om.pricing.facade.PricingFacade#getServiceFor(br.com.auster.om.invoice.ServiceDetail)
	 */
	public Service getServiceFor(ServiceDetail _charge) {
		return loadService(SERVICE_QUERY_BY_DESC, _charge.getCaption(),_charge.getSection().getParentSection().getSubscriptionState());
	}

	/**
	 * @see br.com.auster.billcheckout.pricing.PricingEngine#canCalculatePrice(br.com.auster.om.invoice.UsageDetail)
	 */
	public boolean canCalculatePrice(UsageDetail _usage) {
		return canCalculatePrice(_usage, getServiceFor(_usage));
	}

	/**
	 * @see br.com.auster.billcheckout.pricing.PricingEngine#canCalculatePrice(br.com.auster.om.invoice.UsageDetail,
	 *      br.com.auster.om.pricing.Service)
	 */
	public boolean canCalculatePrice(UsageDetail _usage, Service _service) {
		try {
			ServicePrice sp = getPriceFor(_usage, _service);
			return (sp != null);
		} catch (PricingInformationNotFoundException pinfe) {
//			log.debug("could not find price service information:" + _service);
		}
		return false;
	}

	/**
	 * @see br.com.auster.billcheckout.pricing.PricingEngine#getServicePriceQuery(br.com.auster.om.invoice.UsageDetail,
	 *      br.com.auster.om.invoice.Service)
	 */
	protected String getServicePriceQuery(UsageDetail _usage, Service _service) {
		return SERVICE_PRICE_QUERY;
	}

	/**
	 * @see br.com.auster.om.pricing.facade.impl.PricingFacadeBase#getSubscriptionFeeQuery(br.com.auster.om.invoice.ServiceDetail,
	 *      br.com.auster.om.invoice.Service)
	 */
	protected String getSubscriptionFeeQuery(ServiceDetail _charge,	Service _service) {
		return SERVICE_PRICE_QUERY;
	}

	/*****************************************************************************
	 * Not part of the interface. Anyone using this interface should cast to this
	 * class. This method sets a instance field to be used as where clause for
	 * getting a subscription fee for method
	 *
	 * @see br.com.auster.om.pricing.facade.impl.PricingFacadeBase#getSubscriptionFeeQuery(br.com.auster.om.invoice.ServiceDetail,
	 *      br.com.auster.om.invoice.Service)
	 *
	 * This method expects to receive the after column name where string. For
	 * example: where column IN (A,B)
	 *
	 * This method expects to receive the "IN (A,B)" part.
	 * @param fullWhere
	 */
	public void setQueryListParameters(String fullWhere) {
		this.whereAreaForSubscriptionStateQuery = fullWhere;
	}

	/*****************************************************************************
	 * Receive parms to be replaced to build the query that will get the WHERE
	 * clause.
	 *
	 * Each parameter wil be put in a IN Sequence to build something like
	 *
	 * IN ('A', 'B','C')
	 *
	 * Where A, B and C are ocurrences int the array.
	 *
	 * @param parms
	 */
	public void setQueryListParameters(String[] parms) {
		StringBuffer buf = new StringBuffer();
		buf.append(" in (");
		for (int i = 0; i < parms.length; i++) {
			buf.append('\'');
			buf.append(parms[i]);
			buf.append('\'');
			if (i < parms.length - 1) {
				buf.append(',');
			}
		}
		buf.append(")");
		whereAreaForSubscriptionStateQuery = buf.toString();
	}

	/**
	 * @see br.com.auster.billcheckout.pricing.PricingEngine#setServicePriceQueryParameters(java.sql.PreparedStatement,
	 *      br.com.auster.om.invoice.UsageDetail,
	 *      br.com.auster.om.invoice.Service)
	 */
	protected void setServicePriceQueryParameters(PreparedStatement _query,
			UsageDetail _usage, Service _service) throws SQLException {
		_query.setString(QUERY_PARAMETER_SVC_PRICE_SEQ_NUMBER, _usage.getSvcId());
		// _query.setTimestamp(QUERY_PARAMETER_EFFECTIVE_DATE, new
		// Timestamp(_usage.getDatetime().getTime()));
		// _query.setTimestamp(QUERY_PARAMETER_EXPIRATION_DATE, new
		// Timestamp(_usage.getDatetime().getTime()));
	}

	/**
	 * @see br.com.auster.om.pricing.facade.impl.SQLPricingFacadeBase#setSubscriptionFeeQueryParameters(java.sql.PreparedStatement,
	 *      br.com.auster.om.invoice.ServiceDetail,
	 *      br.com.auster.om.invoice.Service)
	 */
	protected void setSubscriptionFeeQueryParameters(PreparedStatement _query, ServiceDetail _charge, Service _service) throws SQLException {
//		log.debug("Parameter for " + QUERY_PARAMETER_SVC_PRICE_DESCRIPTION + ": " + _charge.getSvcId());
		_query.setString(QUERY_PARAMETER_SVC_PRICE_DESCRIPTION, _charge.getSvcId());

	}

	/**
	 * Since the hibernate query is already sorting the objects by updatedDate, in
	 * descending order, the more recent price information is stored in the first
	 * position of the resulting list.
	 *
	 * @see br.com.auster.billcheckout.pricing.HibernatePricingEngineBase#selectLatestPrice(java.util.List)
	 */
	protected ServicePrice selectLatestPrice(List _resultList) {
		if ((_resultList != null) && (!_resultList.isEmpty())) {
			return (ServicePrice) _resultList.get(0);
		}
		return null;
	}

	/**
	 * Addes the <i>service price sequence number</i> of the usage event to the
	 * list of unkown service prices, since its the only attribute used to search
	 * for pricing information. The next usage event holding the same <i>service
	 * price sequence number</i> will not take time searching for the service
	 * price in the cache or in the database.
	 *
	 * @see br.com.auster.billcheckout.pricing.PricingEngineBase#addToNotFoundList(java.lang.String,
	 *      java.util.Date)
	 */
	protected void addToNotFoundList(String _key, Date _date) {
		String k = _key + "_" + _date.getTime();
//		log.trace("TKT318-Adding service to not found List.Key:[" + k + "]");
		pricingNotFound.put(k, _key);
	}

	/**
	 * Identifies if the current <i>service price sequence number</i> is in the
	 * list of unkown pricing information search criterias. If so, it will save
	 * time searching for the pricing information in the cache and database.
	 *
	 * @see br.com.auster.billcheckout.pricing.PricingEngineBase#inNotFoundList(java.lang.String,
	 *      java.util.Date)
	 */
	protected boolean inNotFoundList(String _key, Date _date) {
		String k = _key + "_" + _date.getTime();
//		log.trace("TKT318-inNotFoundList.Returns:" + pricingNotFound.containsKey(k) + ".CacheKey:[" + k + "]");
		return pricingNotFound.containsKey(k);
	}

	/**
	 * @see br.com.auster.billcheckout.pricing.PricingFacadeBase#buildCacheKey(br.com.auster.om.invoice.UsageDetail,
	 *      br.com.auster.om.pricing.Service)
	 */
	protected String buildCacheKey(UsageDetail _usage, Service _service) {
//		log.trace("TKT318-buildCacheKey (Usage).CacheKey:[" + _usage.getSvcId() + "] for Usage:" + _usage + " and service uid:"  + _service.getUid());
		return _usage.getSvcId();
	}

	/**
	 * @see br.com.auster.billcheckout.pricing.PricingFacadeBase#buildCacheKey(br.com.auster.om.invoice.ServiceDetail,
	 *      br.com.auster.om.pricing.Service)
	 */
	protected String buildCacheKey(ServiceDetail _charge, Service _service) {
//		log.trace("TKT318-buildCacheKey.CacheKey:[" + _charge.getSvcId() + "] for Charge ID:" + _charge.getSvcId());
		return _charge.getSvcId();
	}

	protected String buildCacheKey(ServiceDetail _charge) {
//		log.trace("TKT318-buildCacheKey.CacheKey:[" + _charge.getSvcId() + "] for Charge ID:" + _charge.getSvcId());
		return _charge.getSvcId();
	}

	/**
	 * Loads a <code>Service</code> object using the specified query and its id
	 * parameter. If more then one is found, then only the first is loaded.
	 */
	protected Service loadService(String _query, String _serviceId) {
		return loadService(_query, _serviceId,null);
	}

	protected Service loadService(String _query, String _serviceId, String state) {
		Service svc = null;
		String localService = (state == null) ? _serviceId : _serviceId + "." + state;
		PreparedStatement stmt = null;
		ResultSet rset = null;
		StatsMapping stats = ProcessingStats.starting(getClass(), "loadService()");
		try {
			svc = findServiceInCache(localService);
			if (svc == null) {
//				log.trace("loadService-service not found in cache... going to database:" + localService);
//				log.trace("loadService-Query:" + _query);
				stmt = getPreparedStatement(_query);
				stmt.setString(QUERY_PARAMETER_SVC_NAME, _serviceId);
				rset = stmt.executeQuery();
				if (rset.next()) {
					svc = new Service();
					svc.setUid(rset.getLong("objid"));
					svc.setServiceName(rset.getString("service_name"));
					svc.setServiceDescription(rset.getString("service_description"));
					svc.setServiceType(rset.getString("service_type"));
					svc.setCustom1(rset.getString("custom_1"));
					svc.setCustom2(rset.getString("custom_2"));
					svc.setCustom3(rset.getString("custom_3"));
					svc.setExternalId(rset.getString("service_external_id"));
//					log.trace("loadService-service found in database... adding it to cache.ServiceID:" + localService + ".Service:" + svc);
					putServiceInCache(localService, svc);
//				} else {
//					log.trace("loadService-service not found in database:" + localService);
				}
			}
		} catch (NamingException ne) {
			log.error("loadService-caught persistence exception", ne);
		} catch (SQLException sqle) {
			log.error("loadService-caught persistence exception", sqle);
		} finally {
			stats.finished();
			try {
				if (rset != null) {
					rset.close();
				}
				if (stmt != null) {
					stmt.clearParameters();
				}
			} catch (SQLException sqle) {
				log.error("loadService-caught persistence exception", sqle);
			}
		}
		return svc;

	}

	protected double getTaxForService(ServicePrice _price, String taxState)
			throws PricingInformationNotFoundException {

		// must always send a pricing information
		if (_price == null) {
			throw new IllegalArgumentException("cannot locate the tax rate for a NULL service price.");
		}

		// if no tax category was specified
		if (_price.getTaxCategory() == null) {
			throw new PricingInformationNotFoundException("no tax information found for current service price.Price:" + _price);
		}

		TaxRate tr = _price.getTaxCategory().getTaxRate(taxState, _price.getEffectiveDate());
		if (tr == null) {
			throw new PricingInformationNotFoundException("no tax rate found for usage event state " + taxState);
		}
		return tr.getTaxRate();
	}

	protected double getTax(ServicePrice _price, String taxState,
			Date _usageDate, Service _service)
			throws PricingInformationNotFoundException {
		// must always send a pricing information
		if (_price == null) {
			throw new IllegalArgumentException( "cannot locate the tax rate for a NULL service price.Service:" + _service);
		}
		// if no tax category was specified
		if (_price.getTaxCategory() == null) {
			throw new PricingInformationNotFoundException("no tax information found for current service price.Price:" + _price);
		}
		// cehcking the tax rate
//		if (log.isDebugEnabled()) {
////			log.debug("About to get Tax Category");
//			log.debug("Area:" + taxState + ".Date:" + _usageDate);
//			if (_price.getTaxCategory() != null) {
//				log.debug("TaxCategory:" + _price.getTaxCategory().getUid() + ".Cat:"
//						+ _price.getTaxCategory().getTaxCode());
//				if (_price.getTaxCategory().getTaxRate(taxState, _usageDate) != null) {
//					log.debug("Tax Rate UID:"
//							+ _price.getTaxCategory().getTaxRate(taxState, _usageDate)
//									.getUid());
//					log.debug("Tax Rate Rate:"
//							+ _price.getTaxCategory().getTaxRate(taxState, _usageDate)
//									.getTaxRate());
//				} else {
//					log.debug("Tax Rate for TaxCategory:" + _price.getTaxCategory()
//							+ " and State:" + taxState + " and Date:" + _usageDate
//							+ " is null");
//				}
//
//			} else {
//				log.debug("TaxCategory is NULL");
//			}
//		}
		TaxRate tr = _price.getTaxCategory().getTaxRate(taxState, _usageDate);
		if (tr == null) {
			throw new PricingInformationNotFoundException("no tax rate found for usage event state " + taxState);
		}
		return tr.getTaxRate();
	}

	/**
	 * @see br.com.auster.om.pricing.PricingFacade#getNegotiatedPriceFor(UsageDetail,
	 *      Service, ServicePrice)
	 *
	 * @deprecated As far as from implementation of one account access to get
	 *             negotiated price, Just use the mehtod
	 *             getNegotiatedPriceFor(UsageDetail usage)
	 */
	public ServicePrice getNegotiatedPriceFor(UsageDetail _usage,
			Service _service, ServicePrice _price)
			throws PricingInformationNotFoundException {

		return getNegotiatedPriceFor(_usage);
		/*
		 * SELECT 0 as objid, charge_type, effective_date, expiration_date,
		 * scenario_id, 0 as free_units_id, initial_unit_value, initial_unit_qty,
		 * initial_unit_type, initial_unit_incl_qty, step_unit_value, step_unit_qty,
		 * step_unit_type, step_unit_incl_qty, 'Y' as negotiable_flag, 'N' as
		 * passthrough_flag, sp_area_id, tax_code, updated_date, '' as custom_1, ''
		 * as custom_2, '' as custom_3 FROM sometable WHERE scenario_id = ? and
		 * account_number = ?
		 *
		 */
		// negotiable pool not configured
		// if (this.negotPool == null) {
		// return _price;
		// }
		// ServicePrice sp = _price;
		// PreparedStatement stmt = null;
		// Connection conn = null;
		// try {
		// conn = SQLConnectionManager.getInstance(this.negotPool).getConnection();
		// SQLStatement sqlStmt =
		// SQLConnectionManager.getInstance(this.negotPool).getStatement(
		// this.negotPriceStatement);
		// if (sqlStmt == null) {
		// log.error("PricingFacade configuration missing name for negotiated
		// pricing tables query.");
		// throw new PricingInformationNotFoundException(
		// "PricingFacade configuration missing name for negotiated pricing tables
		// query.");
		// }
		//
		// boolean accessKeyIsAccount = true;
		// String accessKey = null;
		// if (accessKeyIsAccount) {
		// accessKey = _usage.getInvoice().getAccount().getAccountNumber();
		// } else {
		// // Service/Section Detail
		// accessKey = _usage.getSection().getSubscriptionid();
		// }
		//
		// stmt = conn.prepareStatement(sqlStmt.getStatementText());
		// stmt.setString(1, _usage.getSvcId());
		// // stmt.setString(2,
		// _usage.getInvoice().getAccount().getAccountNumber());
		// stmt.setString(2, accessKey);
		// // String cacheKey = _usage.getSvcId() + "@" +
		// // _usage.getInvoice().getAccount().getAccountNumber();
		// String cacheKey = _usage.getSvcId() + "@" + accessKey;
		// sp = loadAllAndReturnPrice(stmt, _service, cacheKey,
		// _usage.getDatetime(), false, true);
		// if (sp != null) {
		// // load taxes for negotiated price
		// if (sp.getTaxCategory() != null) {
		// sp.setTaxCategory(getTaxCategory(String.valueOf(sp.getTaxCategory().getUid())));
		// } else {
		// sp.setTaxCategory(getTaxCategory("0"));
		// }
		// } else {
		// // negotiated price not found! Using previously one.
		// sp = _price;
		// }
		// } catch (SQLException sqle) {
		// log.error("Exception while querying negotiable tables", sqle);
		// PricingInformationNotFoundException ex = new
		// PricingInformationNotFoundException(
		// "Exception while querying negotiable tables.");
		// ex.initCause(sqle);
		// throw ex;
		// } catch (NamingException ne) {
		// log.error("Exception while querying negotiable tables", ne);
		// PricingInformationNotFoundException ex = new
		// PricingInformationNotFoundException(
		// "Exception while querying negotiable tables.");
		// ex.initCause(ne);
		// throw ex;
		// } finally {
		// try {
		// if (stmt != null) {
		// stmt.close();
		// }
		// if (conn != null) {
		// conn.close();
		// }
		// } catch (SQLException sqle) {
		// log.error("Exception while closing resources", sqle);
		// PricingInformationNotFoundException ex = new
		// PricingInformationNotFoundException(
		// "Exception while closing resources.");
		// ex.initCause(sqle);
		// throw ex;
		// }
		// }
		// return sp;
	}

	/*****************************************************************************
	 * This method is supposed to retur
	 */
	public ServicePriceNegotiated getNegotiatedPriceFor(UsageDetail usage) {
		String subscriptionid = usage.getSection().getSubscriptionid();
		if (this.negotUsagePricesMap == null) {
			return null;
		}

		List<ServicePriceNegotiated> priceList = (List) this.negotUsagePricesMap.get(subscriptionid);
		if (priceList == null) {
//			log.debug("There is no negotiated prices for this usage belonging to Subscription ID:" + usage.getSection().getSubscriptionid());
			return null;
		}

		for (Iterator<ServicePriceNegotiated> it = priceList.iterator(); it.hasNext();) {
			ServicePriceNegotiated spn = it.next();
			if (spn.getScenario().equals(usage.getSvcId())) {
//				log.debug("Found a match for Scenario ID:" + spn.getScenario());
				if ( (spn.getExpirationDate() == null || (spn.getExpirationDate().after(usage.getDatetime()))) && spn.getEffectiveDate().before(usage.getDatetime())) {
//					log.debug("Found a Negotiated Price for usage." + spn);
					return spn;
//				} else {
//					log.debug("Negotiation time doesn't match usage date. " + spn + "   " + usage);
				}
			}
		}
		return null;
	}

	public ServicePriceNegotiated getNegotiatedPriceForService(ServiceDetail serviceDetail) {
		String subscriptionid = serviceDetail.getSection().getSubscriptionid();
		if (this.negotUsagePricesMap == null) {
			return null;
		}

		List<ServicePriceNegotiated> priceList = (List) this.negotUsagePricesMap.get(subscriptionid);
		if (priceList == null) {
//			log.debug("There is no negotiated prices for this service belonging to Subscription ID:" + serviceDetail.getSection().getSubscriptionid());
			return null;
		}

		for (Iterator<ServicePriceNegotiated> it = priceList.iterator(); it.hasNext();) {
			ServicePriceNegotiated spn = it.next();
			if (spn.getScenario().equals(serviceDetail.getSvcId())) {
//				log.debug("Found a match for Scenario ID:" + spn.getScenario());
				if ( (spn.getExpirationDate() == null || (spn.getExpirationDate().after(serviceDetail.getStartDate()))) && (spn.getEffectiveDate().compareTo(serviceDetail.getStartDate())) <= 0) {
//					log.debug("Found a Negotiated Price for service." + spn);
					spn.setPriceNegotiated(true);
					return spn;
//				} else {
//					log.debug("Negotiation time doesn't match service date. " + spn + "   " + serviceDetail);
				}
			}
		}
		return null;
	}
}
