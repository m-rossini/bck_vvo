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
 * Created on 31/01/2007
 */
package br.com.auster.vivo.billcheckout.cache.vo;

import java.util.Date;

/**
 * @author mtengelm
 *
 */
public class IntraGroupVO {

	private String subscriptionID;
	private String accountNumber;
	private Date accessLineEffectiveDate;
	private Date accessLineExpirationDate;
	private String accessNumberFavorite;
	private String cycleCode;
	private String accessNumber;
	
	/**
   * 
   */
  public IntraGroupVO() {
	  super();
  }
  
	/* (non-Javadoc)
   * @see java.lang.Object#hashCode()
   */
  @Override
  public int hashCode() {
	  final int PRIME = 31;
	  int result = 1;
	  result = PRIME * result + ((this.accessLineEffectiveDate == null) ? 0 : this.accessLineEffectiveDate.hashCode());
	  result = PRIME * result + ((this.accessNumber == null) ? 0 : this.accessNumber.hashCode());
	  result = PRIME * result + ((this.accessNumberFavorite == null) ? 0 : this.accessNumberFavorite.hashCode());
	  result = PRIME * result + ((this.accountNumber == null) ? 0 : this.accountNumber.hashCode());
	  result = PRIME * result + ((this.cycleCode == null) ? 0 : this.cycleCode.hashCode());
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
	  final IntraGroupVO other = (IntraGroupVO) obj;
	  if (this.accessLineEffectiveDate == null) {
		  if (other.accessLineEffectiveDate != null)
			  return false;
	  } else if (!this.accessLineEffectiveDate.equals(other.accessLineEffectiveDate))
		  return false;
	  if (this.accessNumber == null) {
		  if (other.accessNumber != null)
			  return false;
	  } else if (!this.accessNumber.equals(other.accessNumber))
		  return false;
	  if (this.accessNumberFavorite == null) {
		  if (other.accessNumberFavorite != null)
			  return false;
	  } else if (!this.accessNumberFavorite.equals(other.accessNumberFavorite))
		  return false;
	  if (this.accountNumber == null) {
		  if (other.accountNumber != null)
			  return false;
	  } else if (!this.accountNumber.equals(other.accountNumber))
		  return false;
	  if (this.cycleCode == null) {
		  if (other.cycleCode != null)
			  return false;
	  } else if (!this.cycleCode.equals(other.cycleCode))
		  return false;
	  return true;
  }
  public String toString() {
  	return "Cycle:" + cycleCode + ".Account:" + accountNumber + 
  	".Access:" + accessNumber + ".Favorite:" + accessNumberFavorite;
  }
	/**
   * @return the accessLineEffectiveDate
   */
  public Date getAccessLineEffectiveDate() {
  	return this.accessLineEffectiveDate;
  }
	/**
   * @param accessLineEffectiveDate the accessLineEffectiveDate to set
   */
  public void setAccessLineEffectiveDate(Date accessLineEffectiveDate) {
  	this.accessLineEffectiveDate = accessLineEffectiveDate;
  }
	/**
   * @return the accessLineExpirationDate
   */
  public Date getAccessLineExpirationDate() {
  	return this.accessLineExpirationDate;
  }
	/**
   * @param accessLineExpirationDate the accessLineExpirationDate to set
   */
  public void setAccessLineExpirationDate(Date accessLineExpirationDate) {
  	this.accessLineExpirationDate = accessLineExpirationDate;
  }
	/**
   * @return the accessNumber
   */
  public String getAccessNumber() {
  	return this.accessNumber;
  }
	/**
   * @param accessNumber the accessNumber to set
   */
  public void setAccessNumber(String accessNumber) {
  	this.accessNumber = accessNumber;
  }
	/**
   * @return the accessNumberFavorite
   */
  public String getAccessNumberFavorite() {
  	return this.accessNumberFavorite;
  }
	/**
   * @param accessNumberFavorite the accessNumberFavorite to set
   */
  public void setAccessNumberFavorite(String accessNumberFavorite) {
  	this.accessNumberFavorite = accessNumberFavorite;
  }
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
   * @return the cycleCode
   */
  public String getCycleCode() {
  	return this.cycleCode;
  }
	/**
   * @param cycleCode the cycleCode to set
   */
  public void setCycleCode(String cycleCode) {
  	this.cycleCode = cycleCode;
  }
	/**
   * @return the subscriptionID
   */
  public String getSubscriptionID() {
  	return this.subscriptionID;
  }
	/**
   * @param subscriptionID the subscriptionID to set
   */
  public void setSubscriptionID(String subscriptionID) {
  	this.subscriptionID = subscriptionID;
  }
}
