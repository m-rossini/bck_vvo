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
 * Created on Oct 22, 2005
 */
package br.com.auster.vivo.billcheckout.pricing;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.LRUMap;
import org.apache.log4j.Logger;
import org.w3c.dom.Element;

import br.com.auster.common.datastruct.RangeMap;
import br.com.auster.common.log.LogFactory;
import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.om.invoice.SectionDetail;
import br.com.auster.om.invoice.ServiceDetail;
import br.com.auster.om.invoice.UsageDetail;
import br.com.auster.om.pricing.InvalidPricingCalculationStateException;
import br.com.auster.om.pricing.PricingException;
import br.com.auster.om.pricing.PricingFacade;
import br.com.auster.om.pricing.PricingInformationNotFoundException;
import br.com.auster.om.pricing.Service;
import br.com.auster.om.pricing.ServicePrice;
import br.com.auster.om.pricing.ServicePriceNegotiated;
import br.com.auster.om.pricing.SubscriptionFeeInformationNotFoundException;
import br.com.auster.om.reference.facade.ConfigurationException;
import br.com.auster.om.util.UnitConvertor;
import br.com.auster.om.util.UnitCounter;
import br.com.auster.vivo.billcheckout.util.InvoiceUtils;

/**
 * @author framos
 * @version $Id$
 */
public abstract class PricingFacadeBase implements PricingFacade {

	// ---------------------------
	// Class constants
	// ---------------------------


	public static final String CONFIGURATION_FILE_ATTR = "config-file";
	public static final String ENCRYPTED_FLAG_ATTR = "encrypted";
	public static final String CACHE_SIZE_ATTR = "cache-size";
	public static final String NOTFOUNDSET_SIZE_ATTR = "notfoundset-size";
	public static final String NEGOT_DRYRUN_ATTR = "skip-negotiables";
	public static final String USE_STATE_ATTR = "use-state";

	public static final int DEFAULT_CACHE_SIZE = 10000;
	public static final int DEFAULT_NOTFOUNDSET_SIZE = 10000;

	// ---------------------------
	// Instance variables
	// ---------------------------

	// moved from SQLPricingFacadeImpl to use across other calls
	protected Map<String, Service> serviceCache;

	protected Map<String, RangeMap> pricingCache;
	protected LRUMap pricingNotFound;
	protected int cacheSize;
	protected int notfoundSize;
	protected boolean skipNegotiables;

	protected UnitConvertor convertion;
	protected Map<? extends Object, ? extends Object> negotUsagePricesMap;

	public static final int USE_STATE_ACCOUNT = 1;
	public static final int USE_STATE_SUBSCRIPTION = 2;
	public static final int USE_STATE_USAGE = 3;
	protected int useSate = USE_STATE_SUBSCRIPTION;

	private static final Logger log = LogFactory.getLogger(PricingFacadeBase.class);

	// Taxes Deflator
	private static Map deflatMap = new HashMap();
	static {

		deflatMap.put("SP", new Double(0.740529));
		deflatMap.put("RS", new Double(0.740529));
		deflatMap.put("SC", new Double(0.740529));
		deflatMap.put("PR", new Double(0.719772));
		deflatMap.put("RJ", new Double(0.688635));
		deflatMap.put("ES", new Double(0.740529));
		deflatMap.put("BA", new Double(0.719772));
		deflatMap.put("SE", new Double(0.719772));
		deflatMap.put("AC", new Double(0.740529));
		deflatMap.put("DF", new Double(0.740529));
		deflatMap.put("TO", new Double(0.740529));
		deflatMap.put("AM", new Double(0.740529));
		deflatMap.put("MA", new Double(0.719772));
		deflatMap.put("RR", new Double(0.740529));
		deflatMap.put("AP", new Double(0.740529));
		deflatMap.put("MS", new Double(0.699014));
		deflatMap.put("MT", new Double(0.688635));
		deflatMap.put("GO", new Double(0.699014));
		deflatMap.put("PA", new Double(0.688635));
		deflatMap.put("RO", new Double(0.636741));
		deflatMap.put("AL", new Double(0.719772));
		deflatMap.put("CE", new Double(0.719772));
		deflatMap.put("PI", new Double(0.740529));
		deflatMap.put("PB", new Double(0.688635));
		deflatMap.put("PE", new Double(0.709393));
		deflatMap.put("RN", new Double(0.719772));
		deflatMap.put("MG", new Double(0.740529));
	}

