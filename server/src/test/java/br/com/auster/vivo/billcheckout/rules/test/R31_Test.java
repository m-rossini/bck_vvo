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

import java.util.HashSet;
import java.util.Set;

import br.com.auster.vivo.billcheckout.rules.BaseTestUpdated;


/**
 * @author anardo
 * 
 */

public class R31_Test extends BaseTestUpdated {

	public static void main(String[] args) {
		R31_Test test = new R31_Test();
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
	 * Esta conta possui os seguintes tipos de call classes:
	 * <li>AD2
	 * <li>DSL2
	 * <li>FRANQUIA
	 * <li>N/C
	 * <li>VC1R
	 * <li>VC1SPV
	 * <li>VC2C
	 * <li>VC2H
	 * <li>VC2R
	 * <li>VC3H
	 * <li>VC3R
	 * <li>VIRTUAL CALL
	 * Como essa regra soh gera criticas para chamadas locais,
	 * o numero de criticas esperadas eh 0.
	 */
	public void testRule02() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R31rulesengine.xml";

		SOURCE_FILE = "r31/R31_Test02.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule03() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R31rulesengine.xml";

		SOURCE_FILE = "r31/R31_Test03.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 5;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/**
	 * Tipo ROOT_CNPJ_CRTRA
	 * 
	 * A conta ossui somente call class FRANQUIA. Isso eh local?
	 */
	public void testRule04() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R31rulesengine.xml";

		SOURCE_FILE = "r31/R31_Test04.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 6;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	// Tipo Hierarquia
	public void testRule05() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R31rulesengine.xml";

		SOURCE_FILE = "r31/R31_Test05.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	/**
	 * SIRS do Ticket #591
	 */
	public void testRule06() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R31rulesengine.xml";

		SOURCE_FILE = "r31/R31_Test06.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	/**
	 * SIRS do Ticket #602
	 */
	public void testRule07() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R31rulesengine.xml";

		SOURCE_FILE = "r31/R31_Test07.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("Chamada Intra-Grupo Hierarquia qualificada pela regra não zerada", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/**
	 * Teste para evitar a critica indevida abaixo:
		Nome da Regra	Data de Corte	Número da Conta	Estado	Operadora	Descrição	Arquivo de Origem	Ciclo	NomeDoServico	Terminal	Subscrição	ClasseDaChamada	OperadoraDaChamada	SubClasseDaChamada	TipoDeTarifa	DataHoraChamada	DuraçãoRealChamada	NumeroOrigem	NumeroDestino	ValorChamada
		Tarifação de Intra-Grupo	9/7/2008	2020995450	GO	00	Chamada Intra-Grupo CNPJ Completo qualificada pela regra não zerada	SIRS_71_20080709.prbru3.29365.0748.gz	71	LD CSP 15 PKG FLAT	6296282403	2021042517	VIRTUAL CALL	0			2008-06-18T08:33:22		6296282403	6296144815	1.05
	 */
	public void testRule08() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R31rulesengine.xml";

		SOURCE_FILE = "r31/account.2020995450.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("Chamada Intra-Grupo CNPJ Completo qualificada pela regra não zerada", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public final static Set<String> queries1 = new HashSet<String>();

	public final static Set<String> queries2 = new HashSet<String>();

	public final static Set<String> queries3 = new HashSet<String>();

	/**
	 * Teste para evitar a critica indevida abaixo:
		Nome da Regra	Data de Corte	Número da Conta	Estado	Operadora	Descrição	Arquivo de Origem	Ciclo	NomeDoServico	Terminal	Subscrição	ClasseDaChamada	OperadoraDaChamada	SubClasseDaChamada	TipoDeTarifa	DataHoraChamada	DuraçãoRealChamada	NumeroOrigem	NumeroDestino	ValorChamada
		Tarifação de Intra-Grupo	9/7/2008	0141041307	PA	00	Chamada Intra-Grupo CNPJ Completo qualificada pela regra não zerada	SIRS_71_20080709.prbru4.8340.0108.gz	71	LD CSP 15 PKG FLAT	9191664499	0141041365	VIRTUAL CALL	0			2008-06-28T15:36:23		9191664499	9191662667	8.46
		Tarifação de Intra-Grupo	9/7/2008	0141041307	PA	00	Chamada Intra-Grupo CNPJ Completo qualificada pela regra não zerada	SIRS_71_20080709.prbru4.8340.0108.gz	71	LD CSP 15 PKG FLAT	9191664499	0141041365	VIRTUAL CALL	0			2008-06-28T13:16:13		9191664499	9191662661	0.29
		Tarifação de Intra-Grupo	9/7/2008	0141041307	PA	00	Chamada Intra-Grupo CNPJ Completo qualificada pela regra não zerada	SIRS_71_20080709.prbru4.8340.0108.gz	71	LD CSP 15 PKG FLAT	9191662661	0141041388	VIRTUAL CALL	0			2008-07-08T16:51:07		9191662661	9191664499	0.64
		Tarifação de Intra-Grupo	9/7/2008	0141041307	PA	00	Chamada Intra-Grupo CNPJ Completo qualificada pela regra não zerada	SIRS_71_20080709.prbru4.8340.0108.gz	71	LD CSP 15 PKG FLAT	9191662661	0141041388	VIRTUAL CALL	0			2008-07-07T17:33:25		9191662661	9191662667	1.47
		Tarifação de Intra-Grupo	9/7/2008	0141041307	PA	00	Chamada Intra-Grupo CNPJ Completo qualificada pela regra não zerada	SIRS_71_20080709.prbru4.8340.0108.gz	71	LD CSP 15 PKG FLAT	9191662661	0141041388	VIRTUAL CALL	0			2008-07-02T11:14:42		9191662661	9191126698	2.05
	 */
	public void testRule09() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R31rulesengine.xml";

		SOURCE_FILE = "r31/account.0141041307.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("Chamada Intra-Grupo CNPJ Completo qualificada pela regra não zerada", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	/**
	   #757. 
	   * subscrição:0122344304 serviço:INTRAGRUPO ZERO UNI VC1 RAIZ svc_seq_nbr=56740693
		Executando a query 3, temos o result set: SERV V1ZEROUNI RAIZ
		Executando a query 2, temos o result set: List_CD=5 e LIST_DESC=INTRA-GRUPO UNIDIRECIONAL
		Para o retorno obtido, temos que este serviço é intra-grupo.
		Executando a query 4, obtemos o retorno: ATTR_GROUP_NAME=ROOT_CNPJ_CRTRA
		Temos, pelo resultado, que o "Tipo de Intra-Grupo" é o "CNPJ Raiz".
		Result Set iguais para os terminais 2196475181(Origem), 2196011225 e 2199679315 (Destinos), em sequência:
		ACCT_NBR        CUST_ID_TEXT
		--------------- ----------------------------------------
		0122368853      05618409000190
		Temos, do retorno, que os 8 primeiros números do CNPJ se equivalem:
		-CNPJ Raiz da conta da subscrição de Origem:  05618409000190
		-CNPJ Raiz das contas do terminal de destino: 05618409000190
		Assim, estes eventos de uso são qualificados como Intra-Grupo.
		Conclusão: Assim, temos o cenário onde o uso não está zerado, pois encontram-se, visto no Sirs,
		os valores 0.17 e 0.14, o que resulta na espera das duas críticas geradas.
	 */
	public void testRule10() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R31rulesengine.xml";
		
		SOURCE_FILE = "r31/0122368853_33364.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;
		
		assertEquals("Chamada Intra-Grupo CNPJ Completo qualificada pela regra não zerada", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
}
