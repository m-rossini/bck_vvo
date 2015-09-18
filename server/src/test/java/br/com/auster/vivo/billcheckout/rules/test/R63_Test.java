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
 * @author Luciano
 * Rule 63 unit tests. The following tests are performed:
 * <li>a few correct SIRS
 * <li>each possibly incorrect field (each SIRS has one or more changed fields so that the total amount will not match)
 */
public class R63_Test extends BaseTestUpdated {

	public static void main(String[] args) {
		new R63_Test().testTicket556();
	}

	public void testTicket555() {
		// PLANO TESTE NOVO exige COLABORADOR VIVO (uma critica para cada terminal)
		doTheTest("BUG_104433_SIRS_H3_20080527.pcbru1.23082.0003alt1.sirs", 2);
	}

	public void testTicket556() {
		// Ticket invalidado por correcao da ET (must have deve ser aplicado somente em um sentido)
		doTheTest("BUG_104435_SIRS_H3_20080527.pcbru1.12865.0004alt.sirs", 0);
	}

	public void testTicket619() {
		// PLANO TESTE NOVO nao convive com GESTAO
		// PLANO TESTE NOVO exige COLABORADOR VIVO
		doTheTest("BUG_104600_SIRS_H3_20080627.pcbru1.1182.0005.sirs", 2);
	}

	public void testTicket630() {
		doTheTest("BUG_104609_SIRS_H3_20080627.pcbru1.4645.0005.sirs", 0);
	}

	public void doTheTest(String sirsFile, int expectedConsequences) {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R63rulesengine.xml";

		SOURCE_FILE = "r63/" + sirsFile;
		EXPECTED_BUSINESS_CONSEQUENCES = expectedConsequences;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
}
