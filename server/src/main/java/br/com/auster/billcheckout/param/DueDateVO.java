/*
 * Copyright (c) 2004-2005 Auster Solutions do Brasil. All Rights Reserved.
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
 * Created on 29/08/2006
 */
//TODO Comment this Class
package br.com.auster.billcheckout.param;

import br.com.auster.om.reference.PKEnabledEntity;

/**
 * @author mtengelm
 * @version $Id: CallThresholds.java 584 2006-10-03 23:13:10Z mtengelm $
 */
public class DueDateVO extends PKEnabledEntity implements CachedVO {

	public static final String MONTH_CHANGE_CURRENT = "N";

	public static final String MONTH_CHANGE_NEXT = "S";

	private String cycleCode;

	private String customerType;

	private int dueDate;

	private String monthChangeInd;

	private String currentKey;

	/**
	 * Default constructor
	 */
	public DueDateVO() {
		this(0);
	}

	public DueDateVO(String cycleCode, String customerType, int dueDate, String changeMonthInd) {
		super();
		this.cycleCode = cycleCode;
		this.customerType = customerType;
		this.dueDate = dueDate;
		this.monthChangeInd = changeMonthInd;
	}

	/**
	 * @param uid
	 */
	public DueDateVO(long _uid) {
		setUid(_uid);
	}

	public String getMonthChangeInd() {
		return monthChangeInd;
	}

	public void setMonthChangeInd(String changeMonthInd) {
		this.monthChangeInd = changeMonthInd;
	}

	public String getCustomerType() {
		return customerType;
	}

	public void setCustomerType(String customerType) {
		this.customerType = customerType;
	}

	public String getCycleCode() {
		return cycleCode;
	}

	public void setCycleCode(String cycleCode) {
		this.cycleCode = cycleCode;
	}

	public int getDueDate() {
		return dueDate;
	}

	public void setDueDate(int dueDate) {
		this.dueDate = dueDate;
	}

	public boolean equals(Object obj) {
		DueDateVO inObj;
		if (obj instanceof DueDateVO) {
			inObj = (DueDateVO) obj;
			if ((inObj.getCycleCode().equals(this.getCycleCode()))
					&& (inObj.getCustomerType().equals(this.getCustomerType()))) {
				return true;
			}
		}
		return false;
	}

	public int hashCode() {
		int result = super.hashCode();
		result = result * 37 + (this.getCycleCode() == null ? 0 : this.getCycleCode().hashCode());
		result = result * 37 + (this.getCustomerType() == null ? 0 : this.getCustomerType().hashCode());

		return result;
	}
	
	public String getAlternateKey() {
		return getKey();
	}
	
	public String getKey() {
		if (currentKey == null) {
			currentKey = createKey(this.getCycleCode(), this.getCustomerType());
		}
		return currentKey;
	}
	
	public String toString() {
		return "CycleCode=" + this.getCycleCode() + ".CustomerType=" + this.getCustomerType()
		+ ".DueDate=" + this.getDueDate() + ".Shift:" + this.getMonthChangeInd();
	}
	
	public static String createKey(String cycleCode, String customerType ) {
		if ( null == cycleCode || null==customerType) {
			return null;
		}
		return cycleCode + "." + customerType;
	}
}