	// ---------------------------
	// Constructors
	// ---------------------------

	public PricingFacadeBase() {
		this(DEFAULT_CACHE_SIZE, DEFAULT_NOTFOUNDSET_SIZE);
	}

	public PricingFacadeBase(int _cacheSize) {
		this(_cacheSize, DEFAULT_NOTFOUNDSET_SIZE);
	}

	public PricingFacadeBase(int _cacheSize, int _notfoundSet) {
		this.initCache(_cacheSize);
		this.initNotFoundSet(_notfoundSet);
		// TODO this cache has no configuration for size yet
		this.serviceCache = new LRUMap(1000);
	}

	// ---------------------------
	// Public methods
	// ---------------------------_

	public void setCacheSize(int _size) {
		this.initCache(_size);
	}

	public int getCacheSize() {
		return this.cacheSize;
	}

	public void setNotFoundSetSize(int _size) {
		this.initNotFoundSet(_size);
	}

	public int getNotFoundSetSize() {
		return this.notfoundSize;
	}

	/**
	 * @see br.com.auster.om.reference.facade.ReferenceFacades#configure(org.w3c.dom.Element)
	 */
	public void configure(Element _configuration) throws ConfigurationException {
		this.setCacheSize(DOMUtils.getIntAttribute(_configuration,
				CACHE_SIZE_ATTR, false));
		this.setNotFoundSetSize(DOMUtils.getIntAttribute(_configuration,
				NOTFOUNDSET_SIZE_ATTR, false));
		this.skipNegotiables = DOMUtils.getBooleanAttribute(_configuration,
				NEGOT_DRYRUN_ATTR, true);

		String useState = DOMUtils.getAttribute(_configuration, USE_STATE_ATTR,
				false);
		if (null != useState && !"".equals(useState)) {
			if (useState.equalsIgnoreCase("ACC")) {
				this.useSate = USE_STATE_ACCOUNT;
			} else if (useState.equalsIgnoreCase("SUB")) {
				this.useSate = USE_STATE_SUBSCRIPTION;
			} else if (useState.equalsIgnoreCase("USG")) {
				this.useSate = USE_STATE_USAGE;
			} else {
				this.useSate = USE_STATE_SUBSCRIPTION;
			}
		}
		log.debug("Pricing Facade Base Options:Cache Size:"
				+ this.getCacheSize() + ".Not Found Set Size:"
				+ this.getNotFoundSetSize() + ".SkipNegotiables:"
				+ this.skipNegotiables + ".useState:" + this.useSate);
	}

	/**
	 * @see br.com.auster.om.reference.facade.ReferenceFacades#configure(java.lang.String)
	 */
	public void configure(String _configFile) throws ConfigurationException {
		configure(_configFile, false);
	}

	/**
	 * Calculates the final cost of the current usage event and service
	 * information, according to the formula defined in the class description.
	 *
	 * @see br.com.auster.om.pricing.PricingFacade#calculatePriceFor(br.com.auster.om.invoice.UsageDetail,
	 *      br.com.auster.om.invoice.Service)
	 */
	public double calculatePriceFor(UsageDetail _usage, Service _service)
			throws PricingInformationNotFoundException,
			InvalidPricingCalculationStateException {
		ServicePrice price = getPriceFor(_usage, _service);
//		log.debug("PricingFacadeBase.About to calculatePriceFor usage,service.");
		return calculatePriceFor(_usage, _service, price);
	}

