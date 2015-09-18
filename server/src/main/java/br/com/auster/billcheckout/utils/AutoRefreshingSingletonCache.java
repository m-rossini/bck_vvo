package br.com.auster.billcheckout.utils;

import java.sql.SQLException;
import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;

import br.com.auster.common.xml.DOMUtils;
import br.com.auster.om.reference.facade.ConfigurationException;

public abstract class AutoRefreshingSingletonCache<K, V extends KeyHolder<K>> extends NonLazySingletonCache<K, V> {

	private final Logger log = Logger.getLogger(AutoRefreshingSingletonCache.class);

	private long refreshPeriod = 365 * 24 * 3600 * 1000L; // 1 year

	private final ReadWriteLock lock = new ReentrantReadWriteLock();

	private boolean loaded = false;

	private long expirationTime = 0L;

	@Override
	public void configure(Element config) {
		super.configure(config);

		Element cacheElement = DOMUtils.getElement(config, "cache", true);

		String hours = DOMUtils.getAttribute(cacheElement, "auto-refresh-period", true);
		if ((hours == null) || (hours.trim().length() == 0)) {
			throw new ConfigurationException("auto-refresh-period was not informed.");
		}

		try {
			refreshPeriod = Integer.parseInt(hours) * 3600 * 1000L;
		} catch (NumberFormatException e) {
			throw new ConfigurationException("auto-refresh-period should be a number of hours.");
		}
	}

	@Override
	public V get(K key) throws SQLException {
		lock.readLock().lock();
		try {
			if (!isLoaded() || isCacheExpired()) {
		        lock.readLock().unlock();   // must unlock first to obtain writelock
		        lock.writeLock().lock();
		        try {
					if (!isLoaded() || isCacheExpired()) {
				        load();
					}
		        } finally {
					lock.readLock().lock();  // reacquire read without giving up write lock
					lock.writeLock().unlock(); // unlock write, still hold read
		        }
			}
			return getFromCache(key);
		} finally {
			lock.readLock().unlock();
		}
	}

	/*
	 * Load the full cache (non-lazy) from the database.
	 * This method assumes that a write lock has already been acquired.
	 */
	@Override
	protected void load() throws SQLException {
		if (isLoaded()) {
			emptyCache();
			loaded = false;
		}
		try {
			log.info("Loading cache for query " + getQueryName());
			loadCache();
			loaded = true;
			expirationTime = System.currentTimeMillis() + refreshPeriod;
		} finally {
			closeResultSet();
		}
	}

	private boolean isLoaded() {
		return loaded;
	}

	private boolean isCacheExpired() {
		return expirationTime < System.currentTimeMillis();
	}
}
