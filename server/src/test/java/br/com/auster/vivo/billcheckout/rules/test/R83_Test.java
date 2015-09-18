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

import br.com.auster.vivo.billcheckout.rules.BaseTestUpdated;

/**
 * @author anardo
 * 
 */

public class R83_Test extends BaseTestUpdated {

	public static void main(String[] args) {
		R83_Test test = new R83_Test();
//		test.testRule01();
//		test.testRule02();
//		test.testRule03();
//		test.testRule04();
//		test.testRule05();
//		test.testRule06();
//		test.testRule09();
//		test.testRule10();
		test.testRule14();
	}

	public void testRule01() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R83rulesengine.xml";

		SOURCE_FILE = "r83/R83_Test01.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	// Numero tipo 0300
	public void testRule02() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R83rulesengine.xml";

		SOURCE_FILE = "r83/R83_Test02.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	// Portal de Voz
	public void testRule03() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R83rulesengine.xml";

		SOURCE_FILE = "r83/R83_portal_voz.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	//Caixa Postal
	public void testRule04() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R83rulesengine.xml";

		SOURCE_FILE = "r83/R83_caixa_postal.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	
	//Vivo Informa
	public void testRule05() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R83rulesengine.xml";

		SOURCE_FILE = "r83/R83_vivo_informa.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule06() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R83rulesengine.xml";

		SOURCE_FILE = "r83/R83_Test07.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule08() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R83rulesengine.xml";

		SOURCE_FILE = "r83/R83_Test08.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 6;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule09() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R83rulesengine.xml";

		SOURCE_FILE = "performance/R65_PerformanceTest01_Extra_LargeDaniel.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/**
	 * Teste para evitar a critica indevida abaixo:
		Nome da Regra	Data de Corte	Número da Conta	Estado	Operadora	Descrição	Arquivo de Origem	Ciclo	NomeDoServico	Terminal	Subscrição	Seção	Data	Hora	OrigemChamada	NumeroChamado		DestinoChamado	EstadoOrigem	EstadoDestino	Duracao	Valor	Tarifa	Classe	Subclasse
		Informações Incompletas	9/7/2008	2020445768	GO	0	Número Chamado com tamanho diferente de 10	SIRS_71_20080709.prbru3.29365.0748.gz	71	SPCLDIG	6299683388	2020445769	Chamadas Locais	20/6/2008	T14:45:32	AREA 62	62102	x	AUXILIO A LISTA	GO	GO	1.00	1.99	P	S.V.A.	U
	*/
	public void testRule10() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R83rulesengine.xml";

		SOURCE_FILE = "r83/account.2020445768.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/**
	 * Teste para evitar as criticas indevidas abaixo:
		Nome da Regra	Data de Corte	Número da Conta	Estado	Operadora	Descrição	Arquivo de Origem	Ciclo	NomeDoServico	Terminal	Subscrição	Seção	Data	Hora	OrigemChamada	NumeroChamado		DestinoChamado	EstadoOrigem	EstadoDestino	Duracao	Valor	Tarifa	Classe	Subclasse
		Informações Incompletas	9/7/2008	2021760426	AM	0	Número Chamado com tamanho diferente de 10	SIRS_71_20080709.prbru5.23063.0833.gz	71	GESTAO	9291028956	2021765505	Chamadas Locais	26/6/2008	T01:50:33	AREA 92	*365	x		AM		0.50	0.75	O	S.V.A.	U
		Informações Incompletas	9/7/2008	2021760426	AM	0	Número Chamado com tamanho diferente de 10	SIRS_71_20080709.prbru5.23063.0833.gz	71	GESTAO	9291028953	2021765500	Chamadas Locais	9/7/2008	T20:57:55	AREA 92	*555	x		AM		1.00	0.26	P	*1234/*555	MMI
		Informações Incompletas	9/7/2008	2021760426	AM	0	Número Chamado com tamanho diferente de 10	SIRS_71_20080709.prbru5.23063.0833.gz	71	GESTAO	9291028953	2021765500	Chamadas Locais	4/7/2008	T20:16:07	AREA 92	*555	x		AM		1.80	0.47	P	*1234/*555	MMI
	*/
	public void testRule11() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R83rulesengine.xml";

