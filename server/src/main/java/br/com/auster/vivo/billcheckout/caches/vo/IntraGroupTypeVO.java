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


public class IntraGroupTypeVO {
	private String attrGroupName;
	private String svcName;
	
	public String getAttrGroupName() {
		return attrGroupName;
	}
	public void setAttrGroupName(String attrGroupName) {
		this.attrGroupName = attrGroupName;
	}
	public String getSvcName() {
		return svcName;
	}
	public void setSvcName(String svcName) {
		this.svcName = svcName;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((attrGroupName == null) ? 0 : attrGroupName.hashCode());
		result = prime * result + ((svcName == null) ? 0 : svcName.hashCode());
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
		final IntraGroupTypeVO other = (IntraGroupTypeVO) obj;
		if (attrGroupName == null) {
			if (other.attrGroupName != null)
				return false;
		} else if (!attrGroupName.equals(other.attrGroupName))
			return false;
		if (svcName == null) {
			if (other.svcName != null)
				return false;
		} else if (!svcName.equals(other.svcName))
			return false;
		return true;
	}
	
	
}