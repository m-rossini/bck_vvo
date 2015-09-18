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


public class ServiceListCodeVO {

	private String listCd;
	private String listDesc;
	public String getListCd() {
		return listCd;
	}
	public void setListCd(String listCd) {
		this.listCd = listCd;
	}
	public String getListDesc() {
		return listDesc;
	}
	public void setListDesc(String listDesc) {
		this.listDesc = listDesc;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((listCd == null) ? 0 : listCd.hashCode());
		result = prime * result + ((listDesc == null) ? 0 : listDesc.hashCode());
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
		final ServiceListCodeVO other = (ServiceListCodeVO) obj;
		if (listCd == null) {
			if (other.listCd != null)
				return false;
		} else if (!listCd.equals(other.listCd))
			return false;
		if (listDesc == null) {
			if (other.listDesc != null)
				return false;
		} else if (!listDesc.equals(other.listDesc))
			return false;
		return true;
	}
	
	
}