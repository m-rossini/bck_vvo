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

import java.io.IOException;
import java.util.Hashtable;
import java.util.LinkedList;
import java.util.concurrent.CountDownLatch;

import javax.jms.JMSException;
import javax.jms.MapMessage;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.MessageListener;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueSession;
import javax.jms.Session;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import org.apache.log4j.Logger;

import br.com.auster.common.util.I18n;



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
public class JMSReceiver implements Runnable, MessageListener {

	private static final Logger log = Logger.getLogger(JMSReceiver.class);
	private static final I18n i18n = I18n.getInstance(JMSReceiver.class);

	public static final String KEY_TERMINAL_NUMBER = "terminal_number";
	public static final String KEY_SESSION_NAME    = "session_name";
	public static final String KEY_PROCESSING_TYPE = "processing_type";
	public static final String KEY_INPUT_FILE      = "input_file";
	public static final String KEY_ACCOUNT_NUMBER  = "account_number";

	protected CommandExecutor executor;
	protected Hashtable jndiLookup;
	protected String queueFactory;
	protected String queueName;
	protected CountDownLatch latch;

	public JMSReceiver(CommandExecutor _executor, Hashtable _jndiInfo, String _queueFactory, String _queueName, CountDownLatch _latch) {
		this.executor = _executor;
		this.jndiLookup = _jndiInfo;
		this.queueFactory = _queueFactory;
		this.queueName = _queueName;
		this.latch = _latch;
	}

	/**
	 * Handles all incoming messages from the pre-defined queue.
	 *
	 * @param _message
	 * @see javax.jms.MessageListener#onMessage(javax.jms.Message)
	 */
	public void onMessage(Message _message) {
		try {
			if (_message instanceof MapMessage) {
				MapMessage message = (MapMessage) _message;

				String filename = message.getString(KEY_INPUT_FILE);
				String accountNumber  = message.getString(KEY_ACCOUNT_NUMBER);
				String processinType  = message.getString(KEY_PROCESSING_TYPE);
                String sessionName    = message.getString(KEY_SESSION_NAME);
                String terminalNumber = message.getString(KEY_TERMINAL_NUMBER);
				
				LinkedList<String> parameters = new LinkedList<String>();
				parameters.add( "-D" + KEY_INPUT_FILE + "=" + filename);
				parameters.add( "-D" + KEY_ACCOUNT_NUMBER + "=" + accountNumber);
				parameters.add( "-D" + KEY_PROCESSING_TYPE + "=" + processinType);
				parameters.add( "-D" + KEY_SESSION_NAME + "=" + sessionName);
				parameters.add( "-D" + KEY_TERMINAL_NUMBER + "=" + terminalNumber);
				parameters.add( "-Dbasedir=" + System.getProperty("user.dir") );

				Process proc = executor.execute(parameters);
				int exitValue = proc.waitFor();
				log.debug( "Transformation resulted " + exitValue + " for file " + filename + " and account " + accountNumber);
			}
		} catch (JMSException jmse) {
			log.error(i18n.getString("receiver.jmsException"), jmse);
		} catch (InterruptedException ie) {
			log.error(i18n.getString("receiver.intException"), ie);
		} catch (IOException ioe) {
			log.error(i18n.getString("receiver.ioException"), ioe);
		}
	}

	/**
	 * Starts listening to queue
	 */
	public void run() {
		try {
			Context jndiContext = new InitialContext(jndiLookup);
			QueueConnectionFactory factory = (QueueConnectionFactory) jndiContext.lookup(this.queueFactory);
			log.debug("JMS factory connected at " + this.queueFactory);
			Queue queue = (Queue) jndiContext.lookup(this.queueName);
			log.debug("Initializing JMS queue " + this.queueName);
			QueueConnection queueConnection = factory.createQueueConnection();
			queueConnection.start();
			QueueSession queueSession = queueConnection.createQueueSession(false, Session.AUTO_ACKNOWLEDGE);
			MessageConsumer receiver = queueSession.createConsumer(queue);
			log.info(i18n.getString("receiver.listening"));
			while (true) {
				this.onMessage( receiver.receive() );
			}
		} catch (NamingException ne) {
			log.error("", ne);
		} catch (JMSException jmse) {
			log.error(i18n.getString("receiver.jmsException"), jmse);
		}
		// notifying parent that this thread has finished
		latch.countDown();
	}

}
