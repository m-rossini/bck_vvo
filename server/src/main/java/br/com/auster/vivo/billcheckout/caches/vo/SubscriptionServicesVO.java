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


public class SubscriptionServicesVO {

	private String acctNbr;
	private String subId;
	private String capText;
	private String svcName;
	private Date subAsgmEffDt;
	private Date svcAgrmntEffDt;
	private Date svcAgrmntExpDt;
	private boolean foundInSIRS;
	
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
	public String getCapText() {
		return capText;
	}
	public void setCapText(String capText) {
		this.capText = capText;
	}
	public String getSvcName() {
		return svcName;
	}
	public void setSvcName(String svcName) {
		this.svcName = svcName;
	}
	public Date getSubAsgmEffDt() {
		return subAsgmEffDt;
	}
	public void setSubAsgmEffDt(Date subAsgmEffDt) {
		this.subAsgmEffDt = subAsgmEffDt;
	}
	public Date getSvcAgrmntEffDt() {
		return svcAgrmntEffDt;
	}
	public void setSvcAgrmntEffDt(Date svcAgrmntEffDt) {
		this.svcAgrmntEffDt = svcAgrmntEffDt;
	}
	public Date getSvcAgrmntExpDt() {
		return svcAgrmntExpDt;
	}
	public void setSvcAgrmntExpDt(Date svcAgrmntExpDt) {
		this.svcAgrmntExpDt = svcAgrmntExpDt;
	}
	public boolean isFoundInSIRS() {
		return foundInSIRS;
	}
	public void setFoundInSIRS(boolean foundInSIRS) {
		this.foundInSIRS = foundInSIRS;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((acctNbr == null) ? 0 : acctNbr.hashCode());
		result = prime * result + ((capText == null) ? 0 : capText.hashCode());
		result = prime * result + (foundInSIRS ? 1231 : 1237);
		result = prime * result
				+ ((subAsgmEffDt == null) ? 0 : subAsgmEffDt.hashCode());
		result = prime * result + ((subId == null) ? 0 : subId.hashCode());
		result = prime * result
				+ ((svcAgrmntEffDt == null) ? 0 : svcAgrmntEffDt.hashCode());
		result = prime * result
				+ ((svcAgrmntExpDt == null) ? 0 : svcAgrmntExpDt.hashCode());
		result = prime * result + ((svcName == null) ? 0 : svcName.hashCode());
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
		final SubscriptionServicesVO other = (SubscriptionServicesVO) obj;
		if (acctNbr == null) {
			if (other.acctNbr != null)
				return false;
		} else if (!acctNbr.equals(other.acctNbr))
			return false;
		if (capText == null) {
			if (other.capText != null)
				return false;
		} else if (!capText.equals(other.capText))
			return false;
		if (foundInSIRS != other.foundInSIRS)
			return false;
		if (subAsgmEffDt == null) {
			if (other.subAsgmEffDt != null)
				return false;
		} else if (!subAsgmEffDt.equals(other.subAsgmEffDt))
			return false;
		if (subId == null) {
			if (other.subId != null)
				return false;
		} else if (!subId.equals(other.subId))
			return false;
		if (svcAgrmntEffDt == null) {
			if (other.svcAgrmntEffDt != null)
				return false;
		} else if (!svcAgrmntEffDt.equals(other.svcAgrmntEffDt))
			return false;
		if (svcAgrmntExpDt == null) {
			if (other.svcAgrmntExpDt != null)
				return false;
		} else if (!svcAgrmntExpDt.equals(other.svcAgrmntExpDt))
			return false;
		if (svcName == null) {
			if (other.svcName != null)
				return false;
		} else if (!svcName.equals(other.svcName))
			return false;
		return true;
	}

	
}