package br.com.auster.vivo.billcheckout.hierarchy;

public class HierarchyAccount {

	private String accountId;

	private boolean found = false;

	private boolean applicable = true;

	public HierarchyAccount(String accountId) {
		setAccountId(accountId);
	}

	public HierarchyAccount(String accountId, boolean alreadyAvailable) {
		this(accountId);
		setFound(alreadyAvailable);
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((getAccountId() == null) ? 0 : getAccountId().hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final HierarchyAccount other = (HierarchyAccount) obj;
		if (getAccountId() == null) {
			if (other.getAccountId() != null)
				return false;
		} else if (!getAccountId().equals(other.getAccountId()))
			return false;
		return true;
	}

	@Override
	public String toString() {
		StringBuilder buffer = new StringBuilder();
		buffer.append(getAccountId());
		if (isApplicable()) {
			if (isFound()) {
				buffer.append(" (found)");
			} else {
				buffer.append(" (not found)");
			}
		} else {
			buffer.append(" (empty)");
		}
		return buffer.toString();
	}

	public String getAccountId() {
		return accountId;
	}

	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}

	public boolean isFound() {
		return found;
	}

	public void setFound(boolean found) {
		this.found = found;
	}

	public boolean isApplicable() {
		return applicable;
	}

	public void setApplicable(boolean applicable) {
		this.applicable = applicable;
	}
}