	/**
	 * @see br.com.auster.om.pricing.PricingFacade#calculatePriceFor(UsageDetail,
	 *      Service, ServicePrice)
	 */
	public double calculatePriceFor(UsageDetail _usage, Service _service,
			ServicePrice _price) throws PricingInformationNotFoundException,
			InvalidPricingCalculationStateException {
		if (_price == null) {
//			log.warn("calculatePriceFor-service price information is null");
			throw new PricingInformationNotFoundException(_usage, _service);
		}

		UnitCounter duration = _usage.getUsageDuration();
		if (duration == null) {
//			log.error("calculatePriceFor-cannot calculate price with NULL duration for usage event");
			throw new InvalidPricingCalculationStateException(_usage, _service);
		}
		double taxRate = 1;
		try {
			taxRate = getTaxRate(_price, _usage, _service);
		} catch (PricingInformationNotFoundException pinfe) {
			log.debug("calculatePriceFor-tax rate not found... defaulting to rate 1.0");
		}
		// compute initial cost
		double finalCost = _price.getInitCost().doubleValue();
		// compute step additional cost
		double convertionRate = convertion.getConvertionFactor(duration
				.getType(), _price.getInitType());
//		log.debug("calculatePriceFor-===>For service:" + _service + ".Price:"
//				+ _price + ".Tax:" + taxRate + ".Duration:" + duration);
//		log.debug("calculatePriceFor-===>Using conversion rate:"
//				+ convertionRate + "for units:(Usage:" + duration.getType()
//				+ ") and (Pricing:" + _price.getInitType() + ") ");
		long addUsage = (long) (duration.getUnits() * convertionRate)
				- _price.getInitQuantity().longValue();
		if ((addUsage > 0) && (_price.getStepQuantity().doubleValue() > 0)) {
			finalCost += (addUsage / _price.getStepQuantity().doubleValue())
					* _price.getStepCost().doubleValue();
		}
		// return final cost + taxes
		return (finalCost * taxRate);
	}

	/**
	 * @see br.com.auster.om.pricing.PricingFacade#calculatePriceFor(UsageDetail)
	 */
	public double calculatePriceFor(UsageDetail _usage)
			throws PricingInformationNotFoundException,
			InvalidPricingCalculationStateException {
//		log.debug("PricingFacadeBase.About to calculatePriceFor usage.");
		return calculatePriceFor(_usage, getServiceFor(_usage));
	}

	/**
	 * @see br.com.auster.om.pricing.PricingFacade#calculateSubscriptionFeeFor(ServiceDetail,
	 *      Service)
	 */
	@Deprecated
	public double calculateSubscriptionFeeFor(ServiceDetail _charge,
			Service _service)
			throws SubscriptionFeeInformationNotFoundException {

		ServicePrice price = getSubscriptionFeeFor(_charge, _service);
		if (price == null) {
//			log.warn("service price information not found");
			throw new SubscriptionFeeInformationNotFoundException(_charge, _service);
		}
		double taxRate = 1;
		try {
//			log.trace("Getting tax rate (calculateSubscriptionFeeFor).ChargeCaption:"
//							+ _charge.getCaption()
//							+ ".ChargeTag:"
//							+ _charge.getTag()
//							+ ".ServiceDescription:"
//							+ _service.getServiceDescription()
//							+ ".ServiceObjid: " + _service.getUid());
			taxRate = getTaxRate(price, _charge, _service);
		} catch (PricingInformationNotFoundException pinfe) {
			log.debug("tax rate not found... defaulting to rate 1.0");
		}
		// return final cost + taxes
		return (price.getInitCost().doubleValue() * taxRate);
	}


