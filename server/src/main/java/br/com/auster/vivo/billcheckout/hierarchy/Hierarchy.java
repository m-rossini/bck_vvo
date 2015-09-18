package br.com.auster.vivo.billcheckout.hierarchy;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class Hierarchy {

	private IOException lastFailure;

	private Map<String, HierarchyAccount> accounts = new HashMap<String, HierarchyAccount>();

	/**
	 * Checks if all data collected from each hierarchy account is available. 
	 * @return true if the data collection is complete
	 */
	public synchronized boolean isComplete() {
		if (isFailed() || getAccounts().isEmpty()) {
			return false;
		}
		for (HierarchyAccount node : getAccounts().values()) {
			if (!node.isFound()) {
				return false;
			}
		}
		return true;
	}

	/**
	 * If there was a failure either writing or reading the hierarchy data,
	 * it is useless to proceed, because it is mandatory for all data to be available.
	 * @return true if any I/O failure has occurred
	 */
	public synchronized boolean isFailed() {
		return getLastFailure() != null;
	}

	private IOException getLastFailure() {
		return this.lastFailure;
	}

	/**
	 * Since it will be useless to proceed processing this hierarchy,
	 * mark it whenever there is a failure either writing or reading the hierarchy data.
	 * This method also releases all previously collected data.
	 * @param failure the last I/O exception occurred
	 */
	public synchronized void setLastFailure(IOException failure) {
		this.lastFailure = failure;
		this.accounts.clear();
	}

	@Override
	public String toString() {
		return getAccounts().values().toString();
	}

	public synchronized HierarchyAccount getAccount(String accountId) {
		return accounts.get(accountId);
	}

	public synchronized Hierarchy addAccount(String accountId, boolean alreadyAvailable) {
		this.accounts.put(accountId, new HierarchyAccount(accountId, alreadyAvailable));
		return this;
	}

	public synchronized Map<String, HierarchyAccount> getAccounts() {
		return accounts;
	}
}
