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
public class R05_Test extends BaseTestUpdated {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		R05_Test test = new R05_Test();
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
		BUSINESS_ENGINE_PATH = "R05rulesengine.xml";

		SOURCE_FILE = "r05/R05_franquia_simples.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule02() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R05rulesengine.xml";

		SOURCE_FILE = "r05/R05_franquia_simples2.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}	
	
	public void testRule03() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R05rulesengine.xml";

		SOURCE_FILE = "r05/R05_franquia_compartilhada.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	/**
	 * Critica svc_price_seq_nbr nao encontrado pois a data da tabela expiration_date coincide com a data da chamada
	 * Nao definido na ET se é devido. Assim, critica.
	 */
	public void testRule04() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R05rulesengine.xml";
		
		SOURCE_FILE = "r05/2001771148_#626Custom.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	/**
	 * Critica svc_price_seq_nbr por não existir realmente na tabela
	 */
	public void testRule05() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R05rulesengine.xml";
		
		SOURCE_FILE = "r05/0141630815_#626.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	/**
	 * #843 - Terminal - 2799352313 com dois serviços ativos:
	 * 330D  103.55    103.55   4VIVO EMP ZERO 500 OFF GROUP  2008082320080922  N82094790             0.286500                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
	 * 330D  103.55    103.55   5VIVO EMP ZERO 500 OFF GROUP  2008082320080922  N82094790             0.286500                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
     *
     * Totalizam 2 * 500 Minutes = 1000, onde na sub-regra "Regra R05-INIT7" não re-
     * conhecia o segundo serviço.
     * 
     * Duas críticas de price desatualizado.
	 */
	public void testRule06() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R05rulesengine.xml";
		
		SOURCE_FILE = "r05/0120071498_34976.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2; 
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	/**
	 * Alterado duração das ligações da chave 510D, simulando estourar a franquia.
	 * Alterado duas ligações, um para cada serviço adicional 330D.
	 * Duas críticas de price desatualizado.
	 */
	public void testRule07() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R05rulesengine.xml";
		
		SOURCE_FILE = "r05/0120071498_Alter_34976.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 4;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
/**
 * Ticket corrigido do Gustavo, com mesmo cenário do 34976. Funcionava
 * pois caption==servName coincidiu da table price! Agora corrigido para
 * #843, ainda englobando este ak.
 */	
	public void testRule08() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R05rulesengine.xml";
		
		SOURCE_FILE = "r05/2015635884_612176.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
}