	public double calcSubscriptionFeeFor(ServiceDetail serviceDetail) throws SubscriptionFeeInformationNotFoundException {

		if (serviceDetail.getServicePrice() == null) {
//			log.warn("service price information not found");
			throw new SubscriptionFeeInformationNotFoundException("ServicePrice information not found: " + serviceDetail);
		}

		double taxRate = 1; // default taxRate is 1
		String taxIncludedFlag = "N"; // default taxIncluded is N
		if (serviceDetail.getServicePrice().getCustom3() != null){
			taxIncludedFlag = serviceDetail.getServicePrice().getCustom3();
		}
		boolean negotAndDiscounted = false;
		double discountOnNegot = 0;

		// Verifying if it's a negotiated price
		if (serviceDetail.getServicePrice() instanceof ServicePriceNegotiated) {
			ServicePriceNegotiated spn = (ServicePriceNegotiated) serviceDetail.getServicePrice();
			if (spn.getAbsolutePriceFlag().equalsIgnoreCase("D")) {
				negotAndDiscounted = true;
				discountOnNegot = spn.getDiscountPercent() / 100.0D;
//				log.trace("ServicePriceNegotiated.Discounted.discountOnNegot:" + discountOnNegot);
			}
			taxIncludedFlag = spn.getTaxIncludedFlag();
		}

		// If taxes NOT included, retrieve the tax for this usage
		if (!taxIncludedFlag.equals("Y")) {
			try {
//			log.trace("Getting tax rate (calculateSubscriptionFeeFor).ChargeCaption:"
//					+ serviceDetail.getCaption()
//					+ ".ChargeTag:"
//					+ serviceDetail.getTag()
//					+ ".ScenarioId: " + serviceDetail);

			taxRate = getTaxRate(serviceDetail);

			} catch (PricingInformationNotFoundException pinfe) {
				log.debug("tax rate not found... defaulting to rate 1.0");
			}
		}

		// apply deflators to the tariff tax if it's a government account (E, G, B L)
		String acctType = serviceDetail.getInvoice().getAccount().getAccountType();
		if ("E".equals(acctType) || "G".equals(acctType) || "B".equals(acctType) || "L".equals(acctType)) {
			Double deflatFactor = (Double) deflatMap.get(serviceDetail.getSection().getParentSection().getSubscriptionState());
			if (deflatFactor != null && deflatFactor != 0) {
				taxRate *= deflatFactor;
			}
		}

		// return final cost + taxes + discounted (if any)
		double finalCost = serviceDetail.getServicePrice().getInitCost().doubleValue();
		finalCost = (!negotAndDiscounted) ? (finalCost * taxRate) : (finalCost * taxRate) * (1 - discountOnNegot);
		return (finalCost);
	}

	/**
	 * @see br.com.auster.om.pricing.PricingFacade#calculateSubscriptionFeeFor(ServiceDetail)
	 */
	@Deprecated
	public double calculateSubscriptionFeeFor(ServiceDetail _charge)
			throws SubscriptionFeeInformationNotFoundException {
		return calculateSubscriptionFeeFor(_charge, getServiceFor(_charge));
	}


	public double calcSubscriptionFee(ServiceDetail serviceDetail) throws SubscriptionFeeInformationNotFoundException {
		return calcSubscriptionFeeFor(serviceDetail);
	}

	/**
	 * @see br.com.auster.om.pricing.PricingFacade#getPriceFor(br.com.auster.om.invoice.UsageDetail)
	 */
	public ServicePrice getPriceFor(UsageDetail _usage)
			throws PricingInformationNotFoundException {
		return getPriceFor(_usage, getServiceFor(_usage));
	}

	/**
	 * @see br.com.auster.om.pricing.facade..PricingFacade#hasPrice(br.com.auster.om.invoice.UsageDetail,
	 *      br.com.auster.om.invoice.Service)
	 */
	public boolean hasPrice(UsageDetail _usage, Service _service) {
		try {
			return (getPriceFor(_usage, _service) != null);
		} catch (PricingInformationNotFoundException pinfe) {
			// TODO log
		}
		return false;
	}

	/**
	 * @see br.com.auster.om.pricing.facade..PricingFacade#hasPrice(br.com.auster.om.invoice.UsageDetail)
	 */
	public boolean hasPrice(UsageDetail _usage) {
		return hasPrice(_usage, getServiceFor(_usage));
	}

	/**
	 * @see br.com.auster.om.pricing.PricingFacade#getLocalUnitConvertor()
	 */
	public UnitConvertor getLocalUnitConvertor() {
		return convertion;
	}

	/**
	 * @see br.com.auster.om.pricing.PricingFacade#hasSubscriptionFree(br.com.auster.om.invoice.ServiceDetail)
	 */
	public boolean hasSubscriptionFee(ServiceDetail _charge) {
		return hasSubscriptionFee(_charge, getServiceFor(_charge));
	}

