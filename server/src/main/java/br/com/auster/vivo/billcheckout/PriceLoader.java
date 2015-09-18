/*
 * Copyright (c) 2004 Auster Solutions. All Rights Reserved.
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
 * Created on 10/02/2007
 */
package br.com.auster.vivo.billcheckout;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import javax.xml.parsers.ParserConfigurationException;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.OptionBuilder;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;
import org.apache.commons.cli.PosixParser;
import org.apache.log4j.Logger;
import org.xml.sax.SAXException;

import br.com.auster.common.log.LogFactory;
import br.com.auster.common.util.I18n;
import br.com.auster.common.xml.DOMUtils;

/**
 * @author mtengelm
 * 
 */
public class PriceLoader {
	private static Logger log;	
	private static I18n	i18n	= I18n.getInstance(PriceLoader.class);

	public static final String	ARGS_EFFECTIVE_DATE_LEVEL	   = "effect-date";
	public static final String	ARGS_EFFECTIVE_DATE_MNEMONIC	= "e";

	public static final String	ARGS_PRICING_CLASS_LEVEL	   = "pricing-class";
	public static final String	ARGS_PRICING_CLASS_MNEMONIC	 = "c";

	public static final String	ARGS_SQL_CONF_LEVEL	     = "sql-configuration";
	public static final String	ARGS_SQL_CONF_MNEMONIC	 = "q";
	
	public static final String	ARGS_ENCRYPTED_CONF_LEVEL	     = "secret";
	public static final String	ARGS_ENCRYPTED_CONF_MNEMONIC	 = "s";	

	public static final String	ARGS_UDD_LEVEL	     = "udd";
	public static final String	ARGS_UDD_MNEMONIC	 = "u";	
	
	public static final String	ARGS_INPUT_LEVEL	     = "input";
	public static final String	ARGS_INPUT_MNEMONIC	 = "i";	
	
	public static final String	ARGS_THREADS_LEVEL	     = "threads";
	public static final String	ARGS_THREADS_MNEMONIC	 = "t";		
	
	public static final String ARGS_REMOVEUID_LEVEL = "remove-uid";	
	public static final String ARGS_REMOVEUID_MNEMONIC = "d";
	
	public static final String ARGS_HELP_LEVEL = "help";	
	public static final String ARGS_HELP_MNEMONIC = "h";	

	public static final String ARGS_COMMIT_LEVEL = "commit";	
	public static final String ARGS_COMMIT_MNEMONIC = "m";
	
	
	private static final int DEFAULT_COMMIT_LEVEL = 2000;
	
	private int commitAtEvery;
	private int threadsInUse;
	private String inputFileName;
	private String uddMappingFile;
	private String sqlConfigFile;
	private String className;
	private boolean encrypted;
	private long removeUID = -1;
	private Date effectiveDate;
	/**
	 * @param args
	 */
	public static void main(String[] args) {	
		//Init logging
		try {
	    initLogging();
    } catch (ParserConfigurationException e1) {
    	 exitWithCode(1,e1);
    } catch (SAXException e1) {
    	exitWithCode(2,e1);
    } catch (IOException e1) {
    	exitWithCode(3,e1);
    } catch (GeneralSecurityException e1) {
    	exitWithCode(4,e1);
    }
    printArgs(args);
    
    //Init Class
		PriceLoader loader = new PriceLoader();		
		
		
		//Create and parse command line options
		Options options = loader.createOptions();
		CommandLineParser parser = new PosixParser();
		CommandLine line=null;
		try {
	    line = parser.parse(options,args);
    } catch (ParseException e) {
	    exitWithCode(5,e);
    }
		
    //Handle Options
    if (line.hasOption(ARGS_HELP_MNEMONIC)) {
  		HelpFormatter formatter = new HelpFormatter();
  		formatter.printHelp( PriceLoader.class.getName(), options );  
    }
    
    try {
    	loader.handleOptions(line);
    } catch (NumberFormatException ex) {
    	exitWithCode(6,ex);
    } catch (java.text.ParseException ex) {
    	exitWithCode(7,ex);
    }
    loader.printEffectiveOptions();
    
    try {
	    loader.createClassInstance();
    } catch (ClassNotFoundException ex) {
    	exitWithCode(8,ex);
    }
	}
	
