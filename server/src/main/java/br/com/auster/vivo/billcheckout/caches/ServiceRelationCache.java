package br.com.auster.vivo.billcheckout.caches;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;
import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;

import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.om.invoice.ServiceDetail;
import br.com.auster.om.pricing.ServicePrice;
import br.com.auster.vivo.billcheckout.cache.DataBarnQueryExecutor;
import br.com.auster.vivo.billcheckout.consequence.ServicePriceMissingException;

/**
 * This class holds the service relation ("must have" and "cannot have" services) cache.
 * It is currently in use by Rule 63.
 * It should be configured as a global in order to initialize the query executors.
 * The cache is a singleton, so that, even though configure() method will be called
 * several times, there will only be one (static) instance of the cache.
 */
public class ServiceRelationCache {

	/* Types of product relationships */
	private static final String MUST_HAVE = "M";
	private static final String CANNOT_HAVE = "C";

	private final static Logger log = Logger.getLogger(ServiceRelationCache.class);

	/**
	 * the service on the left-hand side is mutually exclusive to all services
	 * on the right-hand side
	 */ 
	private static Map<String,Set<String>> cannotHaveMap;

	/**
	 * the service on the left-hand side requires at least one service on the
	 * right-hand side
	 */ 
	private static Map<String,Set<String>> mustHaveMap;

	private final static ReadWriteLock cacheLock = new ReentrantReadWriteLock(true);

	private static DataBarnQueryExecutor dataBarn;
	private static DataBarnQueryExecutor internalDB;
	private final static ReentrantLock queryExecutorLock = new ReentrantLock(true);

	public void configure(Element config) {
		queryExecutorLock.lock();
		try {
			if (dataBarn == null) {
				dataBarn = new DataBarnQueryExecutor();
				dataBarn.configure(DOMUtils.getElement(config, "billingQueryExecutor", true));
			}
			if (internalDB == null) {
				internalDB = new DataBarnQueryExecutor();
				internalDB.configure(DOMUtils.getElement(config, "billcheckoutQueryExecutor", true));
			}
		} finally {
			queryExecutorLock.unlock();
		}
	}

	public static Map<String, Set<String>> getCannotHaveServices(Collection<ServiceDetail> services) throws ServicePriceMissingException {
		Map<String, Set<String>> cannotHaveServiceMap = new TreeMap<String, Set<String>>();
		Set<String> serviceNames = convert(services);
		for (String service1 : serviceNames) {
			for (String service2 : serviceNames) {
				if (service1.compareToIgnoreCase(service2) < 0
						&& cannotHave(service1, service2)) {
					Set<String> cannotHaveSet = cannotHaveServiceMap.get(service1);
					if (cannotHaveSet == null) {
						cannotHaveSet = new TreeSet<String>();
						cannotHaveServiceMap.put(service1, cannotHaveSet);
					}
					cannotHaveSet.add(service2);
				}
			}
		}
		return cannotHaveServiceMap;
	}

	/**
	 * Performs the processing for both isAnyCannotHaveServicePresent() and
	 * isAnyMustHaveServiceMissing() methods.
	 * 
	 * @param services the current services
	 * @return true if either isAnyCannotHaveServicePresent() and isAnyMustHaveServiceMissing() methods would return true
	 * @throws ServicePriceMissingException if a given service has no ServicePrice configured
	 */
	public static boolean isThereAnyProblem(Collection<ServiceDetail> services) throws ServicePriceMissingException {
		Set<String> serviceNames = convert(services);
		return isThereAnyProblem(serviceNames);
	}

	private static boolean isThereAnyProblem(Set<String> serviceNames) {
//		log.warn("Services: " + serviceNames);
		for (String service : serviceNames) {
			Set<String> mustHaveSet = getMustHaveServices(service);
			if (mustHaveSet != null) {
				if (Collections.disjoint(serviceNames, mustHaveSet)) {
					// no "must have" service found
					return true;
				}
			}
			for (String otherService : serviceNames) {
				if (service.compareToIgnoreCase(otherService) < 0
						&& cannotHave(service, otherService)) {
					return true;
				}
			}
		}
		return false;
	}

	/**
	 * For each service in 'services', checks if at least one of its
	 * "cannot have" services is present in 'services'.
	 * 
	 * @param services the current services
	 * @return true if mutually exclusive (cannot have) services have been found
	 * @throws ServicePriceMissingException if a given service has no ServicePrice configured
	 */
	public static boolean isAnyCannotHaveServicePresent(Collection<ServiceDetail> services) throws ServicePriceMissingException {
		Set<String> serviceNames = convert(services);
		return isAnyCannotHaveServicePresent(serviceNames);
	}

	private static boolean isAnyCannotHaveServicePresent(Set<String> serviceNames) {
		for (String service1 : serviceNames) {
			for (String service2 : serviceNames) {
				if (service1.compareToIgnoreCase(service2) < 0
						&& cannotHave(service1, service2)) {
					return true;
				}
			}
		}
		return false;
	}

	private static boolean cannotHave(String service1, String service2) {
		return cannotHave(getCannotHaveServices(service1), service2) || cannotHave(getCannotHaveServices(service2), service1);
	}

	private static boolean cannotHave(Set<String> cannotHaveSet, String service) {
		return cannotHaveSet != null && cannotHaveSet.contains(service);
	}

	/** For each service in 'services', checks if at least one of its
	 * "must have" services is present in 'services'.
	 * @param services the current services
	 * @return true if at least one service has no "must have" services
	 * @throws ServicePriceMissingException if a given service has no ServicePrice configured
	 */
	public static boolean isAnyMustHaveServiceMissing(Collection<ServiceDetail> services) throws ServicePriceMissingException {
		return isAnyMustHaveServiceMissing(convert(services));
	}

