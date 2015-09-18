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
 * Created on 23/04/2008
 */
package br.com.auster.vivo.billcheckout;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.naming.NamingException;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;

import br.com.auster.common.io.IOUtils;
import br.com.auster.common.sql.SQLConnectionManager;
import br.com.auster.common.util.I18n;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.vivo.billcheckout.image.CommandExecutor;
import br.com.auster.vivo.billcheckout.image.JMSReceiver;

/**
 * @author framos
 * @version $Id$
 *
 */
public class ImageBootstrap {


	private static final String DELETE_STATEMENT = "ImageBootstrap.delete";



	public static final int INVALID_CONFIGURATION = 1;
	public static final int BOOTSTRAP_EXCEPTION = 2;

	// All these attributes must be configured in the ROOT element
	//    of the XML configuration file
	public static final String CONF_QUEUE_SIZE = "queue-size";
	public static final String CONF_POOL_NAME = "pool-name";
	public static final String CONF_ISC_ANT_FILE = "ant-file";
	public static final String CONF_JNDI_PROPERTIES = "jndi-properties";
	public static final String CONF_QUEUE_FACTORY = "queue-factory";
	public static final String CONF_QUEUE_NAME = "queue-name";



	private static final Logger log = Logger.getLogger(ImageBootstrap.class);
	private static final I18n i18n = I18n.getInstance(ImageBootstrap.class);


	private int queueSize;
	private String antFile;
	private Properties jndiInfo;
	private String queueFactory;
	private String queueName;
	private String poolName;


	/**
	 * Constructor, but also configures the Bootstrap instance
	 *
	 * @param _configurationFile
	 * @throws Exception
	 */
	public ImageBootstrap(String _configurationFile) throws Exception {
		Element configuration = DOMUtils.openDocument(_configurationFile, false);
		// defining how many transformations will occurr in parallel
		this.queueSize = DOMUtils.getIntAttribute(configuration, CONF_QUEUE_SIZE, false);
		if (this.queueSize < 1) {
			this.queueSize = 1;
		}
		log.info(i18n.getString("image.queueSize", String.valueOf(this.queueSize)));
		// defining pool name
		this.poolName = DOMUtils.getAttribute(configuration, CONF_POOL_NAME, true);
		log.info(i18n.getString("image.poolName", this.poolName));
		// defining ISC transformation ANT file
		this.antFile = DOMUtils.getAttribute(configuration, CONF_ISC_ANT_FILE, true);
		log.info(i18n.getString("image.antFile", this.antFile));
		// defining incoming messages' queue factory
		this.queueFactory = DOMUtils.getAttribute(configuration, CONF_QUEUE_FACTORY, true);
		log.info(i18n.getString("image.queueFactory", this.queueFactory));
		// defining incoming messages' queue name
		this.queueName = DOMUtils.getAttribute(configuration, CONF_QUEUE_NAME, true);
		log.info(i18n.getString("image.queueName", this.queueName));
		// defining JNDI properties to connect to queue
		String jndiFile = DOMUtils.getAttribute(configuration, CONF_JNDI_PROPERTIES, true);
		log.info(i18n.getString("image.jndiFile", jndiFile));
		jndiInfo = new Properties();
		jndiInfo.load(IOUtils.openFileForRead(jndiFile));
		// starting up database pools
		SQLConnectionManager.init(configuration);
	}

	/**
	 * Prepares and starts as many threads, listening to the incoming queue, as defined
	 */
	public void start() throws Exception {
		ExecutorService executor = Executors.newFixedThreadPool(this.queueSize);
		CountDownLatch latch = new CountDownLatch(this.queueSize);
		log.debug("Created thread pool with size " + this.queueSize);
		// starting one thread for each parallel transformation
		for (int i=0; i < this.queueSize; i++) {
			JMSReceiver handler = new JMSReceiver( new CommandExecutor(this.antFile), this.jndiInfo, this.queueFactory, this.queueName, latch );
			executor.submit(handler);
		}
		log.info(i18n.getString("image.listening"));
		// should stop here forever, waiting for threads to finish!!!
		latch.await();
		executor.shutdown();
		log.info(i18n.getString("image.shutdown"));
	}

	protected void controlTableCleanup() {
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			SQLConnectionManager sqlConnManager = SQLConnectionManager.getInstance(this.poolName);
			if (sqlConnManager == null) {
				throw new IllegalArgumentException("Pool name " + this.poolName + " not properly configured");
			}
			conn = sqlConnManager.getConnection();
			String sqlStatement = sqlConnManager.getStatement(DELETE_STATEMENT).getStatementText();
			log.debug("Running statement " + sqlStatement);
			stmt = conn.prepareStatement(sqlStatement);
			log.debug("Removed all rows from table: " + stmt.execute());
			// commiting
			if (!conn.getAutoCommit()) {
				conn.commit();
			}
		} catch (NamingException ne) {
			log.error("Could not remove previous rows from control table", ne);
		} catch (SQLException sqle) {
			log.error("Could not remove previous rows from control table", sqle);
		} finally {
			try {
				if (stmt != null) { stmt.close(); }
				if (conn != null) { conn.close(); }
			} catch (SQLException sqle) {
				log.error("Could not remove previous rows from control table", sqle);
			}
		}
	}



	public static void main(String[] _args) {
		if (_args.length < 1) {
			log.fatal(i18n.getString("image.usage"));
			System.exit(INVALID_CONFIGURATION);
		}
		try {
			ImageBootstrap bootstrap = new ImageBootstrap(_args[0]);
			bootstrap.start();
		} catch (Exception e) {
			log.fatal(i18n.getString("image.bootException"), e);
			System.exit(BOOTSTRAP_EXCEPTION);
		}
	}

}
