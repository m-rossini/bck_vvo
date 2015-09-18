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

public class R30_Test extends BaseTestUpdated {

	public static void main(String[] args) {
		R30_Test test = new R30_Test();
		test.testAccount0142824275();
	}

	/**
	 * Ticket #873 - asserts proper "aggregate" call support
	 */
	public void testAccount0142824275() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R30rulesengine.xml";

		SOURCE_FILE = "r30/account.0142824275.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	// Conta ok com favoritos e não favoritos
	public void testRule01() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R30rulesengine.xml";

		SOURCE_FILE = "r30/R30_Test01.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	// Favorito no billing mas não na regra
	public void testRule02() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R30rulesengine.xml";

		SOURCE_FILE = "r30/R30_Test02.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;		
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	// Favorito na regra mas nao no billing
//	public void testRule03() {
//		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
//		BUSINESS_ENGINE_PATH = "R30rulesengine.xml";
//
//		SOURCE_FILE = "r30/R30_Test03.sirs";
//		EXPECTED_BUSINESS_CONSEQUENCES = 1;
//
//		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
//	}
	
	// Cenário real de Favorito
	public void testRule04() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R30rulesengine.xml";

		SOURCE_FILE = "r30/R30_Test04.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule05() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R30rulesengine.xml";

		SOURCE_FILE = "r30/R30_Test05.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("Chamada de Favoritos não qualificada", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
//	public void testRule06() {
//		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
//		BUSINESS_ENGINE_PATH = "R30rulesengine.xml";
//
//		SOURCE_FILE = "r30/R30_Test06.sirs";
//		EXPECTED_BUSINESS_CONSEQUENCES = 1;
//
//		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
//	}
	
	public void testRule07() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R30rulesengine.xml";

		SOURCE_FILE = "r30/R30_Test07.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule08() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R30rulesengine.xml";

		SOURCE_FILE = "r30/R30_Test08.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	public void testRule09() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R30rulesengine.xml";

		SOURCE_FILE = "r30/0131300912.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
}
