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
// TODO Comment this class br.com.auster.vivo.billcheckout.cache.vo "." PromotionRangesVO.java
public class PromotionRangesVO {

	public static final String PROMO_MONEY = "FD";
	public static final String PROMO_FREEUNITS = "FM";
	public static final String PROMO_DISCOUNT = "P";
	
	public static final String LEVEL_ACCOUNT = "A";
	public static final String LEVEL_SUBSCRIPTION = "S";
	
	private String marketingProgramId;
	private String marketingProgramDescription;
	private int beginCycle;
	private int endCycle;
	private double rewardAmount;
	private String serviceArea;
	private String autoEnrollFlag;
	private String applicationIndicator;
	private String promotionLevel;
	private String rewardType;
	
	public boolean isApplicationInMoney() {
		return (this.applicationIndicator != null && this.applicationIndicator.equalsIgnoreCase(PROMO_MONEY));
	}
	public boolean isApplicationInPercentage() {
		return (this.applicationIndicator != null && this.applicationIndicator.equalsIgnoreCase(PROMO_DISCOUNT));
	}	
	public boolean isApplicationInFreeUnits() {
		return (this.applicationIndicator != null && this.applicationIndicator.equalsIgnoreCase(PROMO_FREEUNITS));
	}
	public boolean isPromotionAtAccountLevel() {
		return (this.promotionLevel != null && this.promotionLevel.equalsIgnoreCase(LEVEL_ACCOUNT));
	}
	public boolean isPromotionAtSubscriptionLevel() {
		return (this.promotionLevel != null && this.promotionLevel.equalsIgnoreCase(LEVEL_SUBSCRIPTION));
	}
	
	/**
   * @return the applicationIndicator
   */
  public String getApplicationIndicator() {
  	return this.applicationIndicator;
  }
    
  
	/**
   * @param applicationIndicator the applicationIndicator to set
   */
  public void setApplicationIndicator(String applicationIndicator) {
  	this.applicationIndicator = applicationIndicator;
  }
	/**
   * @return the autoEnrollFlag
   */
  public String getAutoEnrollFlag() {
  	return this.autoEnrollFlag;
  }
	/**
   * @param autoEnrollFlag the autoEnrollFlag to set
   */
  public void setAutoEnrollFlag(String autoEnrollFlag) {
  	this.autoEnrollFlag = autoEnrollFlag;
  }
	/**
   * @return the beginCycle
   */
  public int getBeginCycle() {
  	return this.beginCycle;
  }
	/**
   * @param beginCycle the beginCycle to set
   */
  public void setBeginCycle(int beginCycle) {
  	this.beginCycle = beginCycle;
  }
	/**
   * @return the endCycle
   */
  public int getEndCycle() {
  	return this.endCycle;
  }
	/**
   * @param endCycle the endCycle to set
   */
  public void setEndCycle(int endCycle) {
  	this.endCycle = endCycle;
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
   * @return the marketingProgrmaDescription
   */
  public String getMarketingProgrmaDescription() {
  	return this.marketingProgramDescription;
  }
	/**
   * @param marketingProgrmaDescription the marketingProgrmaDescription to set
   */
  public void setMarketingProgrmaDescription(String marketingProgrmaDescription) {
  	this.marketingProgramDescription = marketingProgrmaDescription;
  }
	/**
   * @return the promotionLevel
   */
  public String getPromotionLevel() {
  	return this.promotionLevel;
  }
	/**
   * @param promotionLevel the promotionLevel to set
   */
  public void setPromotionLevel(String promotionLevel) {
  	this.promotionLevel = promotionLevel;
  }
	/**
   * @return the rewardamount
   */
  public double getRewardAmount() {
  	return this.rewardAmount;
  }
	/**
   * @param rewardamount the rewardamount to set
   */
  public void setRewardAmount(double rewardamount) {
  	this.rewardAmount = rewardamount;
  }
	/**
   * @return the rewardType
   */
  public String getRewardType() {
  	return this.rewardType;
  }
	/**
   * @param rewardType the rewardType to set
   */
  public void setRewardType(String rewardType) {
  	this.rewardType = rewardType;
  }
	/**
   * @return the serviceArea
   */
  public String getServiceArea() {
  	return this.serviceArea;
  }
	/**
   * @param serviceArea the serviceArea to set
   */
  public void setServiceArea(String serviceArea) {
  	this.serviceArea = serviceArea;
  }
	/* (non-Javadoc)
   * @see java.lang.Object#hashCode()
   */
  @Override
  public int hashCode() {
	  final int PRIME = 31;
	  int result = 1;
	  result = PRIME * result + ((this.applicationIndicator == null) ? 0 : this.applicationIndicator.hashCode());
	  result = PRIME * result + ((this.autoEnrollFlag == null) ? 0 : this.autoEnrollFlag.hashCode());
	  result = PRIME * result + this.beginCycle;
	  result = PRIME * result + this.endCycle;
	  result = PRIME * result + ((this.marketingProgramId == null) ? 0 : this.marketingProgramId.hashCode());
	  result = PRIME * result + ((this.promotionLevel == null) ? 0 : this.promotionLevel.hashCode());
	  result = PRIME * result + ((this.rewardType == null) ? 0 : this.rewardType.hashCode());
	  long temp;
	  temp = Double.doubleToLongBits(this.rewardAmount);
	  result = PRIME * result + (int) (temp ^ (temp >>> 32));
	  result = PRIME * result + ((this.serviceArea == null) ? 0 : this.serviceArea.hashCode());
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
	  final PromotionRangesVO other = (PromotionRangesVO) obj;
	  if (this.applicationIndicator == null) {
		  if (other.applicationIndicator != null)
			  return false;
	  } else if (!this.applicationIndicator.equals(other.applicationIndicator))
		  return false;
	  if (this.autoEnrollFlag == null) {
		  if (other.autoEnrollFlag != null)
			  return false;
	  } else if (!this.autoEnrollFlag.equals(other.autoEnrollFlag))
		  return false;
	  if (this.beginCycle != other.beginCycle)
		  return false;
	  if (this.endCycle != other.endCycle)
		  return false;
	  if (this.marketingProgramId == null) {
		  if (other.marketingProgramId != null)
			  return false;
	  } else if (!this.marketingProgramId.equals(other.marketingProgramId))
		  return false;
	  if (this.promotionLevel == null) {
		  if (other.promotionLevel != null)
			  return false;
	  } else if (!this.promotionLevel.equals(other.promotionLevel))
		  return false;
	  if (this.rewardType == null) {
		  if (other.rewardType != null)
			  return false;
	  } else if (!this.rewardType.equals(other.rewardType))
		  return false;
	  if (Double.doubleToLongBits(this.rewardAmount) != Double.doubleToLongBits(other.rewardAmount))
		  return false;
	  if (this.serviceArea == null) {
		  if (other.serviceArea != null)
			  return false;
	  } else if (!this.serviceArea.equals(other.serviceArea))
		  return false;
	  return true;
  }
	
}
