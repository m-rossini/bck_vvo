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
 * @(#)ImageBuilderStartupListener.java Apr 23, 2008
 */
package br.com.auster.vivo.billcheckout.listeners;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.naming.NamingException;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;

import br.com.auster.common.sql.SQLConnectionManager;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.dware.DataAware;
import br.com.auster.dware.StartupListener;
import br.com.auster.dware.graph.Request;
import br.com.auster.dware.request.file.FileRequest;

/**
 * The class <code>ImageBuilderStartupListener</code> it is responsible in
 * <p>
 * TODO To improve the commentaries.
 * </p>
 *
 * @author Anderson Parra
 * @version $Id$
 * @since JDK1.4
 */
public class ImageBuilderStartupListener implements StartupListener {

	private static final Logger log = Logger.getLogger(ImageBuilderStartupListener.class);

	public static final String PROCESSING_TYPE_PROP = "isc.image.format";
    public static final String PROCESSING_SESSION   = "isc.image.session";
    public static final String PROCESSING_TERMINAL  = "isc.image.terminal";
    public static final String DWARE_FORMAT_KEY     = "format";
    public static final String DWARE_SESSION_KEY    = "session";
    public static final String DWARE_TERMINAL_KEY   = "terminal";

//	private int startChar;
//	private int endChar;
	private String attrKey;

	public ImageBuilderStartupListener(Element _configuration) {
//		this.startChar = DOMUtils.getIntAttribute(_configuration, "start-char", true);
//		log.info("Start char defined as " + this.startChar);
//		this.endChar = DOMUtils.getIntAttribute(_configuration, "end-char", true);
//		log.info("End char defined as " + this.endChar);
		this.attrKey = DOMUtils.getAttribute(_configuration, "attribute-key", true);
		log.info("Attribute key defined as " + this.attrKey);
	}


	/**
	 * Will remove any rows in the image control table.
	 * <p>
	 * Example :
	 * <pre>
	 * Create a example.
	 * </pre>
	 * </p>
	 *
	 * @param _dware
	 * @param _configuration
	 * @see br.com.auster.dware.StartupListener#afterConfig(br.com.auster.dware.DataAware, org.w3c.dom.Element)
	 */
	public void afterConfig(DataAware _dware, Element _configuration) { }
	public void beforeConfig(DataAware arg0, Element arg1) { }


	public void afterEnqueue(DataAware arg0, Request arg1) { }
	public void afterEnqueue(DataAware arg0, Collection<Request> arg1) { }


	/**
	 * It responsible in
	 * <p>
	 * Example :
	 * <pre>
	 * Create a example.
	 * </pre>
	 * </p>
	 *
	 * @param _dware
	 * @param _requestList
	 * @return
	 * @see br.com.auster.dware.StartupListener#beforeEnqueue(br.com.auster.dware.DataAware, java.util.Collection)
	 */
	public boolean beforeEnqueue(DataAware _dware, Collection<Request> _requestList) {

		if (_requestList != null) {
			for (Request request : _requestList) {
				beforeEnqueue(_dware, request);
			}
		}
		return true;
	}
	
	/**
	 * It responsible in
	 * <p>
	 * Example :
	 * <pre>
	 * Create a example.
	 * </pre>
	 * </p>
	 *
	 * @param _dware
	 * @param _request
	 * @return
	 * @see br.com.auster.dware.StartupListener#beforeEnqueue(br.com.auster.dware.DataAware, br.com.auster.dware.graph.Request)
	 */
	public boolean beforeEnqueue(DataAware _dware, Request _request) {
		if (_request instanceof FileRequest) {
			FileRequest request = (FileRequest) _request;
			File f = request.getFile();
//			String cycle = new String( f.getName().substring(this.startChar, this.endChar) );
//			log.debug("Cycle code for file " + f + " is " + cycle);
//			request.getAttributes().put(this.attrKey, cycle);
			String cycle = f.getAbsoluteFile().getParentFile().getName();
			log.debug("Cycle code for file " + f + " is " + cycle);
			request.getAttributes().put(this.attrKey, cycle);
			
			String format = System.getProperty(PROCESSING_TYPE_PROP);
			log.debug("Using format " + format);
			if (format != null) {
				List formatList = new ArrayList();
				formatList.add(format);
				request.getAttributes().put(DWARE_FORMAT_KEY, formatList);
			}
			
			String session = System.getProperty(PROCESSING_SESSION);
			log.debug("Using session " + session);
			if (session != null) {
				request.getAttributes().put(DWARE_SESSION_KEY, session);
			}

			String terminal = System.getProperty(PROCESSING_TERMINAL);
			log.debug("Using terminal " + terminal);
			if (terminal != null) {
				request.getAttributes().put(DWARE_TERMINAL_KEY, terminal);
			}
		} else {
			return false;
		}
		return true;
	}
}
