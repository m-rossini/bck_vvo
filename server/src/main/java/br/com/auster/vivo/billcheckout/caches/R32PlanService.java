package br.com.auster.vivo.billcheckout.caches;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.commons.collections.map.LRUMap;

import br.com.auster.billcheckout.utils.GenericQueryExecutorCache;


public class R32PlanService extends GenericQueryExecutorCache<String, String > {
	
	@Override
	protected String getQueryName() {
		return "R32_PlanServices";
	}

	@Override
	protected LRUMap buildInitialCache(int size) {
		return new LRUMap(size);
	}

	@Override
	protected Object[] buildQueryParameters(String key) {
		return (new Object[] {key});
	}

	@Override
	protected String retrieve(ResultSet rs) throws SQLException {
		if (rs.next()) {
			return new String ((rs.getString("ACCESS_NBR_RQR_FLAG")));
		}
		return null;		
	}
	
}
