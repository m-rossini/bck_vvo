package br.com.auster.vivo.billcheckout.hierarchy;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;

import javax.naming.NamingException;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import br.com.auster.billcheckout.consequence.telco.AccountDimension;
import br.com.auster.billcheckout.consequence.telco.CarrierDimension;
import br.com.auster.billcheckout.consequence.telco.CycleDimension;
import br.com.auster.billcheckout.consequence.telco.GeographicDimension;
import br.com.auster.billcheckout.consequence.telco.TimeDimension;
import br.com.auster.common.sql.SQLConnectionManager;
import br.com.auster.common.sql.SQLStatement;
import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.om.invoice.ServiceDetail;
import br.com.auster.om.invoice.UsageDetail;
import br.com.auster.om.reference.facade.ConfigurationException;
import br.com.auster.vivo.billcheckout.util.DimensionCache;

import com.thoughtworks.xstream.XStream;

public class HierarchyHelper {

	private static String rootPath;

	private static Logger log = Logger.getLogger(HierarchyHelper.class);

	private static final Map<String, Hierarchy> hierarchyMap = Collections.synchronizedMap(new HashMap<String, Hierarchy>());

	private Map<String, SQLStatement> stmtsMap = new HashMap<String, SQLStatement>();
	private SQLConnectionManager sqlMan;