	/**
	 * @see br.com.auster.om.pricing.facade..PricingFacade#hasSubscriptionFee(br.com.auster.om.invoice.ServiceDetail,
	 *      br.com.auster.om.invoice.Service)
	 */
	public boolean hasSubscriptionFee(ServiceDetail _charge, Service _service) {
		try {
			return (getSubscriptionFeeFor(_charge, _service) != null);
		} catch (SubscriptionFeeInformationNotFoundException sfinfe) {
			 log.warn("Error found during search for subscription fee:", sfinfe);
		}
		return false;
	}

	/**
	 * @see br.com.auster.om.pricing.PricingFacade#getSubscriptionFeeFor(br.com.auster.om.invoice.ServiceDetail)
	 */
	public ServicePrice getSubscriptionFeeFor(ServiceDetail _charge)
			throws SubscriptionFeeInformationNotFoundException {
		return getSubscriptionFeeFor(_charge, null);
	}

	/**
	 * @see br.com.auster.om.pricing.PricingFacade#price(br.com.auster.om.invoice.UsageDetail,
	 *      boolean)
	 */
	public double price(UsageDetail _usage, boolean ignoreNegotiables) {
		StatsMapping stats = ProcessingStats.starting(getClass(), "price(UsageDetail)");
		try {
			ServicePrice sp = null;
			if (this.negotUsagePricesMap != null
					&& this.negotUsagePricesMap.size() > 0
				&& !ignoreNegotiables) {
//				log.debug("Getting a negotiated price.");
				sp = this.getNegotiatedPriceFor(_usage); // If there is no
															// negot price for
															// this usage, the
															// return from
															// getNegot.. is
															// null
			}

			boolean overridePrice = false;
			ServicePriceNegotiated spn = null;
			if (sp instanceof ServicePriceNegotiated) {
				spn = (ServicePriceNegotiated) sp;
				overridePrice = (spn.getAbsolutePriceFlag().equalsIgnoreCase(ServicePriceNegotiated.PRICE_DISCOUNTED) ||
								spn.getAbsolutePriceFlag().equalsIgnoreCase(ServicePriceNegotiated.PRICE_INCREASED));
			}

			if (sp == null || overridePrice) {
				sp = this.getPriceFor(_usage);
				if (overridePrice) {
					spn.setInitCost(sp.getInitCost());
					spn.setStepCost(sp.getStepCost());
					sp = spn;
				}
			}

			_usage.setPrice(sp);

			// truncate the amount to 2 decimals
			double truncatedAmount = (long) (this.calculatePriceFor(_usage, sp.getService(), sp) * 100);
			truncatedAmount = truncatedAmount/100;
			_usage.setCalculatedValue(truncatedAmount);

			return _usage.getCalculatedValue();

		} catch (PricingInformationNotFoundException pinfe) {
			log.debug("Pricing information not found", pinfe);
		} catch (InvalidPricingCalculationStateException ipcse) {
			log.debug("Could not calculate usage based on the specified price", ipcse);
		} catch (PricingException e) {
			log.error(e);
		} finally {
			stats.finished();
		}
		return Double.NaN;
	}

	public double price(ServiceDetail sd) {
		// Sanity Test
		if (sd == null) {
			return Double.NaN;
		}
		StatsMapping stats = ProcessingStats.starting(getClass(), "price(ServiceDetail)");
		try {
			ServicePrice price = null;


			Map npMap = sd.getInvoice().getAccount().getNegotiatedPrices();
			if ( npMap != null && npMap.size() > 0 ) {
//				log.debug("Getting a negotiated price for service");
				price = this.getNegotiatedPriceForService(sd);
			}

			// if its a negotiated price
			if (price instanceof ServicePriceNegotiated) {
				price.setPriceNegotiated(true);

				ServicePriceNegotiated spn = (ServicePriceNegotiated) price;
				// if its a discounted "D" price (not absolute "A")
				if (spn.getAbsolutePriceFlag().equalsIgnoreCase(ServicePriceNegotiated.PRICE_DISCOUNTED)) {
					// get the default price for this service and set at the negotiated price
					ServicePrice sp = this.getSubscriptionFeeFor(sd);
					price.setInitCost(sp.getInitCost());
					price.setStepCost(sp.getStepCost());
				}
			} else {
				price = this.getSubscriptionFeeFor(sd);
				price.setPriceNegotiated(false);
			}

			sd.setServicePrice(price);

			double amount = calcSubscriptionFee(sd);

			sd.setProRataFactor(getProRataFactor(sd));
			sd.setRated(ServiceDetail.JUST_RATED);
			// truncate the amount to 2 decimals
			double truncatedAmount = (long) ((amount * sd.getProRataFactor()) * 100);
			truncatedAmount = truncatedAmount/100;
			sd.setCalculatedAmount(truncatedAmount);
			return sd.getCalculatedAmount();
		} catch (SubscriptionFeeInformationNotFoundException e) {
			sd.setRated(SectionDetail.NOT_RATED);
			sd.setCalculatedAmount(Double.NaN);
			sd.setServicePrice(null);
			return Double.NaN;
		} finally {
			stats.finished();
		}
	}

