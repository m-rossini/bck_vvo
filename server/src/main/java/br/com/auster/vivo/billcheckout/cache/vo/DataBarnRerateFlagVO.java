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


public class DataBarnRerateFlagVO {

	private String svcPriceSeqNbr;
	private String rerateFlag;
	private String effectiveDate;
	private String expirationDate;
	
	public DataBarnRerateFlagVO() {
		super();
	}
  
	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int PRIME = 31;
		int result = 1;
		result = PRIME * result + ((this.svcPriceSeqNbr == null) ? 0 : this.svcPriceSeqNbr.hashCode());
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
		final DataBarnRerateFlagVO other = (DataBarnRerateFlagVO) obj;
		if (this.svcPriceSeqNbr == null) {
			if (other.svcPriceSeqNbr != null) { return false; }
		} 
		else if (!this.svcPriceSeqNbr.equals(other.svcPriceSeqNbr)) {
			return false;
		}
		if (this.rerateFlag == null) {
			if (other.rerateFlag != null) { return false; }
		} 
		else if (!this.rerateFlag.equals(other.rerateFlag)) {
			return false;
		}
		if (this.effectiveDate == null) {
			if (other.effectiveDate != null) { return false; }
		} 
		else if (!this.effectiveDate.equals(other.effectiveDate)) {
			return false;
		}
		if (this.expirationDate == null) {
			if (other.expirationDate != null) { return false; }
		} 
		else if (!this.expirationDate.equals(other.expirationDate)) {
			return false;
		}
		return true;
	}
	
	public String toString() {
		return "SeqNbr:" + svcPriceSeqNbr + ".RerateFlag:" + rerateFlag + 
			".EffDate:" + effectiveDate + ".ExprDate:" + expirationDate;
	}

	public String getEffectiveDate() {
		return effectiveDate;
	}

	public void setEffectiveDate(String effectiveDate) {
		this.effectiveDate = effectiveDate;
	}

	public String getExpirationDate() {
		return expirationDate;
	}

	public void setExpirationDate(String expirationDate) {
		this.expirationDate = expirationDate;
	}

	public String getSvcPriceSeqNbr() {
		return svcPriceSeqNbr;
	}

	public void setSvcPriceSeqNbr(String priceSeqNbr) {
		this.svcPriceSeqNbr = priceSeqNbr;
	}

	public String getRerateFlag() {
		return rerateFlag;
	}

	public void setRerateFlag(String rerateFlag) {
		this.rerateFlag = rerateFlag;
	}

}
