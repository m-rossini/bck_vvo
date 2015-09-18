/*
 * Copyright (c) 2004 Auster Solutions. All Rights Reserved.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Created on 17/10/2006
 */
package br.com.auster.vivo.billcheckout.util;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.apache.commons.collections.CollectionUtils;
import org.apache.log4j.Logger;

import br.com.auster.om.invoice.Invoice;
import br.com.auster.om.invoice.Section;
import br.com.auster.om.invoice.SectionDetail;
import br.com.auster.om.invoice.ServiceDetail;

/**
 * @author mtengelm
 * 
 */
public class DataBarnHandler {

	private static Logger	log					= Logger.getLogger(DataBarnHandler.class);

	private Map						subsExtMap	= new HashMap();

	private Set						accNoSourceSet;

	/**
	 * 
	 */
	public DataBarnHandler() {
	}

	public void dumpSection(Section section) {
		for (Iterator itr = section.getSubSections().iterator(); itr.hasNext();) {
			Section sub = (Section) itr.next();
			log.debug("SS for section:" + section.getCaption() + ".sub:"
					+ sub.getTag() + " - " + sub.getCaption());
			List list = sub.getDetails();
			for (Iterator det = list.iterator(); det.hasNext();) {
				SectionDetail sd = (ServiceDetail) det.next();
				log.debug(".DET:" + sd.getTag() + " - " + sd.getCaption());
			}
		}
	}

	/*****************************************************************************
	 * Returns the Map with ALL access numbers and respective services
	 * 
	 * @return
	 */
	public Map getExternalSubcriptionServices() {
		return subsExtMap;
	}

	public List getExternalServices(String accessNumber) {
		log.debug("Returning list of services for:" + accessNumber + " -> "
				+ subsExtMap.get(accessNumber));
		return (List) subsExtMap.get(accessNumber);
	}

	/*****************************************************************************
	* @see getExternalAccessNumbers(boolean keepEqualsSub)
	* This method is the same as getExternalAccessNumbers(false)
	 * 
	 * @return
	 */
	public Set getExternalAccessNumbers() {
		return getExternalAccessNumbers(false);
	}

	/*****************************************************************************
	 * 
	 * Returns a Set with all distinct Accesses numbers returned by data barn
	 * query
	 * 
	 * </p>
	 * 
	 * @param keepEqualsSub If true it will keep ocurrences where subscription ID is equals to access numbers
	 * @return A Set with all Databarn Access Numbers
	 */
	public Set getExternalAccessNumbers(boolean keepEqualsSub) {
		if (keepEqualsSub) {
			return subsExtMap.keySet();
		}
		
		Set results = new HashSet();
		for (Iterator it=this.subsExtMap.entrySet().iterator();it.hasNext();) {
			Map.Entry entry = (Map.Entry) it.next();
			String accessNumber = (String) entry.getKey();
			List list = (List) entry.getValue();
			for (Iterator daoIt = list.iterator();daoIt.hasNext();) {
				DAOSubServices dao = (DAOSubServices) daoIt.next();
				if (dao.getAccessNumber() == null || dao.getSubscriptionId() == null) {
					daoIt.remove();
				} else if (dao.getAccessNumber().equals(dao.getSubscriptionId())) {
					daoIt.remove();
				}
			}
			if (list.size() != 0 ) {
				results.add(accessNumber);				
			}
		}
		
		return results;
	}

	/*****************************************************************************
	 * Runs a prepared stmt and returns a ResultSet. Please note it is
	 * responsability of the caller to close: 1.The returned result set 2.The
	 * Prepared stmt.
	 * 
	 * This method is just a bridge to make the transition between the old (And
	 * now deprecated) SQLConectionManager methods to the new implementation.
	 * 
	 * It is here instead of SQLEmitter to no body be tempted to run sql from SQL
	 * Emitter and no close the generated and returned objects.
	 * 
	 * @param stmt
	 *          The Prepared SQL Statement
	 * @return A ResultSet as defined by PreparedStatement.executeQuery() method.
	 * @throws SQLException
	 */
	public ResultSet runSQL(PreparedStatement stmt) throws SQLException {
		return stmt.executeQuery();
	}

	/*****************************************************************************
	 * Builds a Map, whose key is the access number and the value is a list of DAO
	 * Services for that access numbers. The Map is built upon a query (In this
	 * case a resultset) run against data-barn. The result is the number of
	 * distinct access numbers found.
	 * 
	 * This method will call the method
	 * 
	 * @see public int buildExternalSubscriptionServices(ResultSet rs, boolean
	 *      ignoreEqualsSubscription) throws SQLException, passing the boolean as
	 *      false.
	 * 
	 * Additionally thi method WILL CLOSE the ResultSet.
	 * 
	 * @param rs
	 *          The result set used to get the data from external database. PLEASE
	 *          NOTE tis will be closed on exit from this method
	 * @return An int representing the distinct access numbers found in the query.
	 * @throws SQLException
	 */
	public int buildExternalSubscriptionServices(ResultSet rs)
			throws SQLException {
		return buildExternalSubscriptionServices(rs, false);
	}

