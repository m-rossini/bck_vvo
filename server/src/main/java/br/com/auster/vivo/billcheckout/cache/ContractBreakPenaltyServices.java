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

/**
 * @author mtengelm
 *
 */

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
import br.com.auster.vivo.billcheckout.cache.vo.ContractBreakPenaltyVO;

/**
 * @author mruao
 * @version $Id$
 *
 */
public class ContractBreakPenaltyServices implements DataBarnContractBreakServices {

	private static Logger log = Logger.getLogger(ContractBreakPenaltyServices.class);
	protected static final String SQL_NAME_ATTR = "sql-name";
	protected static final String DB_ELEMENT = "database";
	protected static final String POOL_NAME_ATTR = "pool-name";		

	private String stmtName;
	private String poolName;	

  public void configure(Element config) throws ConfigurationException {
  	Element dbElement = DOMUtils.getElement(config, DB_ELEMENT, true);
  	
		poolName = DOMUtils.getAttribute(dbElement, POOL_NAME_ATTR, true);
		if ((poolName == null) || (poolName.trim().length() == 0)) {
			throw new ConfigurationException("pool-name was not informed.");
		}
		stmtName = DOMUtils.getAttribute(dbElement, SQL_NAME_ATTR, true);
		if ((stmtName == null) || (stmtName.trim().length() == 0)) {
			throw new ConfigurationException("sql-name was not informed.");
		}			
  }

	protected ContractBreakPenaltyVO createVO(ResultSet rs) throws SQLException {
		log.trace(">>>ResultSer for createVO:" + rs) ;		
		if (rs == null) { return null; }
		ContractBreakPenaltyVO vo = new ContractBreakPenaltyVO();
		vo.setAccessNumber(rs.getString("accessNo"));
		vo.setAccountNumber(rs.getString("accountNo"));
		vo.setBasePriceAmt(rs.getDouble("baseAmt"));
		vo.setEffectiveDate(rs.getDate("effectiveDate"));
		vo.setExpirationDate(rs.getDate("expirationDate"));
		vo.setNegotPriceAmt(rs.getDouble("negotAmt"));
		vo.setServiceName(rs.getString("serviceName"));
		vo.setScenarioId(null);
		vo.setSubscriptionId(rs.getString("subId"));
		vo.setChargeType(rs.getString("chargeTypeId"));
		vo.setNegotPercent(rs.getDouble("negotPct"));
		vo.setPeriodQuantity(rs.getInt("PERIOD"));
		vo.setServiceAreaId(rs.getString("SP_AREA_ID"));
		vo.setTaxCategoryId(rs.getString("TAX_CATEGORY"));
		vo.setSequenceNumber(rs.getString("SEQ_NO"));
		vo.setCaptionText(rs.getString("captionText"));
		vo.setAgreementExpirationDate(rs.getDate("DT_EXP_AGR"));
		vo.setAgreementEffectiveDate(rs.getDate("DT_EFF_AGR"));
		vo.setDataOriging(rs.getString("ORIGEM"));
		vo.setNegotType(rs.getString("NEGOT_TYPE"));
		vo.setTaxIncluded(rs.getString("TAX_INCLUDED"));
		log.trace(">>>Returning VO:" + vo);		
		return vo;
	}

  public List<ContractBreakPenaltyVO> getPenaltyRecordsFor(String queryName, Object[] parameters) {
		if (log.isTraceEnabled()) {
			Runtime rt = Runtime.getRuntime();
			log.trace("ABM.ContractBreakPenalty.getPenaltyRecordsFor.BFR;Free:" + rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:" + rt.maxMemory());
		}	
  	
  	long st = System.nanoTime();
  	List<ContractBreakPenaltyVO> results = new ArrayList<ContractBreakPenaltyVO>();
  	Connection conn = null;
  	PreparedStatement ps = null;
  	ResultSet rs = null;
  	StatsMapping stats = ProcessingStats.starting("ContractBreakPenaltyServices");
		try {
			log.debug(">>>PoolName:" + poolName + ".StatmentName:" + stmtName);
			conn = SQLConnectionManager.getInstance(poolName).getConnection();
			log.debug(">>>Connection got.");			
			ps = SQLConnectionManager.getInstance(poolName).getStatement(stmtName).prepareStatement(conn, parameters);
			rs = ps.executeQuery();
			while (rs.next()) {
				ContractBreakPenaltyVO vo =createVO(rs);
				log.debug(">>>Adding VO inside Loop:" + vo);
				results.add(vo);
			}
    } catch (NamingException e) {
    	log.error("Unable to get Contract Break Query.", e);
    } catch (SQLException e) {
    	log.error("Error while acessing database for Contract Break Query.", e);
    } finally {
			stats.finished();
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
	      if (conn != null && !conn.isClosed()) {				
	          conn.close();
	      }
	      long et = System.nanoTime();
	      log.debug("Acessing Databarn Time in milliseconds:" + ((et - st) / 1000 / 1000) +
	      		" Result Set size of:" + ((results == null ) ? 0 :  results.size()) + " for getting contract break penalties (R68)" );		      	      
      } catch (SQLException e) {
	      e.printStackTrace();
      }    	
    }
		if (log.isTraceEnabled()) {
			Runtime rt = Runtime.getRuntime();
			log.trace("ABM.ContractBreakPenalty.getPenaltyRecordsFor.AFT;Free:" + rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:" + rt.maxMemory());
		}	
 
	  return results;
  }
}