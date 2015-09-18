package br.com.auster.vivo.billcheckout.caches;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.commons.collections.map.LRUMap;

import br.com.auster.billcheckout.utils.GenericQueryExecutorCache;


public class R08SubscriptionPlan extends GenericQueryExecutorCache<String, String > {
	
	@Override
	protected String getQueryName() {
		return "R08_SubscriptionPlan";
	}

	@Override
	protected LRUMap buildInitialCache(int size) {
		return new LRUMap(size);
	}

	@Override
	protected Object[] buildQueryParameters(String key) {
		String [] parts = key.split("_");
		String acctNbr = parts[0];
		String endDate = parts[1];
		String startDate = parts[2];
		return (new Object[] {acctNbr, endDate, startDate, endDate, endDate, startDate, endDate});
	}

	@Override
	protected String retrieve(ResultSet rs) throws SQLException {
		if (rs.next()) {
			return new String ((rs.getString("SVC_NAME")));
		}
		return new String ();		
	}
	
}
