/*
 * Copyright (c) 2004-2005 Auster Solutions. All Rights Reserved.
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
 * Created on Feb 16, 2005
 */
package br.com.auster.vivo.billcheckout.util;

import java.util.Iterator;

import br.com.auster.om.invoice.ChargedTax;
import br.com.auster.om.invoice.Invoice;
import br.com.auster.om.invoice.Receipt;
import br.com.auster.om.invoice.ReceiptDetail;
import br.com.auster.om.invoice.Section;
import br.com.auster.om.invoice.SectionDetail;

/**
 * <p><b>Title:</b> InvoiceValueChecker</p>
 * <p><b>Description:</b> This class has methods to check total values in an invoice</p>
 * <p><b>Copyright:</b> Copyright (c) 2004-2005</p>
 * <p><b>Company:</b> Auster Solutions</p>
 *
 * @author etirelli
 * @version $Id: InvoiceValueChecker.java 461 2006-02-16 14:24:17Z etirelli $
 */
public class InvoiceValueChecker {
  
  /**
   * Calculates the total invoice amount adding fields from the invoice summary
   * @param invoice
   * @return
   */
  public static double getCalculatedTotalAmount(Invoice invoice) {
    double credits = invoice.getPaymentsAmount() +  
                     invoice.getRetentionAmount() + invoice.getPenaltiesReturnAmount() +
                     invoice.getInterestsReturnAmount();
    double debits = invoice.getCurrentPeriodAmount() + invoice.getPenaltiesAmount() +
                    invoice.getInterestsAmount() + invoice.getContractBreakAmount() +
                    invoice.getMonthlyInstmtAmount() + invoice.getEqpInstmtAmount();
    double totalAmt = invoice.getAdjustmentsAmount() + invoice.getPreviousBalance() +
                      credits + debits;
    return totalAmt;
  }
  
  /**
   * Returns the calculated invoice total amount adding up all sections details 
   * for all details.
   * 
   * @param invoice
   * @return
   */
  public static double getInvoiceTotalAmount(Invoice invoice) {
    double ret = 0;
    for(Iterator i=invoice.getSections().iterator(); i.hasNext(); ) {
      ret += getSectionTotal((Section)i.next());
    }
    ret += invoice.getPreviousBalance() + invoice.getPaymentsAmount(); 
    return ret;
  }
  
  /**
   * Calculates and returns the total amount for a given section
   * @param section
   * @return
   */
  public static double getSectionTotal(Section section) {
    double ret = 0;
    for(Iterator i=section.getSubSections().iterator(); i.hasNext(); ) {
      Section subsection = (Section)i.next();
      if(!subsection.getElementType().equals("SUMMARY_SECTION")) {
        ret += getSectionTotal(subsection);
      }
    }
    for(Iterator i=section.getDetails().iterator(); i.hasNext(); ) {
      SectionDetail detail = (SectionDetail)i.next();
      if(detail.getElementType().equals("ADJUSTMENTS_DETAIL")) {
        ret -= detail.getTotalAmount(); 
      } else {
        ret += detail.getTotalAmount();
      }
    }
    return ret;
  }

  /**
   * Returns the invoice total amount adding up all receipts in the invoice
   * @param invoice
   * @return
   */
  public static double getReceiptTotalAmount(Invoice invoice) {
    double ret = 0;
    for(Iterator i=invoice.getReceipts().iterator(); i.hasNext(); ) {
      ret += getReceiptTotal((Receipt)i.next());
    }
    ret += //invoice.getPreviousBalance()+ // Removed due to OIA implementation
           invoice.getPaymentsAmount()+invoice.getDisputeCredits() +
           invoice.getInterestsAmount()+invoice.getPenaltiesAmount() -
           invoice.getStateTaxAmount()+invoice.getEqpInstmtAmount() +
           invoice.getInterestsReturnAmount()+invoice.getPenaltiesReturnAmount() +
           invoice.getMonthlyInstmtAmount()+invoice.getAdjustmentsAmount() +
           invoice.getContractBreakAmount();
    return ret;
  }
  
  /**
   * Calculates and returns the total amount for the given receipt
   * @param receipt
   * @return
   */
  public static double getReceiptTotal(Receipt receipt) {
    double ret = 0;
    for(Iterator i=receipt.getDetails().iterator(); i.hasNext(); ) {
      ReceiptDetail detail = (ReceiptDetail)i.next();
//      if(!(detail.getFiscalCode().equals("1050") ||  // redebitos
//           detail.getFiscalCode().equals("1060") || 
//           detail.getFiscalCode().equals("1070") ||
//           detail.getFiscalCode().equals("1080") ||
//           detail.getFiscalCode().equals("1090"))) {
        ret += detail.getTotalAmount();
//      }
    }
    for(Iterator j=receipt.getTaxes().iterator(); j.hasNext(); ) {
      ChargedTax tax = (ChargedTax) j.next();
      if(tax.getTaxName().equals("ICMS")) {
        ret += tax.getTaxAmount(); 
      }
    }
    return ret;
  }
  
}
