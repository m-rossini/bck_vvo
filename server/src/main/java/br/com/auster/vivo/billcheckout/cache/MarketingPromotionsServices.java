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
 * Created on 02/02/2007
 */
package br.com.auster.vivo.billcheckout.cache;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.naming.NamingException;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import br.com.auster.common.sql.SQLConnectionManager;
import br.com.auster.common.sql.SQLStatement;
import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.om.reference.facade.ConfigurationException;
import br.com.auster.vivo.billcheckout.cache.vo.MarketingPromotionsCriteriaVO;
import br.com.auster.vivo.billcheckout.cache.vo.MarketingPromotionsVO;
import br.com.auster.vivo.billcheckout.cache.vo.RewardVO;


/**
 * @author gportuga
 * TODO implementar cache
 */
public class MarketingPromotionsServices  {
	private static Logger log = Logger.getLogger(MarketingPromotionsServices.class);

	private Map stmtsMap = new HashMap();
	private SQLConnectionManager sqlMan;
	

	public MarketingPromotionsServices() {

	}

	public void configure(Element config) {
		try {
			Element dbElement = DOMUtils.getElement(config, "database", true);

			String poolName = DOMUtils.getAttribute(dbElement, "pool-name", true);
			if ((poolName == null) || (poolName.trim().length() == 0)) {
				throw new ConfigurationException("pool-name was not informed.");
			}

			sqlMan = SQLConnectionManager.getInstance(poolName);

			Element stmtsElement = DOMUtils.getElement(dbElement, "statement-names", true);
			NodeList nameList = DOMUtils.getElements(stmtsElement, "stament-name");
			int qt = nameList.getLength();
			for (int i = 0; i < qt; i++) {
				Element nameElement = (Element) nameList.item(i);
				String sqlName = DOMUtils.getAttribute(nameElement, "name", true);
				SQLStatement statement = sqlMan.getStatement(sqlName);
				stmtsMap.put(sqlName, statement);
			}
			log.info("Number of SQL Statements successfully loaded is:"	+ this.stmtsMap.size());
		} catch (NamingException e) {
			log.error(e.getStackTrace());
			e.printStackTrace();
		}
	}
	
	public MarketingPromotionsCriteriaVO getCriteria(String queryName, MarketingPromotionsVO mktPromVO, String beginDate, String endDate) {
		SQLStatement query = (SQLStatement) this.stmtsMap.get(queryName);
		if (query == null) {
			log.error("Asking for statement named:" + queryName	+ ", but it does no exists.");
			return null;
		}
		long st = System.nanoTime();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		MarketingPromotionsCriteriaVO criteriaVO = new MarketingPromotionsCriteriaVO();
		StatsMapping stats = ProcessingStats.starting(getClass(), queryName);
		try {
			conn = sqlMan.getConnection();
			ps = query.prepareStatement(conn, new Object[] {mktPromVO.getMarketingProgramId(), mktPromVO.getCsaId(), endDate, beginDate, endDate});
			rs = ps.executeQuery();
			if (log.isDebugEnabled()) {
				log.debug("Running query:" + query.getStatementText());
			}
			criteriaVO.setMarketingProgramId(mktPromVO.getMarketingProgramId());
			criteriaVO.setCsaId(mktPromVO.getCsaId());
			criteriaVO.setAndSet(new HashSet<String>());
			criteriaVO.setOrSet(new HashSet<String>());
			
			while (rs.next()) {
				String crtraInd = rs.getString("CRTRA_AND_OR_IND");
				if ((crtraInd != null) && crtraInd.equals("O")) { 
					criteriaVO.getOrSet().add(rs.getString("CAPTN_TEXT"));
				} else if ((crtraInd != null) && crtraInd.equals("A")) { 
					criteriaVO.getAndSet().add(rs.getString("CAPTN_TEXT"));
				}
			}
		} catch (IllegalArgumentException e) {
			log.error(e.getStackTrace());
			e.printStackTrace();
		} catch (SQLException e) {
			log.error(e.getStackTrace());
			e.printStackTrace();
		} finally {
			stats.finished();
			try {
				if (rs != null) { rs.close(); }
				if (ps != null) { ps.close(); }
				if (conn != null) {	conn.close(); }
				long et = System.nanoTime();
				log.debug("Acessing Databarn Time in milliseconds:"
						+ ((et - st) / 1000 / 1000)
						+ " for getting marketing promotions criteria");
			} catch (SQLException e) {
				log.error("Problems releasing resources for query.");
				log.error(e.getStackTrace());
				e.printStackTrace();
			}
		}
		return criteriaVO;
	}


