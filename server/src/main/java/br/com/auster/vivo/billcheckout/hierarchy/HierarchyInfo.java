package br.com.auster.vivo.billcheckout.hierarchy;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import br.com.auster.billcheckout.consequence.telco.AccountDimension;
import br.com.auster.billcheckout.consequence.telco.CycleDimension;
import br.com.auster.billcheckout.consequence.telco.GeographicDimension;
import br.com.auster.billcheckout.consequence.telco.TimeDimension;

public class HierarchyInfo {

	private AccountDimension account;
	private GeographicDimension geographics;
	private TimeDimension time;
	private CycleDimension cycle;

	private boolean subscriptionsProcessed = false;
	private Collection<HierarchySubscriptionInfo> subscriptions = new ArrayList<HierarchySubscriptionInfo>();

	private Collection<HierarchySubscriptionInfo> dataServices = new ArrayList<HierarchySubscriptionInfo>();
	private Map<String, Collection<HierarchyUsageInfo>> freeCompanyUsages = new HashMap<String, Collection<HierarchyUsageInfo>>();
	private Map<String, Collection<HierarchyUsageInfo>> planoEmpresaUsages = new HashMap<String, Collection<HierarchyUsageInfo>>();

	public final static String NO_HIERARCHY = "NONE";

	public boolean isEmpty() {
		return getSubscriptions().isEmpty()
			&& getDataServices().isEmpty()
			&& getFreeCompanyUsages().isEmpty()
			&& getPlanoEmpresaUsages().isEmpty();
	}

	public AccountDimension getAccount() {
		return account;
	}

	public void setAccount(AccountDimension account) {
		this.account = account;
	}

	public GeographicDimension getGeographics() {
		return geographics;
	}

	public void setGeographics(GeographicDimension geographics) {
		this.geographics = geographics;
	}

	public TimeDimension getTime() {
		return time;
	}

	public void setTime(TimeDimension time) {
		this.time = time;
	}

	public CycleDimension getCycle() {
		return cycle;
	}

	public void setCycle(CycleDimension cycle) {
		this.cycle = cycle;
	}

	public Collection<HierarchySubscriptionInfo> getSubscriptions() {
		return subscriptions;
	}

	public void addSubscription(HierarchySubscriptionInfo subscription) {
		this.subscriptions.add(subscription);
	}

	public Collection<HierarchySubscriptionInfo> getDataServices() {
		return dataServices;
	}

	public void addDataService(HierarchySubscriptionInfo dataService) {
		this.dataServices.add(dataService);
	}

	public Map<String, Collection<HierarchyUsageInfo>> getFreeCompanyUsages() {
		return this.freeCompanyUsages;
	}

	public Map<String, Collection<HierarchyUsageInfo>> getPlanoEmpresaUsages() {
		return this.planoEmpresaUsages;
	}

	public void addFreeCompanyUsage(String serviceName, HierarchyUsageInfo usage) {
		addUsage(getFreeCompanyUsages(), serviceName, usage);
	}

	public void addPlanoEmpresaUsage(String serviceName, HierarchyUsageInfo usage) {
		addUsage(getPlanoEmpresaUsages(), serviceName, usage);
	}

	public void addUsage(Map<String, Collection<HierarchyUsageInfo>> usages,
			String serviceName, HierarchyUsageInfo usage) {
		Collection<HierarchyUsageInfo> serviceUsages = usages.get(serviceName);
		if (serviceUsages == null) {
			serviceUsages = new ArrayList<HierarchyUsageInfo>();
			usages.put(serviceName, serviceUsages);
		}
		serviceUsages.add(usage);
	}

	public boolean isSubscriptionsProcessed() {
		return subscriptionsProcessed;
	}

	public void setSubscriptionsProcessed(boolean subscriptionsProcessed) {
		this.subscriptionsProcessed = subscriptionsProcessed;
	}
}
