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
 * Created on 28/02/2007
 */
package br.com.auster.vivo.billcheckout.cache;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
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
import br.com.auster.vivo.billcheckout.cache.vo.PromotionEnrollmentsVO;
import br.com.auster.vivo.billcheckout.cache.vo.PromotionRangesVO;
import br.com.auster.vivo.billcheckout.cache.vo.PromotionTypesVO;

/**
 * @author mtengelm
 * 
 */
public class UsagePromotionsServices implements DataBarnUsagePromotions {
	private static Logger	                           log	          = Logger.getLogger(DataBarnUsagePromotions.class);

	protected static final String	                   DB_ELEMENT	    = "database";
	protected static final String	                   POOL_NAME_ATTR	= "pool-name";
	protected static final String	                   STMTS_ELMT	    = "statement-names";
	protected static final String	                   STMT_ELMT	    = "stament-name";
	protected static final String	                   NAME_ATTR	    = "name";

	private String	                                 poolName;
	private Map<String, SQLStatement>	               stmts	        = new HashMap<String, SQLStatement>();

	private SQLConnectionManager	                   sqlMan;

//	private List<PromotionTypesVO> promoTypes = null;
//	private Map<String, List<PromotionEnrollmentsVO>> enrollments = null;
	private Map<String, List<PromotionRangesVO>> ranges = null;
	
	public void configure(Element config) {
		try {
			Element dbElement = DOMUtils.getElement(config, DB_ELEMENT, true);

			poolName = DOMUtils.getAttribute(dbElement, POOL_NAME_ATTR, true);
			if ((poolName == null) || (poolName.trim().length() == 0)) {
				throw new ConfigurationException("pool-name was not informed.");
			}

			sqlMan = SQLConnectionManager.getInstance(poolName);

			Element stmtsElement = DOMUtils.getElement(dbElement, STMTS_ELMT, true);
			NodeList nameList = DOMUtils.getElements(stmtsElement, STMT_ELMT);
			int qt = nameList.getLength();
			for (int i = 0; i < qt; i++) {
				Element nameElement = (Element) nameList.item(i);
				String sqlName = DOMUtils.getAttribute(nameElement, NAME_ATTR, true);
				SQLStatement statement = sqlMan.getStatement(sqlName);
				stmts.put(sqlName, statement);
			}
			log.info("Number of SQL Statements successfully loaded is:" + this.stmts.size());
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * (non-Javadoc)
	 * 
	 * @see br.com.auster.vivo.billcheckout.util.DataBarnUsagePromotions#getPromotionRangesById(java.lang.String)
	 */
	public Map<String, List<PromotionRangesVO>> getPromotionRangesById(String queryName, Object[] parameters) {
		SQLStatement query = this.stmts.get(queryName);
		if (query == null) {
			log.error("Asking for statement named:" + queryName + ", but it does no exists.");
			return Collections.emptyMap();
		}
		
		this.ranges = new HashMap<String, List<PromotionRangesVO>>();
				
		long st = System.nanoTime();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		StatsMapping stats = ProcessingStats.starting(getClass(), queryName);
		try {
			conn = sqlMan.getConnection();
			ps = query.prepareStatement(conn, parameters);
			rs = ps.executeQuery();
			if (log.isDebugEnabled()) {
				log.debug("Running query:" + query.getStatementText());
			}
			while (rs.next()) {
				PromotionRangesVO vo = createPromotionsRangeVO(rs);
				List<PromotionRangesVO> lista = this.ranges.get(parameters[0]);
				if (lista == null) {
					lista = new ArrayList<PromotionRangesVO>();
				}
				lista.add(vo);
				this.ranges.put((String)parameters[0], lista);
			}
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			stats.finished();
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
	      long et = System.nanoTime();
	      log.debug("Acessing Databarn Time in milliseconds:" + ((et - st) / 1000 / 1000) +
	      		" for getting promotion types");
			} catch (SQLException e) {
				log.error("Problems releasing resources for query.");
				e.printStackTrace();
			}
		}			
		return this.ranges;
	}

  private PromotionRangesVO createPromotionsRangeVO(ResultSet rs) throws SQLException {
  	PromotionRangesVO vo = new PromotionRangesVO();
  	vo.setApplicationIndicator(rs.getString("APPL_IND"));
  	vo.setAutoEnrollFlag(rs.getString("AUTO_ENROLL_FLAG"));
  	vo.setBeginCycle(rs.getInt("BEGIN_CYCLE_NBR"));
  	vo.setEndCycle(rs.getInt("END_CYCLE_NBR"));
  	vo.setMarketingProgramId(rs.getString("MKTG_PGM_ID"));
  	vo.setMarketingProgrmaDescription(rs.getString("MKTG_PGM_DESC"));
  	vo.setPromotionLevel(rs.getString("PROMO_LEVEL_IND"));
  	vo.setRewardAmount(rs.getDouble("REWARD_AMT"));
  	vo.setRewardType(rs.getString("REWARD_TYPE_CD"));
  	vo.setServiceArea(rs.getString("COMM_SVC_AREA_ID"));
	  return vo;
  }	
  
	/*
	 * (non-Javadoc)
	 * 
	 * @see br.com.auster.vivo.billcheckout.util.DataBarnUsagePromotions#getPromotionTypes()
	 */
	public List<PromotionTypesVO> getPromotionTypes(String queryName) {
		SQLStatement query = this.stmts.get(queryName);
		if (query == null) {
			log.error("Asking for statement named:" + queryName + ", but it does no exists.");
			return Collections.emptyList();
		}

//		if (promoTypes != null) {
//			return promoTypes;
//		}
		
		
		List<PromotionTypesVO> results = new ArrayList<PromotionTypesVO>();
		
		long st = System.nanoTime();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		StatsMapping stats = ProcessingStats.starting(getClass(), queryName);
		try {
			conn = sqlMan.getConnection();
			ps = query.prepareStatement(conn, null);
			rs = ps.executeQuery();
			if (log.isDebugEnabled()) {
				log.debug("Running query:" + query.getStatementText());
			}
			while (rs.next()) {
				results.add(createPromotionTypesVO(rs));
			}
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			stats.finished();
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
	      long et = System.nanoTime();
	      log.debug("Acessing Databarn Time in milliseconds:" + ((et - st) / 1000 / 1000) +
	      		" for getting promotion types");
			} catch (SQLException e) {
				log.error("Problems releasing resources for query.");
				e.printStackTrace();
			}
		}		
		return results;
	}

