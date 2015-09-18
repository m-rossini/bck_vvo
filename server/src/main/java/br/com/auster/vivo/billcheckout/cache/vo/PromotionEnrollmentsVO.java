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
 * Created on 28/02/2007
 */
package br.com.auster.vivo.billcheckout.cache.vo;

/**
 * @author mtengelm
 *
 */
public class PromotionEnrollmentsVO {

	private String accountNumber;
	private String subscriptionId;
	private String marketingProgramId;
	private String captionText;
	/**
   * @return the accountNumber
   */
  public String getAccountNumber() {
  	return this.accountNumber;
  }
	/**
   * @param accountNumber the accountNumber to set
   */
  public void setAccountNumber(String accountNumber) {
  	this.accountNumber = accountNumber;
  }
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
   * @return the subscriptionId
   */
  public String getSubscriptionId() {
  	return this.subscriptionId;
  }
	/**
   * @param subscriptionId the subscriptionId to set
   */
  public void setSubscriptionId(String subscriptionId) {
  	this.subscriptionId = subscriptionId;
  }
  
  public String toString() {
  	return "Acc:" + this.getAccountNumber() + 
  	".Sub:" + this.getSubscriptionId() + 
  	".Mkt:" + this.getMarketingProgramId() + 
  	".Cap:" + this.getCaptionText();
  }
  
	/* (non-Javadoc)
   * @see java.lang.Object#hashCode()
   */
  @Override
  public int hashCode() {
	  final int PRIME = 31;
	  int result = 1;
	  result = PRIME * result + ((this.accountNumber == null) ? 0 : this.accountNumber.hashCode());
	  result = PRIME * result + ((this.captionText == null) ? 0 : this.captionText.hashCode());
	  result = PRIME * result + ((this.marketingProgramId == null) ? 0 : this.marketingProgramId.hashCode());
	  result = PRIME * result + ((this.subscriptionId == null) ? 0 : this.subscriptionId.hashCode());
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
	  final PromotionEnrollmentsVO other = (PromotionEnrollmentsVO) obj;
	  if (this.accountNumber == null) {
		  if (other.accountNumber != null)
			  return false;
	  } else if (!this.accountNumber.equals(other.accountNumber))
		  return false;
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
	  if (this.subscriptionId == null) {
		  if (other.subscriptionId != null)
			  return false;
	  } else if (!this.subscriptionId.equals(other.subscriptionId))
		  return false;
	  return true;
  }
  
  
}
