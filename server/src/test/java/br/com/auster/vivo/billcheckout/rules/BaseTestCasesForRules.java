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
import java.util.List;
import java.util.Map;

import javax.xml.parsers.ParserConfigurationException;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;

import br.com.auster.billcheckout.rules.RulesEngineProcessor;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.common.xml.sax.NIOInputSource;
import br.com.auster.sirs.loader.SirsLoader;
import br.com.auster.udd.reader.TaggedFileReader;
import junit.framework.TestCase;

/**
 * @author mtengelm
 *
 */
public abstract class BaseTestCasesForRules extends TestCase {

	private static final Logger	  log	                  = Logger.getLogger(BaseTestCasesForRules.class);
	protected static final String FILE_DIR = "src/test/resources/input/";
	
	protected static final String LOADER_PATH = "sirsloader.xml";
	protected static final String UDD_PATH = "conf/sirs-definition-v7.xml";
	protected static final String LOG4J_PATH = "log4j.xml";
	
	protected Map globals; 
	protected RulesEngineProcessor engine;
	protected List model;
	protected TaggedFileReader UDDReader;
	protected SirsLoader loader;	
    
	/**
	 * 
	 */
	public BaseTestCasesForRules() {
		super(); 
	}

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
		RuleTestUtils.assertFacts(engine, model.get(0));

		log.info(">>>>Firing Rules...");
		RuleTestUtils.fireRules(engine);		
		
		int consequences = (engine.getResults() == null) ? 0 : engine.getResults().size();
		log.info("Number of Consequences Generated:" + consequences);
		log.info("Consequences");
		log.info(engine.getResults());			
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
	}
}