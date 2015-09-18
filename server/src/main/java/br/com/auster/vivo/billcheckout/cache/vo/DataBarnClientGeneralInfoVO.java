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
package br.com.auster.vivo.billcheckout.cache.vo;

public class DataBarnClientGeneralInfoVO {

	private String addressStreetNum;
	private String neighborhood;
	private String postalCityState;
	private String addressComplement;
	private String identityType;
	private String identityNumber;
	private String customerName;
	
	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int PRIME = 31;
		int result = 1;
		result = PRIME * result;
		result = PRIME * result + ((this.customerName == null) ? 0 : this.customerName.hashCode());		
		result = PRIME * result + ((this.addressStreetNum == null) ? 0 : this.addressStreetNum.hashCode());
		result = PRIME * result + ((this.neighborhood == null) ? 0 : this.neighborhood.hashCode());
		result = PRIME * result + ((this.postalCityState == null) ? 0 : this.postalCityState.hashCode());
		result = PRIME * result + ((this.addressComplement == null) ? 0 : this.addressComplement.hashCode());
		result = PRIME * result + ((this.identityType == null) ? 0 : this.identityType.hashCode());
		result = PRIME * result + ((this.identityNumber == null) ? 0 : this.identityNumber.hashCode());
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
		final DataBarnClientGeneralInfoVO other = (DataBarnClientGeneralInfoVO) obj;
		if (this.customerName == null) {
			if (other.customerName != null) { return false; }
		} 
		else if (!this.customerName.equals(other.customerName)) {
			return false;
		}		
		if (this.addressStreetNum == null) {
			if (other.addressStreetNum != null) { return false; }
		} 
		else if (!this.addressStreetNum.equals(other.addressStreetNum)) {
			return false;
		}
		if (this.neighborhood == null) {
			if (other.neighborhood != null) { return false; }
		} 
		else if (!this.neighborhood.equals(other.neighborhood)) {
			return false;
		}
		if (this.postalCityState == null) {
			if (other.postalCityState != null) { return false; }
		} 
		else if (!this.postalCityState.equals(other.postalCityState)) {
			return false;
		}	
		if (this.addressComplement == null) {
			if (other.addressComplement != null) { return false; }
		} 
		else if (!this.addressComplement.equals(other.addressComplement)) {
			return false;
		}
		if (this.identityType == null) {
			if (other.identityType != null) { return false; }
		} 
		else if (!this.identityType.equals(other.identityType)) {
			return false;
		}
		if (this.identityNumber == null) {
			if (other.identityNumber != null) { return false; }
		} 
		else if (!this.identityNumber.equals(other.identityNumber)) {
			return false;
		}		
		return true;
	}
	
	/* (non-Javadoc)
     * @see java.lang.Object#toString()
     */
	@Override
	public String toString() {
		return ".CustomerName:" + customerName + ".AddressStreetNum:" + addressStreetNum + ".Neighborhood:" + neighborhood + ".PostalCityState:" + postalCityState +
				".AddressComplement:" + addressComplement + ".IdentityType:" + identityType + ".IdentityNumber:" + identityNumber;
	}

	public String getNeighborhood() {
		return neighborhood;
	}

	public void setNeighborhood(String neighborhood) {
		this.neighborhood = neighborhood;
	}

	public String getAddressComplement() {
		return addressComplement;
	}

	public void setAddressComplement(String addressComplement) {
		this.addressComplement = addressComplement;
	}

	public String getIdentityType() {
		return identityType;
	}

	public void setIdentityType(String identityType) {
		this.identityType = identityType;
	}

	public String getIdentityNumber() {
		return identityNumber;
	}

	public void setIdentityNumber(String identityNumber) {
		this.identityNumber = identityNumber;
	}

	public String getAddressStreetNum() {
		return addressStreetNum;
	}

	public void setAddressStreetNum(String addressStreetNum) {
		this.addressStreetNum = addressStreetNum;
	}

	public String getPostalCityState() {
		return postalCityState;
	}

	public void setPostalCityState(String postalCityState) {
		this.postalCityState = postalCityState;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

}