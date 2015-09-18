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

import br.com.auster.common.xml.sax.NIOInputSource;
import br.com.auster.sirs.loader.SirsLoader;
import br.com.auster.vivo.billcheckout.rules.BaseTestCasesForRules;
import br.com.auster.vivo.billcheckout.rules.RuleTestUtils;

/**
 * @author mtengelm
 * 
 */
public class NF_SirsLoader_Test extends BaseTestCasesForRules {
	static final Logger	  log	                  = Logger.getLogger(NF_SirsLoader_Test.class);

	static final String[]	FILE_PATH	            = new String[] { "src/test/resources/input/others/SirsLoader_Test.sirs.gz" };
	static final int LOOP_LIMIT = FILE_PATH.length;		
	
	public void testRule() {
		try {
	    createUDD();
	    
	    SirsLoader loader = createLoader();
	    this.setLoader(loader);
	    
	    NIOInputSource source = (NIOInputSource) RuleTestUtils.getSource(FILE_PATH[0]);
			List model = createModel(source);
	    
			assertTrue("Model should have 5 accounts", model.size() == 5);			
			
			log.info("Model is FULLY loaded.");
			
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