	public void configure(Element config) {
		try {
			Element dbElement = DOMUtils.getElement(config, "database", true);

			String poolName = DOMUtils.getAttribute(dbElement, "pool-name", true);
			if ((poolName == null) || (poolName.trim().length() == 0)) {
				throw new ConfigurationException("pool-name was not informed.");
			}

			this.sqlMan = SQLConnectionManager.getInstance(poolName);

			Element stmtsElement = DOMUtils.getElement(dbElement, "statement-names", true);
			NodeList nameList = DOMUtils.getElements(stmtsElement, "statement-name");
			int qt = nameList.getLength();
			for (int i = 0; i < qt; i++) {
				Element nameElement = (Element) nameList.item(i);
				String sqlName = DOMUtils.getAttribute(nameElement, "name", true);
				SQLStatement statement = sqlMan.getStatement(sqlName);
				this.stmtsMap.put(sqlName, statement);
			}
			log.debug("Number of SQL Statements successfully loaded is:"	+ this.stmtsMap.size());

			Element workDirElement = DOMUtils.getElement(config, "work-dir", true);
			rootPath = DOMUtils.getAttribute(workDirElement, "root-path", true);
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	public Map<String, Collection<HierarchyInfo>> collectHierarchyAccounts(
			Set<String> hierarchyIds, String accountId, String startDate,
			String endDate, HierarchyInfo accountInfo) {
		Map<String, Collection<HierarchyInfo>> collectedHierarchies = null;
		for (String hierarchyId : hierarchyIds) {
			Hierarchy hierarchy = hierarchyMap.get(hierarchyId);
			if (hierarchy == null) {	// new hierarchy: load it up
				hierarchy = updateHierarchyMap(hierarchyId, loadFullHierarchy(hierarchyId, startDate, endDate));
			}
			if (hierarchy.isFailed()) {	// useless to proceed
				return null;
			}
			try {
				boolean completelyLoaded;
				synchronized (hierarchy) {
					HierarchyAccount account = hierarchy.getAccount(accountId);
					account.setFound(true);
					account.setApplicable(!accountInfo.isEmpty());
					completelyLoaded = hierarchy.isComplete();
				}
				if (completelyLoaded) { // load all other accounts
					Map<String, HierarchyInfo> allAccountsData = new HashMap<String, HierarchyInfo>();
					if (!accountInfo.isEmpty()) {
						allAccountsData.put(accountId, accountInfo);
					}
					for (HierarchyAccount account : hierarchy.getAccounts().values()) {
						if (account.isApplicable()) {
							String id = account.getAccountId();
							if (!allAccountsData.containsKey(id)) {
								allAccountsData.put(id, loadAccountData(hierarchyId, id));
							}
						}
					}
					if (collectedHierarchies == null) {
						collectedHierarchies = new HashMap<String, Collection<HierarchyInfo>>();
					}
					collectedHierarchies.put(hierarchyId, allAccountsData.values());
				} else {	// save account data for later use
					if (!accountInfo.isEmpty()) {
						saveAccountData(hierarchyId, accountId, accountInfo);
					}
				}
			} catch (IOException e) {	// mark hierarchy as useless, due to I/O error
				hierarchy.setLastFailure(e);
				removeStoredData(hierarchyId);
			}
		}
		return collectedHierarchies;
	}

	private Hierarchy updateHierarchyMap(String hierarchyId, Hierarchy hierarchy) {
		synchronized (hierarchyMap) {
			Hierarchy currentHierarchy = hierarchyMap.get(hierarchyId);
			if (currentHierarchy == null) {
				hierarchyMap.put(hierarchyId, hierarchy);
			} else {
				hierarchy = currentHierarchy;
			}
			return hierarchy;
		}
	}

	public static void requestFinished() {
		if (!hierarchyMap.isEmpty()) {
			StringBuilder buffer = new StringBuilder();
			buffer.append(hierarchyMap.size());
			buffer.append(" hierarquia(s) nao processada(s):");
			for (Entry<String, Hierarchy> hierarchy : hierarchyMap.entrySet()) {
				buffer.append("\n");
				buffer.append(hierarchy.getKey());
				buffer.append(": ");
				buffer.append(hierarchy.getValue());
				cleanUp(hierarchy.getKey());
			}
			log.warn(buffer.toString());
		}
		hierarchyMap.clear();
	}

	private Hierarchy loadFullHierarchy(String hierarchyId, String startDate, String endDate) {
		Hierarchy hierarchy = new Hierarchy();
		String queryName = "FullHierarchy";
		SQLStatement query = (SQLStatement) this.stmtsMap.get(queryName);
		if (query == null) {
			log.error("Statement named " + queryName + " not found! Assuming hierarchy "+ hierarchyId +" is empty.");
			return hierarchy;
		}
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		File homeFolder = getHierarchyHomeFolder(hierarchyId);
		StatsMapping stats = ProcessingStats.starting(getClass(), queryName);
		try {
			conn = sqlMan.getConnection();
			Object[] parameters = {hierarchyId, endDate, startDate};
			ps = query.prepareStatement(conn, parameters);
			rs = ps.executeQuery();
			while (rs.next()) {
				String accountId = rs.getString("acct_nbr");
				boolean alreadyAvailable = getAccountDataFile(homeFolder, accountId).exists();
				hierarchy.addAccount(accountId, alreadyAvailable);
			}
		} catch (IllegalArgumentException e) {
			log.error("Error preparing statement", e);
		} catch (SQLException e) {
			log.error("Error executing query", e);
		} finally {
			stats.finished();
			try {
				if (rs != null) { rs.close(); }
				if (ps != null) { ps.close(); }
				if (conn != null) {	conn.close(); }
			} catch (SQLException e) {
				log.error("Problems releasing resources for query.", e);
			}
		}
		return hierarchy;
	}

	public static void cleanUp(String hierarchyId) {
		removeStoredData(hierarchyId);
		hierarchyMap.remove(hierarchyId);
	}

	private static void removeStoredData(String hierarchyId) {
		if (hierarchyId != HierarchyInfo.NO_HIERARCHY) {
			log.info("Removing all files within " + hierarchyId + " folder");
			removeRecursively(getHierarchyHomeFolder(hierarchyId));
		}
	}

	private static void removeRecursively(File folder) {
		if (folder.exists()) {
			if (folder.isDirectory()) {
				for (File f : folder.listFiles()) {
					removeRecursively(f);
				}
			}
			folder.delete();
		}
	}

	@SuppressWarnings("unchecked")
	public void addSubscription(HierarchyInfo hierarchyInfo, DimensionCache dimensionCache, ServiceDetail subscriptionService, String servicePlan) {
		hierarchyInfo.addSubscription(buildSubscriptionInfo(dimensionCache, subscriptionService, servicePlan));
	}

	public void addDataServices(HierarchyInfo hierarchyInfo, DimensionCache dimensionCache, Collection<ServiceDetail> dataServices) {
		for (ServiceDetail dataService : dataServices) {
			hierarchyInfo.addDataService(buildSubscriptionInfo(dimensionCache, dataService, null));
		}
	}

	public void addFreeCompanyUsages(HierarchyInfo hierarchyInfo, DimensionCache dimensionCache, Collection<UsageDetail> usages) {
		for (UsageDetail usage : usages) {
			hierarchyInfo.addFreeCompanyUsage(usage.getSvcPlan(), buildUsageInfo(dimensionCache, usage));
		}
	}

	public void addPlanoEmpresaUsages(HierarchyInfo hierarchyInfo, DimensionCache dimensionCache, Collection<UsageDetail> usages) {
		for (UsageDetail usage : usages) {
			hierarchyInfo.addPlanoEmpresaUsage(usage.getSvcPlan(), buildUsageInfo(dimensionCache, usage));
		}
	}

	private HierarchyUsageInfo buildUsageInfo(DimensionCache dimensionCache, UsageDetail usage) {
		return new HierarchyUsageInfo(
			(CarrierDimension) dimensionCache.getFromCache(usage.getCarrierCode()),
			usage.getUsageDuration().getMinutes(),
			usage.getTotalAmount(),
			usage.getCalculatedValue());
	}

	public HierarchySubscriptionInfo buildSubscriptionInfo(DimensionCache dimensionCache, ServiceDetail subscription, String servicePlan) {
		HierarchySubscriptionInfo subInfo = new HierarchySubscriptionInfo();
		subInfo.setCarrier((CarrierDimension) dimensionCache.getFromCache(subscription.getCarrierCode()));
		subInfo.setId(subscription.getSection().getSubscriptionid());
		subInfo.setTerminal(subscription.getSection().getParentSection().getChannelId());
		subInfo.setServicePlan(servicePlan);				// svcPlan from 300D 
		subInfo.setServiceName(subscription.getCaption());	// caption from 325D
		subInfo.setTotalAmount(subscription.getTotalAmount());
		subInfo.setCalculatedAmount(subscription.getCalculatedAmount());
		return subInfo;
	}

	public HierarchyInfo buildHierarchyInfo(DimensionCache dimensionCache) {
		HierarchyInfo hierarchyInfo = new HierarchyInfo();
		hierarchyInfo.setAccount((AccountDimension) dimensionCache.getFromCache("account"));
		hierarchyInfo.setGeographics((GeographicDimension) dimensionCache.getFromCache("geo"));
		hierarchyInfo.setTime((TimeDimension) dimensionCache.getFromCache("time"));
		hierarchyInfo.setCycle((CycleDimension) dimensionCache.getFromCache("cycle"));
		return hierarchyInfo;
	}

	private HierarchyInfo loadAccountData(String hierarchyId, String accountId) throws IOException {
		log.info("Loading data from " + hierarchyId + "/" + accountId);
		File accountDataFile = getAccountDataFile(hierarchyId, accountId);
		try {
			return loadHierarchyInfo(accountDataFile);
		} catch (IOException e) {
			log.error("Error trying to load data for account " + accountId + " from file " + accountDataFile, e);
			throw e;
		}
	}

	private void saveAccountData(String hierarchyId, String accountId, HierarchyInfo accountData) throws IOException {
		File accountDataFile = getAccountDataFile(hierarchyId, accountId);
		log.info("Saving data at " + accountDataFile.getAbsolutePath());
		File folder = accountDataFile.getParentFile();
		if (!folder.exists()) {
			folder.mkdirs();
		}
		try {
			saveHierarchyInfo(accountData, accountDataFile);
		} catch (IOException e) {
			log.error("Error trying to save data for account " + accountId + " into file " + accountDataFile, e);
			throw e;
		}
	}

	private File getAccountDataFile(String hierarchyId, String accountId) {
		File folder = getHierarchyHomeFolder(hierarchyId);
		return getAccountDataFile(folder, accountId);
	}

	private File getAccountDataFile(File homeFolder, String accountId) {
		return new File(homeFolder, accountId + ".dat.gz");
	}

	private static File getHierarchyHomeFolder(String hierarchyId) {
		return new File(rootPath, hierarchyId);
	}

	private HierarchyInfo loadHierarchyInfo(File file) throws IOException {
		return (HierarchyInfo) loadData(buildHierarchyInfoXStream(), file);
	}

	private Object loadData(XStream xstream, File file) throws IOException {
		FileInputStream input = new FileInputStream(file);
		try {
			GZIPInputStream gzip = new GZIPInputStream(input);
			try {
				return xstream.fromXML(gzip);
			} finally {
				gzip.close();
			}
		} finally {
			input.close();
		}
	}

	private void saveHierarchyInfo(HierarchyInfo data, File file) throws IOException {
		saveData(buildHierarchyInfoXStream(), data, file);
	}

	private void saveData(XStream xstream, Object data, File file) throws IOException {
		FileOutputStream output = new FileOutputStream(file);
		try {
			GZIPOutputStream gzip = new GZIPOutputStream(output);
			try {
				xstream.toXML(data, gzip);
				gzip.flush();
			} finally {
				gzip.close();
			}
			output.flush();
		} finally {
			output.close();
		}
	}

	private XStream buildHierarchyInfoXStream() {
		XStream xstream = new XStream();
		xstream.alias("acc", HierarchyInfo.class);
		xstream.alias("sub", HierarchySubscriptionInfo.class);
		xstream.alias("usg", HierarchyUsageInfo.class);
		return xstream;
	}
}