	private static boolean isAnyMustHaveServiceMissing(Set<String> serviceNames) {
		for (String service : serviceNames) {
			Set<String> mustHaveSet = getMustHaveServices(service);
			if (mustHaveSet != null) {
				if (Collections.disjoint(serviceNames, mustHaveSet)) {
					// no "must have" service found
					return true;
				}
			}
		}
		return false;
	}

	public static Set<String> convert(Collection<ServiceDetail> services) throws ServicePriceMissingException {
		Set<String> serviceNames = new HashSet<String>();
		for (ServiceDetail service : services) {
			String serviceName = extractServiceName(service);
			if (serviceName != null) {
				serviceNames.add(serviceName);
			}
		}
		return serviceNames;
	}

	private static String extractServiceName(ServiceDetail serviceDetail) throws ServicePriceMissingException {
		ServicePrice servicePrice = serviceDetail.getServicePrice();
		if (servicePrice == null) {
			throw new ServicePriceMissingException(serviceDetail.getCaption());
		}
		return servicePrice.getService().getExternalId();
	}

	public static Map<String, Set<String>> getMissingMustHaveServices(Collection<ServiceDetail> services) throws ServicePriceMissingException {
		Map<String, Set<String>> allMissingServices = new TreeMap<String, Set<String>>();
		Set<String> serviceNames = convert(services);
		for (String service : serviceNames) {
			Set<String> mustHaveSet = getMustHaveServices(service);
			if (mustHaveSet != null) {
				if (Collections.disjoint(serviceNames, mustHaveSet)) {
					allMissingServices.put(service, mustHaveSet);
				}
			}
		}
		return allMissingServices;
	}

	/* ***** methods below handle cache variables, so they must be thread-safe (through cacheLock) ***** */

	private static Set<String> getCannotHaveServices(String service1) {
		cacheLock.readLock().lock();
		try {
			if (cannotHaveMap == null) {
				cacheLock.readLock().unlock();
				try {
					resetCache();
				} finally {
					cacheLock.readLock().lock();
				}
			}
			return cannotHaveMap.get(service1);
		} finally {
			cacheLock.readLock().unlock();
		}
	}

	private static Set<String> getMustHaveServices(String service) {
		cacheLock.readLock().lock();
		try {
			if (mustHaveMap == null) {
				cacheLock.readLock().unlock();
				try {
					resetCache();
				} finally {
					cacheLock.readLock().lock();
				}
			}
			return mustHaveMap.get(service);
		} finally {
			cacheLock.readLock().unlock();
		}
	}

	private static void resetCache() {
		cacheLock.writeLock().lock();
		try {
			if (cannotHaveMap == null || mustHaveMap == null) {
				try {
					cannotHaveMap = new HashMap<String, Set<String>>();
					mustHaveMap = new HashMap<String, Set<String>>();
					load(dataBarn, "R63_ProductRelationDTBN");
					load(internalDB, "R63_ProductRelation");
				} catch (SQLException e) {
					throw new RuntimeException("Error loading service relation data from database.", e);
				}
			}
		} finally {
			cacheLock.writeLock().unlock();
		}
	}

	/* ***** all methods below must be called with the lock.writeLock() locked ***** */

	private static void load(DataBarnQueryExecutor db, String query) throws SQLException {
		StatsMapping stats = ProcessingStats.starting(ServiceRelationCache.class, query);
		try {
			ResultSet rs = db.getResultSet(query);
			while (rs.next()) {
				String service1 = rs.getString("service1");
				String service2 = rs.getString("service2");
				String relation = rs.getString("relation");
				if (service1 == null || service2 == null || relation == null) {
					log.warn("Ignoring line from " + query + " query due to null information: " +
							"service1=" + service1 + " service2=" + service2 + " relation=" + relation);
				} else {
					if (CANNOT_HAVE.equalsIgnoreCase(relation)) {
						registerCannotHaveServices(service1, service2);
					} else if (MUST_HAVE.equalsIgnoreCase(relation)) {
						registerMustHaveServices(service1, service2);
					} else {
						log.warn("Ignoring line from " + query + " query due to unknown relationship: " +
								"service1=" + service1 + " service2=" + service2 + " relation=" + relation);
					}
				}
			}
		} finally {
			stats.finished();
			db.closeResultSet();
		}
	}

	private static void registerCannotHaveServices(String service1, String service2) {
//		if (service1.endsWith("GESTAO") || service2.endsWith("GESTAO")) {
//			System.out.println(service1 + " x " + service2);
//		}
		Set<String> cannotHaveSet = getCannotHaveServices(service1);
		if (cannotHaveSet == null) {
			cannotHaveSet = new HashSet<String>();
			addCannotHaveServices(service1, cannotHaveSet);
		}
		cannotHaveSet.add(service2);
	}

	private static Set<String> addCannotHaveServices(String service1, Set<String> cannotHaveSet) {
		return cannotHaveMap.put(service1, cannotHaveSet);
	}

	private static void registerMustHaveServices(String service1, String service2) {
		addMustHaveService(service1, service2);
	}

	private static void addMustHaveService(String service1, String service2) {
		Set<String> mustHaveSet = getMustHaveServices(service1);
		if (mustHaveSet == null) {
			mustHaveSet = new TreeSet<String>();
			addMustHaveServices(service1, mustHaveSet);
		}
		mustHaveSet.add(service2);
	}

	private static void addMustHaveServices(String service1, Set<String> mustHaveSet) {
		mustHaveMap.put(service1, mustHaveSet);
	}
}
