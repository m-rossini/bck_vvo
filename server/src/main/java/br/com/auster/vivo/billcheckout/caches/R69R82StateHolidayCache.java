package br.com.auster.vivo.billcheckout.caches;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.collections.map.LRUMap;

import br.com.auster.billcheckout.utils.GenericQueryExecutorCache;
import br.com.auster.vivo.billcheckout.caches.vo.HolidayDateVO;


public class R69R82StateHolidayCache extends GenericQueryExecutorCache<String, List<HolidayDateVO>> {
	
	@Override
	protected String getQueryName() {
		return "R69_82_State_Holiday";
	}

	@Override
	protected LRUMap buildInitialCache(int size) {
		return new LRUMap(size);
	}

	@Override
	protected Object[] buildQueryParameters(String key) {
		String [] parts = key.split("_");
		String state = parts[0];
		String dueDate = parts[1];
		return (new Object[] {state, dueDate, dueDate});
	}
	
	@Override
	protected List<HolidayDateVO> retrieve(ResultSet rs) throws SQLException {
		List<HolidayDateVO> list = new ArrayList<HolidayDateVO>();
		
		while (rs.next()) {	
			HolidayDateVO holidayVO = new HolidayDateVO();
			holidayVO.setHolDate(rs.getDate("HOL_DATE"));
			holidayVO.setPermanentFlag(rs.getString("PERMANENT_FLAG"));
			list.add(holidayVO);
		}
		
		return list;		
	}
	
	public List<HolidayDateVO> findHoliday(String state, Date dueDate) throws SQLException{
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		return this.get(state+"_"+dateFormat.format(dueDate));
	}
}
