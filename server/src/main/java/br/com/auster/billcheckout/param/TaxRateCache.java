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

public class TaxRateCache extends ReferenceDataCache {

    private static Logger log = LogFactory.getLogger(TaxRateCache.class);
  	protected static final String VO_KEY = "TAXRATE";
  	protected static final int VO_CACHE_SIZE_DEFAULT = 450;
  	protected static AtomicInteger voCacheSize;	
  	
    private Set notFound = new HashSet();
    private boolean lazy=true;
		private boolean useAlternate;
    
    public static final String SQL = "select g.objid as  \"geoUID\" , g.geo_country as \"geoCountry\", " +
  	" g.geo_region as \"geoRegion\", g.geo_state as \"geoState\"," +
  	" t.objid as \"taxTypeUID\", t.tax_code as \"taxTypeCode\",  " +
  	" f.objid as \"fiscalCodeUID\", f.fiscal_code as \"fiscalCode\", " +
  	" r.objid as \"taxRateUID\", r.tax_rate as \"taxRate\"" +
    		" from  bck_tax_rate r left outer join bck_fiscal_code f on f.objid = r.fiscal_code_uid" +
    		" inner join bck_geo_dm g on g.objid = r.geo_uid " +
    		" inner join bck_tax_type t on t.objid = r.tax_type_uid" +
    		" where g.geo_country='Brasil' and g.geo_state = ? and t.tax_code = ?" +
    		" and f.fiscal_code = ?";
    
    public static final String NOT_LAZY_SQL = "select g.objid as  \"geoUID\" , g.geo_country as \"geoCountry\", " +
    	" g.geo_region as \"geoRegion\", g.geo_state as \"geoState\"," +
    	" t.objid as \"taxTypeUID\", t.tax_code as \"taxTypeCode\",  " +
    	" f.objid as \"fiscalCodeUID\", f.fiscal_code as \"fiscalCode\", " +
    	" r.objid as \"taxRateUID\", r.tax_rate as \"taxRate\"" +
    	" from  bck_tax_rate r left outer join bck_fiscal_code f on f.objid = r.fiscal_code_uid" +
    	" inner join bck_geo_dm g on g.objid = r.geo_uid" +
    	" inner join bck_tax_type t on t.objid = r.tax_type_uid" +
    	" where g.geo_country='Brasil'";

    
	public TaxRateCache() {
		super();		
	}

	public void configure(Element config) {
		super.configure(config);			
		//this.createCache(VO_KEY,voCacheSize.get());
//		if (!lazy) {
//			populateCache();
//		}
	}
	
//	public void populateCache() {
//		Connection conn=null;
//		PreparedStatement stmt=null;
//		ResultSet rs = null;
//		try {
//			conn = this.getConnection();
//			stmt = conn.prepareStatement(NOT_LAZY_SQL);
//			log.debug("Starting hungry cache populate.");
//			rs = stmt.executeQuery();
//			while (rs.next()) {
//				CachedVO obj = createVO(rs);
//				this.putInCacheFor((this.isUseAlternateKey())? obj.getAlternateKey() : obj.getKey(), obj, VO_KEY);
//			}
//
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} catch (NamingException e) {
//			e.printStackTrace();
//		} finally {			
//				try {
//				if (rs != null) {	rs.close();	}
//				if (stmt != null) {	stmt.close();	}
//				if (conn != null) {	conn.close();	}
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}
//		}		
//	}
	
	public TaxRateVO createVO(ResultSet rs) throws SQLException {
		TaxRateVO obj = new TaxRateVO();
		
		obj.setFiscalCodeUID(rs.getLong("fiscalCodeUID"));
		obj.setGeoUID(rs.getLong("geoUID"));
		obj.setTaxTypeUID(rs.getLong("taxTypeUID"));
		obj.setUid(rs.getLong("taxRateUID"));		
		obj.setFiscalCode(rs.getString("fiscalCode"));
		obj.setGeoCountry(rs.getString("geoCountry"));
		obj.setGeoRegion(rs.getString("geoRegion"));
		obj.setGeoState(rs.getString("geoState"));
		obj.setTaxCode(rs.getString("taxTypeCode"));
		obj.setTaxRate(rs.getDouble("taxRate"));
		return obj;
	}
	/**
	 * Gets a <code>DueDates</code> object by <code>cycleCode</code> and <code>customerType</code>. 
	 */
	public TaxRateVO getTaxRateByAlternateKey(String country, String state, String taxTypeCode, String fiscalCode) {
		String objKey="";
		if (this.isUseAlternateKey()) {
			objKey = TaxRateVO.createAlternateKey(country, state, taxTypeCode, fiscalCode );
		} else {
			log.error("This method does not support use of Object Key. Plase use alternate.");
		}
		TaxRateVO obj = (TaxRateVO) this.getFromCacheFor(objKey, VO_KEY);	
		
		if (obj!=null) {
			//We found it in Cache
			log.debug("The object is in the cache.Obj:" + obj);
			return obj;
		}
		
		if (notFound.contains(objKey)) {
			//It is already in not found cache
			log.debug("The Key is in Not Found Cache.Key:" + objKey);
			return null;
		}
		
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs = null;
		StatsMapping stats = ProcessingStats.starting("TaxRateCache");
		try {
			conn = this.getConnection();
			stmt = conn.prepareStatement(SQL);
			stmt.setString(1, state);
			stmt.setString(2, taxTypeCode);
			stmt.setString(3, fiscalCode);
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
