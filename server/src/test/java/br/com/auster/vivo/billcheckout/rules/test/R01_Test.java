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
 * Created on 07/12/2007
 */
package br.com.auster.vivo.billcheckout.rules.test;

import br.com.auster.vivo.billcheckout.rules.BaseTestUpdated;


/**
 * @author anardo
 * 
 */

public class R01_Test extends BaseTestUpdated {
		
	public static void main(String [] args)  {
		R01_Test test = new R01_Test();
		test.testRule01(); 
		test.testRule02(); 
		test.testRule03(); 
		test.testRule04(); 
		test.testRule05(); 
		test.testRule06();
		test.testRule07();
		test.testRule08();
	}
	
	public void testRule01() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R01rulesengine.xml";
		
		SOURCE_FILE = "r01/R01_Test01.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 4;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES,  ruleTest() );
	}
	
	public void testRule02() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R01rulesengine.xml";
		
		SOURCE_FILE = "r01/R01_Test02.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES,  ruleTest() );
	}
	
	
	// CSA ENT61 - CO/N
	public void testRule03() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R01rulesengine.xml";
		
		SOURCE_FILE = "r01/R01_Test03.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES,  ruleTest() );
	}
	
	public void testRule04() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R01rulesengine.xml";
		
		SOURCE_FILE = "r01/R01_Test04.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 3;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES,  ruleTest() );
	}
	
	public void testRule05() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R01rulesengine.xml";
		
		SOURCE_FILE = "r01/R01_Test05.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES,  ruleTest() );
	}
	public void testRule06() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R01rulesengine.xml";
		
		SOURCE_FILE = "r01/0140863790.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES,  ruleTest() );
	}
	
	public void testRule07() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R01rulesengine.xml";
		
		SOURCE_FILE = "r01/2015421692.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES,  ruleTest() );
	}
	
	public void testRule08() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R01rulesengine.xml";
		
		SOURCE_FILE = "r01/2019409098.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 35;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES,  ruleTest() );
	}
	// issue 104797
	public void testRule09() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R01rulesengine.xml";
		
		SOURCE_FILE = "r01/0031159413.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES,  ruleTest() );
	}
}	
	