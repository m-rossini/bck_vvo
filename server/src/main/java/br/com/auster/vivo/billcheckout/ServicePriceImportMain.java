/*
 * Copyright (c) 2004-2005 Auster Solutions do Brasil. All Rights Reserved.
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
 * Created on Sep 29, 2005
 */
package br.com.auster.vivo.billcheckout;

import java.io.IOException;
import java.io.InputStream;
import java.security.GeneralSecurityException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.cfg.Configuration;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.OptionBuilder;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;
import org.apache.commons.cli.PosixParser;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import br.com.auster.common.io.IOUtils;
import br.com.auster.common.log.LogFactory;
import br.com.auster.common.util.I18n;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.common.xml.sax.NIOInputSource;
import br.com.auster.om.pricing.PricingFacade;
import br.com.auster.om.reference.loader.HibernateLoaderBootstrapBase;
import br.com.auster.vivo.billcheckout.loader.ServicePriceContentHandler;

/**
 * @author framos
 * @version $Id: ServicePriceImportMain.java 1169 2007-02-15 23:47:33Z mtengelm $
 */
public class ServicePriceImportMain extends HibernateLoaderBootstrapBase {
	public static final String	ARGS_EFFECTIVE_DATE_LEVEL	   = "effect-date";
	public static final String	ARGS_EFFECTIVE_DATE_MNEMONIC	= "e";

	public static final String	ARGS_PRICING_CLASS_LEVEL	   = "pricing-class";
	public static final String	ARGS_PRICING_CLASS_MNEMONIC	 = "p";

	public static final String	ARGS_PRICING_CONF_LEVEL	     = "pricing-conf";
	public static final String	ARGS_PRICING_CONF_MNEMONIC	 = "r";

	private static I18n	       i18n	                         = I18n
	                                                             .getInstance(ServicePriceImportMain.class);

