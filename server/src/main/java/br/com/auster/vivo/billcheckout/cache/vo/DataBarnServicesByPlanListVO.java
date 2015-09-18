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

import java.util.ArrayList;
import java.util.List;

import br.com.auster.billcheckout.caches.CacheableKey;
import br.com.auster.billcheckout.caches.CacheableVO;
import br.com.auster.om.reference.CustomizableEntity;

/**
 * TODO What this class is responsible for
 *
 * @author William Soares
 * @version $Id$
 * @since JDK1.4
 */
public class DataBarnServicesByPlanListVO extends CustomizableEntity implements CacheableVO {
	
	/** 
	 * Used to store the values of  <code>serialVersionUID</code>.
	 */
	private static final long serialVersionUID = 1L;
	
	private String svcId;
	private String endDate;
	private String startDate;
	
	private List<DataBarnServiceByPlanVO> dataBarnServicesByPlanVOList =  new ArrayList<DataBarnServiceByPlanVO>();
	
	// generated keys
	private CacheableKey  logicKey;
	
	
	public DataBarnServicesByPlanListVO() {

	}

	public DataBarnServicesByPlanListVO(String planName, List<DataBarnServiceByPlanVO> dataBarnServicesByPlanVOList) {
		setSvcId(planName);
		setDataBarnServicesByPlanVOList(dataBarnServicesByPlanVOList);
	}		

	public String getSvcId() {
		return svcId;
	}

	public void setSvcId(String svcId) {
		this.svcId = svcId;
	}

	public List<DataBarnServiceByPlanVO> getDataBarnServicesByPlanVOList() {
		return dataBarnServicesByPlanVOList;
	}

	public void setDataBarnServicesByPlanVOList(
			List<DataBarnServiceByPlanVO> dataBarnServicesByPlanVOList) {
		this.dataBarnServicesByPlanVOList = dataBarnServicesByPlanVOList;
	}
	
	/**
	 * Inner class to handle the alternate key for ServicesByAccount instances
	 */
	public static final class InnerKey implements CacheableKey {
		
		private String svcId;
		private String endDate;
		private String startDate;
		
		
		public InnerKey( String svcId, String endDate, String startDate) {
			this.svcId = svcId;
			this.endDate = endDate;
			this.startDate = startDate;
		}
		
		public boolean equals(Object _other) {
			if ( _other instanceof InnerKey ) {
				InnerKey other = (InnerKey) _other;
				return (this.svcId.equals(other.svcId) &&
						this.endDate.equals(other.endDate) &&
						this.startDate.equals(other.startDate));
			}
			else 
				return false;
		}

		public int hashCode() {
			final int PRIME = 31;
			int result = 1;
			result = PRIME * result;
			result = PRIME * result + ((this.svcId == null) ? 0 : this.svcId.hashCode());
			result = PRIME * result + ((this.endDate == null) ? 0 : this.endDate.hashCode());
			result = PRIME * result + ((this.startDate == null) ? 0 : this.startDate.hashCode());
			
			return result;			
		}

		public String getSvcId() { return svcId; }	
		public String getEndDate() { return endDate; }	
		public String getStartDate() { return startDate; }	
		
	}	
	
	// ---------------------------
	// Helper methods
	// ---------------------------

	public static final CacheableKey createKey(String planName, String endDate, String startDate) {
		return new InnerKey(planName, endDate, startDate);
	}	
	
	public CacheableKey getAlternateKey() {
		// TODO Auto-generated method stub
		return null;
	}

	public CacheableKey getKey() {
		if (this.logicKey == null) {
			this.logicKey = createKey( this.getSvcId(), this.getEndDate(), this.getStartDate()  );
		}
		return this.logicKey;
	}
	
	public void add(DataBarnServiceByPlanVO obj) {
		dataBarnServicesByPlanVOList.add(obj);
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}		
	
}
