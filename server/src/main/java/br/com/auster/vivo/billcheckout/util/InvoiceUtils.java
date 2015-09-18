/*
 * Copyright (c) 2004-2005 Auster Solutions do Brasil. All Rights Reserved.
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
 * Created on 20/09/2006
 */
//TODO Comment this Class
package br.com.auster.vivo.billcheckout.util;

import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;

import org.apache.log4j.Logger;

import br.com.auster.billcheckout.param.DueDateVO;
import br.com.auster.common.util.DateUtils;
import br.com.auster.om.invoice.ChargedTax;
import br.com.auster.om.invoice.Invoice;
import br.com.auster.om.invoice.Receipt;
import br.com.auster.om.invoice.ReceiptDetail;
import br.com.auster.om.pricing.PricingFacade;

/**
 * @author mtengelm
 * @version $Id: InvoiceUtils.java 1711 2007-11-16 15:22:54Z gportuga $
 */
public class InvoiceUtils {

	private static Logger log = Logger.getLogger(InvoiceUtils.class);
	
	public static double getReceiptTotal(Receipt receipt) {
		double ret = getReceiptTotalWithoutTaxes(receipt);
		ret += getReceiptTaxes(receipt);
		return ret;
	}

	public static double getReceiptTotalWithoutTaxes(Receipt receipt) {
		double ret = 0;
		// valor total da Nota-Fiscal
		for (Iterator it = receipt.getDetails().iterator(); it.hasNext();) {
			ReceiptDetail detail = (ReceiptDetail) it.next();
			ret += detail.getTotalAmount();
		}
		return ret;
	}

	public static double getReceiptTaxes(Receipt receipt) {
		double ret = 0;
		// adiciona os impostos da Nota-Fiscal
		for (Iterator it = receipt.getTaxes().iterator(); it.hasNext();) {
			ChargedTax tax = (ChargedTax) it.next();
			if (tax.getTaxName().equals("ICMS")) {
				ret += tax.getTaxAmount();
			}
		}
		return ret;
	}
	public static boolean dueDateMatches(Invoice invoice, DueDateVO dueDate) {
		if (invoice == null || dueDate == null) {
			return false;
		}
		GregorianCalendar gc = new GregorianCalendar();
		gc.setTime(invoice.getCycleEndDate());
		// Clear method does not reset HOUR_OF_DAY and AM_PM fields. 
		// See GregorianCalendar.clear(int, int) documentation.
		gc.set(Calendar.HOUR_OF_DAY, 0); 
		gc.clear(Calendar.MINUTE);
		gc.clear(Calendar.SECOND);
		gc.clear(Calendar.MILLISECOND);
		gc.set(Calendar.DATE, dueDate.getDueDate());

		if (dueDate.getMonthChangeInd().equals(DueDateVO.MONTH_CHANGE_NEXT)) {
			gc.add(Calendar.MONTH, 1);
		}

		return gc.getTime().equals(invoice.getDueDate());
	}
	
	/**
	 * Calculates the pro-rata (difference in percentage) between two dates. The first date is assumed to be
	 * 	the start of the cycle, and the end of the cycle is the number of days for the start date month.  
	 * <p>
	 * If, for any reason, the end date exceeds the cycle end date, then 100% is returned (value is 1) and the 
	 * 	calculated pro-rata is ignored.
	 * 
	 * 
	 * @param _startCycle the start of the cycle
	 * @param _startCharge the start date of some charge 
	 * @param _endCharge the end date of that charge (maximum of this should be the cycle end date)
	 * 
	 * @return the pro-rata between the cycle start date and the charge end date, ranging from 0 to 1 (1 as 100%) 
	 */
	public static final double calculateProRata(Date _startCyle, Date _startCharge, Date _endCharge) {
		try {
			double totalDays = DateUtils.monthDays(_startCyle);
//			double dateDiff = DateUtils.difference(_start, _end, 'd') + 1;
			double dateDiff = DateUtils.difference(_startCharge, _endCharge, 'd') ;			
			return Math.min( (dateDiff / totalDays), 1D);
		} catch (ParseException pe) {
			throw new IllegalStateException(pe);
		}
	}	
}
