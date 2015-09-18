/*
 * Copyright (c) 2004-2007 Auster Solutions. All Rights Reserved.
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
 * Created on 07/03/2007
 */
package br.com.auster.vivo.billcheckout.listeners;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.naming.NamingException;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;

import br.com.auster.billcheckout.exceptions.BillcheckoutRuntimeException;
import br.com.auster.common.sql.SQLConnectionManager;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.dware.manager.QueueProcessedListener;
import br.com.auster.vivo.billcheckout.util.BundleFileCreator;

/**
 * TODO What this class is responsible for
 * 
 * @author mtengelm
 * @version $Id$
 * @since 07/03/2007
 */
public class PVASampleQueueProcessedListener implements QueueProcessedListener {

	private static Logger					log													= Logger
																																.getLogger(PVASampleQueueProcessedListener.class);

	protected static final String	DB_ELEMENT									= "database";
	protected static final String	POOL_NAME_ATTR							= "pool-name";
	protected static final String	CONFIG_ELEMENT							= "config";

	private static final long			ERROR_UNABLE_TO_FINDPOOL		= 1;
	private static final long			ERROR_UPDATE_WEB_REQUEST		= 2;
	private static final long			ERROR_INSERT_WEB_BUNDLEFILE	= 3;
	private static final long			ERROR_GENERATING_BUNDLEFILE	= 4;

	protected static final int		FINISHED_OK									= 3;

	protected static final String	UPDATE_WEB_REQUEST					= "update web_request set END_DATE = ?, request_status = ? where request_id = ? ";

	protected static final String	INSERT_WEB_BUNDLEFILE				= " insert into web_bundlefile values"
																																+ "(BUNDLEFILE_SEQUENCE.nextval, ?, ?, ? , ?)";
	
	private static final String	PROP_PVA_MESSAGE	= "auster.pva.message";
	private static final String	DEFAULT_PVA_MESSAGE	= "Planilhas de PVA";

	private String								poolName;
	private SQLConnectionManager	sqlMan;

	/**
	 * //TODO why this methods was overriden, and what's the new expected
	 * behavior.
	 * 
	 * @param config
	 * @see br.com.auster.dware.manager.QueueProcessedListener#init(org.w3c.dom.Element)
	 */
	public void init(Element config) {
		try {
			configDatabase(config);
		} catch (NamingException e) {
			BillcheckoutRuntimeException ex = new BillcheckoutRuntimeException();
			ex.initCause(e);
			ex.setErrorCode(ERROR_UNABLE_TO_FINDPOOL);
			throw ex;
		}

	}

	/**
	 * TODO why this methods was overriden, and what's the new expected behavior.
	 * 
	 * @param transactionId
	 * @param size
	 * @see br.com.auster.dware.manager.QueueProcessedListener#onQueueProcessed(java.lang.String,
	 *      int)
	 */
	public void onQueueProcessed(String transactionId, int size) {
		log.info("Starting Queue Processed Listener. TransactionID:"
				+ transactionId + ".Requests:" + size);

		BundleFileCreator creator = new BundleFileCreator();
		File allFiles=null;
		try {
			allFiles = creator.getCompressedReports();
		} catch (IOException e) {
			BillcheckoutRuntimeException ex = new BillcheckoutRuntimeException(
					"Error generating file bundle.");
			ex.initCause(e);
			ex.setErrorCode(ERROR_GENERATING_BUNDLEFILE);
		}
		long tid = Long.parseLong(transactionId);
		createWebBundleFiles(tid, allFiles.getAbsolutePath());
		updateRequest(tid);
	}

	protected boolean createWebBundleFiles(long tid, String fileName) {

		boolean results = false;
		Connection conn = null;
		PreparedStatement st = null;
		ResultSet keys = null;

		String bundleMessage = System.getProperty(PROP_PVA_MESSAGE,DEFAULT_PVA_MESSAGE);
		try {
			conn = sqlMan.getConnection();
			String generatedColumns[] = { "FILE_ID" };
			st = conn.prepareStatement(INSERT_WEB_BUNDLEFILE, generatedColumns);

			st.setLong(1, tid);
			st.setString(2, fileName);
			Date date = new Date();
			st.setTimestamp(3, new Timestamp(date.getTime()));

			st.setString(4, bundleMessage);

			st.execute();
			keys = st.getGeneratedKeys();
			keys.next();
			log.info("Generated Bundle ID (File ID):" + keys.getLong(1) + " file:[" + fileName + "]");

			conn.commit();
			results = true;
		} catch (SQLException e) {
			BillcheckoutRuntimeException ex = new BillcheckoutRuntimeException(
					"Error Inserting into Bundle files table:" + poolName + " .SQL:"
							+ INSERT_WEB_BUNDLEFILE);
			ex.initCause(e);
			ex.setErrorCode(ERROR_INSERT_WEB_BUNDLEFILE);
			throw ex;
		} finally {
			try {
				if (keys != null) {
					keys.close();
				}
				if (st != null) {
					st.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				log.error("Error releasing database resources on WEB_REQUEST update.",
						e);
			}
		}

		return results;
	}

	protected boolean updateRequest(long tid) {
		boolean results = false;
		Connection conn = null;
		PreparedStatement st = null;
		try {
			conn = sqlMan.getConnection();
			st = conn.prepareStatement(UPDATE_WEB_REQUEST);
			Date date = new Date();
			st.setTimestamp(1, new Timestamp(date.getTime()));
			st.setInt(2, FINISHED_OK);
			st.setLong(3, tid);
			st.execute();
			conn.commit();
			results = true;
		} catch (SQLException e) {
			BillcheckoutRuntimeException ex = new BillcheckoutRuntimeException(
					"Error Updating Web Request table:" + poolName + " .SQL:"
							+ UPDATE_WEB_REQUEST);
			ex.initCause(e);
			ex.setErrorCode(ERROR_UPDATE_WEB_REQUEST);
			throw ex;
		} finally {
			try {
				if (st != null) {
					st.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				log.error("Error releasing database resources on WEB_REQUEST update.",
						e);
			}
		}
		return results;
	}

	protected void configDatabase(Element config) throws NamingException {
		Element configElmt = DOMUtils.getElement(config, CONFIG_ELEMENT, true);
		Element dbElement = DOMUtils.getElement(configElmt, DB_ELEMENT, true);
		if (null == dbElement) {
			return;
		}

		poolName = DOMUtils.getAttribute(dbElement, POOL_NAME_ATTR, true);
		if ((poolName == null) || (poolName.trim().length() == 0)) {
			throw new BillcheckoutRuntimeException("pool-name was not informed.");
		}

		sqlMan = SQLConnectionManager.getInstance(poolName);
	}
}