		SOURCE_FILE = "r83/account.2021760426.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/**
	 * Teste para evitar as criticas indevidas abaixo:
		Nome da Regra	Data de Corte	Número da Conta	Estado	Operadora	Descrição	Arquivo de Origem	Ciclo	NomeDoServico	Terminal	Subscrição	Seção	Data	Hora	OrigemChamada	NumeroChamado		DestinoChamado	EstadoOrigem	EstadoDestino	Duracao	Valor	Tarifa	Classe	Subclasse
		Informações Incompletas	9/7/2008	2022511814	SP	0	Número Chamado com tamanho diferente de 10	SIRS_71_20080709.prbru6.22854.0828.gz	71	PLANO NAC4 100 MIN	1196094639	2022549645	Serviços de Voz	6/7/2008	T23:51:47	AREA 15	*555	x		SP	SP		0.96		VIRTUAL CALL	
		Informações Incompletas	9/7/2008	2022511814	SP	0	Número Chamado com tamanho diferente de 10	SIRS_71_20080709.prbru6.22854.0828.gz	71	PLANO NAC4 100 MIN	1196094639	2022549645	Serviços de Voz	29/6/2008	T23:02:59	AREA 15	*555	x		SP	SP		0.40		VIRTUAL CALL	
		Informações Incompletas	9/7/2008	2022511814	SP	0	Número Chamado com tamanho diferente de 10	SIRS_71_20080709.prbru6.22854.0828.gz	71	PLANO NAC4 100 MIN	1196094639	2022549645	Serviços de Voz	29/6/2008	T23:00:07	AREA 15	*555	x		SP	SP		0.64		VIRTUAL CALL	
		Informações Incompletas	9/7/2008	2022511814	SP	0	Número Chamado com tamanho diferente de 10	SIRS_71_20080709.prbru6.22854.0828.gz	71	PLANO NAC4 100 MIN	1196094639	2022549645	Serviços de Voz	29/6/2008	T00:00:08	AREA 15	*555	x		SP	SP		0.14		VIRTUAL CALL	
		Informações Incompletas	9/7/2008	2022511814	SP	0	Número Chamado com tamanho diferente de 10	SIRS_71_20080709.prbru6.22854.0828.gz	71	PLANO NAC4 100 MIN	1196094639	2022549645	Serviços de Voz	28/6/2008	T23:57:28	AREA 15	*555	x		SP	SP		0.21		VIRTUAL CALL	
		Informações Incompletas	9/7/2008	2022511814	SP	0	Número Chamado com tamanho diferente de 10	SIRS_71_20080709.prbru6.22854.0828.gz	71	PLANO NAC4 100 MIN	1196094639	2022549645	Serviços de Voz	28/6/2008	T22:24:09	AREA 15	*555	x		SP	SP		0.12		VIRTUAL CALL	
		Informações Incompletas	9/7/2008	2022511814	SP	0	Número Chamado com tamanho diferente de 10	SIRS_71_20080709.prbru6.22854.0828.gz	71	PLANO NAC4 100 MIN	1196094639	2022549645	Chamadas Locais Originadas em Roaming	6/7/2008	T23:51:47	AREA 15	*555	x		SP	SP	3.70	0.00		AD1	VC1SPV
		Informações Incompletas	9/7/2008	2022511814	SP	0	Número Chamado com tamanho diferente de 10	SIRS_71_20080709.prbru6.22854.0828.gz	71	PLANO NAC4 100 MIN	1196094639	2022549645	Chamadas Locais Originadas em Roaming	29/6/2008	T23:02:59	AREA 15	*555	x		SP	SP	1.70	0.00		AD1	VC1SPV
		Informações Incompletas	9/7/2008	2022511814	SP	0	Número Chamado com tamanho diferente de 10	SIRS_71_20080709.prbru6.22854.0828.gz	71	PLANO NAC4 100 MIN	1196094639	2022549645	Chamadas Locais Originadas em Roaming	29/6/2008	T23:00:07	AREA 15	*555	x		SP	SP	2.70	0.00		AD1	VC1SPV
		Informações Incompletas	9/7/2008	2022511814	SP	0	Número Chamado com tamanho diferente de 10	SIRS_71_20080709.prbru6.22854.0828.gz	71	PLANO NAC4 100 MIN	1196094639	2022549645	Chamadas Locais Originadas em Roaming	29/6/2008	T00:00:08	AREA 15	*555	x		SP	SP	0.60	0.00		AD1	VC1SPV
		Informações Incompletas	9/7/2008	2022511814	SP	0	Número Chamado com tamanho diferente de 10	SIRS_71_20080709.prbru6.22854.0828.gz	71	PLANO NAC4 100 MIN	1196094639	2022549645	Chamadas Locais Originadas em Roaming	28/6/2008	T23:57:28	AREA 15	*555	x		SP	SP	0.90	0.00		AD1	VC1SPV
	 */
	public void testRule12() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R83rulesengine.xml";

