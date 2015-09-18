package br.com.auster.vivo.billcheckout.pricing;

import java.util.List;

import br.com.auster.om.invoice.ServiceDetail;

public class SubscriptionPricingProcess extends AsyncPricingProcess {

	private PricingSubscriptionThreaded[] subscriptionPricingThreads;

	private SubscriptionPricingProcess(PricingSubscriptionThreaded... threads) {
		this.subscriptionPricingThreads = threads;
	}

	@SuppressWarnings("unchecked")
	public static SubscriptionPricingProcess doAsynchronously(String accountNumber, List<ServiceDetail> subscriptionList, SQLPricingFacadeBase... pricingFacades) {
		PricingSubscriptionThreaded[] threads = new PricingSubscriptionThreaded[pricingFacades.length];
		if (pricingFacades.length == 1) {
			threads[0] = new PricingSubscriptionThreaded(
					Thread.currentThread().getName() + "-SubscriptionPricing-1",
					accountNumber, pricingFacades[0], subscriptionList);
			threads[0].start();
		} else {
			// splits the list for each thread
			int fromIndex = 0;
			int toIndex = 0;
			for (int i = 0; i < pricingFacades.length; i++) {
				fromIndex = toIndex;
				if (i == pricingFacades.length - 1) {
					toIndex = subscriptionList.size();
				} else {
					toIndex += subscriptionList.size() / pricingFacades.length;
				}
				threads[i] = new PricingSubscriptionThreaded(
						Thread.currentThread().getName() + "-SubscriptionPricing-" + (i + 1),
						accountNumber, pricingFacades[i], subscriptionList, fromIndex, toIndex);
				threads[i].start();
			}
		}
		return new SubscriptionPricingProcess(threads);
	}

	@Override
	protected Thread[] getThreads() {
		return this.subscriptionPricingThreads;
	}
}
