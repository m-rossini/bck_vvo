package br.com.auster.vivo.billcheckout.cache.vo;

import java.util.Date;

/**
 * Penalty information for late payments
 * 
 * @author mtengelm
 */
public class InterestFeeVO {
    private String accountNumber;
    private String carrierCode;
    private String carrierState;
    private double documentAmount;
    private Date feeDate;
    private double feeAmount;
    private String feeType;
    private Date paymentDate;
    @Deprecated // because it is no longer used
	private Date paymentReferenceDate;
    private Date dueDatePayment;
    private Date dueFeeDate;
    private Date referenceFeeDate;
    private double receivableAmount;
    
    public InterestFeeVO() {} //Does nothing
    
    /**
     * Account number for which the contract was broke
     * @return
     */
    public String getAccountNumber() {
        return accountNumber;
    }
    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

		/**
     * @return the carrierCode
     */
    public String getCarrierCode() {
    	return this.carrierCode;
    }

		/**
     * @param carrierCode the carrierCode to set
     */
    public void setCarrierCode(String carrierCode) {
    	this.carrierCode = carrierCode;
    }

		/**
     * @return the carrierState
     */
    public String getCarrierState() {
    	return this.carrierState;
    }

		/**
     * @param carrierState the carrierState to set
     */
    public void setCarrierState(String carrierState) {
    	this.carrierState = carrierState;
    }

		/**
     * @return the documentAmount
     */
    public double getDocumentAmount() {
    	return this.documentAmount;
    }

		/**
     * @param documentAmount the documentAmount to set
     */
    public void setDocumentAmount(double documentAmount) {
    	this.documentAmount = documentAmount;
    }
    
		/**
     * @return the dueDatePayment
     */
    public Date getDueDatePayment() {
    	return this.dueDatePayment;
    }

		/**
     * @param dueDatePayment the dueDatePayment to set
     */
    public void setDueDatePayment(Date dueDatePayment) {
    	this.dueDatePayment = dueDatePayment;
    }

		/**
     * @return the dueFeeDate
     */
    public Date getDueFeeDate() {
    	return this.dueFeeDate;
    }

		/**
     * @param dueFeeDate the dueFeeDate to set
     */
    public void setDueFeeDate(Date dueFeeDate) {
    	this.dueFeeDate = dueFeeDate;
    }

		/**
     * @return the feeAmount
     */
    public double getFeeAmount() {
    	return this.feeAmount;
    }

		/**
     * @param feeAmount the feeAmount to set
     */
    public void setFeeAmount(double feeAmount) {
    	this.feeAmount = feeAmount;
    }

		/**
     * @return the feeDate
     */
    public Date getFeeDate() {
    	return this.feeDate;
    }

		/**
     * @param feeDate the feeDate to set
     */
    public void setFeeDate(Date feeDate) {
    	this.feeDate = feeDate;
    }

		/**
     * @return the feeType
     */
    public String getFeeType() {
    	return this.feeType;
    }

		/**
     * @param feeType the feeType to set
     */
    public void setFeeType(String feeType) {
    	this.feeType = feeType;
    }

		/**
     * @return the paymentDate
     */
    public Date getPaymentDate() {
    	return this.paymentDate;
    }

		/**
     * @param paymentDate the paymentDate to set
     */
    public void setPaymentDate(Date paymentDate) {
    	this.paymentDate = paymentDate;
    }

	/**
     * Deprecated because it is no longer used
     * @return the paymentReferenceDate
     */
    @Deprecated
    public Date getPaymentReferenceDate() {
    	return this.paymentReferenceDate;
    }

	/**
     * Deprecated because it is no longer used
     * @param paymentReferenceDate the paymentReferenceDate to set
     */
    @Deprecated
	public void setPaymentReferenceDate(Date paymentReferenceDate) {
    	this.paymentReferenceDate = paymentReferenceDate;
    }

		/**
     * @return the referenceFeeDate
     */
    public Date getReferenceFeeDate() {
    	return this.referenceFeeDate;
    }

		/**
     * @param referenceFeeDate the referenceFeeDate to set
     */
    public void setReferenceFeeDate(Date referenceFeeDate) {
    	this.referenceFeeDate = referenceFeeDate;
    }

