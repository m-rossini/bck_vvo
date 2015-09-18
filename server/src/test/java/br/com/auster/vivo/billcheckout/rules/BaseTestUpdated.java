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
 * Created on 12/01/2007
 */
package br.com.auster.vivo.billcheckout.rules;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.ParserConfigurationException;

import junit.framework.TestCase;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;

import br.com.auster.billcheckout.rules.RulesEngineProcessor;
import br.com.auster.common.sql.SQLConnectionManager;
import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.common.xml.sax.NIOInputSource;
import br.com.auster.sirs.loader.SirsLoader;
import br.com.auster.udd.reader.TaggedFileReader;
import br.com.auster.vivo.billcheckout.util.ExecutionTimer;

/**
 * @author gportuga
 *
 */
public abstract class BaseTestUpdated extends TestCase {
	protected  static final Logger	  log = Logger.getLogger(BaseTestUpdated.class);
	protected static final String FILE_DIR = "src/test/resources/input/";
	
	protected static final String LOADER_PATH = "sirsloader.xml";
	protected static final String UDD_PATH = "conf/sirs-definition-v7.xml";
	protected static final String LOG4J_PATH = "log4j.xml";
	
	protected Map globals; 
	protected RulesEngineProcessor engine;
	protected List model;
	protected TaggedFileReader UDDReader;
	protected SirsLoader loader;	
	protected ExecutionTimer execTimerSetup = new ExecutionTimer();
	protected ExecutionTimer execTimerLoader = new ExecutionTimer();
	protected ExecutionTimer execTimerGuiding = new ExecutionTimer();
	protected ExecutionTimer execTimerBusiness = new ExecutionTimer();
	protected ExecutionTimer execTimerBusinessEngine = new ExecutionTimer();
	protected ExecutionTimer execTimerLHS = new ExecutionTimer();
	protected ExecutionTimer execTimerRHS = new ExecutionTimer();
	protected ExecutionTimer execTimerConsequence = new ExecutionTimer();
    
	protected static String	SOURCE_FILE	            = "";
	
	protected static int EXPECTED_GUIDING_CONSEQUENCES = 0;
	protected static String GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";

	protected static int EXPECTED_BUSINESS_CONSEQUENCES =  0;
	
	protected int result_size =  0;
	protected static String BUSINESS_ENGINE_PATH = "";
	
	protected static String ENV = "tiamat";
	protected static String DATABASE_PATH = ENV + "-sql-config.xml";
	protected static String DATABASE_NAME = "sql/" + ENV + "db";
	protected static SQLConnectionManager mann;	
	


	/**
	 * 
	 */
	public BaseTestUpdated() {
		super(); 
		ProcessingStats.dontDumpMyStats();
	}
	
