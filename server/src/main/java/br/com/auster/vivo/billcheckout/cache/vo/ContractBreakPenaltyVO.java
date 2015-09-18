package br.com.auster.vivo.billcheckout.cache.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.log4j.Logger;

import br.com.auster.common.util.DateUtils;

/**
 * Penalty information for contract breaks
 * 
 * @author etirelli
 */
public class ContractBreakPenaltyVO {

	private static Logger	log	= Logger.getLogger(ContractBreakPenaltyVO.class);

	private String				sequenceNumber;																			// NEW1
	private String				accessNumber;
	private String				accountNumber;
	private String				subscriptionId;
	private String				scenarioId;
	private String				chargeType;
	private String				captionText;																					// NEW1
																																							// (This
																																							// is
																																							// the
																																							// invoice
																																							// text)
	private Date					effectiveDate;
	private Date					expirationDate;
	private double				negotPriceAmt;
	private double				negotPercent;
	private double				basePriceAmt;
	private int						periodQuantity;
	private String				serviceAreaId;
	private String				taxCategoryId;
	private Date					agreementExpirationDate;															// NEW1
	private Date					agreementEffectiveDate;															// NEW1
	private String				serviceName;
	private String				dataOriging;																					// NEW1
	private String				negotType;																						// NEW1
																																							// (A-Absoluto
																																							// / D
																																							// -
																																							// Desconto / I -Incremento)
	private String				taxIncluded;																					// NEW1

	
	public boolean isNegotiatedToZero(){
		boolean zeroNegotiated = false;
		
		if (negotType != null && negotType.equalsIgnoreCase("D") && 
			negotPercent == 100)
			zeroNegotiated = true;		
		else 
			if (negotPriceAmt == 0 && basePriceAmt != 0)
				zeroNegotiated = true;
		
		return zeroNegotiated;
	}

	/**
	 * Return the value of a attribute <code>agreementEffectiveDate</code>.
	 * 
	 * @return return the value of <code>agreementEffectiveDate</code>.
	 */
	public Date getAgreementEffectiveDate() {
		return this.agreementEffectiveDate;
	}
	
	/**
	 * Return the value of a attribute <code>agreementEffectiveStringDate</code>.
	 * 
	 * @return return the value of <code>agreementEffectiveDate</code>.
	 */
	public String getAgreementEffectiveStringDate() {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		return dateFormat.format(this.agreementEffectiveDate);
	}

	/**
	 * Set the value of attribute <code>agreementEffectiveDate</code>.
	 * 
	 * @param agreementEffectiveDate
	 */
	public void setAgreementEffectiveDate(Date agreementEffectiveDate) {
		this.agreementEffectiveDate = agreementEffectiveDate;
	}

	/**
	 * Return the value of a attribute <code>agreementExpirationDate</code>.
	 * 
	 * @return return the value of <code>agreementExpirationDate</code>.
	 */
	public Date getAgreementExpirationDate() {
		return this.agreementExpirationDate;
	}

	/*****************************************************************************
	 * Returns true if the expiration date of fee for a contract break is valid. A
	 * Valid date is: If it is null (Not expired) If it is AFTER effective date
	 * <p>
	 * Example:
	 * 
	 * <pre>
	 *    Create a use example.
	 * </pre>
	 * 
	 * </p>
	 * 
	 * @return
	 */
	public boolean isAgreementExpirationDateValid() {
		if (this.getAgreementExpirationDate() == null) {
			return true;
		}
		return (this.getAgreementExpirationDate().after(this
				.getAgreementEffectiveDate())) ? true : false;
	}

	/**
	 * Set the value of attribute <code>agreementExpirationDate</code>.
	 * 
	 * @param agreementExpirationDate
	 */
	public void setAgreementExpirationDate(Date agreementExpirationDate) {
		this.agreementExpirationDate = agreementExpirationDate;
	}

	protected long getAgreementDifference(Date start, Date end, char pattern) {
		long diff = Long.MIN_VALUE;
		try {		
			diff = DateUtils.difference(start,
					end, pattern);
		} catch (IllegalArgumentException e) {
			log.error("Error during date difference calculation.Start:"
					+ getAgreementEffectiveDate() + ".End:"
					+ getAgreementExpirationDate(), e);
		} catch (ParseException e) {
			log.error("Error during date difference calculation.Start:"
					+ getAgreementEffectiveDate() + ".End:"
					+ getAgreementExpirationDate(), e);
		}

		return diff;
	}

	public long getAgreementDifferenceInMonths() {
		if (   (!isAgreementExpirationDateValid()) 
				|| (this.getAgreementEffectiveDate() == null)
				|| (this.getAgreementExpirationDate() == null)) {
			return Long.MIN_VALUE;
		}

		Calendar cStart = Calendar.getInstance();
		cStart.setTime(this.getAgreementEffectiveDate());
		cStart.set(Calendar.DAY_OF_MONTH, 1);

		Calendar cEnd = Calendar.getInstance();
		cEnd.setTime(this.getAgreementExpirationDate());
		cEnd.set(Calendar.DAY_OF_MONTH, 1);
		
		return getAgreementDifference(cStart.getTime(), cEnd.getTime(),'M');
	}	
	
