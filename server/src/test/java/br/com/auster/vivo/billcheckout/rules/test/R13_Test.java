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
 * Created on 03/12/2007
 */
package br.com.auster.vivo.billcheckout.rules.test;

import br.com.auster.vivo.billcheckout.rules.BaseTestUpdated;


/**
 * @author anardo
 * 
 */

public class R13_Test extends BaseTestUpdated {

	public static void main(String[] args) {
		R13_Test test = new R13_Test();
		test.testAccount0036021389();
	}

	/**
	 * Ticket #982
	 */
	public void testAccount0036021389() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R13rulesengine.xml";

		SOURCE_FILE = "r13/account.0036021389.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/**
	 * Ticket #811: garante que diferenca de R$ 0,01 nao gere critica.
	 */
	public void testAccount0142339793() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R13rulesengine.xml";

		SOURCE_FILE = "r13/account.0142339793.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule01() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R13rulesengine.xml";

		SOURCE_FILE = "r13/R13_Test02.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule02() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R13rulesengine.xml";

		SOURCE_FILE = "r13/R13_Test03.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule03() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R13rulesengine.xml";

		SOURCE_FILE = "r13/R13_Test04.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule04() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R13rulesengine.xml";

		SOURCE_FILE = "r13/R13_Test05.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule05() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R13rulesengine.xml";

		SOURCE_FILE = "r13/R13_Test06.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}	
	
	public void testRule06() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R13rulesengine.xml";

		SOURCE_FILE = "r13/R13_Test07.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}	
	
	public void testRule07() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R13rulesengine.xml";

		SOURCE_FILE = "r13/R13_Test08.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}	
	
	// Pró-rata
	public void testRule08() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R13rulesengine.xml";

		SOURCE_FILE = "r13/R13_Test09.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}	
	
	// CSA ENT61 - GF
	public void testRule09() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R13rulesengine.xml";

		SOURCE_FILE = "r13/R13_Test10.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}	
	
	// Cobrança Única - R$14,90 ADESÃO NATAL 07 
	public void testRule10() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R13rulesengine.xml";

		SOURCE_FILE = "r13/R13_Test11.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}	
	
	// Plano com desconto Progressivo - SvcId = 76900910
	public void testRule11() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R13rulesengine.xml";

		SOURCE_FILE = "r13/R13_Test12.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}	
	
	// Conta Governo (Tipo G)
	public void testRule12() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R13rulesengine.xml";

		SOURCE_FILE = "r13/R13_Test13.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}	
	
	
	//negociado
	public void testRule13() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R13rulesengine.xml";

		SOURCE_FILE = "r13/R13_Test14.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}	
	
	public void testRule14() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R13rulesengine.xml";

		SOURCE_FILE = "r13/R13_Test15.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}	
	
//	public void testRule15() {
//		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
//		BUSINESS_ENGINE_PATH = "R13rulesengine.xml";
//
//		SOURCE_FILE = "performance/R65_PerformanceTestGuidingFaster_Large-FRED.sirs";
//		EXPECTED_BUSINESS_CONSEQUENCES = 2;
//
//		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
//	}	
	
	
	public void testRule16() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R13rulesengine.xml";

		SOURCE_FILE = "r13/R13_Test18.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}	
	
	/**
	 * Test case regarding ticket #706
	 *
	 */
	public void testRule17() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R13rulesengine.xml";

		SOURCE_FILE = "r13/R13_Test17.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	/**
	 * Cenário onde consta serviço com datas de ativação e expiração iguais: Data Inicial=2008-07-22, Data Final=2008-07-22,
	 * gerando crítica talvez indevida, pois amount-R$0,00 no Sirs. VIVO ainda não citou este cenário.
	 */
	public void testRule18() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R13rulesengine.xml";
		
		SOURCE_FILE = "r13/0141096329_#726_Custom.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
}
