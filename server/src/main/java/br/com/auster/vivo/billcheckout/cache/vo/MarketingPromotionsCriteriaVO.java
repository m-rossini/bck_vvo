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

import java.util.Set;

/**
 * @author mtengelm
 *
 */
public class MarketingPromotionsCriteriaVO {

		private String marketingProgramId;	
		private String csaId;
		private Set<String> orSet;
		private Set<String> andSet;
		
		public String getMarketingProgramId() {
			return marketingProgramId;
		}
		public void setMarketingProgramId(String marketingProgramId) {
			this.marketingProgramId = marketingProgramId;
		}
		public Set<String> getOrSet() {
			return orSet;
		}
		public void setOrSet(Set<String> orSet) {
			this.orSet = orSet;
		}
		public Set<String> getAndSet() {
			return andSet;
		}
		public void setAndSet(Set<String> andSet) {
			this.andSet = andSet;
		}
		public String getCsaId() {
			return csaId;
		}
		public void setCsaId(String csaId) {
			this.csaId = csaId;
		}
		
}
