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
 * Created on 18/02/2008
 */
package br.com.auster.vivo.billcheckout.rules.test;

import br.com.auster.vivo.billcheckout.rules.BaseTestUpdated;

/**
 * TODO What this class is responsible for
 *
 * @author William Soares
 * @version $Id$
 * @since JDK1.4
 */
public class R73_Test extends BaseTestUpdated {

	public static void main(String[] args) {
		R73_Test test = new R73_Test();
		test.testRule01();
	}

	public void testRule01() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R73rulesengine.xml";
	
		SOURCE_FILE = "r73/R73_Test1.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
	
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());	
	
	}
	
	public void testRule02() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R73rulesengine.xml";
	
		SOURCE_FILE = "r73/R73_Test2.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
	
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());	
	
	}
	
	public void testRule03() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R73rulesengine.xml";
	
		SOURCE_FILE = "r73/R73_Test3.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;
	
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());	
	
	}
	
	public void testRule04() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R73rulesengine.xml";
	
		SOURCE_FILE = "r73/R73_Test4.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;
	
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());	
	
	}

}
	