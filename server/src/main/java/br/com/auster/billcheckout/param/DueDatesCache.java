/*
* Copyright (c) 2004-2005 Auster Solutions do Brasil. All Rights Reserved.
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
* Created on 03/10/2006
*/
//TODO Comment this Class
package br.com.auster.billcheckout.param;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.atomic.AtomicInteger;

import javax.naming.NamingException;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;

import br.com.auster.common.log.LogFactory;
import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;

public class DueDatesCache extends ReferenceDataCache {

    private static Logger log = LogFactory.getLogger(DueDatesCache.class);
  	protected static final String VO_KEY = "DUE";
  	protected static final int VO_CACHE_SIZE_DEFAULT = 175;
  	    
		private static final String LAZY_ATTR = "lazy-cache";
		private static final String CACHE_SIZE_ATTR = "cache-size";
		
		private Set notFound = new HashSet();		
    private boolean lazy=true;
		private boolean useAlternate;
		private AtomicInteger voCacheSize;
    
    public static final String SQL = "select objid, cycle_code," +
    		" customer_type, due_date, month_change_ind " +
    		"from bck_parm_due_dates where cycle_code = ? and customer_type = ?";
    
    public static final String NOT_LAZY_SQL = "select objid, cycle_code," +
		" customer_type, due_date, month_change_ind " +
		"from bck_parm_due_dates";    
    
	public DueDatesCache() {
		super();		
	}

	public void configure(Element config) {
		log.trace("Configuring Cache for class:" + this.getClass().getName() + "@thread:"  + Thread.currentThread().getName());
		super.configure(config);	
	}	
	
	public DueDateVO createVO(ResultSet rs) throws SQLException {
		DueDateVO obj = new DueDateVO();
		obj.setCustomerType(rs.getString("CUSTOMER_TYPE"));
		obj.setCycleCode(rs.getString("CYCLE_CODE"));
		obj.setDueDate(rs.getInt("due_date"));
		obj.setMonthChangeInd(rs.getString("month_change_ind"));
		obj.setUid(rs.getLong("objid"));		
		return obj;
	}
	/**
	 * Gets a <code>DueDates</code> object by <code>cycleCode</code> and <code>customerType</code>. 
	 */
	public DueDateVO getDueDates(String cycleCode, String customerType) {
		String objKey = "";
		if (this.isUseAlternateKey()) {
			log.error("This method does not support the use of alternate key. Plase use Object Key directly.");
		} else {
			objKey = DueDateVO.createKey(cycleCode, customerType);
		}
		DueDateVO obj = (DueDateVO) this.getFromCacheFor(objKey, VO_KEY);	
		
		if (obj!=null) {
			//We found it in Cache
			log.debug("The object is in the cache.Obj:" + obj);
			return obj;
		}
		
		if (notFound.contains(objKey)) {
			//It is already in not found cache
			log.debug("DueDates.The Key is in Not Found Cache.Key:" + objKey);
			return null;
		}
		
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs = null;
		StatsMapping stats = ProcessingStats.starting("DueDatesCache");
		try {
			conn = this.getConnection();
			stmt = conn.prepareStatement(SQL);
			stmt.setString(1, cycleCode);
			stmt.setString(2, customerType);
			rs = stmt.executeQuery();
			if (rs.next()) {
				obj = createVO(rs);
				this.putInCacheFor((this.isUseAlternateKey())? obj.getAlternateKey() : obj.getKey(), obj, VO_KEY);				
				log.debug("Data found in DB.Obj:" + obj);
			} else {
				log.debug("Obj is not found in cache neither in DB.objKey:" + objKey);
				notFound.add(objKey);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		} finally {			
			stats.finished();
			try {
				if (rs != null) {	rs.close();	}
				if (stmt != null) {	stmt.close();	}
				if (conn != null) {	conn.close();	}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return obj;
	}
	/* (non-Javadoc)
   * @see br.com.auster.billcheckout.param.ReferenceDataCache#isLazy()
   */
  public boolean isLazy() {
	  return lazy;
  }

	/* (non-Javadoc)
   * @see br.com.auster.billcheckout.param.ReferenceDataCache#getCacheSize()
   */
  @Override
  public int getCacheSize() {
	  return voCacheSize.get();
  }

	/* (non-Javadoc)
   * @see br.com.auster.billcheckout.param.ReferenceDataCache#isUseAlternateKey()
   */
  @Override
  public boolean isUseAlternateKey() {
  	return useAlternate;
  }

	/* (non-Javadoc)
   * @see br.com.auster.billcheckout.param.ReferenceDataCache#setCacheSize(int)
   */
  @Override
  public void setCacheSize(int cachesize) {
		voCacheSize = new AtomicInteger((cachesize == 0) ? VO_CACHE_SIZE_DEFAULT : cachesize);	  
  }

	/* (non-Javadoc)
   * @see br.com.auster.billcheckout.param.ReferenceDataCache#setLazy(boolean)
   */
  @Override
  public void setLazy(boolean lazy) {
	  this.lazy=lazy; 
  }

	/* (non-Javadoc)
   * @see br.com.auster.billcheckout.param.ReferenceDataCache#setUseAlternateKey()
   */
  @Override
  public void setUseAlternateKey(boolean alternate) {
	  this.useAlternate = alternate;
  }

	/* (non-Javadoc)
   * @see br.com.auster.billcheckout.param.ReferenceDataCache#getCacheKey()
   */
  @Override
  public String getCacheKey() {
	  return VO_KEY;
  }
	
	/* (non-Javadoc)
   * @see br.com.auster.billcheckout.param.ReferenceDataCache#getNonLazySQL()
   */
  @Override
  public String getNonLazySQL() {
	  return NOT_LAZY_SQL;
  }  
}
