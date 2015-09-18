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
package br.com.auster.vivo.billcheckout.cache.vo;

/**
 * This class represent a Unique Tier for discounting a service based on tier volumes.
 * @author mtengelm
 *
 */

public class ProgressiveDiscountVO {

	private String marketingProgramId;
	private String serviceName;
	private String captionText;
	private double tierMinAmount;
	private double tierMaxAmount;
	private double rewardAmount;
	/**
   * @return the captionText
   */
  public String getCaptionText() {
  	return this.captionText;
  }
	/**
   * @param captionText the captionText to set
   */
  public void setCaptionText(String captionText) {
  	this.captionText = captionText;
  }
	/**
   * @return the marketingProgramId
   */
  public String getMarketingProgramId() {
  	return this.marketingProgramId;
  }
	/**
   * @param marketingProgramId the marketingProgramId to set
   */
  public void setMarketingProgramId(String marketingProgramId) {
  	this.marketingProgramId = marketingProgramId;
  }
	/**
   * @return the rewardAmount
   */
  public double getRewardAmount() {
  	return this.rewardAmount;
  }
	/**
   * @param rewardAmount the rewardAmount to set
   */
  public void setRewardAmount(double rewardAmount) {
  	this.rewardAmount = rewardAmount;
  }
	/**
   * @return the serviceName
   */
  public String getServiceName() {
  	return this.serviceName;
  }
	/**
   * @param serviceName the serviceName to set
   */
  public void setServiceName(String serviceName) {
  	this.serviceName = serviceName;
  }
	/**
   * @return the tierMaxAmount
   */
  public double getTierMaxAmount() {
  	return this.tierMaxAmount;
  }
	/**
   * @param tierMaxAmount the tierMaxAmount to set
   */
  public void setTierMaxAmount(double tierMaxAmount) {
  	this.tierMaxAmount = tierMaxAmount;
  }
	/**
   * @return the tierMinAmount
   */
  public double getTierMinAmount() {
  	return this.tierMinAmount;
  }
	/**
   * @param tierMinAmount the tierMinAmount to set
   */
  public void setTierMinAmount(double tierMinAmount) {
  	this.tierMinAmount = tierMinAmount;
  }
  
  public String toString() {
  	return "MKT[" + this.marketingProgramId + "]" + 
  	".SVC[" + this.getServiceName() + "]" +
  	".CAP[" + this.getCaptionText() + "]" +
  	".MIN[" + this.getTierMinAmount() + "]" +
  	".MAX[" + this.getTierMaxAmount() + "]" +
  	".REW[" + this.getRewardAmount() + "]" ;
  }
	/* (non-Javadoc)
   * @see java.lang.Object#hashCode()
   */
  @Override
  public int hashCode() {
	  final int PRIME = 31;
	  int result = 1;
	  result = PRIME * result + ((this.captionText == null) ? 0 : this.captionText.hashCode());
	  result = PRIME * result + ((this.marketingProgramId == null) ? 0 : this.marketingProgramId.hashCode());
	  result = PRIME * result + ((this.serviceName == null) ? 0 : this.serviceName.hashCode());
	  long temp;
	  temp = Double.doubleToLongBits(this.tierMaxAmount);
	  result = PRIME * result + (int) (temp ^ (temp >>> 32));
	  temp = Double.doubleToLongBits(this.tierMinAmount);
	  result = PRIME * result + (int) (temp ^ (temp >>> 32));
	  return result;
  }
	/* (non-Javadoc)
   * @see java.lang.Object#equals(java.lang.Object)
   */
  @Override
  public boolean equals(Object obj) {
	  if (this == obj)
		  return true;
	  if (obj == null)
		  return false;
	  if (getClass() != obj.getClass())
		  return false;
	  final ProgressiveDiscountVO other = (ProgressiveDiscountVO) obj;
	  if (this.captionText == null) {
		  if (other.captionText != null)
			  return false;
	  } else if (!this.captionText.equals(other.captionText))
		  return false;
	  if (this.marketingProgramId == null) {
		  if (other.marketingProgramId != null)
			  return false;
	  } else if (!this.marketingProgramId.equals(other.marketingProgramId))
		  return false;
	  if (this.serviceName == null) {
		  if (other.serviceName != null)
			  return false;
	  } else if (!this.serviceName.equals(other.serviceName))
		  return false;
	  if (Double.doubleToLongBits(this.tierMaxAmount) != Double.doubleToLongBits(other.tierMaxAmount))
		  return false;
	  if (Double.doubleToLongBits(this.tierMinAmount) != Double.doubleToLongBits(other.tierMinAmount))
		  return false;
	  return true;
  }
}
