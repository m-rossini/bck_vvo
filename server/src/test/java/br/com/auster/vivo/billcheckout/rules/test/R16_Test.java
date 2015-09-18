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
 * Created on 07/12/2007
 */
package br.com.auster.vivo.billcheckout.rules.test;

import br.com.auster.vivo.billcheckout.rules.BaseTestUpdated;

/**
 * @author anardo
 * 
 */

public class R16_Test extends BaseTestUpdated {
	public static void main(String[] args) {
		R16_Test test = new R16_Test();
		test.testRule_games();
		test.testRule_play();
		test.testRule_zap();
		test.testRule_01();
		test.testRule_02();
	}

	public void testRule_games() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R16rulesengine.xml";

		SOURCE_FILE = "r16/R16_games.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule_play() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R16rulesengine.xml";

		SOURCE_FILE = "r16/R16_play.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;

		assertEquals("Valor da Chamada superior ao máximo.", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule_zap() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R16rulesengine.xml";

		SOURCE_FILE = "r16/R16_zap.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule_01() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R16rulesengine.xml";

		SOURCE_FILE = "r16/R16_Test02.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 3;

		assertEquals("Valor da Chamada superior ao máximo.", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule_02() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R16rulesengine.xml";

		SOURCE_FILE = "r16/R16_Test03.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 3;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
}
