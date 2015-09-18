/*
 * Copyright (c) 2004-2008 Auster Solutions. All Rights Reserved.
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
 * Created on 18/02/2008
 */
package br.com.auster.vivo.billcheckout.cache;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;

import br.com.auster.billcheckout.caches.CacheableKey;
import br.com.auster.billcheckout.caches.CacheableVO;
import br.com.auster.billcheckout.caches.ReferenceDataCache;
import br.com.auster.common.sql.SQLConnectionManager;
import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.om.reference.facade.ConfigurationException;
import br.com.auster.vivo.billcheckout.cache.vo.DataBarnServiceByPlanVO;
import br.com.auster.vivo.billcheckout.cache.vo.DataBarnServicesByPlanListVO;

public class DataBarnServicesByPlanCache extends ReferenceDataCache {
	
	private static Logger log = Logger.getLogger(DataBarnServicesByPlanCache.class);
	
	//query name
	private String stmt1Name;
	private String svcId;
	private String endDate;
	private String startDate;
	

	public void configure(Element config) throws ConfigurationException {
		Element dbElement = DOMUtils.getElement(config, "database", true);
		stmt1Name = DOMUtils.getAttribute(dbElement, "sql1-name", true);
		if (stmt1Name == null || stmt1Name.trim().length() == 0) {
			throw new ConfigurationException("sql1-name was not informed.");
		}
		super.configure(config);
	}	

	@Override
	protected CacheableVO createVO(ResultSet _rset) throws SQLException {
		if (_rset == null) { return null; }

		DataBarnServicesByPlanListVO vo = new DataBarnServicesByPlanListVO();
		vo.setSvcId(this.svcId);
		vo.setEndDate(this.endDate);
		vo.setStartDate(this.startDate);
				
		while(_rset.next()) {
			DataBarnServiceByPlanVO dataBarnServiceByPlanVO = new DataBarnServiceByPlanVO();
			dataBarnServiceByPlanVO.setServiceName(_rset.getString("member_svc_name"));
			vo.add(dataBarnServiceByPlanVO);
		}
		
		return vo;
	}

	@Override
	protected String getAlternateLazySQL() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected String getLazySQL() {
		return stmt1Name;
	}

	@Override
	protected String getNonLazySQL() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected void setAlternateLazySQLParameters(PreparedStatement arg0,
			CacheableKey arg1) throws SQLException {
		// TODO Auto-generated method stub		
	}

	@Override
	protected void setLazySQLParameters(PreparedStatement _stmt,
			CacheableKey _key) throws SQLException {
		// TODO Auto-generated method stub	
	}

	@Override
	protected void populateCache() {		
		//do nothing because this cache is configured to work only on lazy mode
	}	
	
	protected void loadFromDatabase(CacheableKey _key) {
		DataBarnServicesByPlanListVO.InnerKey key = (DataBarnServicesByPlanListVO.InnerKey) _key;
		SQLConnectionManager man;
		Connection conn=null;
		PreparedStatement stmt=null;
		
		StatsMapping stats = ProcessingStats.starting(getClass(), stmt1Name);
		try {
			man = SQLConnectionManager.getInstance(poolName);
			if (man == null) {
				log.error("SQLConnection Manager is null. Are sure you configured pool " + poolName + "?");
				throw (new ConfigurationException("Pool not configured: " + poolName));
			}
				
			conn = man.getConnection();				
			Object[] parameters = {key.getSvcId(), key.getEndDate(), key.getStartDate(), key.getEndDate()};
			stmt = man.getStatement(stmt1Name).prepareStatement(conn, parameters);
			this.svcId = key.getSvcId();
			this.endDate = key.getEndDate();
			this.startDate = key.getStartDate();
			loadIntoCache(stmt, true);
		} catch (Exception e) {
			log.error("Could not load non-lazy cache", e);
		} finally {
				stats.finished();
				try {
					if (stmt != null) {	stmt.close(); }
					if (conn != null) {	conn.close(); }
			} catch (SQLException e) {
				log.error("Exception populating cache", e);
			} 
		}		
	}
	
	@Override
	protected void loadIntoCache(PreparedStatement _stmt, boolean _overflowAllowed) throws SQLException {
		ResultSet rs = null;
		try {
			rs = _stmt.executeQuery();
			readAndAddToCache(rs, _overflowAllowed);
		} finally {			
			try {
				if (rs != null) {	rs.close();	}
			} catch (SQLException e) {
				log.error("Exception populating cache", e);
			} 
		}	
	}
	
}
