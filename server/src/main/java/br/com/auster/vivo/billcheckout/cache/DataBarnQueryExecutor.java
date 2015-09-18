/*
 * Copyright (c) 2008 Auster Solutions. All Rights Reserved. THIS SOFTWARE
 * IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 * THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * Created on 19/02/2008
 * 
 * @author anardo
 */

package br.com.auster.vivo.billcheckout.cache;

import java.util.Map;
import java.util.HashMap;
import java.util.Map.Entry;
import java.sql.ResultSet;
import java.sql.Connection;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import java.sql.SQLException;
import org.apache.log4j.Logger;
import java.sql.PreparedStatement;
import javax.naming.NamingException;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.common.sql.SQLStatement;
import br.com.auster.common.sql.SQLConnectionManager;
import br.com.auster.om.reference.facade.ConfigurationException;

public class DataBarnQueryExecutor {
	
	private static Logger log = Logger
			.getLogger(DataBarnQueryExecutor.class);

	private Map<String, SQLStatement> stmtsMap = new HashMap<String, SQLStatement>();
	private SQLConnectionManager sqlMan;

	private Connection connection;

	private PreparedStatement statement;

	private ResultSet resultSet;

	public DataBarnQueryExecutor() {
	}

	/**
	 * Creates a new instance of the class <code>DataBarnQueryExecutor</code>,
	 * cloning another <code>DataBarnQueryExecutor</code>.
	 * @param other the instance to be cloned
	 */
	public DataBarnQueryExecutor(DataBarnQueryExecutor other) {
		this.sqlMan = other.sqlMan;
		for (Entry<String, SQLStatement> stmt : other.stmtsMap.entrySet()) {
			this.stmtsMap.put(stmt.getKey(), stmt.getValue());
		}
	}

	public void configure(Element config) {
		try {
			Element dbElement = DOMUtils.getElement(config, "database", true);

			String poolName = DOMUtils.getAttribute(dbElement, "pool-name",
					true);
			if ((poolName == null) || (poolName.trim().length() == 0)) {
				throw new ConfigurationException("pool-name was not informed.");
			}

			sqlMan = SQLConnectionManager.getInstance(poolName);

			Element stmtsElement = DOMUtils.getElement(dbElement,
					"statement-names", true);
			NodeList nameList = DOMUtils.getElements(stmtsElement,
					"stament-name");
			int qt = nameList.getLength();
			for (int i = 0; i < qt; i++) {
				Element nameElement = (Element) nameList.item(i);
				String sqlName = DOMUtils.getAttribute(nameElement, "name",
						true);
				SQLStatement statement = sqlMan.getStatement(sqlName);
				stmtsMap.put(sqlName, statement);
			}
			log.info("Number of SQL Statements successfully loaded is:"
					+ this.stmtsMap.size());
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	public PreparedStatement getPreparedStatement(String queryName) {
		connection = null;
		statement = null;
		resultSet = null;
		try {
			SQLStatement query = getStatement(queryName);
			String sql = query.getStatementText();
			connection = sqlMan.getConnection();
			statement = connection.prepareStatement(sql);
			return statement;
		} catch (SQLException e) {
			log.error("Error running query in getPreparedStatement", e);
			throw new RuntimeException("Error running query in getPreparedStatement", e);
		}
	}

	/**
	 * Recebe o nome da query configurado em data-barn-sql.xml e executa-a, retornando o ResultSet.
	 *  
	 * @param queryName o nome da query
	 * @param parameters os parâmetros da consulta
	 * @return o resultado
	 */
	public ResultSet getResultSet(String queryName,	Object... parameters) {
		SQLStatement query = getStatement(queryName);
		connection = null;
		statement = null;
		resultSet = null;
		try {
			connection = sqlMan.getConnection();
			if (log.isDebugEnabled()) {
				log.debug("Running query:" + queryName);
			}
			statement = query.prepareStatement(connection, parameters);
			resultSet = statement.executeQuery();
			return resultSet;
		} catch (IllegalArgumentException e) {
			// TODO trata a excecao em vez de imprimir
			log.error("Error running query in getResultSet",e);
			throw e;
		} catch (SQLException e) {
			// TODO trata a excecao em vez de imprimir
			log.error("Error running query in getResultSet",e);
			throw new RuntimeException("Error running query in getResultSet",e);
		}
	}

	private SQLStatement getStatement(String queryName) {
		SQLStatement query = this.stmtsMap.get(queryName);
		if (query == null) {
			log.error("Asking for statement named:" + queryName
					+ ", but it does no exist.");
			throw new IllegalArgumentException("Asking for statement named:" + queryName
					+ ", but it does no exist.");
		}
		return query;
	}

	/**
	 * Fecha ResultSet, Statement e Connection desta classe.
	 * TODO renomear essa classe, pois ela não fecha somente o ResultSet
	 */
	public void closeResultSet() {
		try {
			if (resultSet != null) {
				resultSet.close();
				resultSet = null;
			}
			if (statement != null) {
				statement.close();
				statement = null;
			}
			if (connection != null) {
				connection.close();
				connection = null;
			}
		} catch (SQLException e) {
			log.error("Error closing connections",e);
			e.printStackTrace();
		}
	}

	public SQLConnectionManager getSqlMananager() {
		return sqlMan;
	}
}
