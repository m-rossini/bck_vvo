package br.com.auster.vivo.billcheckout.pricing;

import java.util.List;

import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;
import br.com.auster.om.invoice.UsageDetail;

public class PricingUsageThreaded extends Thread {

	private String accountNumber;
	private SQLPricingFacadeBase pricingFacade;
	private List<UsageDetail> usageList;
	private boolean negotiated;
	private int fromIndex;
	private int toIndex;

	protected PricingUsageThreaded(String threadName, String accountNumber, SQLPricingFacadeBase pricingFacade, List<UsageDetail> usageList, boolean negotiated) {
		this(threadName, accountNumber, pricingFacade, usageList, negotiated, 0, usageList.size());
	}

	protected PricingUsageThreaded(String threadName, String accountNumber, SQLPricingFacadeBase pricingFacade, List<UsageDetail> usageList, boolean negotiated, int fromIndex, int toIndex) {
		super(threadName);
		this.accountNumber = accountNumber;
		this.pricingFacade = pricingFacade;
		this.usageList = usageList;
		this.negotiated = negotiated;
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
					UsageDetail usage = this.usageList.get(i);
					// This method must receive true if not negotiated and false if it is negotiated.
					this.pricingFacade.price(usage, !this.negotiated);
				}
			}
		} finally {
			stats.finished();
			this.pricingFacade.releaseResources();
			ProcessingStats.dumpMyStats("Dumping stats for account " + this.accountNumber);
		}
	}
}
