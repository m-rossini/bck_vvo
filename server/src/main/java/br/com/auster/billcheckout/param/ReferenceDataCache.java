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
 * Created on 10/11/2006
 */
package br.com.auster.billcheckout.param;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import javax.naming.NamingException;

import org.apache.commons.collections.map.LRUMap;
import org.apache.log4j.Logger;
import org.w3c.dom.Element;

import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;
import br.com.auster.common.xml.DOMUtils;

/**
 * This is an abstract cache for Billcheckout enabled VOs.
 * Acctually this class behaves as a hub for parameter tables cache.
 * Internally it uses a ConcurrentHashMap to keep track of all caches registered in the configuration
 * 
 * @author mtengelm
 *
 */
public abstract class ReferenceDataCache extends SQLEmitter {
	private static Logger log = Logger.getLogger(ReferenceDataCache.class);
	
	protected Map cache = new HashMap();
	//protected static LRUMap dueDatesCache;	
	private static Lock lock = new ReentrantLock();
	private static AtomicBoolean cached = new AtomicBoolean(false);
	
    protected static final String LAZY_ATTR = "lazy-cache";
	protected static final String CACHE_SIZE_ATTR = "cache-size";
	protected static final String USE_ALTERNATE_KEY_ATTR = "use-alternate";
		
	public ReferenceDataCache() {
		log.debug("Creating a new Instance of ReferenceDataCache");				
	}

	public void configure(Element config) {
		super.configure(config);
		log.debug("Configuring CacheManager for Billcheckout CORE.");
		this.setLazy(DOMUtils.getBooleanAttribute(config, LAZY_ATTR));
		this.setCacheSize(DOMUtils.getIntAttribute(config, CACHE_SIZE_ATTR, false));
		this.setUseAlternateKey(DOMUtils.getBooleanAttribute(config, USE_ALTERNATE_KEY_ATTR));
		createCache(this.getCacheKey(), this.getCacheSize());
		if (!this.isLazy()) {
			populateCache();
		}		
	}
	
	public void refresh() {
		try {
			lock.lock();
			for (Iterator it=cache.values().iterator();it.hasNext();) {
				LRUMap map = (LRUMap) it.next();
				map.clear();
			}
    } finally {
			lock.unlock();
		}
	}
	
	public void createCache(String key, int size) {
		if (cache.containsKey(key)) {
			log.warn("A Cache for specified key currently exists.Key:" + key);
		}
		cache.put(key, new LRUMap(size,false));
		log.debug("Creating a new cache managed for:" + key);
//		try {
//			lock.lock();
//			cache.put(key, new LRUMap(size,false));			
//			log.debug("Creating a new cache managed for:" + key);
//    } finally {
//			lock.unlock();
//		}			
	}
	
	/***
	 * This method returns a Cache from the ConcurrentHashMap (Which stores all caches).
	 * Be carefull that right after this method returns, the map can be changed by any thread and any modifications
	 * made any other thread can cause an exception on requesting thread and vice-versa.
	 * 
	 * This methodis potentially unsafe, thus we recommend using getCacheImageFor method.
	 * @param key
	 * @return
	 */
	public LRUMap getCacheFor(String key) {
//		try {
//			lock.lock();
//			return (LRUMap) cache.get(key);			
//    } finally {
//			lock.unlock();
//		}				
		return (LRUMap) cache.get(key);
	}

	public Map getCacheImageFor(String key) {
		return Collections.unmodifiableMap( (LRUMap) cache.get(key));
//		try {
//			lock.lock();
//			return Collections.unmodifiableMap( (LRUMap) cache.get(key));			
//    } finally {
//			lock.unlock();
//		}				
	}
	
	public Object getFromCacheFor(String key, String cachekey) {
		LRUMap map = (LRUMap) cache.get(cachekey);
		log.debug("Asking for cache key:" + cachekey + " and object key:" + key);
		return map.get(key);
//		try {
//			lock.lock();			
//			LRUMap map = (LRUMap) cache.get(cachekey);
//			log.debug("Asking for cache key:" + cachekey + " and object key:" + key);
//			return map.get(key);
//    } finally {
//			lock.unlock();
//		}				
	}
	
