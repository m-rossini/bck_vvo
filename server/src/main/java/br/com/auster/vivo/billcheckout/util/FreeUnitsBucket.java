/*
 * Copyright (c) 2004-2005 Auster Solutions. All Rights Reserved.
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
 * Created on Oct 5, 2005
 */
package br.com.auster.vivo.billcheckout.util;

import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import br.com.auster.om.invoice.UsageDetail;

/**
 * <p><b>Title:</b> FreeUnitsBucket</p>
 * <p><b>Description:</b> A helper class to implement free units verification rules</p>
 * <p><b>Copyright:</b> Copyright (c) 2004-2005</p>
 * <p><b>Company:</b> Auster Solutions</p>
 *
 * @author etirelli
 * @version $Id: FreeUnitsBucket.java 2131 2008-02-29 18:52:09Z gportuga $
 */
public final class FreeUnitsBucket {
	private String freeUnitsId;
	private boolean shared;
	private String serviceName;
	private double includedUnits;
	private int pkgQnt;
	private double usedUnits;
	private double unitCounter;
	private Date   lastUsageIncluded;
	private Map    accessNumbersMap;
	
	public FreeUnitsBucket() {
		this(null, false, null, 0, 0);
	}
	
	public FreeUnitsBucket(String id, boolean shared, String svcName, double total, double used) {
		this.freeUnitsId=id;
		this.shared=shared;
		this.serviceName=svcName;
		this.includedUnits=total;
		this.usedUnits=used;
		this.unitCounter=0;
		this.pkgQnt=1;
		this.lastUsageIncluded=new Date(0);
		this.accessNumbersMap = new HashMap();
	}
	
	/**
	 * @return Returns the freeUnitsId.
	 */
	public final String getFreeUnitsId() {
		return freeUnitsId;
	}
	
	/**
	 * @param freeUnitsId The freeUnitsId to set.
	 */
	public final void setFreeUnitsId(String freeUnitsId) {
		this.freeUnitsId = freeUnitsId;
	}
	
	/**
	 * @return Returns the serviceName.
	 */
	public String getServiceName() {
		return serviceName;
	}

	/**
	 * @param serviceName The serviceName to set.
	 */
	public void setServiceName(String svcName) {
		this.serviceName = svcName;
	}

	/**
	 * @return Returns the lastUsageIncluded.
	 */
	public final Date getLastUsageIncluded() {
		return lastUsageIncluded;
	}
	
	/**
	 * @param lastUsageIncluded The lastUsageIncluded to set.
	 */
	public final void setLastUsageIncluded(Date lastUsageIncluded) {
		this.lastUsageIncluded = lastUsageIncluded;
	}
	
	/**
	 * @return Returns the unitCounter.
	 */
	public final double getUnitCounter() {
		return unitCounter;
	}
	
	/**
	 * @param unitCounter The unitCounter to set.
	 */
	public final void setUnitCounter(double counter) {
		this.unitCounter = counter;
	}
	
	/**
	 * @return Returns the includedUnits.
	 */
	public final double getIncludedUnits() {
		return includedUnits;
	}
	
	/**
	 * @param includedUnits The includedUnits to set.
	 */
	public final void setIncludedUnits(double includedUnits) {
		this.includedUnits = includedUnits;
	}
	
	/**
	 * Add <code>units</code> to <code>includedUnits</code> attribute
	 * @param units
	 */
	public final void addUnitCounter(double units) {
		this.setUnitCounter(this.getUnitCounter()+units);
	}
	
	/**
	 * Adds the usage detail duration to the used units and also sets last usage included
	 * date in case this usage date is after the previous last usage included date.
	 *  
	 * @param detail
	 */
	public final void addUnitCounter(UsageDetail detail) {
		this.addUnitCounter(detail.getUsageDuration().getUnits());
		if((detail.getDatetime() != null) &&
		   ((this.getLastUsageIncluded() == null) ||
		   (detail.getDatetime().after(this.getLastUsageIncluded())))) {
			this.setLastUsageIncluded(detail.getDatetime());
		}
		
		AccessNumberDetail det = (AccessNumberDetail) this.accessNumbersMap.get(detail.getChannelId());
		if(det != null) {
			det.setSubUnitCounter(det.getSubUnitCounter()+detail.getUsageDuration().getUnits());
		}
	}
	
	/**
	 * @inheritDoc
	 */
	public boolean equals(Object o) {
		FreeUnitsBucket bucket = (FreeUnitsBucket) o;
		return (this.getFreeUnitsId() != null) &&
		       this.getFreeUnitsId().equals(bucket.getFreeUnitsId());
	}

