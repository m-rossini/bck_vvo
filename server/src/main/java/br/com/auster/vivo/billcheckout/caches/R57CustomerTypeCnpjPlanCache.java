package br.com.auster.vivo.billcheckout.caches;

import java.sql.ResultSet;
import java.sql.SQLException;

import br.com.auster.billcheckout.utils.AutoRefreshingSingletonCache;
import br.com.auster.billcheckout.utils.QueryExecutorSingletonCache;
import br.com.auster.vivo.billcheckout.caches.vo.CustomerTypeCnpjPlanVO;

public class R57CustomerTypeCnpjPlanCache extends AutoRefreshingSingletonCache<String, CustomerTypeCnpjPlanVO > {
	
	private static QueryExecutorSingletonCache<String, CustomerTypeCnpjPlanVO> instance;

	@Override
	protected String getQueryName() {
		return "R57_CustomerTypeCnpjPlan";
	}

	@Override
	protected Object[] buildQueryParameters(String key) {
		return new Object[0];
	}

	public static boolean isPlanOnlyCNPJ(String svcId) throws SQLException {
		CustomerTypeCnpjPlanVO vo = instance.get(svcId);
		if (vo != null) { 
			return true; 
		}
		return false;
	}

	@Override
	protected CustomerTypeCnpjPlanVO retrieve(ResultSet rs) throws SQLException {
		if (rs.next()) {
			CustomerTypeCnpjPlanVO customerTypePlanVO = new CustomerTypeCnpjPlanVO();
			customerTypePlanVO.setSvcId(rs.getString("svc_id"));
			customerTypePlanVO.setPlanName(rs.getString("plan_name"));
			return customerTypePlanVO;	
		} else {
			return null;
		}
	}

	@Override
	protected QueryExecutorSingletonCache<String, CustomerTypeCnpjPlanVO> getInstance() {
		return instance;
	}

	@Override
	protected void setInstance(QueryExecutorSingletonCache<String, CustomerTypeCnpjPlanVO> singleton) {
		instance = singleton;
	}
}
