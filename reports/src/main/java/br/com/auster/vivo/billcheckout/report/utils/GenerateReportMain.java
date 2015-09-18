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
 * Created on 11/04/2007
 */
package br.com.auster.vivo.billcheckout.report.utils;

import java.util.Date;
import java.util.Properties;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.DeliveryMode;
import javax.jms.JMSException;
import javax.jms.MessageProducer;
import javax.jms.ObjectMessage;
import javax.jms.Session;
import javax.jms.Topic;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import org.apache.log4j.Logger;

import br.com.auster.minerva.billcheckout.report.BillcheckoutRequest;
import br.com.auster.minerva.spi.ReportRequest;

/**
 * TODO What this class is responsible for
 * 
 * @author mtengelm
 * @version $Id$
 * @since 11/04/2007
 */
public class GenerateReportMain {
	private static Logger log = Logger.getLogger(GenerateReportMain.class);
	
	private static final String	REPORT_TOPIC_NAME	= "topic/reportTopic";

	/**
	 * TODO what this method is responsible for
	 * <p>
	 * Example:
	 * 
	 * <pre>
	 *    Create a use example.
	 * </pre>
	 * 
	 * </p>
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
//		System.setProperty("org.omg.CORBA.ORBClass","com.sun.corba.se.impl.orb.ORBImpl");
//		System.setProperty("javax.rmi.CORBA.UtilClass","com.sun.corba.se.impl.javax.rmi.CORBA.Util");
//		System.setProperty("javax.rmi.CORBA.StubClass","com.sun.corba.se.impl.javax.rmi.CORBA.StubDelegateImpl");
//		System.setProperty("javax.rmi.CORBA.PortableRemoteObjectClass","com.sun.corba.se.impl.javax.rmi.PortableRemoteObject");
//		System.setProperty("org.omg.CORBA.ORBSingletonClass","com.sun.corba.se.impl.orb.ORBSingleton");
		
		GenerateReportMain report = new GenerateReportMain();
		if (args.length != 5) {
			for (int i=0; i < args.length ; i++) {
				System.out.println("Parametro " + i + ":[" + args[i] + "]");
			}
			printUsage();
			System.exit(1);
		}
		report.setArgs(args);
		try {
			report.generate();
		} catch (NamingException e) {			
			e.printStackTrace();
			System.exit(2);
		} catch (JMSException e) {
			e.printStackTrace();
			System.exit(3);
		} 
	}

	/**
	 * TODO what this method is responsible for
	 * <p>
	 * Example:
	 * <pre>
	 *    Create a use example.
	 * </pre>
	 * </p>
	 * 
	 */
	private static void printUsage() {
		System.out.println("Wrong parameters informed. The command line is like below:");
		System.out.println("GenerateReportMain <ConnectionFactory> <NamingProviderURL> <ConnectionFactoryName> <Transaction-id> <ReportName>");
		System.out.println("GenerateReportMain weblogic.jndi.WLInitialContextFactory t3://10.128.200.165:8080 billcheckout.QueueConnectionFactory 140 billcheckout-portal");
	}

	private String	reportName;
	private String	connectionFactoryName;
	private String	topicName;
	private String	initialContextFactory;
	private String	namingProviderURL;
	private long transactionId;