	/**
   * @return
	 * @throws SQLException 
   */
  private PromotionTypesVO createPromotionTypesVO(ResultSet rs) throws SQLException {
  	PromotionTypesVO vo = new PromotionTypesVO();
  	vo.setTypeCode(rs.getString("LIST_CD"));
  	vo.setTypeDescription(rs.getString("LIST_DESC"));
	  return vo;
  }	
	/*
	 * (non-Javadoc)
	 * 
	 * @see br.com.auster.vivo.billcheckout.util.DataBarnUsagePromotions#getSubscriptionEnrollmentByAccount(java.lang.String)
	 */
	public Map<String, List<PromotionEnrollmentsVO>> getSubscriptionEnrollmentByAccount(String queryName, Object[] parameters) {
		SQLStatement query = this.stmts.get(queryName);
		if (query == null) {
			log.error("Asking for statement named:" + queryName + ", but it does no exists.");
			return Collections.emptyMap();
		}		
		
//		if (this.enrollments != null) {
//			return this.enrollments;
//		}
		
		Map<String, List<PromotionEnrollmentsVO>> results = new HashMap<String, List<PromotionEnrollmentsVO>>();
				
		long st = System.nanoTime();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		StatsMapping stats = ProcessingStats.starting(getClass(), queryName);
		try {
			conn = sqlMan.getConnection();
			ps = query.prepareStatement(conn, parameters);
			rs = ps.executeQuery();
			if (log.isDebugEnabled()) {
				log.debug("Running query:" + query.getStatementText());
			}
			while (rs.next()) {
				PromotionEnrollmentsVO vo = createPromotionEnrollmentVO(rs);
				List<PromotionEnrollmentsVO> lista = results.get(vo.getSubscriptionId());
				if (lista == null) {
					lista = new ArrayList<PromotionEnrollmentsVO>();
				}
				lista.add(vo);
				results.put(vo.getSubscriptionId(), lista);
			}
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			stats.finished();
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
	      long et = System.nanoTime();
	      log.debug("Acessing Databarn Time in milliseconds:" + ((et - st) / 1000 / 1000) +
	      		" for getting promotion types");
			} catch (SQLException e) {
				log.error("Problems releasing resources for query.");
				e.printStackTrace();
			}
		}			
		return results;
	}

	/**
   * @param rs
   * @return
	 * @throws SQLException 
   */
  private PromotionEnrollmentsVO createPromotionEnrollmentVO(ResultSet rs) throws SQLException {
  	PromotionEnrollmentsVO vo = new PromotionEnrollmentsVO();
  	vo.setAccountNumber(rs.getString("ACCT_NBR"));
  	vo.setCaptionText(rs.getString("CAPTN_TEXT"));
  	vo.setMarketingProgramId(rs.getString("MKTG_PGM_ID"));  
  	vo.setSubscriptionId(rs.getString("SBSCRP_ID"));  	
	  return vo;
  }

}