	public boolean isPeriodEqualsFromCalculations() {
		return this.getPeriodQuantity() == this.getAgreementDifferenceInMonths();
	}
	
	public long getPeriodDifference() {
		return this.getPeriodQuantity() - this.getAgreementDifferenceInMonths();
	}
	/**
	 * Return the value of a attribute <code>captionText</code>.
	 * 
	 * @return return the value of <code>captionText</code>.
	 */
	public String getCaptionText() {
		return this.captionText;
	}

	/**
	 * Set the value of attribute <code>captionText</code>.
	 * 
	 * @param captionText
	 */
	public void setCaptionText(String captionText) {
		this.captionText = captionText;
	}

	/**
	 * Return the value of a attribute <code>dataOriging</code>.
	 * 
	 * @return return the value of <code>dataOriging</code>.
	 */
	public String getDataOriging() {
		return this.dataOriging;
	}

	/**
	 * Set the value of attribute <code>dataOriging</code>.
	 * 
	 * @param dataOriging
	 */
	public void setDataOriging(String dataOriging) {
		this.dataOriging = dataOriging;
	}

	/**
	 * Return the value of a attribute <code>negotType</code>.
	 * 
	 * @return return the value of <code>negotType</code>.
	 */
	public String getNegotType() {
		return this.negotType;
	}

	/**
	 * Set the value of attribute <code>negotType</code>.
	 * 
	 * @param negotType
	 */
	public void setNegotType(String negotType) {
		this.negotType = negotType;
	}

	/**
	 * Return the value of a attribute <code>sequenceNumber</code>.
	 * 
	 * @return return the value of <code>sequenceNumber</code>.
	 */
	public String getSequenceNumber() {
		return this.sequenceNumber;
	}

	/**
	 * Set the value of attribute <code>sequenceNumber</code>.
	 * 
	 * @param sequenceNumber
	 */
	public void setSequenceNumber(String sequenceNumber) {
		this.sequenceNumber = sequenceNumber;
	}

	/**
	 * Return the value of a attribute <code>taxIncluded</code>.
	 * 
	 * @return return the value of <code>taxIncluded</code>.
	 */
	public String getTaxIncluded() {
		return this.taxIncluded;
	}

	/**
	 * Set the value of attribute <code>taxIncluded</code>.
	 * 
	 * @param taxIncluded
	 */
	public void setTaxIncluded(String taxIncluded) {
		this.taxIncluded = taxIncluded;	
	}


	/**
	 * Access number for which the contract was broke
	 * 
	 * @return
	 */
	public String getAccessNumber() {
		return accessNumber;
	}

	public void setAccessNumber(String accessNumber) {
		this.accessNumber = accessNumber;
	}

	/**
	 * Account number for which the contract was broke
	 * 
	 * @return
	 */
	public String getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

	/**
	 * Base contract penalty amount
	 * 
	 * @return
	 */
	public double getBasePriceAmt() {
		return basePriceAmt;
	}

	public void setBasePriceAmt(double basePriceAmt) {
		this.basePriceAmt = basePriceAmt;
	}

	/**
	 * Contract effective date
	 * 
	 * @return
	 */
	public Date getEffectiveDate() {
		return effectiveDate;
	}

	public void setEffectiveDate(Date effectiveDate) {
		this.effectiveDate = effectiveDate;
	}

	/**
	 * Contract expiration date
	 * 
	 * @return
	 */
	public Date getExpirationDate() {
		return expirationDate;
	}

	public void setExpirationDate(Date expirationDate) {
		this.expirationDate = expirationDate;
	}

	/*****************************************************************************
	 * Returns true if the expiration date of a contract is valid. A Valid date
	 * for contract expiration is: If it is null (Not expired) If it is AFTER
	 * effective date
	 * <p>
	 * Example:
	 * 
	 * <pre>
	 *    Create a use example.
	 * </pre>
	 * 
	 * </p>
	 * 
	 * @return
	 */
	public boolean isExpirationDateValid() {
		if (this.getExpirationDate() == null) {
			return true;
		}
		return (this.getExpirationDate().after(this.getEffectiveDate())) ? true
				: false;
	}

	/**
	 * Contract penalty negotiated amount
	 * 
	 * @return
	 */
	public double getNegotPriceAmt() {
		return negotPriceAmt;
	}

	public void setNegotPriceAmt(double negotPriceAmt) {
		this.negotPriceAmt = negotPriceAmt;
	}

