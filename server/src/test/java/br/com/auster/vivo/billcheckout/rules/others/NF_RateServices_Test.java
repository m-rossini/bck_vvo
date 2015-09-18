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
 * Created on 18/12/2006
 */
package br.com.auster.vivo.billcheckout.rules.others;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import org.apache.log4j.Logger;
import org.xml.sax.SAXException;

import br.com.auster.common.sql.SQLConnectionManager;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.common.xml.sax.NIOInputSource;
import br.com.auster.vivo.billcheckout.rules.BaseTestCasesForRules;
import br.com.auster.vivo.billcheckout.rules.RuleTestUtils;

/**
 * @author mtengelm
 * 
 */
public class NF_RateServices_Test extends BaseTestCasesForRules {
	static final Logger	  log	                  = Logger.getLogger(NF_RateServices_Test.class);
 
	static final String[]	FILE_PATH	            = new String[] { "others/FR_RS_Test.sirs" };
	static final int LOOP_LIMIT = FILE_PATH.length;	
	
	static final int[] EXPECTED_GUIDING_CONSEQUENCES = new int[] { 0 };
	static final String GUIDING_ENGINE_PATH = "RateServicesRulesEngine.xml";
	
	static final String ENV = "tiamat";
	static final String DATABASE_PATH = ENV + "-sql-config.xml";
	static final String DATABASE_NAME = "sql/" + ENV + "db";
	private SQLConnectionManager mann;	
	
	public void testRule() {
		try {
			//Creates SQL Connection Manager.
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Class.forName("org.apache.commons.dbcp.PoolingDriver");
			SQLConnectionManager.init(DOMUtils.openDocument(DATABASE_PATH, false));

			mann = SQLConnectionManager.getInstance(DATABASE_NAME);
			
			
			//Creates the reader
	    createUDD();

	    //Creates a Model
			NIOInputSource source = (NIOInputSource) RuleTestUtils.getSource(FILE_DIR + FILE_PATH[0]);
			this.setLoader(createLoader());			
			List model = createModel(source);	
	    
			
			//Guiding
			createEngine(GUIDING_ENGINE_PATH);
			funBegins();	    
			assertTrue("Expected guiding consequences are different.", (getEngine().getResults().size()==EXPECTED_GUIDING_CONSEQUENCES[0]));
						
			
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
    }
	  		
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
	protected void tearDown() throws Exception {
		super.tearDown();	
	}

}
