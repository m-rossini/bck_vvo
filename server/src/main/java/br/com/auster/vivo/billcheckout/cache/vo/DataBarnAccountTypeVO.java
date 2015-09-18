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
 * @author Gustavo Portugal
 * @version $Id$
 * @since JDK1.4
 */
public class DataBarnAccountTypeVO extends CustomizableEntity implements CacheableVO {
	
	/** 
	 * Used to store the values of  <code>serialVersionUID</code>.
	 */
	private static final long serialVersionUID = 1L;
	
	private String acctNbr;
	private String acctTypeCd;
	
	// generated keys
	private CacheableKey  logicKey;
	
	
	public DataBarnAccountTypeVO() {

	}

	public DataBarnAccountTypeVO(String acctNbr, String acctTypeCd) {
		setAcctNbr(acctNbr);
		setAcctTypeCd(acctTypeCd);
	}		
	
	/**
	 * Inner class to handle the alternate key for ServicesByAccount instances
	 */
	public static final class InnerKey implements CacheableKey {
		
		private String acctNbr;
		
		public InnerKey( String acctNbr) {
			this.acctNbr = acctNbr;
		}
		
		public boolean equals(Object _other) {
			if ( _other instanceof InnerKey ) {
				InnerKey other = (InnerKey) _other;
				return this.acctNbr.equals(other.acctNbr);
			}
			else 
				return false;
		}

		public int hashCode() {
			final int PRIME = 31;
			int result = 1;
			result = PRIME * result;
			result = PRIME * result + ((this.acctNbr == null) ? 0 : this.acctNbr.hashCode());
			
			return result;			
		}

		public String getAcctNbr() { return acctNbr; }	
		
	}	
	
	// ---------------------------
	// Helper methods
	// ---------------------------

	public static final CacheableKey createKey(String acctNbr) {
		return new InnerKey(acctNbr);
	}	
	
	public CacheableKey getAlternateKey() {
		// TODO Auto-generated method stub
		return null;
	}

	public CacheableKey getKey() {
		if (this.logicKey == null) {
			this.logicKey = createKey( this.getAcctNbr());
		}
		return this.logicKey;
	}
	
	public String getAcctNbr() {
		return acctNbr;
	}

	public void setAcctNbr(String acctNbr) {
		this.acctNbr = acctNbr;
	}

	public String getAcctTypeCd() {
		return acctTypeCd;
	}

	public void setAcctTypeCd(String acctTypeCd) {
		this.acctTypeCd = acctTypeCd;
	}
	
	
}