	public List getAccessNumberAutoPromotions(String queryName, Object[] parameters) {
		SQLStatement query = (SQLStatement) this.stmtsMap.get(queryName);
		if (query == null) {
			log.error("Asking for statement named:" + queryName	+ ", but it does no exists.");
			return null;
		}
		long st = System.nanoTime();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List results = new ArrayList();
		StatsMapping stats = ProcessingStats.starting(getClass(), queryName);
		try {
			conn = sqlMan.getConnection();
			Object[] param = {parameters[0], parameters[1], parameters[2], parameters[1], parameters[1], parameters[2], parameters[1] };
			ps = query.prepareStatement(conn, param);
			rs = ps.executeQuery();
			if (log.isDebugEnabled()) {
				log.debug("Running query:" + query.getStatementText());
			}
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			while (rs.next()) {
				MarketingPromotionsVO mktPromVO = new MarketingPromotionsVO();
				mktPromVO.setMarketingProgramId(rs.getString("MKTG_PGM_ID"));
				mktPromVO.setSubId(rs.getString("SBSCRP_ID"));
				mktPromVO.setCapText(rs.getString("CAPTN_TEXT"));
				mktPromVO.setCsaId(rs.getString("COMM_SVC_AREA_ID"));
				mktPromVO.setEnrollDate(formatter.parse(rs.getString("SVC_AGRMNT_EFF_DT")));
				mktPromVO.setRewardsLoaded(false);
				mktPromVO.setSubPromFlag(true);
				results.add(mktPromVO);
			}
		} catch (IllegalArgumentException e) {
			log.error(e.getStackTrace());
			e.printStackTrace();
		} catch (SQLException e) {
			log.error(e.getStackTrace());
			e.printStackTrace();
		} catch (ParseException e) {
			log.error("Error while parsing SVC_AGRMNT_EFF_DT date.");
			log.error(e.getStackTrace());
			e.printStackTrace();
		} finally {
			stats.finished();
			try {
				if (rs != null) { rs.close(); }
				if (ps != null) { ps.close(); }
				if (conn != null) {	conn.close(); }
				long et = System.nanoTime();
				log.debug("Acessing Databarn Time in milliseconds:"
						+ ((et - st) / 1000 / 1000) + " Result Set size of:"
						+ ((results == null) ? 0 : results.size())
						+ " for getting marketing promotions by access number");
			} catch (SQLException e) {
				log.error("Problems releasing resources for query.");
				log.error(e.getStackTrace());
				e.printStackTrace();
			}
		}
		return (results == null) ? Collections.emptyList() : results;
	}
	
	public List getAccessNumberPromotions(String queryName, Object[] parameters) {
		SQLStatement query = (SQLStatement) this.stmtsMap.get(queryName);
		if (query == null) {
			log.error("Asking for statement named:" + queryName	+ ", but it does no exists.");
			return null;
		}
		long st = System.nanoTime();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List results = new ArrayList();
		StatsMapping stats = ProcessingStats.starting(getClass(), queryName);
		try {
			conn = sqlMan.getConnection();
			ps = query.prepareStatement(conn, parameters);
			rs = ps.executeQuery();
			if (log.isDebugEnabled()) {
				log.debug("Running query:" + query.getStatementText());
			}
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			while (rs.next()) {
				MarketingPromotionsVO mktPromVO = new MarketingPromotionsVO();
				mktPromVO.setMarketingProgramId(rs.getString("MKTG_PGM_ID"));
				mktPromVO.setSubId(rs.getString("SBSCRP_ID"));
				mktPromVO.setCapText(rs.getString("CAPTN_TEXT"));
				mktPromVO.setCsaId(rs.getString("COMM_SVC_AREA_ID"));
				mktPromVO.setEnrollDate(formatter.parse(rs.getString("MKTG_PGM_ENROLL_DT")));
				mktPromVO.setRewardsLoaded(false);
				mktPromVO.setSubPromFlag(true);
				results.add(mktPromVO);
			}
		} catch (IllegalArgumentException e) {
			log.error(e.getStackTrace());
			e.printStackTrace();
		} catch (SQLException e) {
			log.error(e.getStackTrace());
			e.printStackTrace();
		} catch (ParseException e) {
			log.error("Error while parsing MKTG_PGM_ENROLL_DT date.");
			log.error(e.getStackTrace());
			e.printStackTrace();
		} finally {
			stats.finished();
			try {
				if (rs != null) { rs.close(); }
				if (ps != null) { ps.close(); }
				if (conn != null) {	conn.close(); }
				long et = System.nanoTime();
				log.debug("Acessing Databarn Time in milliseconds:"
						+ ((et - st) / 1000 / 1000) + " Result Set size of:"
						+ ((results == null) ? 0 : results.size())
						+ " for getting marketing promotions by access number");
			} catch (SQLException e) {
				log.error("Problems releasing resources for query.");
				log.error(e.getStackTrace());
				e.printStackTrace();
			}
		}
		return (results == null) ? Collections.emptyList() : results;
	}
	
