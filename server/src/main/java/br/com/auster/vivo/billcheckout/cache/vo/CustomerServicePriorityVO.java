package br.com.auster.vivo.billcheckout.cache.vo;

public class CustomerServicePriorityVO {
	private String				subscriptionId;
	private String				serviceName;
	private Long 				priority;

	public CustomerServicePriorityVO(){		
	}
	
	public CustomerServicePriorityVO(String subscriptionId, String serviceName,
			Long priority) {
		super();
		this.subscriptionId = subscriptionId;
		this.serviceName = serviceName;
		this.priority = priority;
	}
	
	public String getSubscriptionId() {
		return subscriptionId;
	}
	public void setSubscriptionId(String subscriptionId) {
		this.subscriptionId = subscriptionId;
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
	public String toString() {	
		return "subscriptionId:" + subscriptionId + " serviceName:" + 
				serviceName + " priority:" + priority;
	}
}