	/*****************************************************************************
	 * GIven a result set, initialize, builds and keeps until next call to it a
	 * Map with all Subscriptions Services for all subscriptions of current
	 * account (The query determines who is the current account).
	 * 
	 * If the ignoreEqualsSubscription boolean is false, then even if subscription
	 * id and access number are equals, the database row WILL be populated. If the
	 * ignoreEqualsSubscription boolean is true, then if subscription id and
	 * access number are equals, the row coming from database will NOT be saved in
	 * the Map.
	 * 
	 * If bot of above fields are null they are considered equals.
	 * 
	 * <p>
	 * Example:
	 * 
	 * <pre>
	 *    Create a use example.
	 * </pre>
	 * 
	 * </p>
	 * 
	 * @param rs
	 *          A Result set with databarn data
	 * @param ignoreEqualsSubscription
	 *          If we should ignore rows with subscription id and access number
	 *          equalsto each other.
	 * @return An integer with map size.
	 * @throws SQLException
	 */
	public int buildExternalSubscriptionServices(ResultSet rs,
			boolean ignoreEqualsSubscription) throws SQLException {
		if (log.isTraceEnabled()) {
			Runtime rt = Runtime.getRuntime();
			log.trace("ABM.DBHandler.buildExternalSubscriptionServices.BFR;Free:"
					+ rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:"
					+ rt.maxMemory());
		}
		subsExtMap.clear();

		long st = System.nanoTime();
		try {
			while (rs.next()) {
				String accessNumber = rs.getString("ACCESS_NUMBER");
				String subscriptionID = rs.getString("SUBSCRIPTION_ID");
				if (ignoreEqualsSubscription) {
					if ((accessNumber == null && subscriptionID == null)) {
						// They are equals , because both are null. So, skip this row.
						continue;
					}
					if (accessNumber != null && subscriptionID != null) {
						if (accessNumber.equalsIgnoreCase(subscriptionID)) {
							continue;
						}
					}
				}
				DAOSubServices dao = new DAOSubServices();
				dao.setAccountNumber(rs.getString("ACCOUNT_NBR"));
				dao.setCycleCode(rs.getString("CYCLE_CODE"));

				dao.setAccessNumber(accessNumber);
				dao.setSubscriptionId(subscriptionID);
				dao.setAccessNumberEffective(rs.getDate("ACCESS_NUMBER_EFF"));
				dao.setAccessNumberExpiration(rs.getDate("ACCESS_NUMBER_EXP"));
				dao.setServiceEffective(rs.getDate("SVC_EFF"));
				dao.setServiceExpiration(rs.getDate("SVC_EXP"));
				dao.setServiceName(rs.getString("SVC_NAME"));
				List subExtServices = (List) subsExtMap.get(accessNumber);
				if (subExtServices == null) {
					subExtServices = new ArrayList();
				}
				if (shouldAddService(subExtServices, dao)) {
					log.debug("shoudlAddService is true.VO:" + dao);
					subExtServices.add(dao);
				}
				subsExtMap.put(accessNumber, subExtServices);
			}
		} finally {
			rs.close();
		}

		long et = System.nanoTime();
		if (log.isDebugEnabled()) {
			log.debug("Acessing Databarn Time in milliseconds:"
					+ ((et - st) / 1000 / 1000)
					+ " Returning a list of access numbers with size of:"
					+ subsExtMap.size()
					+ " for getting subscriptions services (R27,R40,R41)");
			for (Iterator it = subsExtMap.entrySet().iterator(); it.hasNext();) {
				Map.Entry entry = (Entry) it.next();
				log.debug("For access number:" + entry.getKey());
				log.debug("Service List:" + entry.getValue());
			}
		}

		if (log.isTraceEnabled()) {
			Runtime rt = Runtime.getRuntime();
			log.trace("ABM.DBHandler.buildExternalSubscriptionServices.AFT;Free:"
					+ rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:"
					+ rt.maxMemory());
		}

		return subsExtMap.size();
	}

