package br.com.auster.vivo.billcheckout.pricing;

import java.util.List;

import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;
import br.com.auster.om.invoice.ServiceDetail;

public class PricingSubscriptionThreaded extends Thread {

	private String accountNumber;
	private SQLPricingFacadeBase pricingFacade;
	private List<ServiceDetail> subscriptionList;
	private int fromIndex;
	private int toIndex;

	@SuppressWarnings("unchecked")
	protected PricingSubscriptionThreaded(String threadName, String accountNumber, SQLPricingFacadeBase pricingFacade, List<ServiceDetail> subscriptionList) {
		this(threadName, accountNumber, pricingFacade, subscriptionList, 0, subscriptionList.size());
	}

	@SuppressWarnings("unchecked")
	protected PricingSubscriptionThreaded(String threadName, String accountNumber, SQLPricingFacadeBase pricingFacade, List<ServiceDetail> subscriptionList, int fromIndex, int toIndex) {
		super(threadName);
		this.accountNumber = accountNumber;
		this.pricingFacade = pricingFacade;
		this.subscriptionList = subscriptionList;
		this.fromIndex = fromIndex;
		this.toIndex = toIndex;
	}

	@Override
	public void run() {
		ProcessingStats.dontDumpMyStats();
		StatsMapping stats = ProcessingStats.starting(getClass(), "run()");
		try {
			if (this.pricingFacade != null) {
				for (int i = this.fromIndex; i < this.toIndex; i++) {
					ServiceDetail sd = this.subscriptionList.get(i);
					this.pricingFacade.price(sd);
				}
			}
		} finally {
			stats.finished();
			this.pricingFacade.releaseResources();
			ProcessingStats.dumpMyStats("Dumping stats for account " + this.accountNumber);
		}
	}
}
