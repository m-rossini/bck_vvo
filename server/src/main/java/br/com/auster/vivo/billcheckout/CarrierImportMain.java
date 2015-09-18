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

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.hibernate.HibernateException;
import org.hibernate.cfg.Configuration;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.OptionBuilder;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.PosixParser;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import br.com.auster.common.io.IOUtils;
import br.com.auster.common.log.LogFactory;
import br.com.auster.common.util.I18n;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.common.xml.sax.NIOInputSource;
import br.com.auster.om.reference.facade.CarrierFacade;
import br.com.auster.om.reference.loader.HibernateLoaderBootstrapBase;
import br.com.auster.udd.reader.TaggedFileReader;
import br.com.auster.vivo.billcheckout.loader.CarrierContentHandler;

/**
 * @author framos
 * @version $Id: ServicePriceImportMain.java 354 2005-12-02 13:19:29Z framos $
 */
public class CarrierImportMain extends HibernateLoaderBootstrapBase {

	
	public static final String ARGS_CARRIER_CLASS_LEVEL = "carrier-class";
	public static final String ARGS_CARRIER_CLASS_MNEMONIC = "p";

	public static final String ARGS_CARRIER_CONF_LEVEL = "carrier-conf";
	public static final String ARGS_CARRIER_CONF_MNEMONIC = "r";
	
	private static I18n i18n = I18n.getInstance(CarrierImportMain.class);
	
	
	
	static {
		try {
			LogFactory.configureLogSystem(DOMUtils.openDocument(CarrierImportMain.class.getResourceAsStream("import-tools.xml")));
		} catch (Exception ioe) {
			System.out.println(i18n.getString("loader.initError"));
			ioe.printStackTrace();
		}
		log = LogFactory.getLogger(CarrierImportMain.class);
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {

		CarrierImportMain main = new CarrierImportMain(); 

		try {
	        Options options = main.createOptions();
	        // create the parser
	        CommandLineParser parser = new PosixParser();
			CommandLine line = parser.parse( options, args );
			
			main.start(line);
            // configure pricing connection            
			log.info(i18n.getString("loader.facadeClassImpl",line.getOptionValue(ARGS_CARRIER_CLASS_MNEMONIC)));
    		CarrierFacade carrier = (CarrierFacade) Class.forName(line.getOptionValue(ARGS_CARRIER_CLASS_MNEMONIC)).newInstance();
			log.info(i18n.getString("loader.facadeConfFile",line.getOptionValue(ARGS_CARRIER_CONF_MNEMONIC)));
    		carrier.configure(line.getOptionValue(ARGS_CARRIER_CONF_MNEMONIC), 
    				          line.hasOption(ARGS_ENCRYPTED_CONFIGURATION_FILES_MNEMONIC));
    		
			main.process(line.getOptionValue(ARGS_FILENAME_MNEMONIC), carrier);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(1);
		}
		
	}
	
	protected Options createOptions() {
		
		OptionBuilder.withArgName(ARGS_CARRIER_CLASS_LEVEL);
		OptionBuilder.hasArg();
		OptionBuilder.isRequired(true);
		OptionBuilder.withDescription(i18n.getString("loader.help.carrierClass"));
		Option carrierClass = OptionBuilder.create(ARGS_CARRIER_CLASS_MNEMONIC);

		OptionBuilder.withArgName(ARGS_CARRIER_CONF_LEVEL);
		OptionBuilder.hasArg();
		OptionBuilder.isRequired(true);
		OptionBuilder.withDescription(i18n.getString("loader.help.carrierConf"));
		Option carrierConf = OptionBuilder.create(ARGS_CARRIER_CONF_MNEMONIC);

		
		Options options = super.createOptions();
		options.addOption(carrierClass);
		options.addOption(carrierConf);
		
		return options;
	}
	
	public void process(String _inputFile, CarrierFacade _carrier) throws SAXException, IOException {
		CarrierContentHandler ch = null;
		try {
			ch = new CarrierContentHandler(factory.openSession(), createImportInfo(_inputFile), _carrier);
			ch.debugMode(isDebugMode());
			uddReader.setContentHandler(ch);			
			uddReader.parse( new NIOInputSource(IOUtils.openFileForRead(_inputFile)) );
		} catch (Exception e) {
			e.printStackTrace();
			try {
				if (ch != null) { 
					ch.rollbackImport(); 
					}
			} catch (SAXException saxe) {
				throw saxe;
			}
		}
	}
	
	protected void configureUDD(String _uddFile, boolean _encrypted) throws ParserConfigurationException, SAXException, IOException, GeneralSecurityException {
		uddReader = new TaggedFileReader(DOMUtils.openDocument(_uddFile, _encrypted));
	}
	
	
	protected void configureHibernate(String _hibernateFile, boolean _encrypted) throws HibernateException {

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