	protected boolean shouldAddService(List svcs, DAOSubServices vo) {
		for (ListIterator it = svcs.listIterator(); it.hasNext();) {
			DAOSubServices sub = (DAOSubServices) it.next();

			log.debug("Checking.VO:" + vo);
			log.debug("Checking.EL:" + sub);

			if (vo.equals(sub)) {
				return false;
			}
			if (!vo.getAccountNumber().equals(sub.getAccountNumber())) {
				return true;
			}
			if (!vo.getAccessNumber().equals(sub.getAccessNumber())) {
				return true;
			}
			if (!vo.getSubscriptionId().equals(sub.getSubscriptionId())) {
				return true;
			}
			if (!vo.getServiceName().equals(sub.getServiceName())) {
				continue;
			}

			// Note1:In below IFS NULL MEANS NOT EXPIRED FOR EXPIRATION. These objects
			// (Without expiration has priority)
			// Note2:Here we assume (given previous IFs on this mehotd) that, Account,
			// Subscription, Terminal and Service are the same

			// If current is not expired and incoming is expired, keep the way it is.
			if (sub.getServiceExpiration() == null
					& vo.getServiceExpiration() != null) {
				log.debug("Current one was kept.Rule1");
				return false;
			}

			// If both services are not expired (Remember Note2) we found a business
			// error.
			// In this case we are ASSUMING the oldest service is the correct one.
			if (sub.getServiceExpiration() == null
					& vo.getServiceExpiration() == null) {
				if (sub.getServiceEffective() == null) {
					log.debug("Removing current and adding incoming.Rule 2.1");
					it.remove();
					return true;
				}
				if (vo.getServiceEffective() == null) {
					log.debug("Current one was kept.Rule2.2");
					return false;
				}
				if (sub.getServiceEffective().before(vo.getServiceEffective())) {
					log.debug("Current one was kept.Rule2.3");
					return false;
				} else {
					log.debug("Removing current and adding incoming.Rule 2.4");
					it.remove();
					return true;
				}

			}

			// If current is expired and incomming is not expired, remove the current
			// and add the incoming
			if (sub.getServiceExpiration() != null
					&& vo.getServiceExpiration() == null) {
				log.debug("Removing current and adding incoming.Rule 3");
				it.remove();
				return true;
			}

			// If both are expired.....Use the most recent expiration....
			if (sub.getServiceExpiration() != null
					&& vo.getServiceExpiration() != null) {
				if (sub.getServiceExpiration().after(vo.getServiceExpiration())) {
					log.debug("Current one was kept.Rule4.1");
					return false;
				} else {
					log.debug("Removing current and adding incoming.Rule4.2");
					it.remove();
					return true;

				}
			}

		}
		return true;
	}

	/*****************************************************************************
	 * returns a set with access numbers found in the invoice.
	 * 
	 * @return null if buildSubcriptionSetFromSource has not being called,
	 *         otherwise the Set.
	 */
	public Set getSourceAccessNumbers() {
		return accNoSourceSet;
	}

	/*****************************************************************************
	 * Builds the Set with all subscriptions of the Invoice. Returning the size of
	 * the Set
	 * 
	 * @param invoice
	 * @return
	 */
	public int buildSubcriptionSetFromSource(Invoice invoice,
			boolean ignoreEqualSubscriptions) {
		if (log.isTraceEnabled()) {
			Runtime rt = Runtime.getRuntime();
			log.trace("ABM.DBHandler.buildSubcriptionSetFromSource.BFR;Free:"
					+ rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:"
					+ rt.maxMemory());
		}
		// if (accNoSourceSet == null) {
		accNoSourceSet = new HashSet();
		// }
		List list = invoice.getSections();
		for (Iterator itr = list.iterator(); itr.hasNext();) {
			Section section = (Section) itr.next();
			if (section.getTag().equals("300D")) {
				if (!accNoSourceSet.contains(section.getAccessNbr())) {
					if (!ignoreEqualSubscriptions
							|| (ignoreEqualSubscriptions && !section
									.isSubscriptionIdEqualsToChannelId())) {
						accNoSourceSet.add(section.getAccessNbr());
					}
				}
			}
		}
		if (log.isDebugEnabled()) {
			log.debug("Source  (SIRS) list of subscriptions is:" + accNoSourceSet
					+ "for account:" + invoice.getAccount().getAccountNumber());
			for (Iterator it = accNoSourceSet.iterator(); it.hasNext();) {
				log.debug("SIRS Access Line:" + it.next());
			}
		}
		if (log.isTraceEnabled()) {
			Runtime rt = Runtime.getRuntime();
			log.trace("ABM.DBHandler.buildSubcriptionSetFromSource.AFR;Free:"
					+ rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:"
					+ rt.maxMemory());
		}

		return accNoSourceSet.size();
	}

