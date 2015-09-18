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
 * Created on 06/12/2007
 */
package br.com.auster.vivo.billcheckout.rules.test;

import br.com.auster.billcheckout.consequence.telco.TelcoConsequence;
import br.com.auster.vivo.billcheckout.rules.BaseTestUpdated;

/**
 * @author dcunha
 * 
 */

public class R69_82_Test extends BaseTestUpdated {

	public static void main(String[] args) {
		R69_82_Test test = new R69_82_Test();
//		test.testRule01();
//		test.testRule02();
//		test.testRule03();
//		test.testRule04();
//		test.testRule05();
//		test.testRule06();
//		test.testRule07();
//		test.testRule08();
//		test.testRule09();
//		test.testRule10();
//		test.testRule11();
//		test.testRule12();
		test.testRule13();
	}
	
	/**
	 * testRule01
	 * 
	 * Test a success case where the penalty/interest 
	 * where correctly charged.
	 */
	public void testRule01() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R69_82rulesengine.xml";

		SOURCE_FILE = "r69_82/R69_82_Test01.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/**
	 * testRule01
	 * 
	 * Test a specific case where the penalty/interest was
	 * charged correctly but in the databarn these 
	 * values were listed as equipament penalty/interest 
	 * and account penalty/interest but in the invoice 
	 * these values are sumarized
	 *  
	 */
	public void testRule02() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R69_82rulesengine.xml";

		SOURCE_FILE = "r69_82/R69_82_Test02.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/**
	 * testRule03
	 * 
	 * Test a success case where the penalty/interest 
	 * where correctly charged.
	 */
	public void testRule03() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R69_82rulesengine.xml";

		SOURCE_FILE = "r69_82/R69_82_Test03.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/**
	 * testRule04
	 * 
	 * Test the case where a penalty was found
	 * in the customer invoice but it was missing in the databarn. 
	 */
	public void testRule04() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R69_82rulesengine.xml";

