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
 * Created on 07/12/2006
 */
package br.com.auster.vivo.billcheckout.cache;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;

import br.com.auster.common.sql.SQLConnectionManager;
import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.om.reference.facade.ConfigurationException;
import br.com.auster.vivo.billcheckout.cache.vo.DataBarnCycleVO;
import br.com.auster.vivo.billcheckout.cache.vo.DataBarnSubscriptionVO;

public class DataBarnSubscriptionServices {
	private static Logger log = Logger.getLogger(DataBarnSubscriptionServices.class);

	private String stmt1Name;
	private String stmt2Name;
	private String stmt3Name;
	private String poolName;
	//TODO implementar cache

	public void configure(Element config) throws ConfigurationException {
		Element dbElement = DOMUtils.getElement(config, "database", true);
		poolName = DOMUtils.getAttribute(dbElement, "pool-name", true);
		if (poolName == null || poolName.trim().length() == 0) {
			throw new ConfigurationException("pool-name was not informed.");
		}
		stmt1Name = DOMUtils.getAttribute(dbElement, "sql1-name", true);
		if (stmt1Name == null || stmt1Name.trim().length() == 0) {
			throw new ConfigurationException("sql1-name was not informed.");
		}			
		stmt2Name = DOMUtils.getAttribute(dbElement, "sql2-name", true);
		if (stmt2Name == null || stmt2Name.trim().length() == 0) {
			throw new ConfigurationException("sql2-name was not informed.");
		}			
		stmt3Name = DOMUtils.getAttribute(dbElement, "sql3-name", true);
		if (stmt3Name == null || stmt3Name.trim().length() == 0) {
			throw new ConfigurationException("sql3-name was not informed.");
		}			
	}

