/*
 * Copyright (c) 2004-2008 Auster Solutions. All Rights Reserved.
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
 * Created on 07/01/2008
 */
package br.com.auster.vivo.billcheckout.rules.test;

import br.com.auster.billcheckout.consequence.telco.TelcoConsequence;
import br.com.auster.vivo.billcheckout.rules.BaseTestUpdated;

/**
 * TODO What this class is responsible for
 *
 * @author William Soares
 * @version $Id$
 * @since JDK1.4
 */
public class R52_Test extends BaseTestUpdated {

	public static void main(String[] args) {
		R52_Test test = new R52_Test();
		test.testRule01();
		test.testRule02();
		test.testRule03();
		test.testRule04();
		test.testRule05();
		test.testRule06();
		test.testRule07();
		test.testRule08();
		test.testRule09();
		test.testRule10();
		test.testRule11();
		test.testRule12();
		test.testRule13();
		test.testRule14();
		test.testRule15();
		test.testRule16();
	}

	public void testRule01() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R52rulesengine.xml";

		SOURCE_FILE = "r52/R52_Test1.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());		
		TelcoConsequence c = (TelcoConsequence)getEngine().getResults().get(0);
		assertEquals("Cadastro do cliente não encontrado no DataBarn.", c.getDescription());
		c = (TelcoConsequence)getEngine().getResults().get(1);
		assertEquals("Dígito verificador da conta diverge do calculado.", c.getDescription());
	}
	
	public void testRule02() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R52rulesengine.xml";

		SOURCE_FILE = "r52/R52_Test2.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule03() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R52rulesengine.xml";

		SOURCE_FILE = "r52/R52_Test3.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());		
		TelcoConsequence c = (TelcoConsequence)getEngine().getResults().get(0);
		assertEquals("Dígito verificador da conta diverge do calculado.", c.getDescription());
	}
	
	public void testRule04() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R52rulesengine.xml";

		SOURCE_FILE = "r52/R52_Test4.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());		
	}	
	
	public void testRule05() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R52rulesengine.xml";

		SOURCE_FILE = "r52/R52_Test5.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
		TelcoConsequence c = (TelcoConsequence)getEngine().getResults().get(0);
		assertEquals("Erro encontrado nos dados cadastrais do cliente.", c.getDescription());	
		assertEquals("Endereço", c.getAttributes().getAttributeValue5());
	}
	
	public void testRule06() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R52rulesengine.xml";

		SOURCE_FILE = "r52/R52_Test6.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
		TelcoConsequence c = (TelcoConsequence)getEngine().getResults().get(0);
		assertEquals("Erro encontrado nos dados cadastrais do cliente.", c.getDescription());	
		assertEquals("Nome do Cliente", c.getAttributes().getAttributeValue5());
	}
	
	public void testRule07() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R52rulesengine.xml";

		SOURCE_FILE = "r52/R52_Test7.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
		TelcoConsequence c = (TelcoConsequence)getEngine().getResults().get(0);
		assertEquals("Erro encontrado nos dados cadastrais do cliente.", c.getDescription());	
	}
	
	public void testRule08() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R52rulesengine.xml";

		SOURCE_FILE = "r52/R52_Test8.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule09() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R52rulesengine.xml";

		SOURCE_FILE = "r52/R52_Test9.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule10() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R52rulesengine.xml";

		SOURCE_FILE = "r52/R52_Test10.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule11() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R52rulesengine.xml";

		SOURCE_FILE = "r52/R52_Test11.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule12() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R52rulesengine.xml";

		SOURCE_FILE = "r52/R52_Test12.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule13() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R52rulesengine.xml";

		SOURCE_FILE = "r52/R52_Test13.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule14() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R52rulesengine.xml";

		SOURCE_FILE = "r52/R52_Test14.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule15() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R52rulesengine.xml";

		SOURCE_FILE = "r52/R52_Test15.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule16() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R52rulesengine.xml";

		SOURCE_FILE = "r52/R52_Test16.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
}
