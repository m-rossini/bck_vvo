package br.com.auster.vivo.billcheckout.hierarchy;

import br.com.auster.billcheckout.consequence.telco.CarrierDimension;

public class HierarchyUsageInfo {

	private CarrierDimension carrier;

	/** Usage duration in minutes */
	private double duration;

	/** Charged amount for the usage */
	private double totalAmount;

	/** Calculated (supposedly correct) amount for the usage */
	private double calculatedAmount;

	public HierarchyUsageInfo(CarrierDimension carrier, double duration, double totalAmount, double calculatedAmount) {
		this.carrier = carrier;
		this.duration = duration;
		this.totalAmount = totalAmount;
		this.calculatedAmount = calculatedAmount;
	}

	public double getDuration() {
		return duration;
	}

	public void setDuration(double duration) {
		this.duration = duration;
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

	public CarrierDimension getCarrier() {
		return carrier;
	}

	public void setCarrier(CarrierDimension carrier) {
		this.carrier = carrier;
	}
}
