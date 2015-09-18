package br.com.auster.vivo.billcheckout.cache.vo;

import java.util.Date;

import br.com.auster.om.invoice.UsageDetail;

public class PriorityOrderVO implements Comparable<PriorityOrderVO>{
	private String				subscriptionId;
	private String				captionText;	
	private String				serviceName;
	private Long 				priority;	
	private Date				agreementEffectiveDate;		
	private Date				agreementTrmntDate;	
	private Date				subServiceEffectiveDate;		
	private Date				subServiceExpirationDate;
	private boolean				foundInSirs;
	private UsageDetail			firstUsageFound;
	
	public String getSubscriptionId() {
		return subscriptionId;
	}
	public void setSubscriptionId(String subscriptionId) {
		this.subscriptionId = subscriptionId;
	}
	public String getCaptionText() {
		return captionText;
	}
	public void setCaptionText(String captionText) {
		this.captionText = captionText;
	}
	public String getServiceName() {
		return serviceName;
	}
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	public Long getPriority() {
		return priority;
	}
	public void setPriority(Long priority) {
		this.priority = priority;
	}
	public Date getAgreementEffectiveDate() {
		return agreementEffectiveDate;
	}
	public void setAgreementEffectiveDate(Date agreementEffectiveDate) {
		this.agreementEffectiveDate = agreementEffectiveDate;
	}
	public Date getAgreementTrmntDate() {
		return agreementTrmntDate;
	}
	public void setAgreementTrmntDate(Date agreementTrmntDate) {
		this.agreementTrmntDate = agreementTrmntDate;
	}
	public Date getSubServiceEffectiveDate() {
		return subServiceEffectiveDate;
	}
	public void setSubServiceEffectiveDate(Date subServiceEffectiveDate) {
		this.subServiceEffectiveDate = subServiceEffectiveDate;
	}
	public Date getSubServiceExpirationDate() {
		return subServiceExpirationDate;
	}
	public void setSubServiceExpirationDate(Date subServiceExpirationDate) {
		this.subServiceExpirationDate = subServiceExpirationDate;
	}	

	
	public String toString() {	
		return "subscriptionId:" + subscriptionId + " serviceName:" + 
				serviceName + " priority:" + priority;
	}

	public int compareTo(PriorityOrderVO other) {
		if (other != null) {
			if(this.priority > other.getPriority()) {
				return -1;
			} else {
				return 1;
			}
		}
		return 0;
	}
	public boolean isFoundInSirs() {
		return foundInSirs;
	}
	public void setFoundInSirs(boolean foundInSirs) {
		this.foundInSirs = foundInSirs;
	}
	public UsageDetail getFirstUsageFound() {
		return firstUsageFound;
	}
	public void setFirstUsageFound(UsageDetail firstUsageFound) {
		this.firstUsageFound = firstUsageFound;
	}
}
