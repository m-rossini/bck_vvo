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
 * Created on 27/02/2007
 */
package br.com.auster.vivo.billcheckout.util;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.math.util.MathUtils;

import br.com.auster.om.invoice.ServiceDetail;
import br.com.auster.om.pricing.Service;
import br.com.auster.om.pricing.ServicePrice;
import br.com.auster.om.pricing.TaxCategory;
import br.com.auster.vivo.billcheckout.cache.vo.ProgressiveDiscountVO;
/**
 * @author mtengelm
 *
 */
// TODO Comment this class br.com.auster.vivo.billcheckout.util "." ProgressiveDiscountSubscription.java
public class ProgressiveDiscountSubscription {

	private List<ServiceDetail> sections;
	private int subCounter=-1;
	private ProgressiveDiscountVO discount=null;
	private ServicePrice price = null;
	private double baseCalculatedPrice=0.0D;
	private boolean hasBasePrice = false;
	/**
   * @return the discount
   */
  public ProgressiveDiscountVO getDiscount() {
  	return this.discount;
  }
	/**
   * @param discount the discount to set
   */
  public void setDiscount(ProgressiveDiscountVO discount) {
  	this.discount = discount;
  }
	/**
   * @return the sections
   */
  public List<ServiceDetail> getSections() {
  	return this.sections;
  }
	/**
   * @param sections the sections to set
   */
  public void setSections(List<ServiceDetail> sections) {
  	this.sections = sections;
  }
	/**
   * @return the subCounter
   */
  public int getSubCounter() {
  	return this.subCounter;
  }
	/**
   * @param subCounter the subCounter to set
   */
  public void setSubCounter(int subCounter) {
  	this.subCounter = subCounter;
  }
	/**
   * @return
   * @see br.com.auster.vivo.billcheckout.cache.vo.ProgressiveDiscountVO#getCaptionText()
   */
  public String getCaptionText() {
	  return this.discount.getCaptionText();
  }
	/**
   * @return
   * @see br.com.auster.vivo.billcheckout.cache.vo.ProgressiveDiscountVO#getMarketingProgramId()
   */
  public String getMarketingProgramId() {
	  return this.discount.getMarketingProgramId();
  }
	/**
   * @return
   * @see br.com.auster.vivo.billcheckout.cache.vo.ProgressiveDiscountVO#getRewardAmount()
   */
  public double getRewardAmount() {
	  return this.discount.getRewardAmount();
  }
	/**
   * @return
   * @see br.com.auster.vivo.billcheckout.cache.vo.ProgressiveDiscountVO#getServiceName()
   */
  public String getServiceName() {
	  return this.discount.getServiceName();
  }
	/**
   * @return
   * @see br.com.auster.vivo.billcheckout.cache.vo.ProgressiveDiscountVO#getTierMaxAmount()
   */
  public double getTierMaxAmount() {
	  return this.discount.getTierMaxAmount();
  }
	/**
   * @return
   * @see br.com.auster.vivo.billcheckout.cache.vo.ProgressiveDiscountVO#getTierMinAmount()
   */
  public double getTierMinAmount() {
	  return this.discount.getTierMinAmount();
  }
	
  public ServiceDetail getFirstSubscription() {
  	return this.sections.get(0);
  }
	/**
   * @return the price
   */
  public ServicePrice getPrice() {
  	return this.price;
  }
	/**
   * @param price the price to set
   */
  public void setPrice(ServicePrice price) {
  	this.price = price;
  }
  
