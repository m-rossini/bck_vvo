package br.com.auster.vivo.billcheckout.hierarchy;

import br.com.auster.billcheckout.consequence.telco.CarrierDimension;

public class HierarchySubscriptionInfo {

	private String id;
	private CarrierDimension carrier;
	private String terminal;
	private String serviceName;
	private String servicePlan;
	private double totalAmount;
	private double calculatedAmount;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public CarrierDimension getCarrier() {
		return carrier;
	}

	public void setCarrier(CarrierDimension carrier) {
		this.carrier = carrier;
	}

	public String getTerminal() {
		return terminal;
	}

	public void setTerminal(String terminal) {
		this.terminal = terminal;
	}

	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	public String getServicePlan() {
		return servicePlan;
	}

	public void setServicePlan(String servicePlan) {
		this.servicePlan = servicePlan;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public double getCalculatedAmount() {
		return calculatedAmount;
	}

	public void setCalculatedAmount(double calculatedAmount) {
		this.calculatedAmount = calculatedAmount;
	}
}