	/**
	 * TODO what this method is responsible for
	 * <p>
	 * Example:
	 * 
	 * <pre>
	 *    Create a use example.
	 * </pre>
	 * 
	 * </p>
	 * @throws NamingException 
	 * @throws JMSException 
	 * 
	 */
	protected void generate() throws NamingException, JMSException {
		BillcheckoutRequest request = new BillcheckoutRequest(this.getReportName());
		request.setGenerationTime((new Date()).getTime());
		request.setTransactionId(Long.toString(this.getTransactionId()));
		request.getAttributes().put(ReportRequest.ATTR_BYPASS_DUP_CHECK, new Boolean(true));

		Properties props = new Properties();
		props.put("java.naming.factory.initial",this.getInitialContextFactory());
		props.put("java.naming.provider.url", this.getNamingProviderURL());
		Context ctx = new InitialContext(props);
		
		ConnectionFactory cf = (ConnectionFactory) ctx.lookup(this.getConnectionFactoryName());
		Topic topic = (Topic) ctx.lookup(this.getTopicName());
		
		Connection conn = cf.createConnection();
		Session session = conn.createSession(false, Session.CLIENT_ACKNOWLEDGE);
		
		MessageProducer producer = session.createProducer(topic);
		producer.setDeliveryMode(DeliveryMode.NON_PERSISTENT);
		producer.setPriority(9);
		
		ObjectMessage msg = session.createObjectMessage();
		msg.setObject(request);
		producer.send(msg);
		
		System.out.println("Message successfully sent to:" + this.getTopicName() + 
				" at " + this.getNamingProviderURL() +
				" with TID:" + this.getTransactionId());
		producer.close();
		session.close();
		conn.close();
		ctx.close();
	}

	/**
	 * TODO what this method is responsible for
	 * <p>
	 * Example:
	 * <pre>
	 *    Create a use example.
	 * </pre>
	 * </p>
	 * 
	 * @return
	 */
	public String getNamingProviderURL() {
		return this.namingProviderURL;
	}

	public void setNamingProviderURL(String namingProviderURL) {
		this.namingProviderURL = namingProviderURL;
	}
	/**
	 * TODO what this method is responsible for
	 * <p>
	 * Example:
	 * <pre>
	 *    Create a use example.
	 * </pre>
	 * </p>
	 * 
	 * @return
	 */
	public String getInitialContextFactory() {		
		return this.initialContextFactory;
	}

	public void setInitialContextFactory(String initialContextFactory) {		
		this.initialContextFactory = initialContextFactory;
	}
	/**
	 * TODO what this method is responsible for
	 * <p>
	 * Example:
	 * <pre>
	 *    Create a use example.
	 * </pre>
	 * </p>
	 * 
	 * @return
	 */
	public String getTopicName() {
		return this.topicName;
	}

	/**
	 * TODO what this method is responsible for
	 * <p>
	 * Example:
	 * <pre>
	 *    Create a use example.
	 * </pre>
	 * </p>
	 * 
	 * @return
	 */
	public String getConnectionFactoryName() {
		return this.connectionFactoryName;
	}

	/**
	 * TODO what this method is responsible for
	 * <p>
	 * Example:
	 * 
	 * <pre>
	 *    Create a use example.
	 * </pre>
	 * 
	 * </p>
	 * 
	 * @return
	 */
	public String getReportName() {
		return this.reportName;
	}

	/**
	 * TODO what this method is responsible for
	 * <p>
	 * Example:
	 * 
	 * <pre>
	 *    Create a use example.
	 * </pre>
	 * 
	 * </p>
	 * 
	 * @param args
	 */
	protected void setArgs(String[] args) {
		this.setInitialContextFactory(args[0]);
		this.setNamingProviderURL(args[1]);
		this.setConnectionFactoryName(args[2]);
		this.setTopicName(REPORT_TOPIC_NAME);
		this.setTransactionId(Long.parseLong(args[3]));
		this.setReportName(args[4]);
	}

	
	/**
	 * Set the value of attribute <code>connectionFactoryName</code>.
	 * @param string
	 */
	public void setConnectionFactoryName(String string) {
		this.connectionFactoryName = string;
	}

	
	/**
	 * Set the value of attribute <code>reportName</code>.
	 * @param reportName
	 */
	public void setReportName(String reportName) {
		this.reportName = reportName;
	}

	
	/**
	 * Set the value of attribute <code>topicName</code>.
	 * @param topicName
	 */
	public void setTopicName(String topicName) {
		this.topicName = topicName;
	}

	
	/**
	 * Return the value of a attribute <code>transactionId</code>.
	 * @return return the value of <code>transactionId</code>.
	 */
	public long getTransactionId() {
		return this.transactionId;
	}

	
	/**
	 * Set the value of attribute <code>transactionId</code>.
	 * @param transactionId
	 */
	public void setTransactionId(long transactionId) {
		this.transactionId = transactionId;
	}

}