	static {
		try {
			LogFactory.configureLogSystem(DOMUtils.openDocument(ServicePriceImportMain.class.getResourceAsStream("import-tools.xml")));
		} catch (Exception ioe) {
			System.out.println(i18n.getString("loader.initError"));
			ioe.printStackTrace();
		}
		log = LogFactory.getLogger(ServicePriceImportMain.class);
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {

		ServicePriceImportMain main = new ServicePriceImportMain();

		// try {
		Options options = main.createOptions();
		// create the parser
		CommandLineParser parser = new PosixParser();
		CommandLine line = null;
		try {
			line = parser.parse(options, args);
		} catch (ParseException e) {
			log.fatal(errorHandler(1));
			e.printStackTrace();
			System.exit(1);
		}

		boolean encrypted = true;
		if (line.hasOption(ARGS_ENCRYPTED_CONFIGURATION_FILES_MNEMONIC)) {
			encrypted = (new Boolean(line.getOptionValue(ARGS_ENCRYPTED_CONFIGURATION_FILES_MNEMONIC)))
			    .booleanValue();
		}
		try {
			main.start(line);
		} catch (Exception e) {
			log.fatal(errorHandler(2));
			e.printStackTrace();
			System.exit(2);
		}
		Date effectiveDate = Calendar.getInstance().getTime();
		if (line.hasOption(ARGS_EFFECTIVE_DATE_MNEMONIC)) {
			SimpleDateFormat formatter = new SimpleDateFormat("dd-mm-yyyy");
			try {
				effectiveDate = formatter.parse(line.getOptionValue(ARGS_EFFECTIVE_DATE_MNEMONIC));
			} catch (java.text.ParseException e) {
				log.fatal(errorHandler(3));
				e.printStackTrace();
				System.exit(3);
			}
		}
		// configure pricing connection
		log.info(i18n.getString("loader.facadeClassImpl", line
		    .getOptionValue(ARGS_PRICING_CLASS_MNEMONIC)));
		PricingFacade pricing = null;
		try {
			pricing = (PricingFacade) Class.forName(line.getOptionValue(ARGS_PRICING_CLASS_MNEMONIC))
			    .newInstance();
		} catch (InstantiationException e) {
    	log.fatal(errorHandler(4));
      e.printStackTrace();
      System.exit(4);
		} catch (IllegalAccessException e) {
    	log.fatal(errorHandler(5));
      e.printStackTrace();
      System.exit(5);
		} catch (ClassNotFoundException e) {
    	log.fatal(errorHandler(6));
      e.printStackTrace();
      System.exit(6);
		}
		log.info(i18n.getString("loader.facadeConfFile", line
		    .getOptionValue(ARGS_PRICING_CONF_MNEMONIC)));
		pricing.configure(line.getOptionValue(ARGS_PRICING_CONF_MNEMONIC), encrypted);
		try {
			main.process(line.getOptionValue(ARGS_FILENAME_MNEMONIC), effectiveDate, pricing);
		} catch (HibernateException e) {
    	log.fatal(errorHandler(7));
      e.printStackTrace();
      System.exit(7);
		} catch (SAXException e) {
    	log.fatal(errorHandler(8));
      e.printStackTrace();
      System.exit(8);
		} catch (IOException e) {
    	log.fatal(errorHandler(9));
      e.printStackTrace();
      System.exit(9);
		}
		// } catch (Exception e) {
		// e.printStackTrace();
		// System.exit(1);
		// }
		System.exit(0);
	}

	protected static String errorHandler(int code) {
		return i18n.getString("loader." + Integer.toString(code)) ;
	}

	protected Options createOptions() {

		OptionBuilder.withArgName(ARGS_EFFECTIVE_DATE_LEVEL);
		OptionBuilder.hasArg();
		OptionBuilder.isRequired(false);
		OptionBuilder.withDescription(i18n.getString("loader.help.effectDate"));
		Option effectiveDate = OptionBuilder.create(ARGS_EFFECTIVE_DATE_MNEMONIC);

		OptionBuilder.withArgName(ARGS_PRICING_CLASS_LEVEL);
		OptionBuilder.hasArg();
		OptionBuilder.isRequired(true);
		OptionBuilder.withDescription(i18n.getString("loader.help.pricingClass"));
		Option pricingClass = OptionBuilder.create(ARGS_PRICING_CLASS_MNEMONIC);

		OptionBuilder.withArgName(ARGS_PRICING_CONF_LEVEL);
		OptionBuilder.hasArg();
		OptionBuilder.isRequired(true);
		OptionBuilder.withDescription(i18n.getString("loader.help.pricingConf"));
		Option pricingConf = OptionBuilder.create(ARGS_PRICING_CONF_MNEMONIC);

		Options options = super.createOptions();
		options.addOption(effectiveDate);
		options.addOption(pricingClass);
		options.addOption(pricingConf);

		return options;
	}

	public void process(String _inputFile, Date _effectiveDate, PricingFacade _pricing)
	    throws SAXException, HibernateException, IOException {
		ServicePriceContentHandler ch = null;
		Session session = null;
		try { 
			session = factory.openSession();
			ch = new ServicePriceContentHandler(session, createImportInfo(_inputFile), _pricing);
			ch.debugMode(isDebugMode());
			ch.setEffectiveDate(_effectiveDate);
			uddReader.setContentHandler(ch);
			uddReader.parse(new NIOInputSource(IOUtils.openFileForRead(_inputFile)));
		} catch (Exception e) {
			e.printStackTrace();
			try {
				if (ch != null) {
					ch.rollbackImport();
				}
			} catch (SAXException saxe) {
				throw saxe;
			}
		} finally {
			if ((session != null) && (session.isOpen())) {
				session.close();
			}
		}
	}

	protected void configureHibernate(String _hibernateFile, boolean _encrypted)
	    throws HibernateException {

		try {
			InputStream inStream = IOUtils.openFileForRead(_hibernateFile, _encrypted);
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			dbf.setNamespaceAware(true);
			dbf.setValidating(false);
			Document doc = dbf.newDocumentBuilder().parse(inStream);
 
			Configuration configuration = new Configuration();
			configuration.configure(doc);
			factory = configuration.buildSessionFactory();
		} catch (IOException ioe) {
			throw new HibernateException(ioe);
		} catch (SAXException saxe) {
			throw new HibernateException(saxe);
		} catch (ParserConfigurationException pce) {
			throw new HibernateException(pce);
		} catch (GeneralSecurityException gse) {
			throw new HibernateException(gse);
		}
	}
}