	/**
	 * Service Name
	 */
	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	public double getPenaltyAmount() {
		return this.negotPriceAmt;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {

		StringBuilder sb = new StringBuilder();
		sb.append("CBP.Account[");
		sb.append(accountNumber);
		sb.append("].");
		sb.append("Access[");
		sb.append(accessNumber);
		sb.append("].");
		sb.append("Service[");
		sb.append(serviceName);
		sb.append("].");
		sb.append("DtEfetiva[");
		sb.append(effectiveDate);
		sb.append("].");
		sb.append("DtExpirada[");
		sb.append(expirationDate);
		sb.append("].");
		sb.append("Base[");
		sb.append(basePriceAmt);
		sb.append("].");
		sb.append("Negociado[");
		sb.append(negotPriceAmt);
		sb.append("].");
		return sb.toString();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int PRIME = 31;
		int result = super.hashCode();
		result = PRIME * result
				+ ((this.accessNumber == null) ? 0 : this.accessNumber.hashCode());
		result = PRIME * result
				+ ((this.accountNumber == null) ? 0 : this.accountNumber.hashCode());
		result = PRIME * result
				+ ((this.chargeType == null) ? 0 : this.chargeType.hashCode());
		result = PRIME * result
				+ ((this.effectiveDate == null) ? 0 : this.effectiveDate.hashCode());
		result = PRIME * result
				+ ((this.expirationDate == null) ? 0 : this.expirationDate.hashCode());
		result = PRIME * result + this.periodQuantity;
		result = PRIME * result
				+ ((this.scenarioId == null) ? 0 : this.scenarioId.hashCode());
		result = PRIME * result
				+ ((this.serviceAreaId == null) ? 0 : this.serviceAreaId.hashCode());
		result = PRIME * result
				+ ((this.serviceName == null) ? 0 : this.serviceName.hashCode());
		result = PRIME * result
				+ ((this.subscriptionId == null) ? 0 : this.subscriptionId.hashCode());
		result = PRIME * result
				+ ((this.taxCategoryId == null) ? 0 : this.taxCategoryId.hashCode());
		return result;
	}

	/*
	 * (non-Javadoc)
	 * 
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
		final ContractBreakPenaltyVO other = (ContractBreakPenaltyVO) obj;
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
		if (this.chargeType == null) {
			if (other.chargeType != null)
				return false;
		} else if (!this.chargeType.equals(other.chargeType))
			return false;
		if (this.effectiveDate == null) {
			if (other.effectiveDate != null)
				return false;
		} else if (!this.effectiveDate.equals(other.effectiveDate))
			return false;
		if (this.expirationDate == null) {
			if (other.expirationDate != null)
				return false;
		} else if (!this.expirationDate.equals(other.expirationDate))
			return false;
		if (this.periodQuantity != other.periodQuantity)
			return false;
		if (this.scenarioId == null) {
			if (other.scenarioId != null)
				return false;
		} else if (!this.scenarioId.equals(other.scenarioId))
			return false;
		if (this.serviceAreaId == null) {
			if (other.serviceAreaId != null)
				return false;
		} else if (!this.serviceAreaId.equals(other.serviceAreaId))
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
		if (this.taxCategoryId == null) {
			if (other.taxCategoryId != null)
				return false;
		} else if (!this.taxCategoryId.equals(other.taxCategoryId))
			return false;
		return true;
	}

	/**
	 * @return the chargeType
	 */
	public String getChargeType() {
		return this.chargeType;
	}

	/**
	 * @param chargeType
	 *          the chargeType to set
	 */
	public void setChargeType(String chargeType) {
		this.chargeType = chargeType;
	}

	/**
	 * @return the negotPercent
	 */
	public double getNegotPercent() {
		return this.negotPercent;
	}

	/**
	 * @param negotPercent
	 *          the negotPercent to set
	 */
	public void setNegotPercent(double negotPercent) {
		this.negotPercent = negotPercent;
	}

	/**
	 * @return the periodQuantity
	 */
	public int getPeriodQuantity() {
		return this.periodQuantity;
	}

	/**
	 * @param periodQuantity
	 *          the periodQuantity to set
	 */
	public void setPeriodQuantity(int periodQuantity) {
		this.periodQuantity = periodQuantity;
	}

	/**
	 * @return the scenarioId
	 */
	public String getScenarioId() {
		return this.scenarioId;
	}

	/**
	 * @param scenarioId
	 *          the scenarioId to set
	 */
	public void setScenarioId(String scenarioId) {
		this.scenarioId = scenarioId;
	}

	/**
	 * @return the serviceAreaId
	 */
	public String getServiceAreaId() {
		return this.serviceAreaId;
	}

	/**
	 * @param serviceAreaId
	 *          the serviceAreaId to set
	 */
	public void setServiceAreaId(String serviceAreaId) {
		this.serviceAreaId = serviceAreaId;
	}

	/**
	 * @return the subscriptionId
	 */
	public String getSubscriptionId() {
		return this.subscriptionId;
	}

	/**
	 * @param subscriptionId
	 *          the subscriptionId to set
	 */
	public void setSubscriptionId(String subscriptionId) {
		this.subscriptionId = subscriptionId;
	}

	/**
	 * @return the taxCategoryId
	 */
	public String getTaxCategoryId() {
		return this.taxCategoryId;
	}

	/**
	 * @param taxCategoryId
	 *          the taxCategoryId to set
	 */
	public void setTaxCategoryId(String taxCategoryId) {
		this.taxCategoryId = taxCategoryId;
	}

}