	public List getAccountPromotions(String queryName, Object[] parameters) {
		SQLStatement query = (SQLStatement) this.stmtsMap.get(queryName);
		if (query == null) {
			log.error("Asking for statement named:" + queryName	+ ", but it does no exists.");
			return null;
		}
		long st = System.nanoTime();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List results = new ArrayList();
		StatsMapping stats = ProcessingStats.starting(getClass(), queryName);
		try {
			conn = sqlMan.getConnection();
			ps = query.prepareStatement(conn, parameters);
			rs = ps.executeQuery();
			if (log.isDebugEnabled()) {
				log.debug("Running query:" + query.getStatementText());
			}
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			while (rs.next()) {
				MarketingPromotionsVO mktPromVO = new MarketingPromotionsVO();
				mktPromVO.setMarketingProgramId(rs.getString("MKTG_PGM_ID"));
				mktPromVO.setCapText(rs.getString("MKTG_PGM_DESC"));
				mktPromVO.setCsaId(rs.getString("COMM_SVC_AREA_ID"));
				mktPromVO.setEnrollDate(formatter.parse(rs.getString("MKTG_PGM_ENROLL_START_DT")));
				mktPromVO.setRewardsLoaded(false);
				mktPromVO.setSubPromFlag(false);
				results.add(mktPromVO);
			}
		} catch (IllegalArgumentException e) {
			log.error(e.getStackTrace());
			e.printStackTrace();
		} catch (SQLException e) {
			log.error(e.getStackTrace());
			e.printStackTrace();
		} catch (ParseException e) {
			log.error("Error while parsing MKTG_PGM_ENROLL_DT date.");
			log.error(e.getStackTrace());
			e.printStackTrace();
		} finally {
			stats.finished();
			try {
				if (rs != null) { rs.close(); }
				if (ps != null) { ps.close(); }
				if (conn != null) {	conn.close(); }
				long et = System.nanoTime();
				log.debug("Acessing Databarn Time in milliseconds:"
						+ ((et - st) / 1000 / 1000) + " Result Set size of:"
						+ ((results == null) ? 0 : results.size())
						+ " for getting marketing promotions by access number");
			} catch (SQLException e) {
				log.error("Problems releasing resources for query.");
				log.error(e.getStackTrace());
				e.printStackTrace();
			}
		}
		return (results == null) ? Collections.emptyList() : results;
	}
	
	public void getPromotionDetails(String queryName, MarketingPromotionsVO mktPromVO) {
		SQLStatement query = (SQLStatement) this.stmtsMap.get(queryName);
		if (query == null) {
			log.error("Asking for statement named:" + queryName	+ ", but it does no exists.");
			return;
		}
		long st = System.nanoTime();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		StatsMapping stats = ProcessingStats.starting(getClass(), queryName);
		try {
			conn = sqlMan.getConnection();
			Object[] parameters = {mktPromVO.getMarketingProgramId(), mktPromVO.getCsaId()  };
			ps = query.prepareStatement(conn, parameters);
			rs = ps.executeQuery();
			if (log.isDebugEnabled()) {
				log.debug("Running query:" + query.getStatementText());
			}

			if (rs.next()) {
				mktPromVO.setBeginCycleNbr(rs.getInt("BEGIN_CYCLE_NBR"));
				mktPromVO.setEndCycleNbr(rs.getInt("END_CYCLE_NBR"));
				mktPromVO.setRewardAmt(rs.getDouble("REWARD_AMT"));
				mktPromVO.setAutoIndicator(rs.getString("auto_enroll_flag"));
				mktPromVO.setApplInd(rs.getString("appl_ind"));
				mktPromVO.setPromoLvlInd(rs.getString("promo_level_ind"));
				mktPromVO.setRewardType(rs.getString("reward_type_cd"));
			}
		} catch (SQLException e) {
			log.error(e.getStackTrace());
			e.printStackTrace();
		} finally {
			stats.finished();
			try {
				if (rs != null) { rs.close(); }
				if (ps != null) { ps.close(); }
				if (conn != null) {	conn.close(); }
				long et = System.nanoTime();
				log.debug("Acessing Databarn Time in milliseconds:" + ((et - st) / 1000 / 1000) + " Result Set size of: 1"
						+ " for getting marketing promotions by access number");
			} catch (SQLException e) {
				log.error("Problems releasing resources for query.");
				log.error(e.getStackTrace());
				e.printStackTrace();
			}
		}
	}