	protected double getProRataFactor(ServiceDetail sd) {
		double proRataFactor = 1;
		if (sd.isProRate()) {
			proRataFactor = InvoiceUtils.calculateProRata(sd.getInvoice().getCycleStartDate(), sd.getStartDate(), sd.getEndDate());
		} else if (sd.getTotalAmount() < 0) {
			proRataFactor = -1 * InvoiceUtils.calculateProRata(sd.getInvoice().getCycleStartDate(),sd.getStartDate(), sd.getEndDate());
		}
		return proRataFactor;
	}
	// ---------------------------
	// Protected methods
	// ---------------------------

	/**
	 * Looks for a previosly loaded pricing information in the internal cache.
	 * If there is no cache for the service being handled, then
	 * <code>null</code> is returned. Otherwise, it will go though the
	 * <code>matchServicePriceScenario</code> implementation to detect a real
	 * match.
	 *
	 * @param _cacheKey
	 *            the previously calculated cache key
	 *
	 * @return the matching pricing information, or <code>null</code> if no
	 *         pricing was found
	 */
	protected ServicePrice findPriceInCache(String _cacheKey, Date _usageDate) {
		// if no service defined, then load price from database
//		log.trace("TKT318-Finding Price in Cache for CacheKey:[" + _cacheKey
//				+ "].Date:" + _usageDate);
		if ((_cacheKey == null) || (_usageDate == null)) {
//			log.trace("cannot locate cached price for NULL usage or NULL date.CacheKey:["
//							+ _cacheKey + "].Date:" + _usageDate);
			return null;
		}
		// checking for previously loaded pricing information
		RangeMap cacheRange = pricingCache.get(_cacheKey);
		if ((cacheRange == null)
				|| (cacheRange.get(_usageDate.getTime()) == null)) {
//			log.trace("No ranges found for cacheKey:" + _cacheKey + ".cacheRange:" + cacheRange + ".DateTime:" + _usageDate);
			if (cacheRange != null) {
//				log.trace(".Date in range:" + cacheRange.get(_usageDate.getTime()));
			}
			return null;
		}

		List rangeInfo = cacheRange.get(_usageDate.getTime());
		Object[] rangeInfoAsArray = rangeInfo.toArray();
		ServicePrice priceFound = null;
//		log.trace("findPriceInCache.About to get the price in dated range cache for cacheKey:["
//						+ _cacheKey + "].Date:" + _usageDate);
		for (int i = 0; i < rangeInfoAsArray.length; i++) {
			ServicePrice currentSvcPrice = (ServicePrice) rangeInfoAsArray[i];
			if (currentSvcPrice == null) {
				continue;
			}
			if (priceFound == null) {
				priceFound = currentSvcPrice;
				// will set the current as the expected price, if its effective
				// date is
				// higher (closer to the _usageDate)
				// then the previously found, but still before the _usageDate
			} else if ((priceFound.getEffectiveDate().getTime() < currentSvcPrice .getEffectiveDate().getTime())
					    && (currentSvcPrice.getEffectiveDate().getTime() < _usageDate .getTime())) {
				priceFound = currentSvcPrice;
			} else if ((priceFound.getEffectiveDate().getTime() == currentSvcPrice.getEffectiveDate().getTime())
					    && (priceFound.getUpdatedDate().getTime() < currentSvcPrice.getUpdatedDate().getTime())) {
				priceFound = currentSvcPrice;
			}
		}
//		log.trace("TKT318-Finding Price in Cache for CacheKey:[" + _cacheKey + "].Date:" + _usageDate + ".Price:" + priceFound);
		return priceFound;
	}

