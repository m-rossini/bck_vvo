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
package br.com.auster.vivo.billcheckout.rules.guide;

import java.io.IOException;
import java.security.GeneralSecurityException;

import javax.xml.parsers.ParserConfigurationException;

import org.apache.log4j.Logger;
import org.xml.sax.SAXException;

import br.com.auster.vivo.billcheckout.rules.BaseTestCasesForRules;

/**
 * @author mtengelm
 * 
 */

public class NFTestGuide_Test06 extends BaseTestCasesForRules {
	static final Logger	  log	                  = Logger.getLogger(NFTestGuide_Test06.class);

	static final String[]	FILE_PATH	            = new String[] { "guide/guide_Test06.sirs" };
	static final int LOOP_LIMIT = FILE_PATH.length;	
	
	static final int[] EXPECTED_CONSEQUENCES = new int[] { 0 };
	static final String ENGINE_PATH = "NFjustGuideEngine.xml";
	
	public void testRule() {
		try {
	    createUDD();
	    long et=0;
	    long st = System.nanoTime();
	    
			for (int i = 0; i < LOOP_LIMIT; i++) {
				log.info(">>>>> STARTING GUIDING RULE TEST<<<<<");
				executeOneRule(FILE_PATH[i], EXPECTED_CONSEQUENCES[i],ENGINE_PATH);
				et = System.nanoTime();
				log.info("=======>For File #" + i + ":" + (et-st)/1000 );
			}
			
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
