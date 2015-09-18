package br.com.auster.vivo.billcheckout.hierarchy;

public class TotalAccumulator {

	double total = 0.0;

	public void increment(double number) {
		this.total += number;
	}

	public double getTotal() {
		return this.total;
	}
}
