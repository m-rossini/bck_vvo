package br.com.auster.vivo.billcheckout.caches;

import java.sql.ResultSet;
import java.sql.SQLException;

import br.com.auster.billcheckout.utils.AutoRefreshingSingletonCache;
import br.com.auster.billcheckout.utils.QueryExecutorSingletonCache;
import br.com.auster.vivo.billcheckout.caches.vo.CustomerTypePlanVO;

public class R57CustomerTypePlanCache extends AutoRefreshingSingletonCache<String, CustomerTypePlanVO > {
	
	private static QueryExecutorSingletonCache<String, CustomerTypePlanVO> instance;

	@Override
	protected String getQueryName() {
		return "R57_CustomerTypePlan";
	}

	@Override
	protected Object[] buildQueryParameters(String key) {
		return new Object[0];
	}

	public static boolean isPlanRightCustType(String svcId, String acctType) throws SQLException {
		CustomerTypePlanVO vo = instance.get(svcId);
		if ((vo == null) || (vo.getCustType().contains(acctType))) { 
			return true; 
		}
		return false;
	}

	@Override
	protected CustomerTypePlanVO retrieve(ResultSet rs) throws SQLException {
		if (rs.next()) {
			CustomerTypePlanVO customerTypePlanVO = new CustomerTypePlanVO();
			customerTypePlanVO.setSvcId(rs.getString("svc_id"));
			customerTypePlanVO.setCustType(rs.getString("cust_type"));
			return customerTypePlanVO;	
		} else {
			return null;
		}
	}

	@Override
	protected QueryExecutorSingletonCache<String, CustomerTypePlanVO> getInstance() {
		return instance;
	}

	@Override
	protected void setInstance(QueryExecutorSingletonCache<String, CustomerTypePlanVO> singleton) {
		instance = singleton;
	}
	
}
