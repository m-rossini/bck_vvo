package br.com.auster.billcheckout.utils;

import java.sql.ResultSet;
import java.sql.SQLException;

import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;
import br.com.auster.vivo.billcheckout.cache.DataBarnQueryExecutor;

public abstract class GenericQueryExecutor<K, V> extends DataBarnQueryExecutor {

	public V get(K key) throws SQLException {
		return load(key);
	}

	public V load(K key) throws SQLException {
		StatsMapping stats = ProcessingStats.starting(getClass(), getQueryName());
		try {
			ResultSet rs = getResultSet(getQueryName(), buildQueryParameters(key));
			return retrieve(rs);
		} finally {
			stats.finished();
			closeResultSet();
		}
	}

	protected abstract String getQueryName();

	protected abstract Object[] buildQueryParameters(K key);

	protected abstract V retrieve(ResultSet rs) throws SQLException;
}
