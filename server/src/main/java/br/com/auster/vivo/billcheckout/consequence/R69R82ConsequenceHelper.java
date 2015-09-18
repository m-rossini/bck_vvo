package br.com.auster.vivo.billcheckout.consequence;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import org.apache.log4j.Logger;

import br.com.auster.vivo.billcheckout.caches.R69R82CityHolidayCache;
import br.com.auster.vivo.billcheckout.caches.R69R82CountryHolidayCache;
import br.com.auster.vivo.billcheckout.caches.R69R82StateHolidayCache;
import br.com.auster.vivo.billcheckout.caches.vo.HolidayDateVO;

public class R69R82ConsequenceHelper {
	private static Logger log = Logger.getLogger(R69R82ConsequenceHelper.class);
	private R69R82CityHolidayCache cityHolidayCache;
	private R69R82StateHolidayCache stateHolidayCache;
	private R69R82CountryHolidayCache countryHolidayCache;
	
	public R69R82ConsequenceHelper(R69R82CityHolidayCache cityHolidayCache, 
			R69R82StateHolidayCache stateHolidayCache, R69R82CountryHolidayCache countryHolidayCache){
		this.cityHolidayCache = cityHolidayCache; 
		this.stateHolidayCache = stateHolidayCache; 
		this.countryHolidayCache = countryHolidayCache; 
	}
	public HolidayDateVO findHolidayData(String state, String city, Date dueDate){		
		GregorianCalendar calendar = new GregorianCalendar();
		List<HolidayDateVO> holidayList = new ArrayList<HolidayDateVO>();
		HolidayDateVO holidayDate = new HolidayDateVO();
		int dueDayOfWeek = 0;
		
		try {
			findAllHoliday(state, city, dueDate, holidayList);
			
			if (holidayList.isEmpty()) return null;

			calendar.setTime(dueDate);
			dueDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
			Date nextWorkDay = findNextWorkingDay(state, city, calendar);			
			holidayDate.setHolDate(dueDate);
			holidayDate.setNextWorkDay(nextWorkDay);
			holidayDate.setDayOfWeek(dueDayOfWeek);
			
		} catch (SQLException e) {
			log.error("Error running Holiday query", e);
			throw new RuntimeException("Error running Holiday query",e);
		}
		return holidayDate;
	}
	
	public boolean isWeekendDay(Date date){
		GregorianCalendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
		
		if (dayOfWeek == 1 || dayOfWeek == 7) return true;
		else return false;
	}
	
	public Date findNextWorkingDay(String state, String city,
			Date dueDate){
		try {
			GregorianCalendar calendar = new GregorianCalendar();
			calendar.setTime(dueDate);
			return findNextWorkingDay(state, city, calendar);
		} catch (SQLException e) {
			log.error("Error running Holiday query", e);
			throw new RuntimeException("Error running Holiday query",e);
		}
	}
	
	private Date findNextWorkingDay(String state, String city,
			GregorianCalendar calendar) throws SQLException {
		List<HolidayDateVO> currHolidayList = null;
		Date nextWorkDay = null;
		int currDayOfWeek = 0;
		
		calendar.set(Calendar.DAY_OF_MONTH, calendar.get(Calendar.DAY_OF_MONTH) + 1);
		
		while(nextWorkDay == null){
			currDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
			
			if (currDayOfWeek != 7 && currDayOfWeek != 1){
				currHolidayList = new ArrayList<HolidayDateVO>();
				findAllHoliday(state, city, calendar.getTime(), currHolidayList);
				
				if (currHolidayList.isEmpty())
					nextWorkDay = calendar.getTime();					
			}
			
			calendar.set(Calendar.DAY_OF_MONTH, calendar.get(Calendar.DAY_OF_MONTH) + 1);				
		}
		
		return nextWorkDay;
	}
	
	private void findAllHoliday(String state, String city, Date dueDate,
			List<HolidayDateVO> holidayList) throws SQLException {		
		List<HolidayDateVO> cityHolidayList = 
			this.cityHolidayCache.findHoliday(state, city, dueDate);
		
		if (cityHolidayList.isEmpty()){
			List<HolidayDateVO> stateHolidayList = 
				this.stateHolidayCache.findHoliday(state, dueDate);
			
			if (stateHolidayList.isEmpty()){
				List<HolidayDateVO> countryHolidayList = 
					this.countryHolidayCache.findHoliday(dueDate);
				
				if (!countryHolidayList.isEmpty())
					holidayList.addAll(countryHolidayList);	
			}
			else holidayList.addAll(stateHolidayList);
		}
		else holidayList.addAll(cityHolidayList);
	}
}
