package br.com.auster.vivo.billcheckout.caches;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.map.LRUMap;

import br.com.auster.billcheckout.utils.GenericQueryExecutorCache;
import br.com.auster.vivo.billcheckout.caches.vo.SubscriptionServicesVO;


public class R08SubscriptionServices extends GenericQueryExecutorCache<String, List<SubscriptionServicesVO> > {
	
	@Override
	protected String getQueryName() {
		return "R08_SubscriptionServices";
	}

	@Override
	protected LRUMap buildInitialCache(int size) {
		return new LRUMap(size);
	}

	@Override
	protected Object[] buildQueryParameters(String key) {
		String [] parts = key.split("_");
		String acctNbr = parts[0];
		String cycleCode = parts[1];
		String endDate = parts[2];
		String startDate = parts[3];
		return (new Object[] {acctNbr, cycleCode, endDate, startDate, endDate, endDate, startDate, endDate, endDate, startDate, endDate});
	}


	@Override
	protected List<SubscriptionServicesVO>  retrieve(ResultSet rs) throws SQLException {
		List<SubscriptionServicesVO> list = new ArrayList<SubscriptionServicesVO>();
		while (rs.next()) {
			SubscriptionServicesVO subscriptionServicesVO = new SubscriptionServicesVO();
			subscriptionServicesVO.setAcctNbr((rs.getString("ACCT_NBR")));
			subscriptionServicesVO.setSubId((rs.getString("SBSCRP_ID")));
			subscriptionServicesVO.setCapText((rs.getString("CAPTN_TEXT")));
			subscriptionServicesVO.setSvcName((rs.getString("SVC_NAME")));
			subscriptionServicesVO.setSubAsgmEffDt((rs.getDate("SBSCRP_ASGM_EFF_DT")));
			subscriptionServicesVO.setSvcAgrmntEffDt((rs.getDate("SVC_AGRMNT_EFF_DT")));
			subscriptionServicesVO.setSvcAgrmntExpDt((rs.getDate("SVC_AGRMNT_TRMNTN_DT")));
			subscriptionServicesVO.setFoundInSIRS(false);
			list.add(subscriptionServicesVO);
		}
		return list;
	}
	
}
