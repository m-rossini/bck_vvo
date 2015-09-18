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
 * @(#)JMSReceiver.java Apr 23, 2008
 */
package br.com.auster.vivo.billcheckout.image;

import java.util.Hashtable;

import javax.jms.MapMessage;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueSender;
import javax.jms.QueueSession;
import javax.jms.Session;
import javax.naming.Context;
import javax.naming.InitialContext;

import br.com.auster.common.io.IOUtils;



/**
 * The class <code>JMSReceiver</code> it is responsible in
 * <p>
 * TODO To improve the commentaries.
 * </p>
 *
 * @author Anderson Parra
 * @version $Id$
 * @since JDK1.4
 */
public class JMSSender {



	public static final String KEY_INPUT_FILE     = "input_file";
	public static final String KEY_ACCOUNT_NUMBER = "account_number";


	protected Hashtable jndiLookup;
	protected String queueFactory;
	protected String queueName;



	public JMSSender(Hashtable _jndiInfo, String _queueFactory, String _queueName) {
		this.jndiLookup = _jndiInfo;
		this.queueFactory = _queueFactory;
		this.queueName = _queueName;
	}


	/**
	 * Handles all incoming messages from the pre-defined queue.
	 *
	 * @param _message
	 * @see javax.jms.MessageListener#onMessage(javax.jms.Message)
	 */
	public void sendMessage() {
		try {
			Context jndiContext = new InitialContext(jndiLookup);
			QueueConnectionFactory factory = (QueueConnectionFactory) jndiContext.lookup(this.queueFactory);
			Queue queue = (Queue) jndiContext.lookup(this.queueName);
			QueueConnection queueConnection = factory.createQueueConnection();
			queueConnection.start();
			QueueSession queueSession = queueConnection.createQueueSession(false, Session.AUTO_ACKNOWLEDGE);
			QueueSender sender = queueSession.createSender(queue);

			MapMessage message = queueSession.createMapMessage();
			message.setString(KEY_INPUT_FILE, "SIRS63112007.0284.GZ");
			message.setString(KEY_ACCOUNT_NUMBER, "0110018379");

			sender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}


	public static void main(String[] args) {
		try {
			java.util.Properties prop = new java.util.Properties();
			prop.load(IOUtils.openFileForRead("src/main/conf/jms/asr1/jms-config.properties"));
			(new JMSSender(prop, "billcheckout.QueueConnectionFactory", "queue/buildInvoiceImage")).sendMessage();
		} catch (Exception e) { e.printStackTrace(); }
	}

}
