package br.com.auster.vivo.billcheckout.caches;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.commons.collections.map.LRUMap;

import br.com.auster.billcheckout.utils.GenericQueryExecutorCache;
import br.com.auster.vivo.billcheckout.caches.vo.IntraGroupTypeVO;


public class R31IntraGroupTypeCache extends GenericQueryExecutorCache<String, IntraGroupTypeVO> {
	
	@Override
	protected String getQueryName() {
		return "R31_IntraGroupType";
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
	protected IntraGroupTypeVO retrieve(ResultSet rs) throws SQLException {
		IntraGroupTypeVO result = new IntraGroupTypeVO();
		if (rs.next()) {
			result.setSvcName(rs.getString("SVC_NAME"));
			result.setAttrGroupName(rs.getString("ATTR_GROUP_NAME"));
		}
		return result;
	}
	
}
