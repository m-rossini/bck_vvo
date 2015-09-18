package br.com.auster.vivo.billcheckout.caches;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.map.LRUMap;

import br.com.auster.billcheckout.utils.GenericQueryExecutorCache;
import br.com.auster.vivo.billcheckout.caches.vo.AccountAndCycleChangeVO;
import br.com.auster.vivo.billcheckout.caches.vo.SubscriptionServicesVO;


public class R08AccountAndCycleChange extends GenericQueryExecutorCache<String, List<AccountAndCycleChangeVO> > {
	
	@Override
	protected String getQueryName() {
		return "R08_AccountAndCycleChange";
	}

	@Override
	protected LRUMap buildInitialCache(int size) {
		return new LRUMap(size);
	}

	@Override
	protected Object[] buildQueryParameters(String key) {
		String [] parts = key.split("_");
		String subId = parts[0];
		String endDate = parts[1];
		String startDate = parts[2];
		return (new Object[] {subId, endDate, startDate, endDate});
	}


	@Override
	protected List<AccountAndCycleChangeVO>  retrieve(ResultSet rs) throws SQLException {
		List<AccountAndCycleChangeVO> list = new ArrayList<AccountAndCycleChangeVO>();
		while (rs.next()) {
			AccountAndCycleChangeVO accountAndCycleChangeVO = new AccountAndCycleChangeVO();
			accountAndCycleChangeVO.setAcctNbr((rs.getString("ACCT_NBR")));
			accountAndCycleChangeVO.setSubId((rs.getString("SBSCRP_ID")));
			accountAndCycleChangeVO.setCycleCd((rs.getString("CYCLE_CD")));
			accountAndCycleChangeVO.setAcctCycleEffDt((rs.getDate("ACCT_CYCLE_EFF_DT")));
			accountAndCycleChangeVO.setAcctCycleEffTm(rs.getString("ACCT_CYCLE_EFF_TM"));
			accountAndCycleChangeVO.setSvcAsgmEffDt((rs.getDate("SBSCRP_ASGM_EFF_DT")));
			accountAndCycleChangeVO.setSvcAsgmExpDt((rs.getDate("SBSCRP_ASGM_EXPR_DT")));
			list.add(accountAndCycleChangeVO);
		}
		return list;
	}
	
}
