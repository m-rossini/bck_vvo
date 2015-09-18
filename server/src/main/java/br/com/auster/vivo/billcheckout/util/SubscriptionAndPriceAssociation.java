/*
 * Copyright (c) 2004-2006 Auster Solutions do Brasil. All Rights Reserved.
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
 * Created on 24/07/2006
 */


package br.com.auster.vivo.billcheckout.util;

import org.apache.log4j.Logger;

import br.com.auster.om.invoice.ServiceDetail;
import br.com.auster.om.pricing.ServicePrice;

/**
 * @author gmatias
 * @version $Id$
 */
public class SubscriptionAndPriceAssociation {
	
	private static final Logger log = Logger.getLogger(SubscriptionAndPriceAssociation.class);
	
	public static final String DESCRIPTION_1 = "ASSINATURA MENSAL -";
	public static final String DESCRIPTION_2 = "ASSINATURA MENSAL-";
	public static final String DESCRIPTION_3 = "ASSINATURA MENSAL";	
	public static final String DESCRIPTION_4 = "ASSIN. MENSAL -";
	public static final String DESCRIPTION_5 = "ASSIN. MENSAL-";
	public static final String DESCRIPTION_6 = "ASSIN. MENSAL";	
	public static final String DESCRIPTION_7 = "ASSIN MENSAL -";
	public static final String DESCRIPTION_8 = "ASSIN MENSAL-";
	public static final String DESCRIPTION_9 = "ASSIN MENSAL";	
	public static final String DESCRIPTION_10 = "ASSIN.MENSAL -";
	public static final String DESCRIPTION_11 = "ASSIN.MENSAL-";
	public static final String DESCRIPTION_12 = "ASSIN.MENSAL";	
		
	
	//public static final String[] DESCS = (DESCRIPTION_1);
	private static final String[] DESCS = new String[] 
	        {DESCRIPTION_1,DESCRIPTION_2,DESCRIPTION_3,DESCRIPTION_4,DESCRIPTION_5,
		DESCRIPTION_6,DESCRIPTION_7,DESCRIPTION_8,DESCRIPTION_9 ,DESCRIPTION_10,DESCRIPTION_11,DESCRIPTION_12};
	
	private ServicePrice price = null;
	private ServiceDetail detail = null;
	private double calculatedPrice = 0D;
	 
	public SubscriptionAndPriceAssociation() {
		//EMPTY CONSTRUCTOR
	}
	
	/**
	 * @return Returns the price.
	 */
	public ServicePrice getServicePrice() {
		return price;
	}
	/**
	 * @param _price The service to set.
	 */
	public void setServicePrice(ServicePrice _price) {
		this.price = _price;
	}
	/**
	 * @return Returns the datail.
	 */
	public ServiceDetail getServiceDetail() {
		return detail;
	}
	/**
	 * @param _detail The datail to set.
	 */
	public void setServiceDetail (ServiceDetail _detail){
	this.detail = _detail;
	}
	
	public double getCalculatedFee() {
		return this.calculatedPrice;
	}
	
	public void setCalculatedFee(double _value) {
		this.calculatedPrice = _value;
	}
	
	public double getProRatedFee() {
		ServiceDetail sd = getServiceDetail();
		double proRataFactor = 1;
		if (sd.isProRate()) {
			proRataFactor = InvoiceUtils.calculateProRata(sd.getInvoice().getCycleStartDate(), sd.getStartDate(), sd.getEndDate());
		} else if (sd.getTotalAmount() < 0) {
			proRataFactor = -1 * InvoiceUtils.calculateProRata(sd.getInvoice().getCycleStartDate(), sd.getStartDate(), sd.getEndDate());
		}
		return this.calculatedPrice * proRataFactor;
	}
	
	/**
	 * @deprecated As of release 3.1.8 where we changed the import of prices.
	 * @param description
	 *  
	 *   
	 */	
	public static String getRealServiceDescription(ServiceDetail _serviceDetail) {
		
		if (_serviceDetail == null) {
			throw new IllegalStateException("ServiceDetail not set");
		}
		
		String assin = _serviceDetail.getCaption(); 
		
		if (isSubscriptionCharge(_serviceDetail)) {
			assin = assin.toUpperCase();
			for (int i=0; i < DESCS.length;i++) {
				if (assin.startsWith(DESCS[i])) {
					assin = assin.substring(DESCS[i].length()).trim();
					break;
				}
			}			
//			if(assin.startsWith(DESCRIPTION_1)){
//				return assin.substring(DESCRIPTION_1.length());
//			}else if (assin.startsWith(DESCRIPTION_2)) {
//				return assin.substring(DESCRIPTION_2.length());
//			} 
//			else {
//				return assin.substring(DESCRIPTION_3.length());
//			}
			
		}	
		log.debug("RealName:" + assin);
		return assin;			
	}
	
	/**
	 * @deprecated As of release 3.1.8 where we changed the import of prices.
	 * @param assin
	 * @return This method return empty.
	 */
	public static boolean isSubscriptionCharge(ServiceDetail _serviceDetail) {

		if (_serviceDetail == null) {
			throw new IllegalStateException("ServiceDetail not set");
		}
		
		String assin = _serviceDetail.getCaption().toUpperCase();
		for (int i=0; i < DESCS.length;i++) {
			if (assin.startsWith(DESCS[i])) {
				log.debug("This is a subscription fee:" + assin);
				return true;
			}
		}
		return false;
		
//		return (assin.startsWith(DESCRIPTION_1) || assin.startsWith(DESCRIPTION_2) || assin.startsWith(DESCRIPTION_3));
	}
	
	/**
	 * @return
	 */
	public boolean isNegotiable() {
		return this.price.isNegotiable();
		
	}

}