	/**
	 * Puts the loaded pricing information in the internal cache map.
	 *
	 * @param _cacheKey
	 *            the previously calculated cache key
	 * @param _price
	 *            the loaded pricing information
	 */
	protected void putPriceInCache(String _cacheKey, ServicePrice _price) {
		// cannot add a null price to cache, or if no service was specified.
//		log.trace("TKT318-Putting Price in Cache for CacheKey:[" + _cacheKey + "].Price:" + _price);
		if ((_price == null) || (_cacheKey == null)) {
//			log.debug("cannot cache price where the cache key or price info. is NULL");
			return;
		}
		// adding price to cache
		RangeMap rangeCache = pricingCache.get(_cacheKey);
		if (rangeCache == null) {
//			log.trace("Adding a new range to cache for cachekey:" + _cacheKey);
			rangeCache = new RangeMap();
			pricingCache.put(_cacheKey, rangeCache);
		}

		long init = _price.getEffectiveDate().getTime();

		long end = Long.MAX_VALUE;
		if (_price.getExpirationDate() != null) {
			if (_price.getEffectiveDate().getTime() > _price.getExpirationDate().getTime()) {
//				log.error("Effective Date for current subscription is AFTER Expiration Date.USING CURRENT DATE AS EFFECTIVE DATE. Price:" + _price);
				end = (new Date()).getTime() + 1;
			} else {
				end = _price.getExpirationDate().getTime() + 1;
			}
		}
		// long end = (_price.getExpirationDate() == null ? Long.MAX_VALUE :
		// _price.getExpirationDate().getTime() + 1);
//		log.trace("TKT318-Putting Price in Cache for CacheKey:[" + _cacheKey + "].Init:" + init + ".End:" + end + ".Price:" + _price);
		rangeCache.add(init, end, _price);
	}

	/**
	 * Looks in the service cache map for previously loaded services for the
	 * specified usage. If there wasnt a previously loaded service, then
	 * <code>null</code> is returned.
	 *
	 * @param _svnName
	 *          the name of the service
	 *
	 * @return the pre-loaded service object, or <code>null</code>.
	 */
	protected Service findServiceInCache(String _svcName) {
		// if no usage defined, then load service from database
//		log.trace("TKT318-findServiceInCache.Key:[" + _svcName + "]");
		if (_svcName == null) {
			return null;
		}
		// checking for previously loaded service information
		Service service = (Service) serviceCache.get(_svcName);
//		log.trace("TKT318-findServiceInCache.Returning service uid:" + ((service == null) ? null : service.getUid()));
		return service;
	}

	/**
	 * Puts a loaded service in the cache of services.
	 *
	 * @param _svcName
	 *          the service name
	 * @param _service
	 *          the loaded service object
	 */
	protected void putServiceInCache(String _svcName, Service _service) {
		// cannot add a null service to cache, or if no usage was specified.
//		log.trace("TKT318-putServiceInCache.CacheKey:[" + _svcName + "].Service uid:" + _service.getUid() );
		if ((_svcName == null) || (_service == null)) {
			return;
		}
//		if (log.isTraceEnabled()) {
//			Runtime rt = Runtime.getRuntime();
//			log.trace("ABM.SQLI.putServiceInCache.BFR;Free:" + rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:" + rt.maxMemory());
//		}
		// adding service to cache
		serviceCache.put(_svcName, _service);
//		if (log.isTraceEnabled()) {
//			Runtime rt = Runtime.getRuntime();
//			log.trace("ABM.SQLI.putServiceInCache.AFT;Free:" + rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:" + rt.maxMemory());
//		}

	}

	private void initCache(int _cacheSize) {
		if (_cacheSize < 1) {
			_cacheSize = DEFAULT_CACHE_SIZE;
		}
		this.cacheSize = _cacheSize;
		// trying to force garbage collection
		if (pricingCache != null) {
			pricingCache = null;
		}
		pricingCache = new LRUMap(this.cacheSize);
//		log.debug("Price cache initialized with size " + this.cacheSize);
	}

