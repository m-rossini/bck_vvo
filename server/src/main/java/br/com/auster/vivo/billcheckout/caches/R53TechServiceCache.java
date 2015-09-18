package br.com.auster.vivo.billcheckout.caches;

import java.sql.ResultSet;
import java.sql.SQLException;

import br.com.auster.billcheckout.utils.AutoRefreshingSingletonCache;
import br.com.auster.billcheckout.utils.QueryExecutorSingletonCache;
import br.com.auster.vivo.billcheckout.cache.vo.DataBarnTechnologyVO;

public class R53TechServiceCache extends AutoRefreshingSingletonCache<String, DataBarnTechnologyVO > {
	
	private static QueryExecutorSingletonCache<String, DataBarnTechnologyVO> instance;

	@Override
	protected String getQueryName() {
		return "R53_TechService";
	}

	@Override
	protected Object[] buildQueryParameters(String key) {
		return new Object[0];
	}

	public static DataBarnTechnologyVO getTechService(String key) throws SQLException {
		return instance.get(key);
	}

	@Override
	protected DataBarnTechnologyVO retrieve(ResultSet rs) throws SQLException {
		if (rs.next()) {
			DataBarnTechnologyVO serviceVO = new DataBarnTechnologyVO();
			serviceVO.setCaptnText(rs.getString("CAPTN_TEXT"));
			serviceVO.setChnlTypeInd(rs.getString("CHNL_TYPE_IND"));
			serviceVO.setSubFlag(false);
			return serviceVO;	
		} else {
			return null;
		}
	}

	@Override
	protected QueryExecutorSingletonCache<String, DataBarnTechnologyVO> getInstance() {
		return instance;
	}

	@Override
	protected void setInstance(QueryExecutorSingletonCache<String, DataBarnTechnologyVO> singleton) {
		instance = singleton;
	}
	
	
}
