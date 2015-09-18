package br.com.auster.vivo.billcheckout.caches;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.commons.collections.map.LRUMap;

import br.com.auster.billcheckout.utils.GenericQueryExecutorCache;


public class R31IntraGroupHirchCache extends GenericQueryExecutorCache<String, String> {
	
	@Override
	protected String getQueryName() {
		return "R31_IntraGroupHirch";
	}

	@Override
	protected LRUMap buildInitialCache(int size) {
		return new LRUMap(size);
	}

	@Override
	protected Object[] buildQueryParameters(String key) {
		String [] parts = key.split("_");
		String acctNbr = parts[0];
		String calledNbr = parts[1];
		String endDate = parts[2];
		String startDate = parts[3];
		return (new Object[] {acctNbr, endDate, startDate, endDate, calledNbr, endDate, startDate, endDate, endDate, startDate, endDate, endDate, startDate, endDate});
	}


	@Override
	protected String retrieve(ResultSet rs) throws SQLException {
		String result = new String();
		if (rs.next()) {
			result = (rs.getString("ACCESS_NBR"));
		}
		return result;
	}
	
}
