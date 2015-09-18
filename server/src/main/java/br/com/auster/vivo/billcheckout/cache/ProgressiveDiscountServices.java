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
 * Created on 05/02/2007
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
import br.com.auster.vivo.billcheckout.cache.vo.ProgressiveDiscountVO;

/**
 * @author mtengelm
 * 
 */
public class ProgressiveDiscountServices implements DataBarnProgressiveDiscounts {
	private static Logger	        log	                    = Logger
	                                                          .getLogger(ProgressiveDiscountServices.class);

	protected static final String	DB_ELEMENT	            = "database";
	protected static final String	POOL_NAME_ATTR	        = "pool-name";
	protected static final String	STMTS_ELMT	            = "statement-names";
	protected static final String	STMT_ELMT	              = "stament-name";
	protected static final String	NAME_ATTR	              = "name";


	private String	              poolName;
	private Map<String,SQLStatement>	                  stmts	                  = new HashMap<String,SQLStatement>();

//	private Map<String,List<ProgressiveDiscountVO>> tiers = new HashMap<String,List<ProgressiveDiscountVO>>();
	
	private SQLConnectionManager	sqlMan;

	private int	                  marketingProgramCount	  = Integer.MIN_VALUE;

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
	 * @see br.com.auster.vivo.billcheckout.util.DataBarnProgressiveDiscounts#getMarketingProgramCount(java.lang.String,
	 *      java.lang.String, java.lang.String)
	 */
	public List<ProgressiveDiscountVO> getMarketingProgramList(String queryName, Object[] parameters) {
		SQLStatement query = this.stmts.get(queryName);
		if (query == null) {
			log.error("Asking for statement named:" + queryName + ", but it does no exists.");
			return Collections.emptyList();
		}

//		List<ProgressiveDiscountVO> tiers = new ArrayList<ProgressiveDiscountVO>();
//		if (currentTiers != null) {
//			log.debug("Returning tiers from cache for service name:" + parameters[0]);
//			return currentTiers;
//		}
		//log.debug("Current Cache:" + this.tiers);
		
		List<ProgressiveDiscountVO> results = new ArrayList<ProgressiveDiscountVO>();
		
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
				log.debug("Running query:" + query.getStatementText() + ".P1:[" + parameters[0] + "]" );
			}
			while (rs.next()) {
				results.add(createVO(rs));
			}
			if (results.size() > 0 ) {
				log.debug("Adding to the cache.ServiceName:" + parameters[0]);
//				this.tiers.put((String)parameters[0], results);
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
	      		" for getting progressive discounts in number of:" + marketingProgramCount );
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
  private ProgressiveDiscountVO createVO(ResultSet rs) throws SQLException {
  	ProgressiveDiscountVO vo = new ProgressiveDiscountVO();
  	vo.setMarketingProgramId(rs.getString("MKTG_PGM_ID"));
  	vo.setServiceName(rs.getString("SVC_NAME"));
  	vo.setCaptionText(rs.getString("CAPTN_TEXT"));
  	vo.setTierMinAmount(rs.getDouble("TIER_MIN_AMT"));
  	vo.setTierMaxAmount(rs.getDouble("TIER_MAX_AMT"));
  	vo.setRewardAmount(rs.getDouble("REWARD_AMT"));
	  return vo;
  }

}