  /***
   * Returns true if price engine gotten a price for this service (Any one of the list, that should be all the same price)
   * @return
   */
  public boolean hasPrice() {
  	return (this.price!=null);
  }
	/**
   * @return
   * @see br.com.auster.om.pricing.ServicePrice#getEffectiveDate()
   */
  public Timestamp getEffectiveDate() {
	  return this.price.getEffectiveDate();
  }
	/**
   * @return
   * @see br.com.auster.om.pricing.ServicePrice#getExpirationDate()
   */
  public Timestamp getExpirationDate() {
	  return this.price.getExpirationDate();
  }
	/**
   * @return
   * @see br.com.auster.om.pricing.ServicePrice#getInitCost()
   */
  public Double getInitCost() {
	  return this.price.getInitCost();
  }
	/**
   * @return
   * @see br.com.auster.om.pricing.ServicePrice#getInitIncludedQuantity()
   */
  public Double getInitIncludedQuantity() {
	  return this.price.getInitIncludedQuantity();
  }
	/**
   * @return
   * @see br.com.auster.om.pricing.ServicePrice#getInitQuantity()
   */
  public Double getInitQuantity() {
	  return this.price.getInitQuantity();
  }
	/**
   * @return
   * @see br.com.auster.om.pricing.ServicePrice#getInitType()
   */
  public String getInitType() {
	  return this.price.getInitType();
  }
	/**
   * @return
   * @see br.com.auster.om.pricing.ServicePrice#getNegotiable()
   */
  public String getNegotiable() {
	  return this.price.getNegotiable();
  }
	/**
   * @return
   * @see br.com.auster.om.pricing.ServicePrice#getPricingArea()
   */
  public String getPricingArea() {
	  return this.price.getPricingArea();
  }
	/**
   * @return
   * @see br.com.auster.om.pricing.ServicePrice#getScenario()
   */
  public String getScenario() {
	  return this.price.getScenario();
  }
	/**
   * @return
   * @see br.com.auster.om.pricing.ServicePrice#getService()
   */
  public Service getService() {
	  return this.price.getService();
  }
	/**
   * @return
   * @see br.com.auster.om.pricing.ServicePrice#getStepCost()
   */
  public Double getStepCost() {
	  return this.price.getStepCost();
  }
	/**
   * @return
   * @see br.com.auster.om.pricing.ServicePrice#getStepIncludedQuantity()
   */
  public Double getStepIncludedQuantity() {
	  return this.price.getStepIncludedQuantity();
  }
	/**
   * @return
   * @see br.com.auster.om.pricing.ServicePrice#getStepQuantity()
   */
  public Double getStepQuantity() {
	  return this.price.getStepQuantity();
  }
	/**
   * @return
   * @see br.com.auster.om.pricing.ServicePrice#getStepType()
   */
  public String getStepType() {
	  return this.price.getStepType();
  }
	/**
   * @return
   * @see br.com.auster.om.pricing.ServicePrice#getTaxCategory()
   */
  public TaxCategory getTaxCategory() {
	  return this.price.getTaxCategory();
  }
	/**
   * @return the baseCalculatedPrice
   */
  public double getBaseCalculatedPrice() {
  	return this.baseCalculatedPrice;
  }
	/**
	 * Once this value is set, the flag returned by @see hasBasePrice() method will be set to true.
   * @param baseCalculatedPrice the baseCalculatedPrice to set
   */
  public void setBaseCalculatedPrice(double baseCalculatedPrice) {
  	this.hasBasePrice  = true;  	
  	this.baseCalculatedPrice = baseCalculatedPrice;
  }
  
  /***
   * returns true if there is a base price already gotten by price engine
   * @return
   */
  public boolean hasBasePrice() {
  	return this.hasBasePrice;
  }
  
  /***
   * Returns the Service Price with discount. Note: This does not calculate pro-ration
   * @return
   */
  public double getDiscountedPrice(){
  	if (this.hasBasePrice()) {
  		return this.getBaseCalculatedPrice() * ( 1 - (this.getRewardAmount()/100) );
  	} else {
  		return 0.0D;
  	}  	
  }
  
  /***
   * Returns the Service Price with discount rounded to 2 decimal places. Note: This does not calculate pro-ration
   * @return
   */  
  public double getDiscountedPriceRounded() {
  	return MathUtils.round(getDiscountedPrice(), 2);
  }
  
  public double getProRatedDiscountedAmount(ServiceDetail sd) {
		double proRataFactor = 1;
		if (sd.isProRate()) {
			proRataFactor = InvoiceUtils.calculateProRata(sd.getInvoice().getCycleStartDate(), sd.getStartDate(), sd.getEndDate());
		} else if (sd.getTotalAmount() < 0) {
			proRataFactor = -1 * InvoiceUtils.calculateProRata(sd.getInvoice().getCycleStartDate(), sd.getStartDate(), sd.getEndDate());
		}
		return getDiscountedPrice() * proRataFactor;
  }
  
  public List<ServiceDetail> getWrongPricedServices() {
  	List<ServiceDetail> results = new ArrayList<ServiceDetail>(); 
  	for (Iterator<ServiceDetail> it=this.sections.iterator();it.hasNext();) {
  		ServiceDetail detail = it.next();
  		double proRatedAmount = this.getProRatedDiscountedAmount(detail);
  		double detailAmount = detail.getTotalAmount();
  		if ( Math.abs(Math.abs(detailAmount) - Math.abs(proRatedAmount)) > 0.01D) {
  			results.add(detail);
  		}
  	}
  	return results;
  }
}
