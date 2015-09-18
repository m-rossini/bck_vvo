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
 * Created on 29/12/2006
 */
package br.com.auster.vivo.billcheckout.util;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.concurrent.atomic.AtomicInteger;

import junit.framework.TestCase;

import org.apache.commons.math.util.MathUtils;

/**
 * @author mtengelm
 *
 */
public class TestNumerics extends TestCase {

	/* (non-Javadoc)
	 * @see junit.framework.TestCase#setUp()
	 */
	protected void setUp() throws Exception {
		int it0=143564;
		it0++;
		
		AtomicInteger it1 = new AtomicInteger(0);
		it1.incrementAndGet();
		
		super.setUp();
	}

	/* (non-Javadoc)
	 * @see junit.framework.TestCase#tearDown()
	 */
	protected void tearDown() throws Exception {
		super.tearDown();
	}

	public void testDST() {		
		String d1 = "20071103";
		goDST(d1);

		String d2 = "20071104";
		goDST(d2);

		String d3 = "20071105";
		goDST(d3);

	}
	
	private void goDST(String date) {
		String pattern = "yyyyMMdd";
		SimpleDateFormat sdf = new SimpleDateFormat();		
		Calendar c1 = Calendar.getInstance();
		sdf.applyPattern(pattern);
		try {
			c1.setTime(sdf.parse(date));
		} catch (ParseException e) {
			fail("Error no testDST()");
		}
		System.out.println("C1-A:" + c1.getTime());
		
		c1.set(Calendar.HOUR_OF_DAY, 23);
		c1.set(Calendar.MINUTE, 59);
		c1.set(Calendar.SECOND, 59);
		c1.set(Calendar.MILLISECOND, 999);
		System.out.println("C1-B:" + c1.getTime());
		
	}
	
	public void testDateDifference() {
		Calendar calFirst = Calendar.getInstance();
		calFirst.set(Calendar.YEAR, 2007);
		calFirst.set(Calendar.MONTH, 7);
		calFirst.set(Calendar.DAY_OF_MONTH, 25);
		calFirst.set(Calendar.HOUR,5);
		calFirst.set(Calendar.MINUTE,0);
		calFirst.set(Calendar.SECOND,0);
		Date dateFirst = calFirst.getTime();
		System.out.println("Date First:" + dateFirst);
		
		Calendar calLast = Calendar.getInstance();
		calLast.set(Calendar.YEAR, 2007);
		calLast.set(Calendar.MONTH, 10);
		calLast.set(Calendar.DAY_OF_MONTH, 24);
		calLast.set(Calendar.HOUR,11);
		calLast.set(Calendar.MINUTE,59);
		calLast.set(Calendar.SECOND,59);
		Date dateLast = calLast.getTime();
		System.out.println("Date Last:" + dateLast);
		
		
		calLast.add(Calendar.DAY_OF_MONTH, -90);
		Date rolled = calLast.getTime();
		System.out.println("Date Rolled:" + rolled);
				
	}
	
	public void testRounding() {
		double value = 207.61805910876;
		System.out.println(MathUtils.round(value, 0));
		System.out.println(MathUtils.round(value, 1));
		System.out.println(MathUtils.round(value, 2));
		System.out.println(MathUtils.round(value, 3));
		System.out.println(MathUtils.round(value, 4));
		System.out.println(MathUtils.round(value, 5));		
	}
	
	public void testTrunc() {
		double value = 207.61805910876;
		System.out.println(truncate(value,0));
		System.out.println(truncate(value,1));
		System.out.println(truncate(value,2));
		System.out.println(truncate(value,3));
		System.out.println(truncate(value,4));
		System.out.println(truncate(value,5));		
	}
	
	public double truncate(double value, int pos) {	
		double temp = value - Math.floor(value);		
	
		double factor = Math.pow(10, pos);
		double res = factor * temp;		
		
		double newFloor = Math.floor(res);
		
		newFloor = newFloor / factor;
		
		return newFloor + Math.floor(value);
	}
	
	public void testCalculatePrice() {
  	double calc = Math.abs(0.2903465721234995);
  	double chrg = Math.abs(0.27) ;	  	
  	double diff = Math.abs(calc - chrg);
  	diff = Math.floor(diff*100)/100;
  	System.out.println(diff <= 0.01);
	}
	
	public void testNumberPatterns() {
		Locale loc = new Locale("pt", "BR");
		NumberFormat nf = NumberFormat.getInstance(loc);
		if (nf instanceof DecimalFormat) {
			DecimalFormat df = (DecimalFormat) nf;
			String original="" ;
			Number number = null;
			
			try {
				df.applyPattern("#,##0.0000");
				DecimalFormatSymbols sym = df.getDecimalFormatSymbols();
				System.out.println("PatternSeparator:"+ sym.getPatternSeparator());
				
				System.out.println(">>>>>Starting parsing testes with pattern:" + df.toPattern());
				
				original = "1X,";
				parsePrint(df,original,number);
				
				original = "011111A.111A1";
				parsePrint(df,original,number);
				
	      original = "1.1111";
	      parsePrint(df,original,number);
	      
	      original = "0.0";
	      parsePrint(df,original,number);
	      
				original = "0,1111";
				parsePrint(df,original,number);
				
	      original = "1,1111";
	      parsePrint(df,original,number);
	      
	      original = "0,0";
	      parsePrint(df,original,number);
	      
				df.applyPattern("###,0000");
				
				System.out.println(">>>>Starting parsing testes with pattern:" + df.toPattern());
				original = "0.1111";				
				parsePrint(df,original,number);				

	      original = "1.1111";
	      parsePrint(df,original,number);
	      
	      original = "0.0";
	      parsePrint(df,original,number);
	      
				original = "0,1111";
				parsePrint(df,original,number);
				
	      original = "1,1111";
	      parsePrint(df,original,number);
	      
	      original = "0,0";
	      parsePrint(df,original,number);
      
			} catch (ParseException e) {
	      e.printStackTrace();
      }
		} else {
			fail("Not an instance of NumberFormat." + nf.getClass().getName());
		} 
		
	}
	
	protected void parsePrint(NumberFormat df, String original, Number number ) throws ParseException {
    number = df.parse(original);
    System.out.println("Original:" + original + ".As Double:" + number.doubleValue() + " of the class " + number.getClass().getName());		
	}
	
	public void testNumeric() {
		double num1 = 1231.0 / 100000.0;
		System.out.println("n1:"+ num1);
		
		double num2 = 1001.0 / 100000.0;
		System.out.println("n2:"+num2);

		double num3 = 1999.0 / 100000.0;
		System.out.println("n3:"+num3);
		
		double num4 = 999.0 / 100000.0;
		System.out.println("n4:"+num4);
		
		double num5 = 1000.0 / 100000.0;
		System.out.println("n5:"+num5);		
		
		System.out.println(Math.floor(num1*100)/100);
		System.out.println(Math.floor(num2*100)/100);
		System.out.println(Math.floor(num3*100)/100);
		System.out.println(Math.floor(num4*100)/100);		
		System.out.println(Math.floor(num5*100)/100);		
		
		assertEquals(Math.floor(num1*100)/100, 0.01, 0);
		assertEquals(Math.floor(num2*100)/100, 0.01, 0);
		assertEquals(Math.floor(num3*100)/100, 0.01, 0);
		assertEquals(Math.floor(num4*100)/100, 0.00, 0);
		assertEquals(Math.floor(num5*100)/100, 0.01, 0);
	}
}
