package br.com.auster.billcheckout.utils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;

public abstract class NonLazySingletonSetCache<E> extends QueryExecutorSingletonCache<E, E> {

	private volatile boolean loaded = false;

	private final Lock lock = new ReentrantLock();

	@Override
	public E get(E key) throws SQLException {
		if (!loaded) {
			load();
		}
		return getFromCache(key);
	}

	protected void load() throws SQLException {
		try {
			if (!loaded) {
				lock.lock();
				try {
					if (!loaded) {
						loadCache();
						loaded = true;
					}
				} finally {
					lock.unlock();
				}
			}
		} finally {
			closeResultSet();
		}
	}

	protected void loadCache() throws SQLException {
		StatsMapping stats = ProcessingStats.starting(getClass(), getQueryName());
		try {
			ResultSet rs = getResultSet(getQueryName());
			E value;
			while ((value = retrieve(rs)) != null) {
				putIntoCache(value, value);
			}
		} finally {
			stats.finished();
		}
	}
}
