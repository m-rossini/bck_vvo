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

public class R68_Test extends BaseTestUpdated {

	public static void main(String[] args) {
		R68_Test test = new R68_Test();
//		test.testFeeDiscount();
//		test.testFeeIncrement();
//		test.testVoidAgreement();
//		test.testRulePenaltyValueOk();
//		test.testAbsoluteNegotiationOk2();
//		test.testAbsoluteNegotiationOk3();
//		test.testAbsoluteNegotiationOk1();
//		test.testRulePenaltyValueNotOk();
//		test.testRulePenaltyMissingDTBN();
//		test.testRulePenaltyMissingSIRS();
//		test.testTicket588();
		test.testTicket655();
	}

	/**
	 * Test scenario: negot_type = 'D' (from ticket #640)
	 */
	public void testFeeDiscount() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R68rulesengine.xml";
		SOURCE_FILE = "r68/original_SIRS_C0_20080615.pcbru1.16236.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/**
	 * Test scenario: negot_type = 'I' (from ticket #640)
	 */
	public void testFeeIncrement() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R68rulesengine.xml";
		SOURCE_FILE = "r68/original_SIRS_C0_20080615.pcbru1.16189.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/**
	 * Test scenario: negot_type = 'A' and dt_exp_agr = dt_eff_agr (from ticket #640)
	 */
	public void testVoidAgreement() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R68rulesengine.xml";
		SOURCE_FILE = "r68/original_SIRS_C0_20080615.pcbru1.16219.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/**
	 * Test scenario: Modificado o valor de R$ 220,00 para R$ 110,00 (from ticket #652)
	 */
	public void testWrongValue1() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R68rulesengine.xml";

		SOURCE_FILE = "r68/alterado_SIRS_C0_20080615.pcbru1.16236.pcbru1.sirs";	// account 0030035484
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals(EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/**
	 * Test scenario: Modificado o valor de R$ 484,00 para R$ 184,00 (from ticket #652)
	 */
	public void testWrongValue2() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R68rulesengine.xml";

		SOURCE_FILE = "r68/alterado_SIRS_C0_20080615.pcbru1.16189.sirs"; 		// account 0030035492
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals(EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/*
	 * Test scenario: Modificada a data da negociação para 13/06/2008 (from ticket #652)
	 */
/*	public void testWrongDate() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R68rulesengine.xml";

		SOURCE_FILE = "r68/alterado_SIRS_C0_20080615.pcbru1.16189.pcbru1.sirs";	// account 0030035504
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals(EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
*/
	public void testRulePenaltyValueOk() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R68rulesengine.xml";

		SOURCE_FILE = "r68/R68_Test01.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testAbsoluteNegotiationOk1() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R68rulesengine.xml";

		SOURCE_FILE = "r68/R68_Test05.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testAbsoluteNegotiationOk2() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R68rulesengine.xml";
		
		SOURCE_FILE = "r68/R68_Test06.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());	
	}

	public void testAbsoluteNegotiationOk3() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R68rulesengine.xml";
		
		SOURCE_FILE = "r68/R68_Test07.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());	
	}
	
	public void testRulePenaltyValueNotOk() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R68rulesengine.xml";

		SOURCE_FILE = "r68/R68_Test02.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
		TelcoConsequence c = (TelcoConsequence)getEngine().getResults().get(0);
		assertEquals("Multa cobrada com valor calculado diferente ao da fatura.", c.getDescription());	
	}

	public void testRulePenaltyMissingDTBN() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R68rulesengine.xml";

		SOURCE_FILE = "r68/R68_Test03.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
		TelcoConsequence c = (TelcoConsequence)getEngine().getResults().get(0);
		assertEquals("Multa cobrada na fatura sem registro no DataBarn.", c.getDescription());	
	}
	
	public void testRulePenaltyMissingSIRS() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R68rulesengine.xml";

		SOURCE_FILE = "r68/R68_Test04.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
		TelcoConsequence c = (TelcoConsequence)getEngine().getResults().get(0);
		assertEquals("Multa cobrada no databarn sem registro na fatura.", c.getDescription());
	}

	/**
	 * SIRS to ticket #588
	 */
	public void testTicket588() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R68rulesengine.xml";

		SOURCE_FILE = "r68/R68_Test08.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("Multa cobrada com valor calculado diferente ao da fatura.", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	/**
	 * SIRS to ticket #588
	 */
	public void testTicket655() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R68rulesengine.xml";

		SOURCE_FILE = "r68/R68_Test11.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("Multa cobrada com valor calculado diferente ao da fatura.", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
}