		SOURCE_FILE = "r83/account.2022511814.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/**
	 * Teste para evitar as criticas indevidas abaixo:
		Nome da Regra	Data de Corte	Número da Conta	Estado	Operadora	Descrição	Arquivo de Origem	Ciclo	NomeDoServico	Terminal	Subscrição	Seção	Data	Hora	OrigemChamada	NumeroChamado	DestinoChamado	EstadoOrigem	EstadoDestino	Duracao	Valor	Tarifa	Classe	Subclasse
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	30/6/2008	T10:58:08	AREA 11		AREA 11	SP	SP	1.20	0.00		AD2	U
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	29/6/2008	T10:56:08	AREA 11		AREA 11	SP	SP	5.40	0.00		AD2	U
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	29/6/2008	T08:30:45	AREA 11		AREA 11	SP	SP	6.90	0.00		AD2	U
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	28/6/2008	T18:20:51	AREA 11		AREA 11	SP	SP	1.70	0.00		AD2	U
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	28/6/2008	T17:37:47	AREA 11		AREA 11	SP	SP	2.20	0.00		AD2	U
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	28/6/2008	T16:49:29	AREA 11		AREA 11	SP	SP	4.60	0.00		AD2	U
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	28/6/2008	T08:36:21	AREA 11		AREA 11	SP	SP	1.00	0.00		AD2	U
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	27/6/2008	T09:28:11	AREA 11		AREA 11	SP	SP	1.80	0.00		AD2	U
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	26/6/2008	T16:03:15	AREA 11		AREA 11	SP	SP	0.50	0.00		AD2	U
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	26/6/2008	T15:08:58	AREA 11		AREA 11	SP	SP	1.50	0.00		AD2	U
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	26/6/2008	T14:51:14	AREA 11		AREA 11	SP	SP	5.90	0.00		AD2	U
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	26/6/2008	T14:27:56	AREA 11		AREA 11	SP	SP	4.90	0.00		AD2	U
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	26/6/2008	T12:54:35	AREA 11		AREA 11	SP	SP	3.70	0.00		AD2	U
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	26/6/2008	T11:42:46	AREA 11		AREA 11	SP	SP	2.20	0.00		AD2	U
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	25/6/2008	T19:26:31	AREA 11		AREA 11	SP	SP	0.50	0.00		AD2	U
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	25/6/2008	T17:47:33	AREA 11		AREA 11	SP	SP	4.10	0.00		AD2	U
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	25/6/2008	T17:36:51	AREA 11		AREA 11	SP	SP	1.00	0.00		AD2	U
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	24/6/2008	T09:28:47	AREA 11		AREA 11	SP	SP	0.60	0.00		AD2	U
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	23/6/2008	T12:54:06	AREA 11		AREA 11	SP	SP	2.20	0.00		AD2	U
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	23/6/2008	T11:16:40	AREA 11		AREA 11	SP	SP	0.60	0.00		AD2	U
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	23/6/2008	T11:05:22	AREA 11		AREA 11	SP	SP	0.60	0.00		AD2	U
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	23/6/2008	T11:02:51	AREA 11		AREA 11	SP	SP	1.80	0.00		AD2	U
		Informações Incompletas	9/7/2008	2020716594	BA	0	Número Chamado faltando	SIRS_71_20080709.prbru3.29365.0748.gz	71	VIVO MAIS 650 TIT RJ	7199734766	2020716734	Chamadas Locais Recebidas em Roaming	23/6/2008	T10:48:08	AREA 11		AREA 11	SP	SP	2.80	0.00		AD2	U
	 */
	public void testRule13() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R83rulesengine.xml";

