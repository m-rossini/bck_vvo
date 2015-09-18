package br.com.auster.vivo.billcheckout.caches.vo;

import java.util.Date;

public class HolidayDateVO {
	String permanentFlag;
	Date holDate;
	Date nextWorkDay;
	Integer dayOfWeek;
	
	public Date getHolDate() {
		return holDate;
	}
	public void setHolDate(Date holDate) {
		this.holDate = holDate;
	}
	public Date getNextWorkDay() {
		return nextWorkDay;
	}
	public void setNextWorkDay(Date nextWorkDay) {
		this.nextWorkDay = nextWorkDay;
	}
	public Integer getDayOfWeek() {
		return dayOfWeek;
	}
	public void setDayOfWeek(Integer dayOfWeek) {
		this.dayOfWeek = dayOfWeek;
	}
	public String getPermanentFlag() {
		return permanentFlag;
	}
	public void setPermanentFlag(String permanentFlag) {
		this.permanentFlag = permanentFlag;
	}
}
