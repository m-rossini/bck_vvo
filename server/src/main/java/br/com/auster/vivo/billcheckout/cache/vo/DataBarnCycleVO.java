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

public class DataBarnCycleVO {

	private String accountNumber;
	private String cycleCode;
	private String effectiveDate;
	
	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int PRIME = 31;
		int result = 1;
		result = PRIME * result + ((this.accountNumber == null) ? 0 : this.accountNumber.hashCode());
		result = PRIME * result + ((this.cycleCode == null) ? 0 : this.cycleCode.hashCode());
		result = PRIME * result + ((this.effectiveDate == null) ? 0 : this.effectiveDate.hashCode());
		return result;
	}

	/* (non-Javadoc)
     * @see java.lang.Object#equals(java.lang.Object)
     */
	@Override
	public boolean equals(Object obj) {
		if (this == obj) { return true; }
		if (obj == null) { return false; }
		if (getClass() != obj.getClass()) { return false; }
		final DataBarnCycleVO other = (DataBarnCycleVO) obj;
		if (this.accountNumber == null) {
			if (other.accountNumber != null) { return false; }
		} 
		else if (!this.accountNumber.equals(other.accountNumber)) {
			return false;
		}
		if (this.cycleCode == null) {
			if (other.cycleCode != null) { return false; }
		} 
		else if (!this.cycleCode.equals(other.cycleCode)) {
			return false;
		}
		if (this.effectiveDate == null) {
			if (other.effectiveDate != null) { return false; }
		} 
		else if (!this.effectiveDate.equals(other.effectiveDate)) {
			return false;
		}
		return true;
	}
	
	/* (non-Javadoc)
     * @see java.lang.Object#toString()
     */
	@Override
	public String toString() {
		return "AccountNbr:" + accountNumber + ".CycleCd:" + cycleCode +
			".EffDate:" + effectiveDate;
	}

	public String getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

	public String getCycleCode() {
		return cycleCode;
	}

	public void setCycleCode(String cycleCode) {
		this.cycleCode = cycleCode;
	}

	public String getEffectiveDate() {
		return effectiveDate;
	}

	public void setEffectiveDate(String effectiveDate) {
		this.effectiveDate = effectiveDate;
	}
}
