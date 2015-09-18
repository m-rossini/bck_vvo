/*
 *
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
 * Created on Apr 23, 2008
 *
 * @(#)ImageBuilderFinishListener.java Apr 23, 2008
 */
package br.com.auster.vivo.billcheckout.listeners;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Collection;
import java.util.Date;
import java.util.Map;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;

import br.com.auster.common.sql.SQLConnectionManager;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.dware.graph.FinishListener;
import br.com.auster.dware.graph.Graph;
import br.com.auster.dware.graph.Request;
import br.com.auster.vivo.billcheckout.image.ImageCutter;
import br.com.auster.vivo.billcheckout.image.InvoicedPage;

/**
 * @author Anderson Parra
 * @version $Id$
 * @since JDK1.4
 */
public class ImageBuilderFinishListener implements FinishListener {

	private static final String KEY_CYCLE = "cycle";
	private static final String KEY_DUE_DATE = "dueDate";
	private static final String KEY_ACCOUNT = "account";

	private static final Logger log = Logger.getLogger(ImageBuilderFinishListener.class);
	
	private static final String DELETE_STATEMENT = "ImageBuilderFinishListener.delete";
	
	private String poolName;
	private String pathName;
	
	public ImageBuilderFinishListener(Element _configuration) {
		this.poolName = DOMUtils.getAttribute(_configuration, "pool-name", true);
		log.info("ImageBuilder listener configured for pool " + this.poolName);
		this.pathName = DOMUtils.getAttribute(_configuration, "output-dir", true);
		log.info("ImageBuilder listener configured for output dir " + this.pathName);
	}
	
	public void graphCommiting(Graph arg0, Request arg1) throws Exception {	}

	public void graphRollingBack(Graph arg0, Request arg1, Throwable arg2) throws Exception { }

	/**
	 * It responsible in finish request.
	 * 
	 * @param _graph
	 * @param _request
	 * @param _exception
	 * @param _finishDate
	 * @throws Exception
	 * @see br.com.auster.dware.graph.FinishListener#graphFinished(br.com.auster.dware.graph.Graph, br.com.auster.dware.graph.Request, java.lang.Throwable, java.util.Date)
	 */
	public void graphFinished(Graph _graph, Request _request, Throwable _exception, Date _finishDate) throws Exception {
		String account = (String) _request.getAttributes().get(KEY_ACCOUNT);
		String dueDate = (String) _request.getAttributes().get(KEY_DUE_DATE);
		String cycle   = (String) _request.getAttributes().get(KEY_CYCLE);

		// corta somente arquivos com formato HTML
		if (_request.getAttributes().containsKey(ImageBuilderStartupListener.DWARE_FORMAT_KEY) && 
			((Collection) _request.getAttributes().get(ImageBuilderStartupListener.DWARE_FORMAT_KEY)).contains("HTML")) 
		{
			log.debug("Request HTML redirect for cutter file.");
			Collection collection = ((Map) _request.getAttributes().get("generatedFiles")).values();
			fileCutter((String) collection.iterator().next(), cycle, dueDate, account);
		}

		SQLConnectionManager sqlConnManager = SQLConnectionManager.getInstance(this.poolName);
		if (sqlConnManager == null) {
			throw new IllegalArgumentException("Pool name " + this.poolName	+ " not properly configured");
		}
		
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = sqlConnManager.getConnection();
			String sqlStatement = sqlConnManager.getStatement(DELETE_STATEMENT).getStatementText();
			log.debug("Running statement " + sqlStatement);
			stmt = conn.prepareStatement(sqlStatement);
			// account Id
			stmt.setString(1, account);
			// due date
			stmt.setString(2, dueDate);
			log.debug("Removed control row for account " + account + " and dueDate " + dueDate + ":" + stmt.execute());
			// commiting
			if (!conn.getAutoCommit()) {
				conn.commit();
			}
		} finally {
			if (stmt != null) {stmt.close();}
			if (conn != null) {conn.close();}
		}
	}

	/**
	 * 
	 * @param fileName
	 * @param cycle
	 * @param dueDate
	 * @param account
	 * @throws Exception
	 */
	protected final void fileCutter(String fileName, String cycle, String dueDate, String account) throws Exception {
		if (fileName != null) {
			File file = new File(fileName);
		
			if (file.exists()) {
				ImageCutter imageCutter = new ImageCutter(file);
				InvoicedPage invoicedPage = new InvoicedPage(this.pathName +"/"+ cycle +"/"+ dueDate +"/"+ account +"/"+ account);

				log.debug("Path file: " + file.getPath());
				
				imageCutter.start();
				invoicedPage.start();
			
				log.debug("Cutter file: " + fileName);
			
				imageCutter.join();
				invoicedPage.join();
				
				log.debug("Remove file: " + fileName);
				file.delete();
			}	
		}
	}
}
