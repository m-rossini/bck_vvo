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
 * Created on 31/01/2007
 */
package br.com.auster.vivo.billcheckout.cache;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
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
import br.com.auster.vivo.billcheckout.cache.vo.IntraGroupVO;

/**
 * @author mtengelm
 * 
 */
public class IntragroupServices implements DataBarnIntraGroup {

	private static Logger	        log	           = Logger.getLogger(IntragroupServices.class);

	protected static final String	DB_ELEMENT	   = "database";
	protected static final String	POOL_NAME_ATTR	= "pool-name";
	protected static final String	STMTS_ELMT	   = "statement-names";
	protected static final String	STMT_ELMT	     = "stament-name";
	protected static final String	NAME_ATTR	     = "name";	

	private String	              poolName;
	private Map stmts = new HashMap();

	private SQLConnectionManager sqlMan;

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
			for (int i=0; i < qt; i++) {
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
	
	public boolean isCalledNumberInIntraList(List intra, String calledNumber) {
		boolean results = false;
		
		for (Iterator it=intra.iterator();it.hasNext();) {
			IntraGroupVO vo = (IntraGroupVO) it.next();
			if (vo.getAccessNumberFavorite().equals(calledNumber)) {
				return true;
			}
		}
		return results;
	}
	
	/*
	 * (non-Javadoc)
	 * 
	 * @see br.com.auster.vivo.billcheckout.util.DataBarnIntraGroup#getAllAccountsInHierarchy(java.lang.String)
	 */
	public List getAllAccountsInHierarchy(String queryName, Object[] parameters) {
		SQLStatement query = (SQLStatement) this.stmts.get(queryName);
		if (query == null) {
			log.error("Asking for statement named:" + queryName + ", but it does no exists.");
			return null;
		}
		long st = System.nanoTime();
		Connection conn=null;
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
//	    results = new ArrayList();
	    while (rs.next()) {
	    	results.add(buildHierarchyList(rs));
	    }
    } catch (IllegalArgumentException e) {
	    e.printStackTrace();
    } catch (SQLException e) {    	
	    e.printStackTrace();
    } finally {
    		stats.finished();
			try {
				if (rs != null) {	rs.close();	}
				if (ps != null) {	ps.close();	}
				if (conn != null) {	conn.close();	}
	      long et = System.nanoTime();
	      log.debug("Acessing Databarn Time in milliseconds:" + ((et - st) / 1000 / 1000) + 
	      		" Result Set size of:" + ((results == null ) ? 0 :  results.size()) +
	      		" for getting accounts in heirarchy for intragroup" );				
			} catch (SQLException e) {    
				log.error("Problems releasing resources for query.");
		    e.printStackTrace();
	    } 
    }
    
    if (results == null) {
    	return Collections.emptyList();
    }
    
		return (results.size() == 0 ) ? null :  results;
	}
	
	protected String buildHierarchyList(ResultSet rs) throws SQLException {
		return rs.getString("acctnbr");
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see br.com.auster.vivo.billcheckout.util.DataBarnIntraGroup#getIntraGroupEntries(java.lang.String,
	 *      java.lang.String, java.util.Date)
	 */
	public List getIntraGroupEntries(String queryName, Object[] parameters) {
		SQLStatement query = (SQLStatement) this.stmts.get(queryName);
		if (query == null) {
			log.error("Asking for statement named:" + queryName + ", but it does no exists.");
			return Collections.emptyList();
		}
		
		long st = System.nanoTime();		
		Connection conn=null;
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
	    results = new ArrayList();
	    while (rs.next()) {
	    	results.add(buildIntraGroupList(rs));
	    }
    } catch (IllegalArgumentException e) {
    	log.error("Error acessing database in IntraGroup Services for current account." , e);    	
    } catch (SQLException e) {    	
    	log.error("Error acessing database in IntraGroup Services for current account." , e);      	
    } finally {
    		stats.finished();
			try {
				if (rs != null) {	rs.close();	}
				if (ps != null) {	ps.close();	}
				if (conn != null) {	conn.close();	}
	      long et = System.nanoTime();
	      log.debug("Acessing Databarn Time in milliseconds:" + ((et - st) / 1000 / 1000) + 
	      		" Result Set size of:" + ((results == null ) ? 0 :  results.size()) +
	      		" for getting intragroups" );					
			} catch (SQLException e) {    
				log.error("Problems releasing resources for query.");
		    e.printStackTrace();
	    } 
    }
    
    if (results == null) {
    	return Collections.emptyList();
    }
		return (results.size() == 0 ) ? null :  results;
	}

	/**
   * @param rs
	 * @throws SQLException 
   */
  protected IntraGroupVO buildIntraGroupList(ResultSet rs) throws SQLException {
  	IntraGroupVO results = new IntraGroupVO();
  	
  	results.setSubscriptionID(rs.getString("sbscrp_id"));
  	results.setAccountNumber(rs.getString("acctnbr"));
  	results.setAccessLineEffectiveDate(rs.getDate("access_line_eff_date"));
  	results.setAccessLineExpirationDate(rs.getDate("access_line_exp_date"));
  	results.setAccessNumberFavorite(rs.getString("al_favorito"));
  	results.setCycleCode(rs.getString("cycle_cd"));
  	results.setAccessNumber(rs.getString("al_base"));
  	
  	return results;	  
  }

	/*
	 * (non-Javadoc)
	 * 
	 * @see br.com.auster.vivo.billcheckout.util.DataBarnIntraGroup#isSameHierarchy(java.lang.String,
	 *      java.lang.String)
	 */
	public boolean isSameHierarchy(String queryName, Object[] parameters) {
		List list = this.getAllAccountsInHierarchy(queryName, parameters);
		return (list == null) ? false: list.contains(parameters[0]) ;
	}

}