	/**
	 * @inheritDoc
	 */
	public int hashCode() {
		return (this.getFreeUnitsId() != null) ? 
				this.getFreeUnitsId().hashCode() : 
				super.hashCode();
	}
	
	public void addAccessNumberDetail(String accessNbr, double usedUnits) {
		AccessNumberDetail detail = new AccessNumberDetail(accessNbr, usedUnits);
		this.accessNumbersMap.put(accessNbr, detail);
	}
	
	public String getRelatedAccessNumber() {
		String numbers = new String();
		Iterator it = this.accessNumbersMap.keySet().iterator();
	    while ( it.hasNext() ){
	    	if (!numbers.equals("")) { numbers += ";"; }
	    	numbers = numbers + (String) it.next();
        }
	    return numbers;
	}
	
	public boolean contains(String accessNumber) {
		return this.accessNumbersMap.containsKey(accessNumber);
	}

	/**
	 * @return Returns the usedUnits.
	 */
	public double getUsedUnits() {
		return usedUnits;
	}

	/**
	 * @param usedUnits The usedUnits to set.
	 */
	public void setUsedUnits(double usedUnits) {
		this.usedUnits = usedUnits;
	}
	
	public boolean isShared() {
		return this.shared;
	}
	
	public void setShared(boolean shared) {
		this.shared = shared;
	}
	
	public String toXML(String ident) {
		StringBuffer buf = new StringBuffer();
		buf.append(ident);
		buf.append("<");
		buf.append(this.getClass().getName());
		buf.append(" freeUnitsId=\"");
		buf.append(this.getFreeUnitsId());
		buf.append("\" serviceName=\"");
		buf.append(this.getServiceName());
		buf.append("\" relatedAccessNumber=\"");
		buf.append(this.getRelatedAccessNumber());
		buf.append("\" includedUnits=\"");
		buf.append(this.getIncludedUnits());
		buf.append("\" usedUnits=\"");
		buf.append(this.getUsedUnits());
		buf.append("\" unitCounter=\"");
		buf.append(this.getUnitCounter());
		buf.append("\" lastUsageIncluded=\"");
		buf.append(this.getLastUsageIncluded());
		if(this.accessNumbersMap.size() > 0) {
			buf.append("\">\n");
			for(Iterator i=this.accessNumbersMap.values().iterator(); i.hasNext(); ) {
				AccessNumberDetail detail = (AccessNumberDetail) i.next();
				buf.append(detail.toXML(ident+"    "));
			}
			buf.append(ident);
			buf.append("</");
			buf.append(this.getClass().getName());
			buf.append(">");
		} else {
			buf.append("\"/>\n");
		}
		
		return buf.toString();
	}
	
	public String toString() {
		return this.toXML("");
	}
	
	private static class AccessNumberDetail {
		private String accessNumber;
		private double subUsedUnits;
		private double subUnitCounter;
		
		public AccessNumberDetail(String accessNbr, double usedUnits) {
			this.accessNumber = accessNbr;
			this.subUsedUnits = usedUnits;
			this.subUnitCounter = 0;
		}

		/**
		 * @return Returns the accessNumber.
		 */
		public String getAccessNumber() {
			return accessNumber;
		}

		/**
		 * @param accessNumber The accessNumber to set.
		 */
		public void setAccessNumber(String accessNumber) {
			this.accessNumber = accessNumber;
		}

		/**
		 * @return Returns the subUnitCounter.
		 */
		public double getSubUnitCounter() {
			return subUnitCounter;
		}

		/**
		 * @param subUnitCounter The subUnitCounter to set.
		 */
		public void setSubUnitCounter(double subUnitCounter) {
			this.subUnitCounter = subUnitCounter;
		}

		/**
		 * @return Returns the subUsedUnits.
		 */
		public double getSubUsedUnits() {
			return subUsedUnits;
		}

		/**
		 * @param subUsedUnits The subUsedUnits to set.
		 */
		public void setSubUsedUnits(double subUsedUnits) {
			this.subUsedUnits = subUsedUnits;
		}
		
		public String toXML(String ident) {
			StringBuffer buf = new StringBuffer();
			buf.append(ident);
			buf.append("<");
			buf.append(this.getClass().getName());
			buf.append("\" accessNumber=\"");
			buf.append(this.getAccessNumber());
			buf.append("\" usedUnits=\"");
			buf.append(this.getSubUsedUnits());
			buf.append("\" unitCounter=\"");
			buf.append(this.getSubUnitCounter());
    		buf.append("\"/>\n");
			return buf.toString();
		}
	}

	public int getPkgQnt() {
		return pkgQnt;
	}

	public void setPkgQnt(int pkgQnt) {
		this.pkgQnt = pkgQnt;
	}

}
