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


public class IntraGroupAccountVO {
	private String attrNbr;
	private String cnpj;
	
	public String getAttrNbr() {
		return attrNbr;
	}
	public void setAttrNbr(String attrNbr) {
		this.attrNbr = attrNbr;
	}
	public String getCnpj() {
		return cnpj;
	}
	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((attrNbr == null) ? 0 : attrNbr.hashCode());
		result = prime * result + ((cnpj == null) ? 0 : cnpj.hashCode());
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
		final IntraGroupAccountVO other = (IntraGroupAccountVO) obj;
		if (attrNbr == null) {
			if (other.attrNbr != null)
				return false;
		} else if (!attrNbr.equals(other.attrNbr))
			return false;
		if (cnpj == null) {
			if (other.cnpj != null)
				return false;
		} else if (!cnpj.equals(other.cnpj))
			return false;
		return true;
	}
	
	public boolean isFullCnpjEquals(IntraGroupAccountVO obj) {
		if ((this.cnpj != null ) && (this.cnpj.equals(obj.getCnpj()))) { 
			return true; 
		}
		return false;
	}
	
	public boolean isRootCnpjEquals(IntraGroupAccountVO obj) {
		if ((this.cnpj != null ) && (this.cnpj.length() == 14) 
				&& (obj.getCnpj() != null) && (obj.getCnpj().length() == 14)) {
			if (this.cnpj.substring(0, 8).equals(obj.getCnpj().substring(0,8))) {
				return true;
			}
		}
		return false;
	}

	
}