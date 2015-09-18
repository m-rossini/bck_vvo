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
 * Created on 04/12/2007
 */
package br.com.auster.vivo.billcheckout.rules.test;

import br.com.auster.vivo.billcheckout.hierarchy.HierarchyHelper;
import br.com.auster.vivo.billcheckout.rules.BaseTestUpdated;

/**
 * @author anardo
 * 
 */

public class R20_Test extends BaseTestUpdated {

	public static void main(String[] args) {
		R20_Test test = new R20_Test();
//		test.testHierarchy0110118505001();
//		test.testHierarchy0110387640001();
//		test.testHierarchy0122076176001();
//		test.testHierarchy0122067632001();
		test.testHierarchy0033767606001Changed();
	}

	/*
	 * Ticket #972
	 */
	public void testHierarchy0033767606001Changed() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R20rulesengine.xml";
		EXPECTED_BUSINESS_CONSEQUENCES = 25;

		SOURCE_FILE = "r20/0033767606001-changed/account.0033767606.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033767606001-changed/account.0033767607.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033767606001-changed/account.0033767608.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033767606001-changed/account.0033767610.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033767606001-changed/account.0033767612.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033767606001-changed/account.0033767615.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033767606001-changed/account.0033767618.sirs";
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());

		HierarchyHelper.requestFinished();
	}

	/*
	 * Ticket #972
	 */
	public void testHierarchy0033767606001() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R20rulesengine.xml";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		SOURCE_FILE = "r20/0033767606001/account.0033767606.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033767606001/account.0033767607.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033767606001/account.0033767608.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033767606001/account.0033767610.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033767606001/account.0033767612.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033767606001/account.0033767615.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033767606001/account.0033767618.sirs";
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());

		HierarchyHelper.requestFinished();
	}

	/*
	 * Ticket #969
	 */
	public void testHierarchy0033767604001() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R20rulesengine.xml";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		SOURCE_FILE = "r20/0033767604001/account.0033767604.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033767604001/account.0033767611.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033767604001/account.0033767613.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033767604001/account.0033767614.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033767604001/account.0033767616.sirs";
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());

		HierarchyHelper.requestFinished();
	}

	/*
	 * Ticket #969
	 */
	public void testHierarchy0033767604001Changed() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R20rulesengine.xml";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		SOURCE_FILE = "r20/0033767604001-changed/account.0033767604.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033767604001-changed/account.0033767611.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033767604001-changed/account.0033767613.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033767604001-changed/account.0033767614.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033767604001-changed/account.0033767616.sirs";
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());

		HierarchyHelper.requestFinished();
	}

	/*
	 * Ticket #979
	 */
	public void testHierarchy0033765815001() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R20rulesengine.xml";
		EXPECTED_BUSINESS_CONSEQUENCES = 6;

		SOURCE_FILE = "r20/0033765815001/account.0033765815.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033765815001/account.0033765820.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033765815001/account.0033765823.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033765815001/account.0033765826.sirs";
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());

		HierarchyHelper.requestFinished();
	}

	/*
	 * Only one account contains the applicable services
	 */
	public void testHierarchy0033766807001() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R20rulesengine.xml";
		EXPECTED_BUSINESS_CONSEQUENCES = 10;

		SOURCE_FILE = "r20/0033766807001/account.0033766807.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033766807001/account.0033766811.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033766807001/account.0033766814.sirs";
		assertEquals("", 0, ruleTest());

		SOURCE_FILE = "r20/0033766807001/account.0033766817.sirs";
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());

		HierarchyHelper.requestFinished();
	}

	/*
	 * Free Company 30: hierarquia incompleta
	 */
	public void testTicket971() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R20rulesengine.xml";

		SOURCE_FILE = "r20/BUG_105168_SIRS_C4_20081015.pcbru1.912.0004.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
		HierarchyHelper.requestFinished();
	}

	/*
	 * 11 data services: 5% discount
	 */
	public void testTicket969() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R20rulesengine.xml";

		SOURCE_FILE = "r20/BUG_105166_SIRS_C9_20081015.pcbru1.28555.0002.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/*
	 * 10 data services: no discount
	 */
	public void testTicket969ChangedSIRS() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R20rulesengine.xml";

		SOURCE_FILE = "r20/BUG_105166_SIRS_C9_20081015.pcbru1.28555alt.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 10;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/*
	 * Incomplete hierarchy test
	 */
	public void testHierarchy0110118505001() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R20rulesengine.xml";

		SOURCE_FILE = "r20/account.2022657023.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/*
	 * Complete hierarchy test
	 */
	public void testHierarchy0110387640001() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R20rulesengine.xml";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		SOURCE_FILE = "r20/0110387640001/account.0110378203.sirs";
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());

		SOURCE_FILE = "r20/0110387640001/account.0110381312.sirs";
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());

		SOURCE_FILE = "r20/0110387640001/account.0110381359.sirs";
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());

		SOURCE_FILE = "r20/0110387640001/account.0110389555.sirs";
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/*
	 * Another complete hierarchy test: 1 account with 9 subscribers (only 1 ASSINATURA MENSAL - EMPRESA MASTER 80)
	 */
	public void testHierarchy0122076176001() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R20rulesengine.xml";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		SOURCE_FILE = "r20/account.0122132987.sirs";
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	/*
	 * Another complete hierarchy test: 1 account with 200 subscribers
	 */
	public void testHierarchy0122067632001() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R20rulesengine.xml";
		EXPECTED_BUSINESS_CONSEQUENCES = 2;

		SOURCE_FILE = "r20/account.0122202842.sirs";
		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule01() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R20rulesengine.xml";

		SOURCE_FILE = "r20/R20_pro-rate.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

/*	public void testRule02() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R20rulesengine.xml";

		SOURCE_FILE = "r20/R20_plano_empresa.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 21;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
	*/
	public void testUsageDiscount() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R20rulesengine.xml";

		SOURCE_FILE = "r20/R20_free_company_changed.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 1;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}

	public void testRule03() {
		GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
		BUSINESS_ENGINE_PATH = "R20rulesengine.xml";

		SOURCE_FILE = "r20/R20_blocked.sirs";
		EXPECTED_BUSINESS_CONSEQUENCES = 0;

		assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
	}
}
