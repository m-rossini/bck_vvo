/*
 * Copyright (c) 2008 Auster Solutions. All Rights Reserved.
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
 * Created on Jan 03, 2008
 *
 * @author anardo
 *
 */


package br.com.auster.vivo.billcheckout.rules.test;

import br.com.auster.vivo.billcheckout.rules.BaseTestUpdated;

public class R54_Test extends BaseTestUpdated {
	
	public static void main(String[] args) {
		R54_Test test = new R54_Test();
		
		test.testRule01();
		test.testRule02();
		test.testRule03();
		test.testRule04();
		test.testRule05();
		//#612199
		test.testRule06();
	}

	public void testRule01() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R54rulesengine.xml";

		SOURCE_FILE = "r54/R54_OK.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
				
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
	}
	public void testRule02() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R54rulesengine.xml";
		
		SOURCE_FILE = "r54/R54_all_funttel.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2; 
		//2 conseqs, pq um valor funttel coloquei com diferença de 0.01 e não deve criticar msm
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
	}
	public void testRule03() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R54rulesengine.xml";
		
		SOURCE_FILE = "r54/R54_all_fust.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;
		//2 conseqs, pq um valor fust coloquei com diferença de 0.01 e não deve criticar msm
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
	}
	
	public void testRule04() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R54rulesengine.xml";
		
		SOURCE_FILE = "r54/R54_all_nfTotal.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 5;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
	}
	public void testRule05() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R54rulesengine.xml";
		
		SOURCE_FILE = "r54/R54_two_icms.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 3;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
	}
	public void testRule06() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R54rulesengine.xml";
		
		SOURCE_FILE = "r54/2018384172.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
		
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
	}
}