		SOURCE_FILE = "r83/account.2020716594.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/**
	 * Teste para evitar as criticas indevidas abaixo:
		Nome da Regra	Data de Corte	Número da Conta	Estado	Operadora	Descrição	Arquivo de Origem	Ciclo	NomeDoServico	Terminal	Subscrição	Seção	Data	Hora	OrigemChamada	NumeroChamado	DestinoChamado	EstadoOrigem	EstadoDestino	Duracao	Valor	Tarifa	Classe	Subclasse
		Conteúdo de Campo Inválido	9/7/2008	2018384172	BA	0	Número Chamado com tamanho diferente de 10	R54_2018384172.txt	71	GESTAO	7199746859	2018398286	Chamadas Locais Originadas em Roaming	12/6/2008	T10:32:00	AREA 74	*365		BA		1.90	2.83	P	VC1R	MF
		Conteúdo de Campo Inválido	9/7/2008	2018384172	BA	0	Número Chamado com tamanho diferente de 10	R54_2018384172.txt	71	GESTAO	7199746859	2018398286	Chamadas Locais Originadas em Roaming	12/6/2008	T10:31:26	AREA 74	*365		BA		0.50	0.74	P	VC1R	MF
		Conteúdo de Campo Inválido	9/7/2008	2018384172	BA	0	Número Chamado com tamanho diferente de 10	R54_2018384172.txt	71	GESTAO	7199746859	2018398286	Chamadas Locais Originadas em Roaming	12/6/2008	T07:51:44	AREA 74	*365		BA		0.50	0.74	O	VC1R	MF
		Conteúdo de Campo Inválido	9/7/2008	2018384172	BA	0	Número Chamado com tamanho diferente de 10	R54_2018384172.txt	71	GESTAO	7199887917	2020233832	ChamadasChamadas Locais	08/7/2008	T22:22:28	AREA 71	130	HORA CERTA	BA		0.50	0.24	O	S.V.A.	U
		Conteúdo de Campo Inválido	9/7/2008	2018384172	BA	0	Estado de Destino faltando	R54_2018384172.txt	71	GESTAO	7199746859	2018398286	Chamadas Locais Originadas em Roaming	12/6/2008	T10:32:00	AREA 74	*365		BA		1.90	2.83	P	VC1R	MF
		Conteúdo de Campo Inválido	9/7/2008	2018384172	BA	0	Estado de Destino faltando	R54_2018384172.txt	71	GESTAO	7199746859	2018398286	Chamadas Locais Originadas em Roaming	12/6/2008	T10:31:26	AREA 74	*365		BA		0.50	0.74	P	VC1R	MF
		Conteúdo de Campo Inválido	9/7/2008	2018384172	BA	0	Estado de Destino faltando	R54_2018384172.txt	71	GESTAO	7199746859	2018398286	Chamadas Locais Originadas em Roaming	12/6/2008	T07:51:44	AREA 74	*365		BA		0.50	0.74	O	VC1R	MF
	 */
	public void testRule14() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R83rulesengine.xml";

		SOURCE_FILE = "r83/account.2018384172.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/**
	 * Teste para evitar a critica indevida abaixo:
		Nome da Regra	Data de Corte	Número da Conta	Estado	Operadora	Descrição	Arquivo de Origem	Ciclo	NomeDoServico	Terminal	Subscrição	Seção	Data	Hora	OrigemChamada	NumeroChamado	DestinoChamado	EstadoOrigem	EstadoDestino	Duracao	Valor	Tarifa	Classe	Subclasse
		Conteúdo de Campo Inválido	9/7/2008	2031230646	RJ	0	Número Chamado com tamanho diferente de 10	R54_2031230646.txt	71	VIVO MAIS 650 TIT RJ	2198802480	2031230647	Chamadas Locais Originadas em Roaming	17/6/2008	T20:20:48	AREA 11	*365		SP	SP	0.50	0.00	U	FRANQUIA	VC1SPV
	 */
	public void testRule15() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R83rulesengine.xml";

		SOURCE_FILE = "r83/account.2031230646.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
}
