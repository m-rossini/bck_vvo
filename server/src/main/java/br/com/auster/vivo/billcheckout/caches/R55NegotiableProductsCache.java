package br.com.auster.vivo.billcheckout.caches;

import java.sql.ResultSet;
import java.sql.SQLException;

import br.com.auster.billcheckout.utils.AutoRefreshingSingletonSetCache;
import br.com.auster.billcheckout.utils.QueryExecutorSingletonCache;

public class R55NegotiableProductsCache extends AutoRefreshingSingletonSetCache<String> {
	
	private static QueryExecutorSingletonCache<String, String> instance;

	@Override
	protected String getQueryName() {
		return "R55_NegotiableProducts";
	}

	@Override
	protected Object[] buildQueryParameters(String key) {
		return new Object[0];
	}

	public static boolean isProductNegotiated(String seqNumber) throws SQLException {
		return instance.get(seqNumber) != null;
	}

	@Override
	protected String retrieve(ResultSet rs) throws SQLException {
		if (rs.next()) {
			return rs.getString("svc_price_seq_nbr");
		} else {
			return null;
		}
	}

	@Override
	protected QueryExecutorSingletonCache<String, String> getInstance() {
		return instance;
	}

	@Override
	protected void setInstance(QueryExecutorSingletonCache<String, String> singleton) {
		instance = singleton;
	}
}
