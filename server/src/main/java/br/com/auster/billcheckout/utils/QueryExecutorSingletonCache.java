package br.com.auster.billcheckout.utils;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import org.w3c.dom.Element;

public abstract class QueryExecutorSingletonCache<K, V> extends GenericQueryExecutorCache<K, V> {

	protected Lock configureLock = new ReentrantLock();

	@Override
	public void configure(Element config) {
		this.configureLock.lock();
		try {
			if (getInstance() == null) {
				setInstance(this);
				super.configure(config);
			}
		} finally {
			this.configureLock.unlock();
		}
	}

	protected abstract QueryExecutorSingletonCache<K, V> getInstance();

	protected abstract void setInstance(QueryExecutorSingletonCache<K, V> singleton);
}
