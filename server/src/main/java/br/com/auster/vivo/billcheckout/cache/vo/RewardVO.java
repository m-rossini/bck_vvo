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
 * Created on 02/02/2007
 */
package br.com.auster.vivo.billcheckout.cache.vo;

import java.util.Date;

/**
 * @author gportuga
 *
 */
public class RewardVO {
	private String acctNbr;
	private String cycleCd;
	private Date cycleEndDate;
	private double rewardAmount;
	
	public RewardVO() {}

	public String getAcctNbr() {
		return acctNbr;
	}

	public void setAcctNbr(String acctNbr) {
		this.acctNbr = acctNbr;
	}

	public String getCycleCd() {
		return cycleCd;
	}

	public void setCycleCd(String cycleCd) {
		this.cycleCd = cycleCd;
	}

	public Date getCycleEndDate() {
		return cycleEndDate;
	}

	public void setCycleEndDate(Date cycleEndDate) {
		this.cycleEndDate = cycleEndDate;
	}

	public double getRewardAmount() {
		return rewardAmount;
	}

	public void setRewardAmount(double rewardAmount) {
		this.rewardAmount = rewardAmount;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((acctNbr == null) ? 0 : acctNbr.hashCode());
		result = prime * result + ((cycleCd == null) ? 0 : cycleCd.hashCode());
		result = prime * result
				+ ((cycleEndDate == null) ? 0 : cycleEndDate.hashCode());
		long temp;
		temp = Double.doubleToLongBits(rewardAmount);
		result = prime * result + (int) (temp ^ (temp >>> 32));
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
		final RewardVO other = (RewardVO) obj;
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
		if (cycleEndDate == null) {
			if (other.cycleEndDate != null)
				return false;
		} else if (!cycleEndDate.equals(other.cycleEndDate))
			return false;
		if (Double.doubleToLongBits(rewardAmount) != Double
				.doubleToLongBits(other.rewardAmount))
			return false;
		return true;
	}

}
