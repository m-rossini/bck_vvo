package br.com.auster.vivo.billcheckout.caches;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;

import org.apache.commons.collections.map.LRUMap;

import br.com.auster.billcheckout.utils.GenericQueryExecutorCache;


public class R74SharingPlanCache extends GenericQueryExecutorCache<String, Set<String>> {
	
	@Override
	protected String getQueryName() {
		return "R74_SharingPlan";
	}

	@Override
	protected LRUMap buildInitialCache(int size) {
		return new LRUMap(size);
	}

	@Override
	protected Object[] buildQueryParameters(String key) {
		String [] parts = key.split("_");
		String usageAcumSeqNbrctNbr = parts[0];
		String commSvcAreaId = parts[1];
		String endDate = parts[2];
		String startDate = parts[3];
		return (new Object[] {usageAcumSeqNbrctNbr, commSvcAreaId, endDate, startDate, endDate});
	}


	@Override
	protected Set<String> retrieve(ResultSet rs) throws SQLException {
		Set<String> services = new HashSet<String>();
		while (rs.next()) {
			services.add(rs.getString("svc_name"));
		}
		return services;
	}
}
