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
 * Created on 10/01/2008
 */
package br.com.auster.vivo.billcheckout.caches.vo;

import java.util.Date;


public class AccountAndCycleChangeVO {

	private String acctNbr;
	private String subId;
	private String cycleCd;
	private Date acctCycleEffDt;
	private String acctCycleEffTm;
	private Date svcAsgmEffDt;
	private Date svcAsgmExpDt;
	public String getAcctNbr() {
		return acctNbr;
	}
	public void setAcctNbr(String acctNbr) {
		this.acctNbr = acctNbr;
	}
	public String getSubId() {
		return subId;
	}
	public void setSubId(String subId) {
		this.subId = subId;
	}
	public String getCycleCd() {
		return cycleCd;
	}
	public void setCycleCd(String cycleCd) {
		this.cycleCd = cycleCd;
	}
	public Date getAcctCycleEffDt() {
		return acctCycleEffDt;
	}
	public void setAcctCycleEffDt(Date acctCycleEffDt) {
		this.acctCycleEffDt = acctCycleEffDt;
	}
	public String getAcctCycleEffTm() {
		return acctCycleEffTm;
	}
	public void setAcctCycleEffTm(String acctCycleEffTm) {
		this.acctCycleEffTm = acctCycleEffTm;
	}
	public Date getSvcAsgmEffDt() {
		return svcAsgmEffDt;
	}
	public void setSvcAsgmEffDt(Date svcAsgmEffDt) {
		this.svcAsgmEffDt = svcAsgmEffDt;
	}
	public Date getSvcAsgmExpDt() {
		return svcAsgmExpDt;
	}
	public void setSvcAsgmExpDt(Date svcAsgmExpDt) {
		this.svcAsgmExpDt = svcAsgmExpDt;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((acctCycleEffDt == null) ? 0 : acctCycleEffDt.hashCode());
		result = prime * result
				+ ((acctCycleEffTm == null) ? 0 : acctCycleEffTm.hashCode());
		result = prime * result + ((acctNbr == null) ? 0 : acctNbr.hashCode());
		result = prime * result + ((cycleCd == null) ? 0 : cycleCd.hashCode());
		result = prime * result + ((subId == null) ? 0 : subId.hashCode());
		result = prime * result
				+ ((svcAsgmEffDt == null) ? 0 : svcAsgmEffDt.hashCode());
		result = prime * result
				+ ((svcAsgmExpDt == null) ? 0 : svcAsgmExpDt.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final AccountAndCycleChangeVO other = (AccountAndCycleChangeVO) obj;
		if (acctCycleEffDt == null) {
			if (other.acctCycleEffDt != null)
				return false;
		} else if (!acctCycleEffDt.equals(other.acctCycleEffDt))
			return false;
		if (acctCycleEffTm == null) {
			if (other.acctCycleEffTm != null)
				return false;
		} else if (!acctCycleEffTm.equals(other.acctCycleEffTm))
			return false;
		if (acctNbr == null) {
			if (other.acctNbr != null)
				return false;
		} else if (!acctNbr.equals(other.acctNbr))
			return false;
		if (cycleCd == null) {
			if (other.cycleCd != null)
				return false;
		} else if (!cycleCd.equals(other.cycleCd))
			return false;
		if (subId == null) {
			if (other.subId != null)
				return false;
		} else if (!subId.equals(other.subId))
			return false;
		if (svcAsgmEffDt == null) {
			if (other.svcAsgmEffDt != null)
				return false;
		} else if (!svcAsgmEffDt.equals(other.svcAsgmEffDt))
			return false;
		if (svcAsgmExpDt == null) {
			if (other.svcAsgmExpDt != null)
				return false;
		} else if (!svcAsgmExpDt.equals(other.svcAsgmExpDt))
			return false;
		return true;
	}
		
}