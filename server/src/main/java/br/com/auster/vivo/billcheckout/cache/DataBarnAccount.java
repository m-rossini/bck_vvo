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
 * Created on 02/02/2007
 */
package br.com.auster.vivo.billcheckout.cache;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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


/**
 * @author gportuga
 * TODO implementar cache
 */
public class DataBarnAccount  {
	private static Logger log = Logger.getLogger(DataBarnAccount.class);

	private Map stmtsMap = new HashMap();
	private SQLConnectionManager sqlMan;

	public DataBarnAccount() {

	}

	public void configure(Element config) {
		try {
			Element dbElement = DOMUtils.getElement(config, "database", true);

			String poolName = DOMUtils.getAttribute(dbElement, "pool-name", true);
			if ((poolName == null) || (poolName.trim().length() == 0)) {
				throw new ConfigurationException("pool-name was not informed.");
			}

			sqlMan = SQLConnectionManager.getInstance(poolName);

			Element stmtsElement = DOMUtils.getElement(dbElement, "statement-names", true);
			NodeList nameList = DOMUtils.getElements(stmtsElement, "stament-name");
			int qt = nameList.getLength();
			for (int i = 0; i < qt; i++) {
				Element nameElement = (Element) nameList.item(i);
				String sqlName = DOMUtils.getAttribute(nameElement, "name", true);
				SQLStatement statement = sqlMan.getStatement(sqlName);
				stmtsMap.put(sqlName, statement);
			}
			log.info("Number of SQL Statements successfully loaded is:"	+ this.stmtsMap.size());
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	public String getAcctType(String queryName, String acctNbr) {
		SQLStatement query = (SQLStatement) this.stmtsMap.get(queryName);
		if (query == null) {
			log.error("Asking for statement named:" + queryName	+ ", but it does no exists.");
			return null;
		}
		long st = System.nanoTime();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List results = new ArrayList();
		StatsMapping stats = ProcessingStats.starting("DataBarnAccount");
		try {
			conn = sqlMan.getConnection();
			Object[] parameters = {acctNbr};
			ps = query.prepareStatement(conn, parameters);
			rs = ps.executeQuery();
			if (log.isDebugEnabled()) {
				log.debug("Running query:" + query.getStatementText());
			}
			while (rs.next()) {
				return rs.getString("ACCT_TYPE_CD");
			}
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			stats.finished();
			try {
				if (rs != null) { rs.close(); }
				if (ps != null) { ps.close(); }
				if (conn != null) {	conn.close(); }
				long et = System.nanoTime();
				log.debug("Acessing Databarn Time in milliseconds:"
						+ ((et - st) / 1000 / 1000) + " Result Set size of:"
						+ ((results == null) ? 0 : results.size())
						+ " for getting marketing promotions by access number");
			} catch (SQLException e) {
				log.error("Problems releasing resources for query.");
				e.printStackTrace();
			}
		}
		return null;
	}
	
}