	public List<DataBarnSubscriptionVO> getAccountSubscriptions(String accountNumber, String endDate, String startDate) throws SQLException, NamingException {
		List<DataBarnSubscriptionVO> results = new ArrayList<DataBarnSubscriptionVO>();
		if (log.isTraceEnabled()) {
			Runtime rt = Runtime.getRuntime();
			log.trace("ABM." + this.getClass().getSimpleName() + ".getAccountSubscriptions.BFR;Free:" + rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:" + rt.maxMemory());
		}	
		long st = System.nanoTime();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		StatsMapping stats = ProcessingStats.starting(getClass(), stmt1Name);
		try {
			log.debug(">>>PoolName:" + poolName + ".StatmentName:" + stmt1Name);
			SQLConnectionManager man = SQLConnectionManager.getInstance(poolName);
			if (man == null) {
				log.error("SQLConnection Manager is null. Are sure you configured pool " + poolName + "?");
				throw (new ConfigurationException("Pool not configured: " + poolName));
			}
			conn = man.getConnection();
			log.debug(">>>Got connection.");
			Object[] parameters = { accountNumber, endDate, startDate, endDate, startDate };
			ps = man.getStatement(stmt1Name).prepareStatement(conn, parameters);
			rs = ps.executeQuery();
			while (rs.next()) {
				DataBarnSubscriptionVO vo = new DataBarnSubscriptionVO();
				vo.setQueryNumber(1);
				vo.setAccountNumber(accountNumber);
				vo.setSubscriptionId(rs.getString("sbscrp_id"));
				vo.setEffectiveDate(rs.getString("eff_dt"));		
				vo.setExpirationDate(rs.getString("expr_dt"));
				results.add(vo);
			}
		} 
		catch (NamingException e) {
			log.error("Naming lookup error acessing database in " + this.getClass().getSimpleName() + " for current account.", e);    
			throw (e);
		} 
		catch (SQLException e) {
			log.error("SQL error acessing database in " + this.getClass().getSimpleName() +  " for current account.", e);
			throw (e);
		} 
		finally {
			stats.finished();
			try {
				if (rs != null) { rs.close(); }
				if (ps != null) { ps.close(); }
				if (conn != null && !conn.isClosed()) { conn.close(); }
				long et = System.nanoTime();
				log.debug("Acessing Databarn Time in milliseconds:" + ((et - st) / 1000 / 1000) +
						" Result Set size of:" + ((results == null ) ? 0 :  results.size()) + " for getting subscriptions by account" );				
			} 
			catch (SQLException e) {
				e.printStackTrace();
				throw (e);
			}    	
		}
		if (log.isTraceEnabled()) {
			Runtime rt = Runtime.getRuntime();
			log.trace("ABM." + this.getClass().getSimpleName() + ".getAccountSubscriptions.AFT;Free:" + rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:" + rt.maxMemory());
		}	
		return results;
	}

	public List<DataBarnSubscriptionVO> getSubscriptionsById(String subscriptionId, String endDate, String startDate) throws NamingException, SQLException {
		List<DataBarnSubscriptionVO> results = new ArrayList<DataBarnSubscriptionVO>();
		if (log.isTraceEnabled()) {
			Runtime rt = Runtime.getRuntime();
			log.trace("ABM." + this.getClass().getSimpleName() + ".getSubscriptionsById.BFR;Free:" + rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:" + rt.maxMemory());
		}	
		long st = System.nanoTime();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		StatsMapping stats = ProcessingStats.starting(getClass(), stmt2Name);
		try {
			log.debug(">>>PoolName:" + poolName + ".StatmentName:" + stmt2Name);
			SQLConnectionManager man = SQLConnectionManager.getInstance(poolName);
			if (man == null) {
				log.error("SQLConnection Manager is null. Are sure you configured pool " + poolName + "?");
				throw (new ConfigurationException("Pool not configured: " + poolName));
			}
			conn = man.getConnection();
			log.debug(">>>Got connection.");
			Object[] parameters = { subscriptionId, endDate, startDate, endDate };
			ps = man.getStatement(stmt2Name).prepareStatement(conn, parameters);
			rs = ps.executeQuery();
			while (rs.next()) {
				DataBarnSubscriptionVO vo = new DataBarnSubscriptionVO();
				vo.setQueryNumber(2);
				vo.setAccountNumber(rs.getString("acct_nbr"));
				vo.setSubscriptionId(subscriptionId);
				vo.setEffectiveDate(rs.getString("sbscrp_asgm_eff_dt"));		
				vo.setExpirationDate(rs.getString("sbscrp_asgm_expr_dt"));
				results.add(vo);
			}
		} 
		catch (NamingException e) {
			log.error("Naming lookup error acessing database in " + this.getClass().getSimpleName() + " for current account.", e);    
			throw (e);
		} 
		catch (SQLException e) {
			log.error("SQL error acessing database in " + this.getClass().getSimpleName() +  " for current account.", e);
			throw (e);
		} 
		finally {
			stats.finished();
			try {
				if (rs != null) { rs.close(); }
				if (ps != null) { ps.close(); }
				if (conn != null && !conn.isClosed()) { conn.close(); }
				long et = System.nanoTime();
				log.debug("Acessing Databarn Time in milliseconds:" + ((et - st) / 1000 / 1000) +
						" Result Set size of:" + ((results == null ) ? 0 :  results.size()) + " for getting subscriptions by id" );				
			} 
			catch (SQLException e) {
				e.printStackTrace();
				throw (e);
			}    	
		}
		if (log.isTraceEnabled()) {
			Runtime rt = Runtime.getRuntime();
			log.trace("ABM." + this.getClass().getSimpleName() + ".getSubscriptionsById.AFT;Free:" + rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:" + rt.maxMemory());
		}	
		return results;
	}
	
	public List<DataBarnCycleVO> getAccountCycles(String accountNumber) throws SQLException, NamingException {
		List<DataBarnCycleVO> results = new ArrayList<DataBarnCycleVO>();
		if (log.isTraceEnabled()) {
			Runtime rt = Runtime.getRuntime();
			log.trace("ABM." + this.getClass().getSimpleName() + ".getAccountCycles.BFR;Free:" + rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:" + rt.maxMemory());
		}	
		long st = System.nanoTime();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		StatsMapping stats = ProcessingStats.starting(getClass(), stmt3Name);
		try {
			log.debug(">>>PoolName:" + poolName + ".StatmentName:" + stmt3Name);
			SQLConnectionManager man = SQLConnectionManager.getInstance(poolName);
			if (man == null) {
				log.error("SQLConnection Manager is null. Are sure you configured pool " + poolName + "?");
				throw (new ConfigurationException("Pool not configured: " + poolName));
			}
			conn = man.getConnection();
			log.debug(">>>Got connection.");
			Object[] parameters = { accountNumber };
			ps = man.getStatement(stmt3Name).prepareStatement(conn, parameters);
			rs = ps.executeQuery();
			while (rs.next()) {
				DataBarnCycleVO vo = new DataBarnCycleVO();
				vo.setAccountNumber(accountNumber);
				vo.setCycleCode(rs.getString("cycle_cd"));
				vo.setEffectiveDate(rs.getString("acct_cycle_eff_dt"));		
				results.add(vo);
			}
		} 
		catch (NamingException e) {
			log.error("Naming lookup error acessing database in " + this.getClass().getSimpleName() + " for current account.", e);   
			throw (e);
		} 
		catch (SQLException e) {
			log.error("SQL error acessing database in " + this.getClass().getSimpleName() + " for current account.", e);
			throw (e);
		} 
		finally {
			stats.finished();
			try {
				if (rs != null) { rs.close(); }
				if (ps != null) { ps.close(); }
				if (conn != null && !conn.isClosed()) { conn.close(); }
				long et = System.nanoTime();
				log.debug("Acessing Databarn Time in milliseconds:" + ((et - st) / 1000 / 1000) +
						" Result Set size of:" + ((results == null ) ? 0 :  results.size()) + " for getting cycles by account" );				
			} 
			catch (SQLException e) {
				e.printStackTrace();
				throw (e);
			}    	
		}
		if (log.isTraceEnabled()) {
			Runtime rt = Runtime.getRuntime();
			log.trace("ABM." + this.getClass().getSimpleName() + ".getAccountCycles.AFT;Free:" + rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:" + rt.maxMemory());
		}	
		return results;
	}
}