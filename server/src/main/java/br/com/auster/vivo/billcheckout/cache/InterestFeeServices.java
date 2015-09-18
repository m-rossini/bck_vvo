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
import br.com.auster.vivo.billcheckout.cache.vo.InterestFeeVO;

/**
 * @author mruao
 * @version $Id$
 *
 */
public class InterestFeeServices implements DataBarnInterestFeeServices {

	private static Logger log = Logger.getLogger(InterestFeeServices.class);
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

	protected InterestFeeVO createVO(ResultSet rs) throws SQLException {
		log.debug(">>>ResultSet for createVO:" + rs) ;
		if (rs == null) { return null; }
		InterestFeeVO vo = new InterestFeeVO();
		vo.setAccountNumber(rs.getString("ACCT_NBR"));
		vo.setCarrierCode(rs.getString("carriercode"));
		vo.setCarrierState(rs.getString("carrierstate"));		
		vo.setDocumentAmount(rs.getDouble("valortotal"));	
		vo.setFeeDate(rs.getDate("data_multa_juros"));
		vo.setFeeAmount(rs.getDouble("valor_multa_juros"));
		vo.setFeeType(rs.getString("tipo_cobranca"));
		vo.setPaymentDate(rs.getDate("data_pagamento"));
		vo.setDueDatePayment(rs.getDate("data_vencimento_pagto"));
		vo.setDueFeeDate(rs.getDate("data_vencto_apl_juros_multas"));
		vo.setReferenceFeeDate(rs.getDate("dat_ref_apl_juros_multa"));		
		vo.setReceivableAmount(rs.getDouble("docamt"));
		
		log.debug(">>>Returning VO:" + vo);
		return vo;
	}

	/* (non-Javadoc)
   * @see br.com.auster.vivo.billcheckout.util.DataBarnInterestFeeServices#getInterestRecordsFor(java.lang.String)
   */
  public List<InterestFeeVO> getInterestRecordsFor(String queryName, Object[] parameters) {
		if (log.isTraceEnabled()) {
			Runtime rt = Runtime.getRuntime();
			log.trace("ABM.InterestFee.getInterestRecordsFor.BFR;Free:" + rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:" + rt.maxMemory());
		}	
		
  	long st = System.nanoTime();
   	List<InterestFeeVO> results = new ArrayList<InterestFeeVO>();
  	Connection conn = null;
  	PreparedStatement ps = null;
  	ResultSet rs = null;
  	StatsMapping stats = ProcessingStats.starting(getClass(), stmtName);
		try {
			log.debug(">>>PoolName:" + poolName + ".StatmentName:" + stmtName);
			SQLConnectionManager man = SQLConnectionManager.getInstance(poolName);
			if (man == null) {
				log.error("SQLConnection Manager is NULL. Are sure you configured pool:" + poolName + " ?");
			}
			conn = man.getConnection();
			log.debug(">>>Connection got.");
			ps = man.getStatement(stmtName).prepareStatement(conn, parameters);
			rs = ps.executeQuery();
			while (rs.next()) {
				InterestFeeVO vo =createVO(rs);
				log.trace(">>>Adding VO inside Loop:" + vo);
				results.add(vo);
			}
    } catch (NamingException e) {
    	log.error("Naming lookup error acessing database in Interest Services for current account.", e);    	
    } catch (SQLException e) {
    	log.error("SQL error acessing database in Interest Services for current account.", e);
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
	      		" Result Set size of:" + ((results == null ) ? 0 :  results.size()) + " for getting fees (R69, R82)" );		      
      } catch (SQLException e) {
	      e.printStackTrace();
      }    	
    }
		if (log.isTraceEnabled()) {
			Runtime rt = Runtime.getRuntime();
			log.trace("ABM.InterestFee.getInterestRecordsFor.AFT;Free:" + rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:" + rt.maxMemory());
		}	

	  return results;
  }
}