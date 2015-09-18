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
 * Created on 28/02/2007
 */
package br.com.auster.vivo.billcheckout.cache.vo;

/**
 * @author mtengelm
 *
 */
// TODO Comment this class br.com.auster.vivo.billcheckout.cache.vo "." PromotionTypesVO.java
public class PromotionTypesVO {

		private String typeCode;
		private String typeDescription;
		/**
     * @return the typeCode
     */
    public String getTypeCode() {
    	return this.typeCode;
    }
		/**
     * @param typeCode the typeCode to set
     */
    public void setTypeCode(String typeCode) {
    	this.typeCode = typeCode;
    }
		/**
     * @return the typeDescription
     */
    public String getTypeDescription() {
    	return this.typeDescription;
    }
		/**
     * @param typeDescription the typeDescription to set
     */
    public void setTypeDescription(String typeDescription) {
    	this.typeDescription = typeDescription;
    }
    
    public String toString() {
    	return "Code:" + this.getTypeCode() + ".Desc:" + this.getTypeDescription();
    }
		/* (non-Javadoc)
     * @see java.lang.Object#hashCode()
     */
    @Override
    public int hashCode() {
	    final int PRIME = 31;
	    int result = 1;
	    result = PRIME * result + ((this.typeCode == null) ? 0 : this.typeCode.hashCode());
	    result = PRIME * result + ((this.typeDescription == null) ? 0 : this.typeDescription.hashCode());
	    return result;
    }
		/* (non-Javadoc)
     * @see java.lang.Object#equals(java.lang.Object)
     */
    @Override
    public boolean equals(Object obj) {
	    if (this == obj)
		    return true;
	    if (obj == null)
		    return false;
	    if (getClass() != obj.getClass())
		    return false;
	    final PromotionTypesVO other = (PromotionTypesVO) obj;
	    if (this.typeCode == null) {
		    if (other.typeCode != null)
			    return false;
	    } else if (!this.typeCode.equals(other.typeCode))
		    return false;
	    if (this.typeDescription == null) {
		    if (other.typeDescription != null)
			    return false;
	    } else if (!this.typeDescription.equals(other.typeDescription))
		    return false;
	    return true;
    }
		
		
}
