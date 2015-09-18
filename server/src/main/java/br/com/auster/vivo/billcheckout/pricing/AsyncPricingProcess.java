package br.com.auster.vivo.billcheckout.pricing;

public abstract class AsyncPricingProcess {

	public void awaitCompletion() throws InterruptedException {
		for (Thread thread : getThreads()) {
			thread.join();
		}
	}

	protected abstract Thread[] getThreads();
}