	public int ruleTest() {
		try {
			execTimerSetup.start();
			//Creates SQL Connection Manager.
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Class.forName("org.apache.commons.dbcp.PoolingDriver");
			SQLConnectionManager.init(DOMUtils.openDocument(DATABASE_PATH, false));

			mann = SQLConnectionManager.getInstance(DATABASE_NAME);
			execTimerSetup.end();
			
			execTimerLoader.start();
			//Creates the reader
			createUDD();
			//Creates a Model
			NIOInputSource source = (NIOInputSource) RuleTestUtils.getSource(FILE_DIR + SOURCE_FILE);
			this.setLoader(createLoader());			
			List model = createModel(source);	
			execTimerLoader.end();
			
			execTimerGuiding.start();
			//Guiding
			createEngine(GUIDING_ENGINE_PATH);
			funBegins();	    
			execTimerGuiding.end();
			
			execTimerBusiness.start();
			//Business
			execTimerBusinessEngine.start();
			createEngine(BUSINESS_ENGINE_PATH);
			execTimerBusinessEngine.end();
			funBegins();	
			execTimerBusiness.end();
			this.result_size = getEngine().getResults().size();
			return (this.result_size);
			
	    } catch (ParserConfigurationException e) {
		    e.printStackTrace();
	  		log.fatal("Error in test case. See Above:", e);
	  		fail("Test Case Failed. see previous messages.");	    
	    } catch (SAXException e) {
		    e.printStackTrace();
	  		log.fatal("Error in test case. See Above:", e);
	  		fail("Test Case Failed. see previous messages.");	    
	    } catch (IOException e) {
		    e.printStackTrace();
	  		log.fatal("Error in test case. See Above:", e);
	  		fail("Test Case Failed. see previous messages.");	    
	    } catch (GeneralSecurityException e) {
		    e.printStackTrace();
	  		log.fatal("Error in test case. See Above:", e);
	  		fail("Test Case Failed. see previous messages.");	    
	    } catch (Exception e) {
		    e.printStackTrace();
	  		log.fatal("Error in test case. See Above:", e);
	  		fail("Test Case Failed. see previous messages.");	    
	    } finally {
	    	ProcessingStats.dumpMyStats("Dumping stats:");
	    }
	    return 0;
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see junit.framework.TestCase#setUp()
	 */
	protected void setUp() throws Exception {
		super.setUp();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see junit.framework.TestCase#tearDown()
	 */

	public void createUDD() throws ParserConfigurationException, SAXException, IOException, GeneralSecurityException {
		System.out.println("Configuring LOG...");
		RuleTestUtils.configureLog(LOG4J_PATH);

		log.info(">>>>>Parsing UDD File");
		XMLReader reader = RuleTestUtils.parseUDDMapping(UDD_PATH);
		UDDReader = (TaggedFileReader) reader;		
	}
	
	public SirsLoader createLoader() throws Exception {
		log.info(">>>>>Creating loader handler...");
		SirsLoader loader = new SirsLoader();

		log.info(">>>>>Reading configuration file name:" + LOADER_PATH);
		Element config = DOMUtils.openDocument(LOADER_PATH, false);
		loader.configure(config);
		return loader;
	}
	
	public List createModel(InputSource source) throws IOException, SAXException {
		log.info(">>>>>Setting up content handler...");
		UDDReader.setContentHandler(loader);

		log.info("Reading input file");
		UDDReader.parse(source);
		
		log.info(">>>>>Getting Objects...");
		model = loader.getObjects();
		assertTrue("Object list is empty.", model.size() > 0);	
		return loader.getObjects();
	}
	
	public void createEngine(String enginePath) throws Exception {
		log.info(">>>>>Getting globals...");
		globals = RuleTestUtils.getGlobals(enginePath);

		log.info(">>>>>Creating Rules Engine...");
		engine = RuleTestUtils.getEngine(enginePath);

		log.info(">>>>>Starting up engine...");
		RuleTestUtils.initEngine(engine, globals); // Set Globals and Add DRL
		// Files

		log.info(">>>>>Preparing engine...");
		RuleTestUtils.prepareEngine(engine, globals); // Add Globals, Creates WM
	}
	
	public void funBegins() throws Exception {
		log.info(">>>>>Asserting Facts...");
		execTimerLHS.start();
		RuleTestUtils.assertFacts(engine, model.get(0));
		execTimerLHS.end();
		
		log.info(">>>>Firing Rules...");
		execTimerRHS.start();
		RuleTestUtils.fireRules(engine);
		execTimerRHS.end();
		
		execTimerConsequence.start();
		int consequences = (engine.getResults() == null) ? 0 : engine.getResults().size();
		log.info("Number of Consequences Generated:" + consequences);
		log.info("Consequences");
		log.info(engine.getResults());		
		execTimerConsequence.end();
	}
	
	public void testRules(String[] rules, int[] expectedConsequences, int limit, String enginePath) {
  	try {
  		createUDD();
  
  		for (int i = 0; i < limit; i++) {		
  			executeOneRule(rules[i], expectedConsequences[i],enginePath);  			  		
  		}
  		
  		log.info(">>>>> DONE TESTING <<<<<");
  
  	} catch (Exception e) {
  		e.printStackTrace();
  		log.fatal("Error in test case. See Above:", e);
  		fail("Test Case Failed. see previous messages.");
  	}
  }

	/**
   * @param string
   * @param i
   * @param enginePath
	 * @throws Exception 
   */
  protected void executeOneRule(String rule, int expectedConsequences, String enginePath) throws Exception {
		log.info(">>>>>Creating InputSource for File:"  + FILE_DIR + rule);
		NIOInputSource source = (NIOInputSource) RuleTestUtils.getSource(FILE_DIR + rule);

		loader = createLoader();
		
		model = createModel(source);	
		
		createEngine(enginePath); //Replaces Instance Variable of Globals and Engine

		funBegins();
				
//		log.info("Number of Consequences Generated:" + engine.getResults().size());
//		log.info("Consequences");
//		log.info(engine.getResults());	

		assertEquals("Expected Consequence Count does not Match.", expectedConsequences, (engine.getResults() == null) ? 0 : engine.getResults().size() );
  }

	/**
   * @return the engine
   */
  public RulesEngineProcessor getEngine() {
  	return this.engine;
  }

	/**
   * @return the globals
   */
  public Map getGlobals() {
  	return this.globals;
  }

	/**
   * @return the model
   */
  public List getModel() {
  	return this.model;
  }

	/**
   * @return the uDDReader
   */
  public TaggedFileReader getUDDReader() {
  	return this.UDDReader;
  }

	/**
   * @return the loader
   */
  public SirsLoader getLoader() {
  	return this.loader;
  }

  public void setLoader(SirsLoader loader) {
  	this.loader = loader;
  }
	/**
	 * TODO why this methods was overriden, and what's the new expected behavior.
	 * 
	 * @throws Exception
	 * @see junit.framework.TestCase#tearDown()
	 */
	@Override
	protected void tearDown() throws Exception {
		super.tearDown();
		if (this.engine != null) {
			this.engine.clear();			
		}
		this.engine = null;
		this.loader = null;
		this.model = null;
		this.globals = null;	
		
		long total = execTimerSetup.duration() + execTimerLoader.duration() + 
		 			 execTimerGuiding.duration() + execTimerBusiness.duration();
		
		System.out.println("Resumo do Teste");
		System.out.println("Startup Total:  " + formatResult(execTimerSetup.duration(), total));
		System.out.println("Loader Total:   " + formatResult(execTimerLoader.duration(), total));
		System.out.println("Guiding Total:  " + formatResult(execTimerGuiding.duration(), total));
		System.out.println("Business Total: " + formatResult(execTimerBusiness.duration(), total));
		System.out.println(" CreateEngine: " + formatResult(execTimerBusinessEngine.duration(), total));
		System.out.println(" LHS: " + formatResult(execTimerLHS.duration(), total));
		System.out.println(" RHS: " + formatResult(execTimerRHS.duration(), total));
		System.out.println(" Consequence: " + formatResult(execTimerConsequence.duration(), total) + "  qtde: " + result_size);

		
		System.out.println("TOTAL: " + (double) total/1000 + " s");
	}
	
	protected String formatResult(long partTime, long totalTime) {
		DecimalFormat df = new DecimalFormat("##00.00");
		double percent = ((double) partTime/(double) totalTime) * 100;
		double time = ((double) partTime/(double) 1000);
		return "(" + df.format(percent) + "%) " + df.format(time) + "s";
	}
}
