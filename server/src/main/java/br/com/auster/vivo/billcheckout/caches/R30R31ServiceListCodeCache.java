package br.com.auster.vivo.billcheckout.caches;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.commons.collections.map.LRUMap;

import br.com.auster.billcheckout.utils.GenericQueryExecutorCache;
import br.com.auster.vivo.billcheckout.caches.vo.ServiceListCodeVO;

public class R30R31ServiceListCodeCache extends GenericQueryExecutorCache<String, ServiceListCodeVO> {
	
	@Override
	protected String getQueryName() {
		return "R30_ServiceListCode";
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
	protected ServiceListCodeVO retrieve(ResultSet rs) throws SQLException {
		ServiceListCodeVO result = new ServiceListCodeVO();
		if (rs.next()) {
			result.setListCd(rs.getString("LIST_CD"));
			result.setListDesc(rs.getString("LIST_DESC"));
		}
		return result;
	}
	
}