		/* (non-Javadoc)
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString() {
	    return "Acc:" + accountNumber + ".CCode:" + carrierCode 
	    + ".CState:" + carrierState + ".Amt:" +  documentAmount;
    }

		/* (non-Javadoc)
     * @see java.lang.Object#hashCode()
     */
    @Override
    public int hashCode() {
	    final int PRIME = 31;
	    int result = super.hashCode();
	    result = PRIME * result + ((this.accountNumber == null) ? 0 : this.accountNumber.hashCode());
	    result = PRIME * result + ((this.carrierCode == null) ? 0 : this.carrierCode.hashCode());
	    result = PRIME * result + ((this.carrierState == null) ? 0 : this.carrierState.hashCode());
	    long temp;
	    temp = Double.doubleToLongBits(this.documentAmount);
	    result = PRIME * result + (int) (temp ^ (temp >>> 32));
	    result = PRIME * result + ((this.dueDatePayment == null) ? 0 : this.dueDatePayment.hashCode());
	    result = PRIME * result + ((this.dueFeeDate == null) ? 0 : this.dueFeeDate.hashCode());
	    temp = Double.doubleToLongBits(this.feeAmount);
	    result = PRIME * result + (int) (temp ^ (temp >>> 32));
	    result = PRIME * result + ((this.feeDate == null) ? 0 : this.feeDate.hashCode());
	    result = PRIME * result + ((this.feeType == null) ? 0 : this.feeType.hashCode());
	    result = PRIME * result + ((this.paymentDate == null) ? 0 : this.paymentDate.hashCode());
	    result = PRIME * result + ((this.paymentReferenceDate == null) ? 0 : this.paymentReferenceDate.hashCode());
	    result = PRIME * result + ((this.referenceFeeDate == null) ? 0 : this.referenceFeeDate.hashCode());
	    return result;
    }

		/* (non-Javadoc)
     * @see java.lang.Object#equals(java.lang.Object)
     */
    @Override
    public boolean equals(Object obj) {
	    if (this == obj)
		    return true;
	    if (!super.equals(obj))
		    return false;
	    if (getClass() != obj.getClass())
		    return false;
	    final InterestFeeVO other = (InterestFeeVO) obj;
	    if (this.accountNumber == null) {
		    if (other.accountNumber != null)
			    return false;
	    } else if (!this.accountNumber.equals(other.accountNumber))
		    return false;
	    if (this.carrierCode == null) {
		    if (other.carrierCode != null)
			    return false;
	    } else if (!this.carrierCode.equals(other.carrierCode))
		    return false;
	    if (this.carrierState == null) {
		    if (other.carrierState != null)
			    return false;
	    } else if (!this.carrierState.equals(other.carrierState))
		    return false;
	    if (Double.doubleToLongBits(this.documentAmount) != Double.doubleToLongBits(other.documentAmount))
		    return false;
	    if (this.dueDatePayment == null) {
		    if (other.dueDatePayment != null)
			    return false;
	    } else if (!this.dueDatePayment.equals(other.dueDatePayment))
		    return false;
	    if (this.dueFeeDate == null) {
		    if (other.dueFeeDate != null)
			    return false;
	    } else if (!this.dueFeeDate.equals(other.dueFeeDate))
		    return false;
	    if (Double.doubleToLongBits(this.feeAmount) != Double.doubleToLongBits(other.feeAmount))
		    return false;
	    if (this.feeDate == null) {
		    if (other.feeDate != null)
			    return false;
	    } else if (!this.feeDate.equals(other.feeDate))
		    return false;
	    if (this.feeType == null) {
		    if (other.feeType != null)
			    return false;
	    } else if (!this.feeType.equals(other.feeType))
		    return false;
	    if (this.paymentDate == null) {
		    if (other.paymentDate != null)
			    return false;
	    } else if (!this.paymentDate.equals(other.paymentDate))
		    return false;
	    if (this.paymentReferenceDate == null) {
		    if (other.paymentReferenceDate != null)
			    return false;
	    } else if (!this.paymentReferenceDate.equals(other.paymentReferenceDate))
		    return false;
	    if (this.referenceFeeDate == null) {
		    if (other.referenceFeeDate != null)
			    return false;
	    } else if (!this.referenceFeeDate.equals(other.referenceFeeDate))
		    return false;
	    return true;
    }

		
		/**
		 * Return the value of a attribute <code>receivableAmount</code>.
		 * @return return the value of <code>receivableAmount</code>.
		 */
		public double getReceivableAmount() {
			return this.receivableAmount;
		}

		
		/**
		 * Set the value of attribute <code>receivableAmount</code>.
		 * @param receivableAmount
		 */
		public void setReceivableAmount(double receivableAmount) {
			this.receivableAmount = receivableAmount;
		}
    
}
