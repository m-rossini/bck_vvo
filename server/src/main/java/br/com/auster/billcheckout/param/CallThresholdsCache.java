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
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.atomic.AtomicInteger;

import javax.naming.NamingException;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;

import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;
import br.com.auster.om.reference.facade.ConfigurationException;
import br.com.auster.om.util.UnitCounter;

/**
 * @author mtengelm
 * @version $Id: CallThresholdsCache.java 2665 2008-07-18 14:03:20Z aleite $
 */
public class CallThresholdsCache extends ReferenceDataCache {

	private static final Logger	log	               = Logger.getLogger(CallThresholdsCache.class);

	protected static final String VO_KEY = "CALLTHRESHOLDS";
	protected static final int VO_CACHE_SIZE_DEFAULT = 450;
	
	private static final ThreadLocal notFound = new ThreadLocal() {
		protected synchronized Object initialValue() {
			return new HashSet();
		}
	};
	
	private static final ThreadLocal noBestMatch = new ThreadLocal() {
		protected synchronized Object initialValue() {
			return new HashSet();
		}
	};
	
	private static final ThreadLocal bestMatchMap = new ThreadLocal() {
		protected synchronized Object initialValue() {
			return new HashMap();
		}
	};	
//	private Set notFound = new HashSet();
//	private Set noBestMatch = new HashSet();		
  private boolean lazy=true;
	private boolean useAlternate;
	private AtomicInteger voCacheSize;
	
	public static final int	    LIMIT_OK	         = 0;
	public static final int	    LIMIT_MIN_VALUE	   = 1;
	public static final int	    LIMIT_MAX_VALUE	   = 2;
	public static final int	    LIMIT_MIN_DURATION	= 4;
	public static final int	    LIMIT_MAX_DURATION	= 8;

	public static final String SQL = "select " +
			" 1, OBJID, CALL_CLASS, CALL_SUB_CLASS, CALL_TARIFF, MAX_DURATION_TYPE, MAX_DURATION_UNIT, MIN_VALUE, MAX_VALUE " +
			" from BCK_PARM_THRESHOLD_CALLS where CALL_CLASS = ? and CALL_SUB_CLASS=? and CALL_TARIFF = ?" +
			" UNION ALL" +
			" select " +
			" 2, OBJID, CALL_CLASS, CALL_SUB_CLASS, CALL_TARIFF, MAX_DURATION_TYPE, MAX_DURATION_UNIT, MIN_VALUE, MAX_VALUE " +
			" from BCK_PARM_THRESHOLD_CALLS where CALL_CLASS = ? and CALL_SUB_CLASS= ? and CALL_TARIFF is null" +
			" UNION ALL" +
			" select " +
			" 3, OBJID, CALL_CLASS, CALL_SUB_CLASS, CALL_TARIFF, MAX_DURATION_TYPE, MAX_DURATION_UNIT, MIN_VALUE, MAX_VALUE " +
			" from BCK_PARM_THRESHOLD_CALLS where CALL_CLASS = ? and CALL_SUB_CLASS is null and CALL_TARIFF = ?" +
			" UNION ALL" +
			" select " +
			" 4, OBJID, CALL_CLASS, CALL_SUB_CLASS, CALL_TARIFF, MAX_DURATION_TYPE, MAX_DURATION_UNIT, MIN_VALUE, MAX_VALUE " +
			" from BCK_PARM_THRESHOLD_CALLS where CALL_CLASS = ? and CALL_SUB_CLASS is null and CALL_TARIFF is null" +
			" order by 1" 
	;
	
	public static final String NOT_LAZY_SQL = "select OBJID, CALL_CLASS, CALL_SUB_CLASS," +
			" CALL_TARIFF, MAX_DURATION_TYPE, MAX_DURATION_UNIT, MIN_VALUE, MAX_VALUE" +
			" from BCK_PARM_THRESHOLD_CALLS";

	/**
	 * 
	 */
	public CallThresholdsCache() {
		super();
	}

	public void configure(Element _configuration) throws ConfigurationException {
		log.trace("Configuring Cache for class:" + this.getClass().getName() + "@thread:"  + Thread.currentThread().getName());		
		super.configure(_configuration);
	}

	/* (non-Javadoc)
   * @see br.com.auster.billcheckout.param.ReferenceDataCache#createVO(java.sql.ResultSet)
   */
  @Override
  public CachedVO createVO(ResultSet rs) throws SQLException {
  	CallThresholdVO vo = new CallThresholdVO(); 
  	
  	vo.setUid(rs.getLong("OBJID"));
  	vo.setCallClass(rs.getString("CALL_CLASS"));
  	vo.setCallSubClass(rs.getString("CALL_SUB_CLASS"));
  	vo.setCallTariff(rs.getString("CALL_TARIFF"));
  	UnitCounter counter = new UnitCounter();
  	counter.setType(rs.getString("MAX_DURATION_TYPE"));
  	counter.setUnits(rs.getLong("MAX_DURATION_UNIT"));
  	vo.setMaxDuration(counter);
  	vo.setMinValue(rs.getDouble("MIN_VALUE"));
  	vo.setMaxValue(rs.getDouble("MAX_VALUE"));
  	
	  return vo;
  }

