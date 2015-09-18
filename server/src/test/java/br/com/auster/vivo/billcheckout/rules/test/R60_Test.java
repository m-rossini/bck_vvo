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
 * Created on 05/12/2007
 */
package br.com.auster.vivo.billcheckout.rules.test;

import br.com.auster.vivo.billcheckout.rules.BaseTestUpdated;

/**
 * @author anardo
 * 
 */

public class R60_Test extends BaseTestUpdated {

	public static void main(String[] args) {
		R60_Test test = new R60_Test();
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
		BUSINESS_ENGINE_PATH = "R60rulesengine.xml";

		SOURCE_FILE = "r60/R60_Test01.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule02() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R60rulesengine.xml";

		SOURCE_FILE = "r60/R60_Test02.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule03() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R60rulesengine.xml";

		SOURCE_FILE = "r60/R60_Test03.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule04() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R60rulesengine.xml";

		SOURCE_FILE = "r60/R60_Test04.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule05() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R60rulesengine.xml";

		SOURCE_FILE = "r60/R60_Test05.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule06() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R60rulesengine.xml";

		SOURCE_FILE = "r60/R60_Test06.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule07() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R60rulesengine.xml";

		SOURCE_FILE = "r60/R60_Test07.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	
	public void testRule08() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R60rulesengine.xml";

		SOURCE_FILE = "r60/R60_Test08.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
}