		SOURCE_FILE = "r69_82/R69_82_Test04A.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
		TelcoConsequence c = (TelcoConsequence)getEngine().getResults().get(0);
		assertEquals("Multa com registro na Fatura e sem registro no DataBarn.", c.getDescription());
		c = (TelcoConsequence)getEngine().getResults().get(1);
		assertEquals("Multa com registro na Fatura e sem registro no DataBarn.", c.getDescription());	
	}

	/**
	 * testRule05
	 * 
	 * Test the case where a interest was found
	 * in the customer invoice but it was missing in the databarn. 
	 */
	public void testRule05() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R69_82rulesengine.xml";

		SOURCE_FILE = "r69_82/R69_82_Test04B.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
		TelcoConsequence c = (TelcoConsequence)getEngine().getResults().get(0);
		assertEquals("Juros com registro na Fatura e sem registro no DataBarn.", c.getDescription());
		c = (TelcoConsequence)getEngine().getResults().get(1);
		assertEquals("Juros com registro na Fatura e sem registro no DataBarn.", c.getDescription());	
	}
	
	/**
	 * testRule06
	 * 
	 * Test the case where a interest was found
	 * in the DataBarn but it was missing in the customer invoice. 
	 */
	public void testRule06() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R69_82rulesengine.xml";

		SOURCE_FILE = "r69_82/R69_82_Test05A.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
		TelcoConsequence c = (TelcoConsequence)getEngine().getResults().get(0);
		assertEquals("Juro com registro no DataBarn e sem registro na Fatura.", c.getDescription());
		c = (TelcoConsequence)getEngine().getResults().get(1);
		assertEquals("Juro com registro no DataBarn e sem registro na Fatura.", c.getDescription());
	}
	
	/**
	 * testRule07
	 * 
	 * Test the case where a penalty was found
	 * in the DataBarn but it was missing in the customer invoice. 
	 */
	public void testRule07() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R69_82rulesengine.xml";

		SOURCE_FILE = "r69_82/R69_82_Test05B.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
		TelcoConsequence c = (TelcoConsequence)getEngine().getResults().get(0);
		assertEquals("Multa com registro no DataBarn e sem registro na Fatura.", c.getDescription());
		c = (TelcoConsequence)getEngine().getResults().get(1);
		assertEquals("Multa com registro no DataBarn e sem registro na Fatura.", c.getDescription());
	}
	
	
	/**
	 * testRule08
	 * 
	 * Test the case where the penalty/interest
	 * was charged but the invoice due date was a 
	 * city holiday, and so, the fee was invalid.
	 */
	public void testRule08() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R69_82rulesengine.xml";

		SOURCE_FILE = "r69_82/R69_82_Test08.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
		TelcoConsequence c = (TelcoConsequence)getEngine().getResults().get(0);
		assertEquals("Multa com registro no DataBarn indevidamente (feriado)", c.getDescription());
		c = (TelcoConsequence)getEngine().getResults().get(1);
		assertEquals("Juro com registro no DataBarn indevidamente (feriado)", c.getDescription());
	}
	
	/**
	 * testRule09
	 * 
	 * Test the case where the penalty/interest
	 * was charged but the invoice due date was a 
	 * state holiday, and so, the fee was invalid.
	 */
	public void testRule09() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R69_82rulesengine.xml";

		SOURCE_FILE = "r69_82/R69_82_Test09.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
		TelcoConsequence c = (TelcoConsequence)getEngine().getResults().get(0);
		assertEquals("Multa com registro no DataBarn indevidamente (feriado)", c.getDescription());
		c = (TelcoConsequence)getEngine().getResults().get(1);
		assertEquals("Juro com registro no DataBarn indevidamente (feriado)", c.getDescription());
	}
	

	/**
	 * testRule10
	 * 
	 * Test the case where the penalty/interest
	 * was charged but the invoice due date was a 
	 * country holiday, and so, the fee was invalid.
	 */
	public void testRule10() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R69_82rulesengine.xml";

		SOURCE_FILE = "r69_82/R69_82_Test10.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
		TelcoConsequence c = (TelcoConsequence)getEngine().getResults().get(0);
		assertEquals("Multa com registro no DataBarn indevidamente (feriado)", c.getDescription());
		c = (TelcoConsequence)getEngine().getResults().get(1);
		assertEquals("Juro com registro no DataBarn indevidamente (feriado)", c.getDescription());
	}
	
	/**
	 * testRule11
	 * 
	 * Test the case where the penalty/interest
	 * was charged but the invoice due date was a 
	 * weakend, and so, the fee was invalid.
	 */
	public void testRule11() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R69_82rulesengine.xml";

		SOURCE_FILE = "r69_82/R69_82_Test11.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
		TelcoConsequence c = (TelcoConsequence)getEngine().getResults().get(0);
		assertEquals("Multa com registro no DataBarn indevidamente (final de semana)", c.getDescription());
		c = (TelcoConsequence)getEngine().getResults().get(1);
		assertEquals("Juro com registro no DataBarn indevidamente (final de semana)", c.getDescription());
	}
	

	/**
	 * testRule12
	 * 
	 * Test the case where the penalty/interest
	 * was charged but the invoice due date was a 
	 * weekend and holiday on monday, and so, the fee was invalid.
	 */
//	public void testRule12() {
//		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
//		BUSINESS_ENGINE_PATH = "R69_82rulesengine.xml";
//
//		SOURCE_FILE = "r69_82/R69_82_Test12.sirs";
//		EXPECTED_BUSINESS_CONSEQUENCES = 1;
//
//		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
//		TelcoConsequence c = (TelcoConsequence)getEngine().getResults().get(0);
//		assertEquals("Multa com registro no DataBarn indevidamente (final de semana)", c.getDescription());
//		c = (TelcoConsequence)getEngine().getResults().get(1);
//		assertEquals("Juro com registro no DataBarn indevidamente (final de semana)", c.getDescription());
//	}
	
	public void testRule13() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R69_82rulesengine.xml";

		SOURCE_FILE = "r69_82/R69_82_Test13.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

}
