/*
 * Copyright (c) 2004-2008 Auster Solutions. All Rights Reserved.
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
 * Created on 18/02/2008
 */
package br.com.auster.vivo.billcheckout.cache.vo;

/**
 * TODO What this class is responsible for
 *
 * @author William Soares
 * @version $Id$
 * @since JDK1.4
 */
public class DataBarnServicesByAccountVO {

	private String serviceName;	
	private String subscriptionId;
	private String cycleCode;
	private String accountNumber;
	private String svcAgrmntEffDt;
	private String svcAgrmntTrmntnDt;
	public String getServiceName() {
		return serviceName;
	}
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	public String getSubscriptionId() {
		return subscriptionId;
	}
	public void setSubscriptionId(String subscriptionId) {
		this.subscriptionId = subscriptionId;
	}
	public String getCycleCode() {
		return cycleCode;
	}
	public void setCycleCode(String cycleCode) {
		this.cycleCode = cycleCode;
	}
	public String getAccountNumber() {
		return accountNumber;
	}
	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}
	public String getSvcAgrmntEffDt() {
		return svcAgrmntEffDt;
	}
	public void setSvcAgrmntEffDt(String svcAgrmntEffDt) {
		this.svcAgrmntEffDt = svcAgrmntEffDt;
	}
	public String getSvcAgrmntTrmntnDt() {
		return svcAgrmntTrmntnDt;
	}
	public void setSvcAgrmntTrmntnDt(String svcAgrmntTrmntnDt) {
		this.svcAgrmntTrmntnDt = svcAgrmntTrmntnDt;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((accountNumber == null) ? 0 : accountNumber.hashCode());
		result = prime * result + ((cycleCode == null) ? 0 : cycleCode.hashCode());
		result = prime * result + ((serviceName == null) ? 0 : serviceName.hashCode());
		result = prime * result + ((subscriptionId == null) ? 0 : subscriptionId.hashCode());
		result = prime * result + ((svcAgrmntEffDt == null) ? 0 : svcAgrmntEffDt.hashCode());
		result = prime * result + ((svcAgrmntTrmntnDt == null) ? 0 : svcAgrmntTrmntnDt.hashCode());
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
		final DataBarnServicesByAccountVO other = (DataBarnServicesByAccountVO) obj;
		if (accountNumber == null) {
			if (other.accountNumber != null)
				return false;
		} else if (!accountNumber.equals(other.accountNumber))
			return false;
		if (cycleCode == null) {
			if (other.cycleCode != null)
				return false;
		} else if (!cycleCode.equals(other.cycleCode))
			return false;
		if (serviceName == null) {
			if (other.serviceName != null)
				return false;
		} else if (!serviceName.equals(other.serviceName))
			return false;
		if (subscriptionId == null) {
			if (other.subscriptionId != null)
				return false;
		} else if (!subscriptionId.equals(other.subscriptionId))
			return false;
		if (svcAgrmntEffDt == null) {
			if (other.svcAgrmntEffDt != null)
				return false;
		} else if (!svcAgrmntEffDt.equals(other.svcAgrmntEffDt))
			return false;
		if (svcAgrmntTrmntnDt == null) {
			if (other.svcAgrmntTrmntnDt != null)
				return false;
		} else if (!svcAgrmntTrmntnDt.equals(other.svcAgrmntTrmntnDt))
			return false;
		return true;
	}
	
	
	
}
