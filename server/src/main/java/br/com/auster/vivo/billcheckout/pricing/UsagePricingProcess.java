package br.com.auster.vivo.billcheckout.pricing;

import java.util.List;

import br.com.auster.om.invoice.UsageDetail;

public class UsagePricingProcess extends AsyncPricingProcess {

	private PricingUsageThreaded[] usagePricingThreads;

	private UsagePricingProcess(PricingUsageThreaded... threads) {
		this.usagePricingThreads = threads;
	}

	@SuppressWarnings("unchecked")
	public static UsagePricingProcess doAsynchronously(String accountNumber, List<UsageDetail> usageList, boolean negotiated, SQLPricingFacadeBase... pricingFacades) {
		PricingUsageThreaded[] threads = new PricingUsageThreaded[pricingFacades.length];
		if (pricingFacades.length == 1) {
			threads[0] = new PricingUsageThreaded(
					Thread.currentThread().getName() + "-UsagePricingThread-1",
					accountNumber, pricingFacades[0], usageList, negotiated);
			threads[0].start();
		} else {
			// splits the list for each thread
			int fromIndex = 0;
			int toIndex = 0;
			for (int i = 0; i < pricingFacades.length; i++) {
				fromIndex = toIndex;
				if (i == pricingFacades.length - 1) {
					toIndex = usageList.size();
				} else {
					toIndex += usageList.size() / pricingFacades.length;
				}
				threads[i] = new PricingUsageThreaded(
						Thread.currentThread().getName() + "-UsagePricingThread-" + (i + 1),
						accountNumber, pricingFacades[i], usageList, negotiated, fromIndex, toIndex);
				threads[i].start();
			}
		}
		return new UsagePricingProcess(threads);
	}

	@Override
	protected Thread[] getThreads() {
		return this.usagePricingThreads;
	}
}
