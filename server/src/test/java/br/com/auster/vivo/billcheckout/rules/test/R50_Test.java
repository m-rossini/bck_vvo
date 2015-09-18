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

public class R50_Test extends BaseTestUpdated {

	public static void main(String[] args) {
		R50_Test test = new R50_Test();
		test.testAccount2011718991();
	}

	/**
	 * Assures not to create consequences of R$ 0,01 difference (ticket #983).
	 * The following consequences are expected:
	 * <li>Description=[Chamada Nacional Negociada Tarifada Incorretamente] [0] Ciclo=12 [1] NomeDoServico=VIVO EMP ZERO PK [2] Valor Calculado=1,13 [3] Valor Cobrado=0,87 [4] Diferença=0,26 [5] Classe Chamada=VC1C [6] Tarifa Chamada=P [7] Data=08/11/08 [8] Hora=07h53m37s [9] Número Origem=2798372386 [10] Número Destino=27-9833-1610 [11] Duração Chamada=00h02m54s [12] Cenário=81937920 [13] Valor Inicial=0,20 [14] Valor Adicional=0,04 [15] Unidade=SECONDS [16] Categoria=4 [17] Imposto=1,40 [18] Estado Subscrição=ES [19] Tipo de Cliente=X
	 * <li>Description=[Chamada Nacional Negociada Tarifada Incorretamente] [0] Ciclo=12 [1] NomeDoServico=VIVO EMP ZERO PK [2] Valor Calculado=0,82 [3] Valor Cobrado=0,63 [4] Diferença=0,19 [5] Classe Chamada=VC1C [6] Tarifa Chamada=P [7] Data=07/11/08 [8] Hora=18h34m11s [9] Número Origem=2798372386 [10] Número Destino=27-9833-1610 [11] Duração Chamada=00h02m06s [12] Cenário=81937920 [13] Valor Inicial=0,20 [14] Valor Adicional=0,04 [15] Unidade=SECONDS [16] Categoria=4 [17] Imposto=1,40 [18] Estado Subscrição=ES [19] Tipo de Cliente=X
	 * <li>Description=[Chamada Nacional Negociada Tarifada Incorretamente] [0] Ciclo=12 [1] NomeDoServico=VIVO EMP ZERO PK [2] Valor Calculado=0,35 [3] Valor Cobrado=0,27 [4] Diferença=0,08 [5] Classe Chamada=VC1H [6] Tarifa Chamada=P [7] Data=12/11/08 [8] Hora=16h23m18s [9] Número Origem=2798372373 [10] Número Destino=27-9935-4504 [11] Duração Chamada=00h00m54s [12] Cenário=81938040 [13] Valor Inicial=0,20 [14] Valor Adicional=0,04 [15] Unidade=SECONDS [16] Categoria=4 [17] Imposto=1,40 [18] Estado Subscrição=ES [19] Tipo de Cliente=X
	 * <li>Description=[Chamada Nacional Negociada Tarifada Incorretamente] [0] Ciclo=12 [1] NomeDoServico=VIVO EMP ZERO PK [2] Valor Calculado=0,19 [3] Valor Cobrado=0,15 [4] Diferença=0,04 [5] Classe Chamada=VC1H [6] Tarifa Chamada=P [7] Data=12/11/08 [8] Hora=07h15m25s [9] Número Origem=2798372373 [10] Número Destino=27-9941-8663 [11] Duração Chamada=00h00m30s [12] Cenário=81938040 [13] Valor Inicial=0,20 [14] Valor Adicional=0,04 [15] Unidade=SECONDS [16] Categoria=4 [17] Imposto=1,40 [18] Estado Subscrição=ES [19] Tipo de Cliente=X
	 * <li>Description=[Preço Negociado com Excesso de Erros de Tarifação.] [0] Ocorrencias=4 [1] NomeDoServico=VIVO EMP ZERO PK [2] Qualificacao=VC1C.MMI.P
	 * <li>Description=[Preço Negociado com Excesso de Erros de Tarifação.] [0] Ocorrencias=20 [1] NomeDoServico=VIVO EMP ZERO PK [2] Qualificacao=VC1H.MMI.P
	 */
	public void testAccount2011718991() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R50rulesengine.xml";

		SOURCE_FILE = "r50/account.2011718991.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 6;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}	

	// Descounted Negotiation
	public void testRule01() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R50rulesengine.xml";

		SOURCE_FILE = "r50/R50_Test01.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}	

	// Increased Negotiation
	public void testRule02() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R50rulesengine.xml";

		SOURCE_FILE = "r50/R50_Test02.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}	
	
	// Deslocamento
	public void testRule03() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R50rulesengine.xml";

		SOURCE_FILE = "r50/R50_Test03.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}	
	
	// AD
	public void testRule04() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R50rulesengine.xml";

		SOURCE_FILE = "r50/R50_Test04.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}	

}