	protected void createClassInstance() throws ClassNotFoundException {
		Class.forName(this.className);
	}
	
	protected void handleOptions(CommandLine line) throws java.text.ParseException {
		if (line.hasOption(ARGS_COMMIT_MNEMONIC)) {
			try {
				this.commitAtEvery = Integer.parseInt(line.getOptionValue(ARGS_COMMIT_MNEMONIC));
			} catch (NumberFormatException e) {
				this.commitAtEvery = DEFAULT_COMMIT_LEVEL;
				log.warn(i18n.getString("price.loader.parameters.error.m",line.getOptionValue(ARGS_COMMIT_MNEMONIC)));
			}
		} else {
			this.commitAtEvery = DEFAULT_COMMIT_LEVEL;
		}
		
		if (line.hasOption(ARGS_THREADS_MNEMONIC)) {
			try {
				this.threadsInUse = Integer.parseInt(line.getOptionValue(ARGS_THREADS_MNEMONIC));
			} catch (NumberFormatException e) {
				this.threadsInUse = Runtime.getRuntime().availableProcessors();
				log.warn(i18n.getString("price.loader.parameters.error.t",line.getOptionValue(ARGS_THREADS_MNEMONIC)));
			}
		} else {
			this.threadsInUse = Runtime.getRuntime().availableProcessors();
		}
		
		this.inputFileName = line.getOptionValue(ARGS_INPUT_MNEMONIC);
		this.uddMappingFile = line.getOptionValue(ARGS_UDD_MNEMONIC);
		this.sqlConfigFile = line.getOptionValue(ARGS_SQL_CONF_MNEMONIC);		
		this.className = line.getOptionValue(ARGS_PRICING_CLASS_MNEMONIC);		
		this.encrypted = Boolean.parseBoolean(line.getOptionValue(ARGS_ENCRYPTED_CONF_MNEMONIC));
		
		if (line.hasOption(ARGS_REMOVEUID_MNEMONIC)) {
			this.removeUID = Long.parseLong(line.getOptionValue(ARGS_REMOVEUID_MNEMONIC));			
		}
		
		this.effectiveDate = Calendar.getInstance().getTime();
		if (line.hasOption(ARGS_EFFECTIVE_DATE_MNEMONIC)) {
			SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
			formatter.setLenient(false);
			effectiveDate = formatter.parse(line.getOptionValue(ARGS_EFFECTIVE_DATE_MNEMONIC));
		}
	}
	
	protected void printEffectiveOptions() {
		log.info(i18n.getString("price.loader.parameters.inuse.m", this.commitAtEvery));
		log.info(i18n.getString("price.loader.parameters.inuse.t", this.threadsInUse));		
		log.info(i18n.getString("price.loader.parameters.inuse.i", this.inputFileName));
		log.info(i18n.getString("price.loader.parameters.inuse.u", this.uddMappingFile));		
		log.info(i18n.getString("price.loader.parameters.inuse.q", this.sqlConfigFile));
		log.info(i18n.getString("price.loader.parameters.inuse.c", this.className));		
		log.info(i18n.getString("price.loader.parameters.inuse.s", this.encrypted));
		log.info(i18n.getString("price.loader.parameters.inuse.e", this.effectiveDate));		
		
		if (removeUID != -1) {
			log.info(i18n.getString("price.loader.parameters.inuse.d", this.removeUID));
		}
	}
	
	private static void initLogging() throws ParserConfigurationException, SAXException, IOException, GeneralSecurityException {
		LogFactory.configureLogSystem(DOMUtils.openDocument(PriceLoader.class.getResourceAsStream("log4j-import-price.xml")));	
		log = LogFactory.getLogger(PriceLoader.class);		
	}
	
