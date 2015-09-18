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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.NamingException;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.w3c.dom.Element;

import br.com.auster.common.sql.SQLConnectionManager;
import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.om.reference.facade.ConfigurationException;
import br.com.auster.vivo.billcheckout.cache.vo.DataBarnRerateFlagVO;

public class DataBarnRerateFlagServices {
	private static Logger log = Logger.getLogger(DataBarnRerateFlagServices.class);

	private String stmtName;
	private String poolName;
	private Map<String, List<DataBarnRerateFlagVO>> cache;
	
	public DataBarnRerateFlagServices() {
		cache = new HashMap<String, List<DataBarnRerateFlagVO>>();
	}
	
	private void putIntoCache(DataBarnRerateFlagVO vo) {
		String seqNbr = vo.getSvcPriceSeqNbr();
		List<DataBarnRerateFlagVO> list = cache.get(seqNbr);
		if (list == null) {
			list = new ArrayList<DataBarnRerateFlagVO>();
			cache.put(seqNbr, list);
		}
		list.add(vo);
	}
	
	private DataBarnRerateFlagVO getFromCache(String seqNbr, String date) {
		if (StringUtils.isEmpty(date)) { return null; }
		List<DataBarnRerateFlagVO> list = cache.get(seqNbr);
		if (list == null) { return null; }
		for (DataBarnRerateFlagVO vo : list) {
			if (date.compareTo(vo.getEffectiveDate()) >= 0 &&
					date.compareTo(vo.getExpirationDate()) <= 0) {
				return vo;
			}
		}
		return null;
	}

	public void configure(Element config) throws ConfigurationException {
		Element dbElement = DOMUtils.getElement(config, "database", true);
		poolName = DOMUtils.getAttribute(dbElement, "pool-name", true);
		if (poolName == null || poolName.trim().length() == 0) {
			throw new ConfigurationException("pool-name was not informed.");
		}
		stmtName = DOMUtils.getAttribute(dbElement, "sql-name", true);
		if (stmtName == null || stmtName.trim().length() == 0) {
			throw new ConfigurationException("sql-name was not informed.");
		}			
	}

	public DataBarnRerateFlagVO getRerateFlagFor(String seqNbr, String date) {
		DataBarnRerateFlagVO vo = null;
		if (log.isTraceEnabled()) {
			Runtime rt = Runtime.getRuntime();
			log.trace("ABM." + this.getClass().getSimpleName() + ".getRerateFlagFor.BFR;Free:" + rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:" + rt.maxMemory());
		}
		vo = getFromCache(seqNbr, date);
		if (vo != null) {
			// found!
			return vo; 
		}
		
		long st = System.nanoTime();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		StatsMapping stats = ProcessingStats.starting("DataBarnRerateFlagServices");
		try {
			log.debug(">>>PoolName:" + poolName + ".StatmentName:" + stmtName);
			SQLConnectionManager man = SQLConnectionManager.getInstance(poolName);
			if (man == null) {
				log.error("SQLConnection Manager is null. Are sure you configured pool " + poolName + "?");
				// Next line will throw NullPointerException. We should throw our exception here.
				// (Another programming error replicated by copy-paste.)
			}
			conn = man.getConnection();
			log.debug(">>>Got connection.");
			Object[] parameters = { seqNbr, date };
			ps = man.getStatement(stmtName).prepareStatement(conn, parameters);
			rs = ps.executeQuery();
			if (rs.next()) {
				vo = new DataBarnRerateFlagVO();
				vo.setSvcPriceSeqNbr(rs.getString("svc_price_seq_nbr"));
				vo.setRerateFlag(rs.getString("rerate_incol_flag"));
				vo.setEffectiveDate(rs.getString("svc_price_eff_dt"));		
				vo.setExpirationDate(rs.getString("svc_price_expr_dt"));
				putIntoCache(vo);
			}
		} 
		catch (NamingException e) {
			log.error("Naming lookup error acessing database in " + this.getClass().getSimpleName() + " for current account.", e);    	
		} 
		catch (SQLException e) {
			log.error("SQL error acessing database in " + this.getClass().getSimpleName() +  " for current account.", e);
			// What's the application behaviour after this? God knows.
		} 
		finally {
			stats.finished();
			try {
				if (rs != null) { rs.close(); }
				if (ps != null) { ps.close(); }
				if (conn != null && !conn.isClosed()) { conn.close(); }
				long et = System.nanoTime();
				log.debug("Acessing Databarn Time in milliseconds:" + ((et - st) / 1000 / 1000) +
					" for getting rerate flag." );		      
			} 
			catch (SQLException e) {
				e.printStackTrace();
			}    	
		}
		if (log.isTraceEnabled()) {
			Runtime rt = Runtime.getRuntime();
			log.trace("ABM." + this.getClass().getSimpleName() + ".getRerateFlagFor.AFT;Free:" + rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:" + rt.maxMemory());
		}	
		return vo;
	}
}