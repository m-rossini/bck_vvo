/*
 * Copyright (c) 2008 Auster Solutions. All Rights Reserved.
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
 * Created on 16/04/2007
 */
package br.com.auster.vivo.billcheckout.rules.test;

import br.com.auster.vivo.billcheckout.rules.BaseTestUpdated;

/**
 * @author anardo
 * 
 */

public class R65_Test extends BaseTestUpdated {

	public static void main(String[] args) {
		R65_Test test = new R65_Test();
		//tests 1 a 3 para testes da secao 5.2
		test.testRule01();
		test.testRule02();
		test.testRule03();
		//tests 4 para secao 5.3.1.1
		test.testRule04();
		//test 5 para secao 5.3.1.2
		test.testRule05();
		//test 6 a 9 para secao 5.3.2
		test.testRule06();
		test.testRule07();
		test.testRule08();
		test.testRule09();
		//test 10 para secao 5.3.3
		test.testRule10();
		//test 11 para secao 5.3.4
		test.testRule11();
		test.testRule12();
		//tests 13,14,15 para secao 5.4.1
		test.testRule13();
		test.testRule14();
		test.testRule15();
		//tests para secao 5.4.2
//		test.testRule16();
//		test.testRule17();
//		test.testRule18();
		test.testRule19();
		test.testRule19();
		//5.3.4
		test.testRule20();
	}

	/**
	 * Ticket #997: repeticao de servicos causou duas criticas indevidas.
	 * O problema foi resolvido alterando a validacao da sub-regra "R65-04-2"
	 * para utilizar a hierarquia dos registros, em vez de comparar os captions.
	 */
	public void testAccount0111246589() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine.xml";
		
		SOURCE_FILE = "r65/account.0111246589.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule01() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine.xml";
		
		SOURCE_FILE = "r65/contaGoverno/Sec_5_2/R65_G01_OK.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule02() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_2/R65_NG02_Alter202X.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule03() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_2/R65_NG02_Alter202Y.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 3;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule04() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_311/R65_NG02_Alter202V.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule05() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine.xml";
		
		SOURCE_FILE = "r65/contaGoverno/Sec_5_312/2021133486_Diverg.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 10;
		//Ak têm erros de Isentos e Aliquota pq conta governo com mais de um 202V, não previsto (Map)
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule06() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine.xml";
		
		SOURCE_FILE = "r65/naoGoverno/R65_NG02_OK-Custom.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		//ak eu tenho erro do Valor ICMS, pois no arquivo original já diverge este valor
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule07() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_3_2/R65_NG02_Alter202Y.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 12;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule08() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_3_2/R65_NG02_Alter202V.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 3;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule09() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_3_2/R65_NG02_Alter202VY.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 8;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule10() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_3_3/R65_NG02_Alter202VY.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 4;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule11() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_3_4/R65_NG02_Alter202Y.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 6;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule12() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine.xml";
		
		SOURCE_FILE = "r65/contaGoverno/Sec_5_1/0030014047_OK.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule13() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_4/0030014457_#572_OK.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule14() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_4/0030014457_#572_Alter.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}	
	public void testRule15() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_4/0030017482_#579_Alter.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule16() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_4/0030014047_#559_orig.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule17() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_4/0030014047_#559_alt.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule18() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_4/2016068566_franq_Plano.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	/**
	 * Test scenario: absence of 202X record (FUST and FUNTTEL).
	 */
	public void testRule19() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_3_2/R65_NG02_Sem202X.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	/**
	 * Teste de Serviços Adicionais com aliquota e sem aliquota, não previsto na ET. CFOP 1030 para VIVO.
	 * Assim, esses dois erros (Servs. Isentos e Aliquota), até uma possível mudanca na regra e ET. 
	 */
	public void testRule20() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_3_4/2018384172.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 8;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
}
