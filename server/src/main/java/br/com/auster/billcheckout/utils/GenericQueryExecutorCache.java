package br.com.auster.billcheckout.utils;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import org.apache.commons.collections.map.LRUMap;
import org.w3c.dom.Element;

import br.com.auster.common.xml.DOMUtils;

public abstract class GenericQueryExecutorCache<K, V> extends GenericQueryExecutor<K, V> {

	private static int DEFAULT_LRU_CACHE_SIZE = 100;

	private Map<K, V> cache;

	private Set<K> notFoundKeys;

	private final ReadWriteLock cacheLock = new ReentrantReadWriteLock();

	@Override
	public void configure(Element config) {
		Element cacheElement = DOMUtils.getElement(config, "cache", false);
		this.cache = buildInitialCache(cacheElement);
		this.notFoundKeys = new HashSet<K>();
		super.configure(config);
	}

	@Override
	public V get(K key) throws SQLException {
		V value = getFromCache(key);
		if (value == null) {
			if (isNotFound(key)) {
				return null;
			} else {
				value = load(key);
			}
			putIntoCache(key, value);
		}
		return value;
	}

	protected boolean isNotFound(K key) {
		this.cacheLock.readLock().lock();
		try {
			return this.notFoundKeys.contains(key);
		} finally {
			this.cacheLock.readLock().unlock();
		}
	}

	protected V getFromCache(K key) {
		this.cacheLock.readLock().lock();
		try {
			return this.cache.get(key);
		} finally {
			this.cacheLock.readLock().unlock();
		}
	}

	protected void putIntoCache(K key, V value) {
		this.cacheLock.writeLock().lock();
		try {
			if (value == null) {
				this.notFoundKeys.add(key);
			} else {
				this.cache.put(key, value);
			}
		} finally {
			this.cacheLock.writeLock().unlock();	
		}
	}

	protected Map<K, V> buildInitialCache(Element cacheElement) {
		if (cacheElement != null) {
			String cacheType = DOMUtils.getAttribute(cacheElement, "type", false);
			if ("LRU".equalsIgnoreCase(cacheType)) {
				String cacheSize = DOMUtils.getAttribute(cacheElement, "size", false);
				if (cacheSize == null) {
					return buildInitialCache(DEFAULT_LRU_CACHE_SIZE);
				} else {
					return buildInitialCache(Integer.parseInt(cacheSize));
				}
			}
		}
		return buildInitialCache();
	}

	protected void emptyCache() {
		this.cache.clear();
	}

	@SuppressWarnings("unchecked")
	protected Map<K, V> buildInitialCache(int size) {
		return new LRUMap(size);
	}

	protected Map<K, V> buildInitialCache() {
		return new HashMap<K, V>();
	}
}
