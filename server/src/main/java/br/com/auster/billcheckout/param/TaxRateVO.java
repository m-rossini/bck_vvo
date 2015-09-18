/*
 * Copyright (c) 2004-2005 Auster Solutions do Brasil. All Rights Reserved.
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
 * Created on 29/08/2006
 */
//TODO Comment this Class
package br.com.auster.billcheckout.param;

import br.com.auster.om.reference.PKEnabledEntity;

/**
 * @author mtengelm
 * @version $Id: TaxRateVO.java 584 2006-10-03 23:13:10Z mtengelm $
 */
public class TaxRateVO extends PKEnabledEntity implements CachedVO {
	private long geoUID;
	private long taxTypeUID;
	private long fiscalCodeUID;
	private String geoCountry;
	private String geoRegion;
	private String geoState;
	private String fiscalCode;
	private String taxCode;
	private double taxRate;
	
	private String currentKey;
	private String currentAlternateKey;	

	/**
	 * Default constructor
	 */
	public TaxRateVO() {
		this(0);
	}

	/**
	 * @param uid
	 */
	public TaxRateVO(long _uid) {
		setUid(_uid);
	}

	/**
   * @return the fiscalCode
   */
  public String getFiscalCode() {
  	return this.fiscalCode;
  }

	/**
   * @param fiscalCode the fiscalCode to set
   */
  public void setFiscalCode(String fiscalCode) {
  	this.fiscalCode = fiscalCode;
  }

	/**
   * @return the fiscalCodeUID
   */
  public long getFiscalCodeUID() {
  	return this.fiscalCodeUID;
  }

	/**
   * @param fiscalCodeUID the fiscalCodeUID to set
   */
  public void setFiscalCodeUID(long fiscalCodeUID) {
  	this.fiscalCodeUID = fiscalCodeUID;
  }

	/**
   * @return the geoCountry
   */
  public String getGeoCountry() {
  	return this.geoCountry;
  }

	/**
   * @param geoCountry the geoCountry to set
   */
  public void setGeoCountry(String geoCountry) {
  	this.geoCountry = geoCountry;
  }

	/**
   * @return the geoRegion
   */
  public String getGeoRegion() {
  	return this.geoRegion;
  }

	/**
   * @param geoRegion the geoRegion to set
   */
  public void setGeoRegion(String geoRegion) {
  	this.geoRegion = geoRegion;
  }

	/**
   * @return the geoState
   */
  public String getGeoState() {
  	return this.geoState;
  }

	/**
   * @param geoState the geoState to set
   */
  public void setGeoState(String geoState) {
  	this.geoState = geoState;
  }

	/**
   * @return the geoUID
   */
  public long getGeoUID() {
  	return this.geoUID;
  }

	/**
   * @param geoUID the geoUID to set
   */
  public void setGeoUID(long geoUID) {
  	this.geoUID = geoUID;
  }

	/**
   * @return the taxCode
   */
  public String getTaxCode() {
  	return this.taxCode;
  }

	/**
   * @param taxCode the taxCode to set
   */
  public void setTaxCode(String taxCode) {
  	this.taxCode = taxCode;
  }

	/**
   * @return the taxRate
   */
  public double getTaxRate() {
  	return this.taxRate;
  }

	/**
   * @param taxRate the taxRate to set
   */
  public void setTaxRate(double taxRate) {
  	this.taxRate = taxRate;
  }
  
	/**
   * @return the taxTypeUID
   */
  public long getTaxTypeUID() {
  	return this.taxTypeUID;
  }

	/**
   * @param taxTypeUID the taxTypeUID to set
   */
  public void setTaxTypeUID(long taxTypeUID) {
  	this.taxTypeUID = taxTypeUID;
  }
	public boolean equals(Object obj) {
		TaxRateVO inObj;
		if (obj instanceof TaxRateVO) {
			inObj = (TaxRateVO) obj;
			if ((inObj.getGeoUID() == this.getGeoUID())	
					&& (inObj.getTaxTypeUID() ==  this.getTaxTypeUID())
					&& (inObj.getFiscalCodeUID() ==  this.getFiscalCodeUID()) ) {
				return true;
			}
		}
		return false;
	}

	public int hashCode() {
		int result = super.hashCode();
		result = result * 37 + (int) this.getGeoUID();
		result = result * 37 + (int) this.getTaxTypeUID();		
//		(this.getCycleCode() == null ? 0 : this.getCycleCode().hashCode());
		result = result * 37 + (int) (this.getFiscalCodeUID() == -1 ? 0 : this.getFiscalCodeUID());

		return result;
	}
	
	public String getKey() {
		if (currentKey == null) {
			currentKey = createKey(this.getGeoUID(), this.getTaxTypeUID() , this.getFiscalCodeUID());
		}
		return currentKey;
	}
	
	public String getAlternateKey() {
		if (currentAlternateKey == null) {
			currentAlternateKey = createAlternateKey(this.getGeoCountry(), this.getGeoState() , this.getTaxCode(), this.getFiscalCode());
		}
		return currentAlternateKey;
	}
	
	public String toString() {
		return "Geo:" + this.getGeoUID() + ".TaxType:" + this.getTaxTypeUID()
		+ ".FiscalCode:" + this.getFiscalCodeUID() + ".Rate:" + this.getTaxRate();
	}
	
	public static String createKey(long geoUID, long taxTypeUID, long fiscalCodeUID) {
		return Long.toString(geoUID) + "." + Long.toString(taxTypeUID) + "." + Long.toString(fiscalCodeUID);
	}
	
	public static String createAlternateKey(String country, String state, String taxTypeCode, String fiscalCode) {
		return country + "." + state + "." + taxTypeCode + "." + fiscalCode;		
	}
}


