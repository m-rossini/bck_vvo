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

public class R10_Test extends BaseTestUpdated {
	public static void main(String [] args)  {
		R10_Test test = new R10_Test();
		test.testRule01();
		test.testRule02();
		test.testRule03();
		test.testRule04();
		test.testRule05();
		test.testRule_desordenado();
	}	
	
	public void testRule01() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R10rulesengine.xml";
	
		SOURCE_FILE = "r10/R10_Test01.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 3;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES,  ruleTest() );
	}
	
	public void testRule02() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R10rulesengine.xml";

		SOURCE_FILE = "r10/R10_Test02.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule03() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R10rulesengine.xml";
	
		SOURCE_FILE = "r10/R10_Test03.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 3;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES,  ruleTest() );
	}
	
	public void testRule04() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R10rulesengine.xml";
	
		SOURCE_FILE = "r10/R10_Test04.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 3;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES,  ruleTest() );
	}	
	
	public void testRule05() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R10rulesengine.xml";
	
		SOURCE_FILE = "r10/R10_Test05.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 3;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES,  ruleTest() );
	}
	
	public void testRule_desordenado() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R10rulesengine.xml";
	
		SOURCE_FILE = "r10/R10_desordenado.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES,  ruleTest() );
	}
}