	public List getUsedRewardsBySubcription(String queryName, MarketingPromotionsVO mktPromVO) {
		SQLStatement query = (SQLStatement) this.stmtsMap.get(queryName);
		if (query == null) {
			log.error("Asking for statement named:" + queryName
					+ ", but it does no exists.");
			return null;
		}
		long st = System.nanoTime();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List results = null;
		StatsMapping stats = ProcessingStats.starting(getClass(), queryName);
		try {
			conn = sqlMan.getConnection();
		    SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			Object[] parameters = { mktPromVO.getMarketingProgramId(), mktPromVO.getSubId(), formatter.format(mktPromVO.getEnrollDate()) };
			ps = query.prepareStatement(conn, parameters);
			rs = ps.executeQuery();
			if (log.isDebugEnabled()) {
				log.debug("Running query:" + query.getStatementText());
			}
			results = new ArrayList();
			while (rs.next()) {
				RewardVO reward = new RewardVO();
				reward.setAcctNbr(rs.getString("ACCT_NBR"));
				reward.setCycleCd(rs.getString("CYCLE_CD"));
				reward.setCycleEndDate(formatter.parse(rs.getString("CYCLE_END_DT")));
				reward.setRewardAmount(rs.getDouble("REWARD_DOLLAR_AMT"));
				results.add(reward);
			}
			mktPromVO.setRewardsLoaded(true);
			mktPromVO.setRewardsList(results);
		} catch (SQLException e) {
			log.error(e.getStackTrace());
			e.printStackTrace();
		} catch (ParseException e) {
			log.error("Error while parsing CYCLE_END_DT date.");
			log.error(e.getStackTrace());
			e.printStackTrace();
		} finally {
			stats.finished();
			try {
				if (rs != null) { rs.close(); }
				if (ps != null) { ps.close(); }
				if (conn != null) {	conn.close(); }
				long et = System.nanoTime();
				log.debug("Acessing Databarn Time in milliseconds:" + ((et - st) / 1000 / 1000) + " Result Set size of: 1"
						+ " for getting marketing promotions by access number");
			} catch (SQLException e) {
				log.error("Problems releasing resources for query.");
				log.error(e.getStackTrace());
				e.printStackTrace();
			}
		}
		return (results == null) ? Collections.emptyList() : results;
	}
	
	public List getUsedRewardsByAccount(String queryName, MarketingPromotionsVO mktPromVO, String conta) {
		SQLStatement query = (SQLStatement) this.stmtsMap.get(queryName);
		if (query == null) {
			log.error("Asking for statement named:" + queryName
					+ ", but it does no exists.");
			return null;
		}
		long st = System.nanoTime();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List results = null;
		StatsMapping stats = ProcessingStats.starting(getClass(), queryName);
		try {
			conn = sqlMan.getConnection();
		    SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			Object[] parameters = { mktPromVO.getMarketingProgramId(), conta, formatter.format(mktPromVO.getEnrollDate()) };
			ps = query.prepareStatement(conn, parameters);
			rs = ps.executeQuery();
			if (log.isDebugEnabled()) {
				log.debug("Running query:" + query.getStatementText());
			}
			results = new ArrayList();
			while (rs.next()) {
				RewardVO reward = new RewardVO();
				reward.setAcctNbr(rs.getString("ACCT_NBR"));
				reward.setCycleCd(rs.getString("CYCLE_CD"));
				reward.setCycleEndDate(formatter.parse(rs.getString("CYCLE_END_DT")));
				reward.setRewardAmount(rs.getDouble("REWARD_DOLLAR_AMT"));
				results.add(reward);
			}
			mktPromVO.setRewardsLoaded(true);
			mktPromVO.setRewardsList(results);
		} catch (SQLException e) {
			log.error(e.getStackTrace());
			e.printStackTrace();
		} catch (ParseException e) {
			log.error("Error while parsing CYCLE_END_DT date.");
			e.printStackTrace();
		} finally {
			try {
				stats.finished();
				if (rs != null) { rs.close(); }
				if (ps != null) { ps.close(); }
				if (conn != null) {	conn.close(); }
				long et = System.nanoTime();
				log.debug("Acessing Databarn Time in milliseconds:" + ((et - st) / 1000 / 1000) + " Result Set size of: 1"
						+ " for getting marketing promotions by access number");
			} catch (SQLException e) {
				log.error("Problems releasing resources for query.");
				log.error(e.getStackTrace());
				e.printStackTrace();
			}
		}
		return (results == null) ? Collections.emptyList() : results;
	}

}
