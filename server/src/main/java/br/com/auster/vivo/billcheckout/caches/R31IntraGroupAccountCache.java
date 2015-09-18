package br.com.auster.vivo.billcheckout.caches;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.commons.collections.map.LRUMap;

import br.com.auster.billcheckout.utils.GenericQueryExecutorCache;
import br.com.auster.vivo.billcheckout.caches.vo.IntraGroupAccountVO;


public class R31IntraGroupAccountCache extends GenericQueryExecutorCache<String, IntraGroupAccountVO> {
	
	@Override
	protected String getQueryName() {
		return "R31_IntraGroupAccount";
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
	protected IntraGroupAccountVO retrieve(ResultSet rs) throws SQLException {
		IntraGroupAccountVO result = new IntraGroupAccountVO();
		if (rs.next()) {
			result.setAttrNbr(rs.getString("ACCT_NBR"));
			result.setCnpj(rs.getString("CUST_ID_TEXT"));
		}
		return result;
	}
	
}
