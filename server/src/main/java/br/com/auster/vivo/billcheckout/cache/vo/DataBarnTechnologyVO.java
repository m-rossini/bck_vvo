/*
 * Copyright (c) 2008 Auster Solutions. All Rights Reserved.
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
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. * 
 */

package br.com.auster.vivo.billcheckout.cache.vo;

import br.com.auster.billcheckout.utils.KeyHolder;

/**
 * @author anardo
 * Created on 29/01/2008
 */

public class DataBarnTechnologyVO implements KeyHolder<String> {
	
	private String  chnlTypeInd;   // Q1 e Q2
	private String  sbscrp_id;	   // Q1
	private String  captnText; 	   // Q2
	private boolean subFlag;	   // se true, é VO da subscrição. False, é VO do serviço.

	public DataBarnTechnologyVO() {
	}

	public boolean isSubFlag() {
		return subFlag;
	}

	public void setSubFlag(boolean subFlag) {
		this.subFlag = subFlag;
	}
	
	public String getChnlTypeInd() {
		return chnlTypeInd;
	}

	public void setChnlTypeInd(String chnlTypeInd) {
		this.chnlTypeInd = chnlTypeInd;
	}

	public String getCaptnText() {
		return captnText;
	}

	public void setCaptnText(String captnText) {
		this.captnText = captnText;
	}

	public String getSbscrp_id() {
		return sbscrp_id;
	}

	public void setSbscrp_id(String sbscrp_id) {
		this.sbscrp_id = sbscrp_id;
	}

	public String getKey() {
		return getCaptnText();
	}
}