	/*****************************************************************************
	 * Verifies if a given date is between a given range. If check is inside the
	 * range of sr and er, then returns 0. If nullvalid is true and check date is
	 * null, then returns 0.
	 * 
	 * @param sr
	 *          Start range for checking the date
	 * @param er
	 *          End range for checking the date
	 * @param check
	 *          The date to be checked
	 * @param nullValid
	 *          If true, null check dates are valid. Otherwise they are invalid
	 * @return 0 if the date is in a valid range (OR check date is null and
	 *         nullvalid is true) 1 if the check date is null and nullvalid is
	 *         false 2 if the check date is after the er date 4 if the check date
	 *         is before the sr date
	 */
	public static int isDateInRange(Date sr, Date er, Date check,
			boolean nullValid) {
		int retval = 0;
		if (check == null && nullValid) {
			return 0;
		}

		if (check == null && !nullValid) {
			return 1;
		}
		if (er == null || check.after(er)) {
			retval += 2;
		}

		if (sr == null || check.before(sr)) {
			retval += 4;
		}
		return retval;
	}

	public static String getSvcPlan(String caption) {
		int index = caption.lastIndexOf('-');
		index = (index > -1) ? index : caption.lastIndexOf('.');
		return caption.substring(index + 1).trim();
	}

	protected List checkDatesForDetails(List details, String accessNumber,
			Date sdate, Date edate) {
		List retval = new ArrayList();
		for (Iterator itr = details.iterator(); itr.hasNext();) {
			SectionDetail sd = (SectionDetail) itr.next();
			log.debug("SectionDetail.TAG:" + sd.getTag() + ".Caption:"
					+ sd.getCaption() + ".=>" + getSvcPlan(sd.getCaption()));
			if (sd.getTag().equals("325D")) {
				ServiceDetail service = (ServiceDetail) sd;
				log.debug("SD:" + service.getStartDate() + ".ED:"
						+ service.getEndDate());
			}

		}
		return retval;
	}

	/*****************************************************************************
	 * Returns the Subtract operation of two Sets. It will return all
	 * Subscriptions that exists in SIRS but not exists in DATA-BARN. See
	 * CollectionUtils in commons-collection (Apache)
	 * 
	 * @return
	 */
	public Collection getExternalMissing() {
		Collection results =	CollectionUtils.subtract(getSourceAccessNumbers(),
				getExternalAccessNumbers());
		log.trace("GetExternalMissing(Source subtract External):" + results);
		return results;
	}

	/*****************************************************************************
	 * Returns the Subtract operation of two Sets. It will return all
	 * Subscriptions that exists in DATA-BARN but not exists in SIRS. See
	 * CollectionUtils in commons-collection (Apache)
	 * 
	 * @return
	 */
	public Collection getSourceMissing() {
		Collection results = CollectionUtils.subtract(getExternalAccessNumbers(),
				getSourceAccessNumbers());
		log.trace("GetSourceMissing(External subtract Source):" + results);		
		return results;
	}

	/*****************************************************************************
	 * Returns the Subtract operation of two Sets. It will return all
	 * Subscriptions that exists in DATA-BARN but not exists in SIRS.
	 * 
	 * Additionally, this method will return ONLY ocurrences in DATA-BARN where:
	 * 
	 * ACCESS_NUMBER_EXP_DATE is NULL OR ACCESS_NUMBER_EXP_DATE is NOT NULL AND
	 * ACCESS_NUMBER_EXP_DATE IS AFTER the given date
	 * 
	 * See CollectionUtils in commons-collection (Apache)
	 * 
	 * @return
	 */
	public Collection getSourceMissingAfterDate(Date date) {
		Collection results = CollectionUtils.subtract(getExternalAccessNumbersAfterDate(date),
				getSourceAccessNumbers());
		log.trace("getSourceMissing after date. date:" + date + ".External (After date) subtract Source:" + results);
		return results;
	}

	/*****************************************************************************
	 * Returns a Set with all distinct Accesses numbers returned by data barn
	 * query
	 * 
	 * Only and only the ACCESS_NUMBER_EXPIRATION_DATE is NULL OR
	 * ACCESS_NUMBER_EXPIRATION_DATE IS NOT NULL && ACCESS_NUMBER_EXPIRATION_DATE >
	 * than the given date
	 * 
	 * @return
	 */
	public Set<String> getExternalAccessNumbersAfterDate(Date date) {
		Set<String> results = new HashSet<String>();

		for (Iterator<Map.Entry<String, List>> it = subsExtMap.entrySet()
				.iterator(); it.hasNext();) {
			Entry<String, List> entry = it.next();

			String accessNo = entry.getKey();
			List services = entry.getValue();

			for (Iterator<DAOSubServices> itList = services.iterator(); itList
					.hasNext();) {
				DAOSubServices vo = itList.next();
				if (vo.getAccessNumberExpiration() == null
						|| (vo.getAccessNumberExpiration() != null && vo
								.getAccessNumberExpiration().after(date))) {
					if ((vo.getAccessNumber() != null && vo.getSubscriptionId() != null && !vo
							.getAccessNumber().equals(vo.getSubscriptionId()))) {
						results.add(accessNo);
						break;
					}
				}
			}

		}
		return results;
	}
}
