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

public class R65_Test_Sec1 extends BaseTestUpdated {

	public static void main(String[] args) {
		R65_Test_Sec1 test = new R65_Test_Sec1();
		test.testRule01();
		test.testRule02();
		test.testRule03();
		test.testRule04();
		test.testRule05();
		test.testRule06();
		test.testRule07();
		test.testRule08();
//		test.testRule09();
//		test.testRule10();
		test.testRule11();
		test.testRule12();
		test.testRule13();
		test.testRule14();
		test.testRule15();
		test.testRule16();
		test.testRule17();
		test.testRule18();
		test.testRule19();		
		//Teste #658 - 104706 - Chave 570D com valor zero 
		test.testRule20();
		test.testRule21();
		//Teste #663 - 104730 - Chave 560D com valor zero
		test.testRule22();
	}
	public void testRule01() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/2002808790_325D_330D_340D.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	//testando tags 325D_330D_340D
	public void testRule02() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/2002808790_325D_330D_340D_Alter.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 5;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	//
	public void testRule03() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/0120740921_270D_325D_330D.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	// testando tag 270D e 325D
	public void testRule04() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/0120740921_270D_325D_330D_Alter270325.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 4;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule05() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/2017430970_595D.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule06() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/2017430970_595D_Alter.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 4;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule07() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/2004820503.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	//Testa tags 510D_680D_520D_535D_540D_550D_545D_555D_570D_560D_575D_585D_590D_1230(tags - 650D,660D,665D,675D) - Do 1230 só faltou 655D e 670D
	public void testRule08() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/2004820503_Alter.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 25;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
//	public void testRule09() {
//		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
//		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
//		
//		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/0121620927_600D.sirs";
//		EXPECTED_BUSINESS_CONSEQUENCES = 0;
//		
//		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
//	}
//	public void testRule10() {
//		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
//		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
//		
//		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/0121620927_600D.sirs.gz";
//		EXPECTED_BUSINESS_CONSEQUENCES = 0;
//		
//		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
//	}
	public void testRule11() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/2006909340_405D.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule12() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/2006909340_405DAlter.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule13() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/2021774811_406D.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule14() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/2026240448_406D.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule15() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/2026240448_406DAlter.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 4;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule16() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/0100739488_407D.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule17() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/0100739488_407DAlter.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule18() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/2007093535_408D.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule19() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/2007093535_408DAlter.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule20() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/BUG_104706_570D.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule21() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/BUG_104706_570DAlter.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 4;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule22() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/BUG_104730_560D_Alter.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}	
	public void testRule23() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/2031647513.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule24() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/2006909340_405D.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	/**
	 * Cenario de duas NF's para (VIVO) para uma mesma conta, mas com estados distintos.
	 * Contém para o CFOP 1010 - Planos Contratados, 00SP e 00MS. A regra atual espera apenas um cfop para uma NF e um estado.
	 * Nao houve critica para a aliquota nesta conta pois apenas nesse teste valida os cfop's. 
	 * Caso não previsto na ET, que até o momento ficara com critica.
	 */
	public void testRule25() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R65rulesengine_SecOne.xml";
		
		SOURCE_FILE = "r65/naoGoverno/Sec_5_1/2023279691_#718_DualCarrier.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 12;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
}