	public void putInCacheFor(String key, Object obj, String cachekey) {
		LRUMap map = (LRUMap) cache.get(cachekey);
		map.put(key, obj);
		log.debug("Cache for [" + cachekey + "] has size of:" + map.size() + " and a max size of:"+ map.maxSize() + ".Obj:[" + obj + "]");		
		cache.put(cachekey, map);
//		try {
//			lock.lock();
//			LRUMap map = (LRUMap) cache.get(cachekey);
//			map.put(key, obj);
//			log.debug("Cache for [" + cachekey + "] has size of:" + map.size() + " and a max size of:"+ map.maxSize() + ".Obj:[" + obj + "]");		
//			cache.put(cachekey, map);
//    } finally {
//			lock.unlock();
//		}			
	}
	
	public void updateCacheFor(String key, LRUMap map) {
		cache.put(key, map);
//		try {
//			lock.lock();
//			cache.put(key, map);
//    } finally {
//			lock.unlock();
//		}						
	}
	
	public void populateCache() {
		if (log.isTraceEnabled()) {
			Runtime rt = Runtime.getRuntime();
			log.trace("ABM.ReferenceDataCache.BFR;Free:" + rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:" + rt.maxMemory());
		}			
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs = null;
		StatsMapping stats = ProcessingStats.starting("ReferenceDataCache");
		try {
			//lock.lock();
			conn = this.getConnection();
			stmt = conn.prepareStatement(this.getNonLazySQL());
			log.debug("Starting hungry cache populate.");
			rs = stmt.executeQuery();
			while (rs.next()) {
				CachedVO obj = createVO(rs);
				if (getCacheFor(getCacheKey()).isFull()) {
					log.warn("Cache for key is full. Leaving the hungry populate.Key:" + this.getCacheKey());
					break;
				}
				this.putInCacheFor((this.isUseAlternateKey())? obj.getAlternateKey() : obj.getKey(), obj, this.getCacheKey());
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		} finally {	
				stats.finished();
				if (log.isTraceEnabled()) {
					Runtime rt = Runtime.getRuntime();
					log.trace("ABM.ReferenceDataCache.AFT;Free:" + rt.freeMemory() + ";Total:" + rt.totalMemory() + ";Max:" + rt.maxMemory());
				}			
			
				try {
				if (rs != null) {	rs.close();	}
				if (stmt != null) {	stmt.close();	}
				if (conn != null) {	conn.close();	}
			} catch (SQLException e) {
				e.printStackTrace();
			} 
			//lock.unlock();
		}		
	}
	
	public abstract void setCacheSize(int cachesize);
	public abstract int getCacheSize();
	public abstract void setLazy(boolean lazy);	
	public abstract boolean isLazy();
	public abstract void setUseAlternateKey(boolean alternate);	
	public abstract boolean isUseAlternateKey();
	public abstract String getCacheKey();
	public abstract String getNonLazySQL();
	public abstract CachedVO createVO(ResultSet rs) throws SQLException;
	
//	public GeographicDimension getGeoDimension(String state) {
//		if (geoCache.containsKey(state)) { }
//		return null;
//	}
	/*
	private Map loadTaxTypeFromDatabase() throws NamingException, SQLException {
		SQLConnectionManager cm = SQLConnectionManager.getInstance(pool);
		Connection conn = cm.getConnection();
		String SQL = "select objid, tax_code, tax_name FROM bck_tax_type";
		PreparedStatement stmt = conn.prepareStatement(SQL);
		ResultSet rs = stmt.executeQuery();
		Map geo = new HashMap();
		while (rs.next()) {
			TaxType gd = new TaxType();
			geo.put(rs.getString("tax_code"), new Long(rs.getLong("OBJID")));
		}
		rs.close();
		stmt.close();
		conn.close();
		return geo;
	}
	
	private Map loadGeoFromDatabase() throws NamingException, SQLException {
		SQLConnectionManager cm = SQLConnectionManager.getInstance(pool);
		Connection conn = cm.getConnection();
		String SQL = "select objid, geo_country, geo_region, geo_state, geo_city FROM bck_geo_dm ";
		PreparedStatement stmt = conn.prepareStatement(SQL);
		ResultSet rs = stmt.executeQuery();
		Map geo = new HashMap();
		while (rs.next()) {
			GeographicDimension gd = new GeographicDimension();
			gd.setUid(rs.getLong("OBJID"));
			gd.setCountry(rs.getString("geo_country"));
			gd.setCity(rs.getString("geo_city"));
			gd.setState(rs.getString("geo_state"));		
			geo.put(gd.getKey(), gd);
		}
		rs.close();
		stmt.close();
		conn.close();
		return geo;
	}
	*/
}
