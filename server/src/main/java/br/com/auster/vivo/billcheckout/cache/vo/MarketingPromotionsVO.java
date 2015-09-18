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
import java.util.List;

/**
 * @author mtengelm
 *
 */
public class MarketingPromotionsVO {
		// Q1 and Q2
		private String marketingProgramId;	
		private String subId;
		private String capText;
		private String csaId;
		private Date enrollDate;
		
		// Q3 
		private int beginCycleNbr;
		private int endCycleNbr;
		private double rewardAmt;
		private String autoIndicator;
		private String applInd;
		private String promoLvlInd;
		private String rewardType;
		
		// Q1 and Q2
		private boolean subPromFlag;
		
		//Q4 and Q5
		private boolean rewardsLoaded;
		private List<RewardVO> rewardsList;

		public MarketingPromotionsVO() {}

		public String getMarketingProgramId() {
			return marketingProgramId;
		}

		public void setMarketingProgramId(String marketingProgramId) {
			this.marketingProgramId = marketingProgramId;
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

		public String getCsaId() {
			return csaId;
		}

		public void setCsaId(String csaId) {
			this.csaId = csaId;
		}

		public Date getEnrollDate() {
			return enrollDate;
		}

		public void setEnrollDate(Date enrollDate) {
			this.enrollDate = enrollDate;
		}

		public int getBeginCycleNbr() {
			return beginCycleNbr;
		}

		public void setBeginCycleNbr(int beginCycleNbr) {
			this.beginCycleNbr = beginCycleNbr;
		}

		public int getEndCycleNbr() {
			return endCycleNbr;
		}

		public void setEndCycleNbr(int endCycleNbr) {
			this.endCycleNbr = endCycleNbr;
		}

		public double getRewardAmt() {
			return rewardAmt;
		}

		public void setRewardAmt(double rewardAmt) {
			this.rewardAmt = rewardAmt;
		}

		public String getAutoIndicator() {
			return autoIndicator;
		}

		public void setAutoIndicator(String autoIndicator) {
			this.autoIndicator = autoIndicator;
		}

		public String getApplInd() {
			return applInd;
		}

		public void setApplInd(String applInd) {
			this.applInd = applInd;
		}

		public String getPromoLvlInd() {
			return promoLvlInd;
		}

		public void setPromoLvlInd(String promoLvlInd) {
			this.promoLvlInd = promoLvlInd;
		}

		public String getRewardType() {
			return rewardType;
		}

		public void setRewardType(String rewardType) {
			this.rewardType = rewardType;
		}

		public boolean isSubPromFlag() {
			return subPromFlag;
		}

		public void setSubPromFlag(boolean subPromFlag) {
			this.subPromFlag = subPromFlag;
		}

		public boolean isRewardsLoaded() {
			return rewardsLoaded;
		}

		public void setRewardsLoaded(boolean rewardsLoaded) {
			this.rewardsLoaded = rewardsLoaded;
		}

		public List<RewardVO> getRewardsList() {
			return rewardsList;
		}

		public void setRewardsList(List<RewardVO> rewardsList) {
			this.rewardsList = rewardsList;
		}

}
