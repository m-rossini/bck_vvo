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
 * Created on Dec 18, 2007
 *
 * @author anardo
 *
 */


package br.com.auster.vivo.billcheckout.rules.test;

import br.com.auster.vivo.billcheckout.rules.BaseTestUpdated;

public class R75_Test extends BaseTestUpdated {
	
	public static void main(String[] args) {
		R75_Test test = new R75_Test();
		//testes 1 a 5 para verificar Demonstração mês/ano
		test.testRule01();
		test.testRule02();
		test.testRule03();
		test.testRule04();
		test.testRule05();
		//testes 6 a 11 para verificar série/sub-série
		test.testRule06();
		test.testRule07();
		test.testRule08();
		test.testRule09();
		test.testRule10();
		test.testRule11();
		//teste 12 para verificar as duas sub-regras
		test.testRule12();
	}

	public void testRule01() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R75rulesengine.xml";

		SOURCE_FILE = "r75/R75_OK.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
				
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
	}
	public void testRule02() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R75rulesengine.xml";
		
		SOURCE_FILE = "r75/R75_anoNF.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
	}
	public void testRule03() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R75rulesengine.xml";
		
		SOURCE_FILE = "r75/R75_mesNF.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
	}
	
	public void testRule04() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R75rulesengine.xml";
		
		SOURCE_FILE = "r75/R75_anoCorte.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
	}
	public void testRule05() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R75rulesengine.xml";
		
		SOURCE_FILE = "r75/R75_mesCorte.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
	} 
	public void testRule06() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R75rulesengine.xml";
		
		SOURCE_FILE = "r75/R75-2_Inexiste.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
	}
	public void testRule07() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R75rulesengine.xml";
		
		SOURCE_FILE = "r75/R75-2_Serie.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
	}
	public void testRule08() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R75rulesengine.xml";
		
		SOURCE_FILE = "r75/R75-2_Sub.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
	}
	public void testRule09() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R75rulesengine.xml";
		
		SOURCE_FILE = "r75/R75-2_due_Serie.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
	}
	
	public void testRule10() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R75rulesengine.xml";
		
		SOURCE_FILE = "r75/R75-2_OK2.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
	}
	public void testRule11() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R75rulesengine.xml";
		
		SOURCE_FILE = "r75/R75-2_Serie2.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 3;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
	}
	public void testRule12() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R75rulesengine.xml";
		
		SOURCE_FILE = "r75/R75-1-2_mesNF_Serie2.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 5;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
	}
	
	public void testRule13() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R75rulesengine.xml";
		
		SOURCE_FILE = "r75/R75-1erro.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
	}
	public void testRule14() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R75rulesengine.xml";
		
		SOURCE_FILE = "r75/2021760426.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
	}
}