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
 * Created on 17/10/2006
 */
package br.com.auster.billcheckout.param;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.naming.NamingException;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;
import org.xml.sax.SAXException;

import br.com.auster.common.sql.SQLConnectionManager;
import br.com.auster.common.sql.SQLStatement;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.om.reference.facade.ConfigurationException;
import br.com.auster.om.reference.facade.ReferenceFacades;

/**
 * @author mtengelm
 * 
 */
public class SQLEmitter implements ReferenceFacades {
	private static Logger	        log	           = Logger.getLogger(SQLEmitter.class);
	// TODO Adjust logging levels.
	protected static final String	DB_ELEMENT	   = "database";
	protected static final String	POOL_NAME_ATTR	= "pool-name";

	private String	              poolName;
//	private SQLConnectionManager	connectionManager;
//	private Connection connection;
//	private Connection	          connection;

	public SQLEmitter() {
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see br.com.auster.om.reference.facade.ReferenceFacades#configure(org.w3c.dom.Element)
	 */
	/***
	 * For this class, just gets the pool name and saves it.
	 * During normal use, one have to call getXXX methods for connection manager and connection.
	 * Tipically the user of this class will have to manually get and release connection (This is VERY important)
	 * Additionally, the prepared or any other kind of statements must also be manually created and released.
	 * In fact this class is just a very thin wrapper helper for Using SQL as Global Inside a Rule.
	 */
	public void configure(Element config) throws ConfigurationException {
		try {
			Element dbElement = DOMUtils.getElement(config, DB_ELEMENT, false);
			if (dbElement != null) {
				poolName = DOMUtils.getAttribute(dbElement, POOL_NAME_ATTR, true);
				if ((poolName == null) || (poolName.length() == 0)) {
					throw new ConfigurationException("pool-name was not informed.");
				}
			} else {
				throw new ConfigurationException("database configuration was not found.");
			}
		} catch (Exception e) {
			log.error("Problems during configuration for pool named:" + poolName + ".See below:");
			e.printStackTrace();
		}
	}

	public String getPoolName() {
		return this.poolName;
	}
	
	public SQLConnectionManager getConnectionManager() throws NamingException {
		log.debug("Trying to get a connection manager.");
		return SQLConnectionManager.getInstance(poolName);
	}
	
	public Connection getConnection() throws SQLException, NamingException {
		log.debug("Trying to get a connection from manager.");
		return getConnectionManager().getConnection();
	}
	
	public SQLStatement getSQLStatement(String name) throws NamingException {
		log.debug("Trying to get a statement named:" + name);
		return getConnectionManager().getStatement(name);
	}
	
	public PreparedStatement getPreparedStatement(Connection conn, String name, Object[] parms) throws IllegalArgumentException, SQLException, NamingException {
		log.debug("Trying to get a prepared statement.Name:" + name);
		if (log.isTraceEnabled()) {
			for (int i=0; i < parms.length;i++) {
				log.trace("Query Parameter #" + i + ".Value:" + parms[i]);
			}			
		}
		return getSQLStatement(name).prepareStatement(conn, parms);		
	}
//	public ResultSet runSQL(String stmtName, Object[] parms) throws IllegalArgumentException,
//	    SQLException {
//		log.info("Running named sql[" + stmtName + "]");
//		if (log.isDebugEnabled()) {
//			for (int i = 0; i < parms.length; i++) {
//				log.debug("Parm #" + i + " is:" + parms[i]);
//			}
//		}
//		
//		SQLStatement stmt = this.connectionManager.getStatement(stmtName);
//		if (stmt == null) {
//			log.error("No stataments named [" + stmtName + "] found.");
//			return null;
//		}
//
//		long s = System.nanoTime();
//		ResultSet resultSet = stmt. (connection, parms);
//		long e = System.nanoTime();
//		log.info("Total time for querying database was [" + ((e - s) / 1000 / 1000)
//		    + "] milliseconds.");
//		
//		//connection.close();
//		return resultSet;
//	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see br.com.auster.om.reference.facade.ReferenceFacades#configure(java.lang.String)
	 */
	public void configure(String _configurationFile) throws ConfigurationException {
		this.configure(_configurationFile, true);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see br.com.auster.om.reference.facade.ReferenceFacades#configure(java.lang.String,
	 *      boolean)
	 */
	public void configure(String _configurationFile, boolean _encrypted)
	    throws ConfigurationException {
		try {
			this.configure(DOMUtils.openDocument(_configurationFile, _encrypted));
		} catch (ParserConfigurationException e) {
			throw new ConfigurationException(e);
		} catch (SAXException e) {
			throw new ConfigurationException(e);
		} catch (IOException e) {
			throw new ConfigurationException(e);
		} catch (GeneralSecurityException e) {
			throw new ConfigurationException(e);
		}
	}

}
