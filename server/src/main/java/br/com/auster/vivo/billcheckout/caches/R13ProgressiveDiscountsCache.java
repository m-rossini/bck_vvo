package br.com.auster.vivo.billcheckout.caches;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.commons.collections.map.LRUMap;

import br.com.auster.billcheckout.utils.GenericQueryExecutorCache;


public class R13ProgressiveDiscountsCache extends GenericQueryExecutorCache<String, Boolean> {
	
	@Override
	protected String getQueryName() {
		return "R13_ProgressiveDiscountPlans";
	}

	@Override
	protected LRUMap buildInitialCache(int size) {
		return new LRUMap(size);
	}

	@Override
	protected Boolean retrieve(ResultSet rs) throws SQLException {
		if (rs.next()) {
			return true;
		}
		return false;
	}

	@Override
	protected Object[] buildQueryParameters(String key) {
		String [] parts = key.split("\\|");
		String svcId = parts[0];
		String endDate = parts[1];
		String startDate = parts[2];
		return (new Object[] {svcId, endDate, startDate, endDate});
	}

	public String buildKey(String serviceId, String cycleEndDate, String cycleStartDate) {
		return serviceId + "|" + cycleEndDate + "|" + cycleStartDate;
	}
}