	private void initNotFoundSet(int _notfoundSet) {
		if (_notfoundSet < 1) {
			_notfoundSet = DEFAULT_NOTFOUNDSET_SIZE;
		}
		this.notfoundSize = _notfoundSet;
		// trying to force garbage collection
		if (pricingNotFound != null) {
			pricingNotFound = null;
		}
		pricingNotFound = new LRUMap(this.notfoundSize);
//		log.debug("Not found set cache initialized with size " + this.notfoundSize);
	}

	// ---------------------------
	// Abstract methods
	// ---------------------------

	/**
	 * Should create a string in Hibernate-QL syntax (or SQL), to query for the
	 * princing information. This query string can have parameters, which will
	 * be set in the <code>setServicePriceQueryParameters()</code> method. The
	 * values for such query parameters must be found as, either constants of
	 * the implementing subclass or attributes of the incoming usage and service
	 * instances.
	 *
	 * @param _usage
	 *            the usage event data
	 * @param _service
	 *            the service related to such event
	 *
	 * @return the query string to search for a specific pricing information
	 */
	protected abstract String getServicePriceQuery(UsageDetail _usage,
			Service _service);

	/**
	 * Should create a string in Hibernate-QL syntax (or SQL), to query for the
	 * subscription fee information. This query string can have parameters,
	 * which will be set in the <code>setSubscriptionFeeQueryParameters()</code>
	 * method. The values for such query parameters must be found as either
	 * constants of the implementing subclass or attributes of the incoming
	 * charge and service instances.
	 *
	 * @param _charge
	 *            the service charge
	 * @param _service
	 *            the service related to such charge
	 *
	 * @return the query string to search for a specific subscription fee
	 *         information
	 */
	protected abstract String getSubscriptionFeeQuery(ServiceDetail _usage,
			Service _service);

	/**
	 * Creates the key by which pricing information for the pair
	 * <code>_usage + _service</code> will be cached. If the required
	 * information inside those parameters is not present, and the key cannot be
	 * computated, then <code>null</code> is returned.
	 *
	 * @param _usage
	 *            the usage event data
	 * @param _service
	 *            the service related to such event
	 *
	 * @return the cache key for the specified usage and service
	 */
	protected abstract String buildCacheKey(UsageDetail _usage, Service _service);

	/**
	 * Creates the key by which pricing information for the pair
	 * <code>_charge + _service</code> will be cached. If the required
	 * information inside those parameters is not present, and the key cannot be
	 * computated, then <code>null</code> is returned.
	 *
	 * @param _charge
	 *            the service charge
	 * @param _service
	 *            the service related to such charge
	 *
	 * @return the cache key for the specified charge and service
	 */
	protected abstract String buildCacheKey(ServiceDetail _charge,
			Service _service);


	protected abstract String buildCacheKey(ServiceDetail _charge);


	/**
	 * Identifies pricing queries which resulted in no pricing data. That is,
	 * there is no pricing data in the reference tables for the specified cache
	 * key. Since the cache key is not date-relative, the usage date is also
	 * needed here.
	 *
	 * @param _cacheKey
	 *            the key by which the pricing should be cached
	 * @param _usageDate
	 *            the date from the usage event currently begin priced
	 *
	 * @return if the cache key resulted in a
	 *         <code>PricingInformationNotFoundException</code> exception
	 */
	protected abstract boolean inNotFoundList(String _cacheKey, Date _usageDate);

	/**
	 * Marks the cache key as one which does not point to a pricing information
	 * in the reference tables. Since the cache key is not date-relative, the
	 * usage date is also needed here.
	 *
	 * @param _cacheKey
	 *            the key by which the pricing should be cached
	 * @param _usageDate
	 *            the date from the usage event currently begin priced
	 */
	protected abstract void addToNotFoundList(String _cacheKey, Date _usageDate);

	public void setNegotUsagePricesMap(Map<? extends Object, ? extends Object> negotUsagePricesMap) {
		this.negotUsagePricesMap = negotUsagePricesMap;
	}
}
