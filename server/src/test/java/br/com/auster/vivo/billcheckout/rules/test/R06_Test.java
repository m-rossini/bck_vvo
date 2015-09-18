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
 * Created on 04/12/2007
 */
package br.com.auster.vivo.billcheckout.rules.test;

import br.com.auster.vivo.billcheckout.rules.BaseTestUpdated;


/**
 * @author anardo
 *
 */

public class R06_Test extends BaseTestUpdated {

	public static void main(String[] args) {
		R06_Test test = new R06_Test();
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
	}

	public void testRule01() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R07rulesengine.xml";

		SOURCE_FILE = "r06/R06_Test01.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 3 + 1; // +1 is for overlap since now duplicate and overlap are in the same DRL

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule02() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R07rulesengine.xml";

		SOURCE_FILE = "r06/R06_Test02.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 4 + 1; // +1 is for overlap since now duplicate and overlap are in the same DRL

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule03() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R07rulesengine.xml";

		SOURCE_FILE = "r06/R06_Test03.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule04() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R07rulesengine.xml";

		SOURCE_FILE = "r06/R06_Test04.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 3; // +1 is for overlap since now duplicate and overlap are in the same DRL

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule05() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R07rulesengine.xml";

		SOURCE_FILE = "r06/R06_Test05.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 4;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule06() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R07rulesengine.xml";

		SOURCE_FILE = "r06/R06_Test06.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 4;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule07() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R07rulesengine.xml";

		SOURCE_FILE = "r06/R06_Test07.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule08() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R07rulesengine.xml";

		SOURCE_FILE = "r06/R06_Test08.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	/**
	 * Gera criticas pois não preenchido campos SplitChargeInfo que informaria que é chamada fatiada
	 */
	public void testRule09() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R07rulesengine.xml";
		
		SOURCE_FILE = "r06/0143518030_#729.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/**
	 * Ligação Criança Esperança não tratada na ET e reclamada como indevida.
	 */
	public void testRule10() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R07rulesengine.xml";
		
		SOURCE_FILE = "r06/0141327658_#729.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 3;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	/**
	 * Não verificava o número chamado, conforme pedia ET. Gerava estas duas críticas:
	 * SIRS:
	 * 2018344090     2018344091     2499760444                     P2 TORPEDO ALERTA      150M                      650D      00RJ        1116111             1       20080925155956   1.00         EVENTO               1.00           TORPEDO ALERTA       0.10          0.10         UUTORPEDO ALERTA                   24-9976-0444        SHORT MSG           /CL            TORPEDO ALERTA      /SP            0.3365
	   2018344090     2018344091     2499760444                     P2 TORPEDO INTERATIVO  150M                      650D      00RJ        1243311             1       20080925155956   1.00         EVENTO               1.00           TORPEDO INTERATIVO   0.45          0.45         UUTORPEDO INTERATIVO               48033               TORPEDO INTERATIVO  /SP            AREA 24             /RJ            0.3365
	   Críticas:
	   Duplicidade de Chamadas	16/10/2008	2018344090	RJ	0	Duplicidade tipo SMS	SIRS_78_20081016.prbru4.27824.0704.gz	78	2499760444	2018344091	TORPEDO	0	OUTROS	U	2008-09-25T15:59:56	1 unidade(s)	2499760444	48033	0.45	não  se trata de  duplicidade  destinos diferentes 
	   Duplicidade de Chamadas	16/10/2008	2018344090	RJ	0	Duplicidade tipo SMS	SIRS_78_20081016.prbru4.27824.0704.gz	78	2499760444	2018344091	TORPEDO	0	OUTROS	U	2008-09-25T15:59:56	1 unidade(s)	2499760444	2499760444	0.10	não  se trata de  duplicidade  destinos diferentes 
	 */
	public void testRule11() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R07rulesengine.xml";
		
		SOURCE_FILE = "r06/2018344090_36223.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	/**
	 * Feito teste gerando a crítica, deixando as duas chamadas com números iguais
	 */
	public void testRule12() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R07rulesengine.xml";
		
		SOURCE_FILE = "r06/2018344090_36223_Alter.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
}