	public Options createOptions() {
		OptionBuilder.withArgName(ARGS_EFFECTIVE_DATE_LEVEL);
		OptionBuilder.hasArg();
		OptionBuilder.isRequired(false);
		OptionBuilder.withDescription(i18n.getString("price.loader.parameters.help.e"));
		Option effectiveDate = OptionBuilder.create(ARGS_EFFECTIVE_DATE_MNEMONIC);

		OptionBuilder.withArgName(ARGS_PRICING_CLASS_LEVEL);
		OptionBuilder.hasArg();
		OptionBuilder.isRequired(true);
		OptionBuilder.withDescription(i18n.getString("price.loader.parameters.help.c"));
		Option pricingClass = OptionBuilder.create(ARGS_PRICING_CLASS_MNEMONIC);

		OptionBuilder.withArgName(ARGS_SQL_CONF_LEVEL);
		OptionBuilder.hasArg();
		OptionBuilder.isRequired(true);
		OptionBuilder.withDescription(i18n.getString("price.loader.parameters.help.q"));
		Option sqlConf = OptionBuilder.create(ARGS_SQL_CONF_MNEMONIC);
		
		OptionBuilder.withArgName(ARGS_ENCRYPTED_CONF_LEVEL);
		OptionBuilder.hasArg();
		OptionBuilder.isRequired(false);
		OptionBuilder.withDescription(i18n.getString("price.loader.parameters.help.s"));
		Option encryptOption = OptionBuilder.create(ARGS_ENCRYPTED_CONF_MNEMONIC);
		
		OptionBuilder.withArgName(ARGS_UDD_LEVEL);
		OptionBuilder.hasArg();
		OptionBuilder.isRequired(true);
		OptionBuilder.withDescription(i18n.getString("price.loader.parameters.help.u"));
		Option uddOption = OptionBuilder.create(ARGS_UDD_MNEMONIC);		

		OptionBuilder.withArgName(ARGS_INPUT_LEVEL);
		OptionBuilder.hasArg();
		OptionBuilder.isRequired(true);
		OptionBuilder.withDescription(i18n.getString("price.loader.parameters.help.i"));
		Option inputOption = OptionBuilder.create(ARGS_INPUT_MNEMONIC);		
		
		OptionBuilder.withArgName(ARGS_THREADS_LEVEL);
		OptionBuilder.hasArg();
		OptionBuilder.isRequired(false);
		OptionBuilder.withDescription(i18n.getString("price.loader.parameters.help.t"));
		Option threadsOption = OptionBuilder.create(ARGS_THREADS_MNEMONIC);	
		
    OptionBuilder.withArgName(ARGS_REMOVEUID_LEVEL);
    OptionBuilder.hasArg();
    OptionBuilder.isRequired(false);    
    OptionBuilder.withDescription(i18n.getString("price.loader.parameters.help.d"));
    Option removeOption = OptionBuilder.create(ARGS_REMOVEUID_MNEMONIC);
    
		OptionBuilder.withArgName(ARGS_HELP_LEVEL);
		OptionBuilder.withDescription(i18n.getString("price.loader.parameters.help.h"));
		Option helpOption = OptionBuilder.create(ARGS_HELP_MNEMONIC);
		
    OptionBuilder.withArgName(ARGS_COMMIT_LEVEL);
    OptionBuilder.hasArg();
    OptionBuilder.isRequired(false);    
    OptionBuilder.withDescription(i18n.getString("price.loader.parameters.help.m"));
    Option commitOption = OptionBuilder.create(ARGS_COMMIT_MNEMONIC);
    
		Options options =  new Options();
		options.addOption(effectiveDate);
		options.addOption(pricingClass);
		options.addOption(sqlConf);
		options.addOption(encryptOption);
		options.addOption(uddOption);
		options.addOption(inputOption);
		options.addOption(threadsOption);
		options.addOption(removeOption);
		options.addOption(helpOption);	
		options.addOption(commitOption);			

		return options;
	}
	
	protected static void exitWithCode(int code, Throwable e) {
		String msg = getMessage(code);
		if (code > 4) {
			log.fatal(msg,e);
			log.info(i18n.getString("price.loader.0",code));
		}
		System.out.println(msg + '\n' + e);
		System.out.println(i18n.getString("price.loader.0",code));
		System.exit(code);
	}
	
	protected static String getMessage(int code) {
		return i18n.getString("price.loader.error." + Integer.toString(code)) ;
	}
	
	private static void printArgs(String[] args) {
		log.info(i18n.getString("price.loader.parameters.1"));
		StringBuilder sb = new StringBuilder();
		sb.append(':');
		for (int i=0; i < args.length;i++) {
			sb.append(args[i]);
			sb.append('/');
		}
		log.info(sb.toString());
	}
}
