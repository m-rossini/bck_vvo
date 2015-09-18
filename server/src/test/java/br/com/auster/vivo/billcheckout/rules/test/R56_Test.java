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
 * @author dcunha
 * 
 */

public class R56_Test extends BaseTestUpdated {

	public static void main(String[] args) {
		R56_Test test = new R56_Test();	
		//test.testPriorityOrderOk1();
		//test.testPriorityOrderOk2();
		//test.testPriorityOrderOk3();
		//test.testPriorityOrderNotOk();
		test.testPriorityOrderNotOk();
		//test.testTicket609();
	}

	public void testPriorityOrderOk1() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R56rulesengine.xml";

		SOURCE_FILE = "r56/R56_Test01.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testPriorityOrderOk2() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R56rulesengine.xml";

		SOURCE_FILE = "r56/R56_Test02.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testPriorityOrderOk3() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R56rulesengine.xml";

		SOURCE_FILE = "r56/R56_Test03.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testPriorityOrderOk4() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R56rulesengine.xml";

		SOURCE_FILE = "r56/R56_Test04.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testPriorityOrderNotOk() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R56rulesengine.xml";

		SOURCE_FILE = "r56/R56_Test05.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testPriorityMultiOrderOk() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R56rulesengine.xml";

		SOURCE_FILE = "r56/R56_Test06.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	

	public void testPriorityMultiOrderNotOk() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R56rulesengine.xml";

		SOURCE_FILE = "r56/R56_Test07.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 3;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}	
	
	/**
	 * Testing SIRS regarding Ticket #609.
	 *
	 */
	public void testTicket609() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R56rulesengine.xml";

		SOURCE_FILE = "r56/R56_Test08.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}	
	public void testPerformance() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R56rulesengine.xml";

		SOURCE_FILE = "performance/R65_PerformanceTestGuidingFaster_Large-FRED.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 75;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}	
	
}
