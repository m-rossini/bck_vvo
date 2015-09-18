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

import java.util.Iterator;

import br.com.auster.billcheckout.consequence.telco.TelcoConsequence;
import br.com.auster.vivo.billcheckout.rules.BaseTestUpdated;

/**
 * TODO What this class is responsible for
 *
 * @author William Soares
 * @version $Id$
 * @since JDK1.4
 */
public class R71_Test extends BaseTestUpdated {

	public static void main(String[] args) {
		R71_Test test = new R71_Test();
		test.testRule01();
		test.testRule02();
		test.testRule03();
		test.testRule04();
		test.testRule05();
		test.testRule06();
		test.testRule07();
		test.testRule08();
		test.testRule09();
	}

	/**
	 * Correct file: One subscription with service "GESTAO" and mandatory package "PACOTE GESTAO LIGHT".
	 */
	public void testRule01() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R71rulesengine.xml";

		SOURCE_FILE = "r71/R71_Test1.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());	

	}
	
	/**
	 * Wrong file: One subscription with service "GESTAO" and any mandatory package.
	 */
	public void testRule02() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R71rulesengine.xml";

		SOURCE_FILE = "r71/R71_Test2.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());		
		TelcoConsequence c = (TelcoConsequence)getEngine().getResults().get(0);
		assertEquals("Terminal com Serviço Gestão sem um dos Pacotes Obrigatórios.", c.getDescription());			
		
	}
	
	/**
	 * Correct file: Three subscriptions with service "GESTAO" and the mandatories packages: 
	 * "PACOTE GESTAO LIGHT" and "PACOTE GESTÃO CONTROLE CONSUMO"
	 *
	 */
	public void testRule03() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R71rulesengine.xml";

		SOURCE_FILE = "r71/R71_Test3.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());		
	}
	
	/**
	 * Wrong file: Three subscriptions: two with service "GESTAO" and mandatories packages,
	 * and one without the service.
	 */
	public void testRule04() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R71rulesengine.xml";

		SOURCE_FILE = "r71/R71_Test4.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());	
		TelcoConsequence c = (TelcoConsequence)getEngine().getResults().get(0);
		assertEquals("Conta com Terminais Gestão e Terminais não Gestão.", c.getDescription());	
	}	
	
	/**
	 * Correct file: Three subscriptions: two with service "GESTAO" (only one with the mandatory package),
	 * and one without the service.
	 */
	public void testRule05() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R71rulesengine.xml";

		SOURCE_FILE = "r71/R71_Test5.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());	
		assertEquals("Terminal com Serviço Gestão sem um dos Pacotes Obrigatórios.", ((TelcoConsequence)getEngine().getResults().get(0)).getDescription());	
		assertEquals("Conta com Terminais Gestão e Terminais não Gestão.", ((TelcoConsequence)getEngine().getResults().get(1)).getDescription());	
	}	
	
	/**
	 * Wrong file: Three subscriptions: one with service "GESTAO" and mandatories packages,
	 * and two without the service.
	 */
	public void testRule06() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R71rulesengine.xml";

		SOURCE_FILE = "r71/R71_Test6.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());	
		assertEquals("Conta com Terminais Gestão e Terminais não Gestão.", ((TelcoConsequence)getEngine().getResults().get(0)).getDescription());	
		assertEquals("Conta com Terminais Gestão e Terminais não Gestão.", ((TelcoConsequence)getEngine().getResults().get(1)).getDescription());	
	}	
	
	public void testRule07() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R71rulesengine.xml";

		SOURCE_FILE = "r71/R71_Test7.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());	
	}	
	
	public void testRule08() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R71rulesengine.xml";

		SOURCE_FILE = "r71/R71_Test8.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());	
	}	
	/**
	 * Teste para garantir que nao gere as criticas indevidas abaixo:
		Nome da Regra	Data de Corte	Número da Conta	Estado	Operadora	Descrição	Arquivo de Origem	Conta	Ciclo	Número do Terminal
		Dados Cadastrais do Cliente	9/7/2008	2021760426	AM	0	Terminal com Serviço Gestão sem um dos Pacotes Obrigatórios.	SIRS_71_20080709.prbru5.23063.0833.gz	2021760426	71	9291028956
		Dados Cadastrais do Cliente	9/7/2008	2021760426	AM	0	Terminal com Serviço Gestão sem um dos Pacotes Obrigatórios.	SIRS_71_20080709.prbru5.23063.0833.gz	2021760426	71	9291028955
		Dados Cadastrais do Cliente	9/7/2008	2021760426	AM	0	Terminal com Serviço Gestão sem um dos Pacotes Obrigatórios.	SIRS_71_20080709.prbru5.23063.0833.gz	2021760426	71	9291028954
		Dados Cadastrais do Cliente	9/7/2008	2021760426	AM	0	Terminal com Serviço Gestão sem um dos Pacotes Obrigatórios.	SIRS_71_20080709.prbru5.23063.0833.gz	2021760426	71	9291028953
		Dados Cadastrais do Cliente	9/7/2008	2021760426	AM	0	Terminal com Serviço Gestão sem um dos Pacotes Obrigatórios.	SIRS_71_20080709.prbru5.23063.0833.gz	2021760426	71	9291028952
		Dados Cadastrais do Cliente	9/7/2008	2021760426	AM	0	Terminal com Serviço Gestão sem um dos Pacotes Obrigatórios.	SIRS_71_20080709.prbru5.23063.0833.gz	2021760426	71	9291028951
		Dados Cadastrais do Cliente	9/7/2008	2021760426	AM	0	Terminal com Serviço Gestão sem um dos Pacotes Obrigatórios.	SIRS_71_20080709.prbru5.23063.0833.gz	2021760426	71	9291028949
		Dados Cadastrais do Cliente	9/7/2008	2021760426	AM	0	Terminal com Serviço Gestão sem um dos Pacotes Obrigatórios.	SIRS_71_20080709.prbru5.23063.0833.gz	2021760426	71	9291028948
	 */
	public void testRule09() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R71rulesengine.xml";

		SOURCE_FILE = "r71/account.2021760426.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());	
	}
}
