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
 * Created on Dec 11, 2007
 */
package br.com.auster.vivo.billcheckout.rules.test;

import br.com.auster.vivo.billcheckout.rules.BaseTestUpdated;

/**
 * @author anardo
 *
 */

public class R64_Test extends BaseTestUpdated{	
	public static void main(String[] args) {
		R64_Test test = new R64_Test();
		test.testRule01();		
		test.testRule02();		
		test.testRule03();		
		test.testRule04();		
		test.testRule05();		
		test.testRule06();		
	}
		    
	  public void testRule01() { 
			GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
			BUSINESS_ENGINE_PATH = "R64rulesengine.xml";

			SOURCE_FILE = "r64/R64_mesPeriodFinal.sirs";
			EXPECTED_BUSINESS_CONSEQUENCES = 2;
					
			assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());
			
			//ak gera duas críticas pois o mês da data de corte é usado na comparação
			//do Mês de Referência e do Período da Fatura
			
		}
	  
	  public void testRule02() { 
			GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
			BUSINESS_ENGINE_PATH = "R64rulesengine.xml";

			SOURCE_FILE = "r64/R64_mesPeriodInitial.sirs";
			EXPECTED_BUSINESS_CONSEQUENCES = 1;
					
			assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
		}
	  
	  public void testRule03() { 
			GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
			BUSINESS_ENGINE_PATH = "R64rulesengine.xml";

			SOURCE_FILE = "r64/R64_mesRefCorte.sirs";
			EXPECTED_BUSINESS_CONSEQUENCES = 2;
					
			assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
		}
	  
	  public void testRule04() { 
			GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
			BUSINESS_ENGINE_PATH = "R64rulesengine.xml";

			SOURCE_FILE = "r64/R64_OK.sirs";
			EXPECTED_BUSINESS_CONSEQUENCES = 0;
					
			assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
		}
	  
	  public void testRule05() { 
			GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
			BUSINESS_ENGINE_PATH = "R64rulesengine.xml";

			SOURCE_FILE = "r64/R64_mesRefProces.sirs";
			EXPECTED_BUSINESS_CONSEQUENCES = 1;
					
			assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
		}
	  
	  public void testRule06() { 
			GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
			BUSINESS_ENGINE_PATH = "R64rulesengine.xml";

			SOURCE_FILE = "r64/R64_RefCorte_DiaPeriodFinal.sirs";
			EXPECTED_BUSINESS_CONSEQUENCES = 2;
					
			assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
		}
	  
	  public void testRule07() { 
			GUIDING_ENGINE_PATH = "GUIDINGrulesengine.xml";
			BUSINESS_ENGINE_PATH = "R64rulesengine.xml";

			SOURCE_FILE = "r64/R64_Bug01.sirs";
			EXPECTED_BUSINESS_CONSEQUENCES = 1;
					
			assertEquals("", EXPECTED_BUSINESS_CONSEQUENCES, ruleTest());						
		}
}
