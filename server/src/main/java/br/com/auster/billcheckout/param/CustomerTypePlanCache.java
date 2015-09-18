/*
 * Copyright (c) 2007 Auster Solutions do Brasil. All Rights Reserved.
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
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. *
 * 
 */

/**
 * @author gportuga
 * Created on 08/01/2007
 * 
 *  Classe que busca dados da tabela BCK_CUST_TYPE_PLAN e BCK_CUST_TYPE_CNPJ_PLAN
 */

package br.com.auster.billcheckout.param;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.NamingException;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;

import br.com.auster.common.log.LogFactory;
import br.com.auster.common.sql.SQLConnectionManager;
import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.om.reference.facade.ConfigurationException;

public class CustomerTypePlanCache{	

	private SQLConnectionManager sqlMan;

	private static Logger log = LogFactory.getLogger(CustomerTypePlanCache.class);
	public static final String SQL = "select plan_name from bck_cust_type_cnpj_plan where svc_id = ? ";
	public static final String SQL2 = "select cust_type from bck_cust_type_plan where svc_id = ? ";

	//função para acessar o arquivo billcheckout.xml e verificar configurações de acesso ao DB	
	public void configure(Element config) {
		try {
			Element dbElement = DOMUtils.getElement(config, "database", true);
			String poolName = DOMUtils.getAttribute(dbElement, "pool-name", true);

			if ((poolName == null) || (poolName.trim().length() == 0)) {
				throw new ConfigurationException("pool-name was not informed.");
			}			
			sqlMan = SQLConnectionManager.getInstance(poolName);		
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}	

	public boolean isPlanOnlyCNPJ(String svcId) {
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs = null;
		StatsMapping stats = ProcessingStats.starting("CustomerTypePlanCache.isPlanOnlyCNPJ");
		try {
			conn = sqlMan.getConnection();
			stmt = conn.prepareStatement(SQL);
			stmt.setString(1, svcId);
			rs = stmt.executeQuery();
			if (rs.next()) {
				return true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} 
		finally 			
		{	
			stats.finished();
			try {
				if (rs != null) 	{ rs.close();   }
				if (stmt != null) 	{ stmt.close(); }
				if (conn != null) 	{ conn.close(); }
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return false;
	}
	
	public boolean isPlanRightCustType(String svcId, String clientType) {
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs = null;
		StatsMapping stats = ProcessingStats.starting("CustomerTypePlanCache.isPlanRightCustType");
		try {
			conn = sqlMan.getConnection();
			stmt = conn.prepareStatement(SQL2);
			stmt.setString(1, svcId);
			rs = stmt.executeQuery();
			if (rs.next()) {
				if (!rs.getString("CUST_TYPE").contains(clientType)) {
					return false;
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} 
		finally 			
		{	
			stats.finished();
			try {
				if (rs != null) 	{ rs.close();   }
				if (stmt != null) 	{ stmt.close(); }
				if (conn != null) 	{ conn.close(); }
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}
}
