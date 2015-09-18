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
 * Created on 17/10/2006
 */
package br.com.auster.vivo.billcheckout.util;

import java.util.Date;

/**
 * @author mtengelm
 *
 */
public class DAOSubServices {

	private String accountNumber;
	private String cycleCode;
	private String accessNumber;
	private String subscriptionId;
	private Date accessNumberEffective;
	private Date accessNumberExpiration;
	private Date serviceEffective;
	private Date serviceExpiration;
	private String serviceName;
	/**
	 * 
	 */
	public DAOSubServices() {
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
   * @return the accessNumberEffective
   */
  public Date getAccessNumberEffective() {
  	return this.accessNumberEffective;
  }
	/**
   * @param accessNumberEffective the accessNumberEffective to set
   */
  public void setAccessNumberEffective(Date accessNumberEffective) {
  	this.accessNumberEffective = accessNumberEffective;
  }
	/**
   * @return the accessNumberExpiration
   */
  public Date getAccessNumberExpiration() {
  	return this.accessNumberExpiration;
  }
	/**
   * @param accessNumberExpiration the accessNumberExpiration to set
   */
  public void setAccessNumberExpiration(Date accessNumberExpiration) {
  	this.accessNumberExpiration = accessNumberExpiration;
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
   * @return the serviceEffective
   */
  public Date getServiceEffective() {
  	return this.serviceEffective;
  }
	/**
   * @param serviceEffective the serviceEffective to set
   */
  public void setServiceEffective(Date serviceEffective) {
  	this.serviceEffective = serviceEffective;
  }
	/**
   * @return the serviceExpiration
   */
  public Date getServiceExpiration() {
  	return this.serviceExpiration;
  }
	/**
   * @param serviceExpiration the serviceExpiration to set
   */
  public void setServiceExpiration(Date serviceExpiration) {
  	this.serviceExpiration = serviceExpiration;
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
	
  public String toString() {
  	return "ACN:" + this.getAccountNumber() + ".ALN:" + this.getAccessNumber() 
  	  + ".SUB:" + this.getSubscriptionId() 
  	  + ".SVC:" + this.getServiceName()  	  
  	  + ".SVCEFF:" + this.getServiceEffective()
  	  + ".SVCEXP:" + this.getServiceExpiration()
  	  + ".DTALNEFF:" + this.getAccessNumberEffective() 
  	  + ".DTALNEXP:" + this.getAccessNumberExpiration()  	  
  		;
  }
	/* (non-Javadoc)
   * @see java.lang.Object#hashCode()
   */
  @Override
  public int hashCode() {
	  final int PRIME = 31;
	  int result = 1;
	  result = PRIME * result + ((this.accessNumber == null) ? 0 : this.accessNumber.hashCode());
	  result = PRIME * result + ((this.accountNumber == null) ? 0 : this.accountNumber.hashCode());
	  result = PRIME * result + ((this.cycleCode == null) ? 0 : this.cycleCode.hashCode());
	  result = PRIME * result + ((this.serviceEffective == null) ? 0 : this.serviceEffective.hashCode());
	  result = PRIME * result + ((this.serviceExpiration == null) ? 0 : this.serviceExpiration.hashCode());
	  result = PRIME * result + ((this.serviceName == null) ? 0 : this.serviceName.hashCode());
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
	  final DAOSubServices other = (DAOSubServices) obj;
	  if (this.accessNumber == null) {
		  if (other.accessNumber != null)
			  return false;
	  } else if (!this.accessNumber.equals(other.accessNumber))
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
	  if (this.serviceEffective == null) {
		  if (other.serviceEffective != null)
			  return false;
	  } else if (!this.serviceEffective.equals(other.serviceEffective))
		  return false;
	  if (this.serviceExpiration == null) {
		  if (other.serviceExpiration != null)
			  return false;
	  } else if (!this.serviceExpiration.equals(other.serviceExpiration))
		  return false;
	  if (this.serviceName == null) {
		  if (other.serviceName != null)
			  return false;
	  } else if (!this.serviceName.equals(other.serviceName))
		  return false;
	  if (this.subscriptionId == null) {
		  if (other.subscriptionId != null)
			  return false;
	  } else if (!this.subscriptionId.equals(other.subscriptionId))
		  return false;
	  return true;
  }
}
