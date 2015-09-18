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
 * Created on 17/02/2007
 */
package br.com.auster.vivo.billcheckout.util;

import java.text.ParseException;
import java.util.Calendar;

import junit.framework.TestCase;
import br.com.auster.common.util.DateUtils;

/**
 * @author mtengelm
 *
 */
public class TestInvoiceUtils extends TestCase {

	/* (non-Javadoc)
	 * @see junit.framework.TestCase#setUp()
	 */
	protected void setUp() throws Exception {
		super.setUp();
	}

	/* (non-Javadoc)
	 * @see junit.framework.TestCase#tearDown()
	 */
	protected void tearDown() throws Exception {
		super.tearDown();
	}

	public void testMonth() throws IllegalArgumentException, ParseException {
		//20060127
		//20070123
		
		
		//AFTER
		Calendar c1 = Calendar.getInstance();
		c1.setLenient(false);
		c1.set(Calendar.YEAR, 2007);
		c1.set(Calendar.MONTH, 0);
		c1.set(Calendar.DAY_OF_MONTH, 01);		
		System.out.println(c1.getTime() + "->" +  c1);
		
		//BEFORE
		Calendar c2 = Calendar.getInstance();
		c2.setLenient(false);
		c2.set(Calendar.YEAR, 2006);
		c2.set(Calendar.MONTH, 0);
		c2.set(Calendar.DAY_OF_MONTH, 1);			
		System.out.println(c2.getTime() + "->" +  c2);
		
		System.out.println(DateUtils.difference(c2.getTime(), c1.getTime(), 'M'));
		System.out.println(DateUtils.difference(c2.getTime(), c1.getTime(), 'd'));
				
	}
	
	 public void testDoubles() {
		 double base = 0.8880000001;
		 System.out.println(base);
		 
		 double step1 = base * 100;
		 System.out.println(step1);	
		 
		 long step2 = Math.round(step1);
		 System.out.println(step2);
		 
		 double step3 = (double) step2/100;
		 System.out.println(step3);
	 }
}