  public CachedVO getObjectByKey(String callclass, String callsubclass, String calltariff) {
		String objKey = "";
		if (this.isUseAlternateKey()) {
			log.error("This method does not support the use of alternate key. Plase use Object Key directly.");
		} else {
			objKey = CallThresholdVO.createKey(callclass, callsubclass, calltariff);
		}
		CallThresholdVO obj = (CallThresholdVO) this.getFromCacheFor(objKey, VO_KEY);	
		if (obj!=null) {
			//We found it in Cache
			log.debug("The object is in the cache.Obj:" + obj);
			return obj;
		}
		
		// Lets see if there is an entry on not found cache
		if (((Set) notFound.get()).contains(objKey)) {
			// It is already in not found cache
			log.debug("The Key is in Not Found Cache.Key:" + objKey);
			// Lets see if there is NO best match for this object
			if (((Set) noBestMatch.get()).contains(objKey)) {
				log.debug("The key has no BEST MATCH.");
				return null;
			}
			// We may find a best match...let's try.
			Map map = (Map) bestMatchMap.get();
			if (!map.containsKey(objKey)) {
				//No cached Best Map.
				CachedVO bestMatch = bestMatch(callclass, callsubclass, calltariff);
				log.debug("This is the best MATCH:" + bestMatch);
				if (bestMatch == null) {
					//Yeap.....NO Best Match any way....
					((Set) noBestMatch.get()).add(objKey);
				} else {
					//Yeas. We got a Best Match. No need to iterate over the potential matches again....
					map.put(objKey, bestMatch);
				}
				return bestMatch;
			} else {
				log.debug("The key HAS and entry in Best Match Cache.");
				return (CachedVO) map.get(objKey);
			}
		}
		//The object is NOT in Cache and is NOT in not found cache. Let's try the Database
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs = null;
		StatsMapping stats = ProcessingStats.starting("CallThresholdsCache");
		try {
			conn = this.getConnection();
			log.debug("Going to Database.For Key:" + objKey);
			stmt = conn.prepareStatement(SQL);
			stmt.setString(1, callclass); // Select 1.
			stmt.setString(2, callsubclass); //Select 1.
			stmt.setString(3, calltariff); //Select 1.
			stmt.setString(4, callclass);	 //Select 2.
			stmt.setString(5, callsubclass);	//Select 2.
			stmt.setString(6, callclass);	//Select 3.
			stmt.setString(7, calltariff);	//Select 3.
			stmt.setString(8, callclass);	 //Select 4.
			rs = stmt.executeQuery();
			if (rs.next()) {
				obj = (CallThresholdVO) createVO(rs);
				this.putInCacheFor((this.isUseAlternateKey())? obj.getAlternateKey() : obj.getKey(), obj, VO_KEY);				
				log.debug("Data found in DB.Obj:" + obj);
				if (!objKey.equals(obj.getKey())) {
					log.debug("Found the BEST MATCH, not the FULL MATCH. Adding requested object to NOT FOUND List");
					((Set) notFound.get()).add(objKey);
					Map map = (Map) bestMatchMap.get();		
					map.put(objKey, obj);					
				}
			} else {
				log.debug("Obj is not found in cache neither in DB.objKey:" + objKey);
				((Set) notFound.get()).add(objKey);
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
  
  public CachedVO bestMatch(String callclass, String callsubclass, String calltariff) {
		log.debug("Trying the BEST MATCH");
		Map cache = getCacheImageFor(VO_KEY);

		//Does exists an entry for callclass and subclass ONLY?
		String key = CallThresholdVO.createKey(callclass, callsubclass, null);
		if (cache.containsKey(key)) {
			return (CachedVO) cache.get(key);
		}
		
		//Does exists an entry for callclass and calltariff ONLY?
		key = CallThresholdVO.createKey(callclass, null, calltariff);
		if (cache.containsKey(key)) {
			return (CachedVO) cache.get(key);
		}
		
		//Does not exists (callclass && callsubclass ) || (callclass && calltariff).
		//So, lets try callclass ONLY, if does not exists..well..it does not!!! :)
		return (CachedVO) cache.get(CallThresholdVO.createKey(callclass, null, null));
	}
  
  public static int isUsageDurationOutBounds(CachedVO vo, String type, long units) {
  	int ret = 0;
  	CallThresholdVO bound = (CallThresholdVO) vo;
  	if (bound.getMaxDuration().getType().equals(type)) {
  		if (units > bound.getMaxDuration().getUnits()) {
  			return 1;
  		}
  	}
  	return ret;
  }
  
  public static int isUsageMinValueOutBounds(CachedVO vo, double amt) {
  	int ret=0;
  	CallThresholdVO bound = (CallThresholdVO) vo;
  	if (amt < bound.getMinValue()) {
  		return 1;
  	}
  	return ret;
  }

  public static int isUsageMaxValueOutBounds(CachedVO vo, double amt) {
  	int ret=0;
  	CallThresholdVO bound = (CallThresholdVO) vo;
  	if (amt > bound.getMaxValue()) {
  		return 1;
  	}
  	return ret;
  }  
	/*
	 * (non-Javadoc)
	 * 
	 * @see br.com.auster.billcheckout.param.ReferenceDataCache#getCacheKey()
	 */
  @Override
  public String getCacheKey() {
	  return VO_KEY;
  }

	/* (non-Javadoc)
   * @see br.com.auster.billcheckout.param.ReferenceDataCache#getCacheSize()
   */
  @Override
  public int getCacheSize() {
	  return voCacheSize.get();
  }

	/* (non-Javadoc)
   * @see br.com.auster.billcheckout.param.ReferenceDataCache#getNonLazySQL()
   */
  @Override
  public String getNonLazySQL() {
	  return NOT_LAZY_SQL;
  }

	/* (non-Javadoc)
   * @see br.com.auster.billcheckout.param.ReferenceDataCache#isLazy()
   */
  @Override
  public boolean isLazy() {
	  return lazy;
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
   * @see br.com.auster.billcheckout.param.ReferenceDataCache#setUseAlternateKey(boolean)
   */
  @Override
  public void setUseAlternateKey(boolean alternate) {	
	  this.useAlternate=alternate;
  }

}
