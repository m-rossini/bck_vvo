/*
 * Copyright (c) 2007 Auster Solutions do Brasil. All Rights Reserved.
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
 * 
 */

/**
 * @author anardo
 * Created on 21/12/2007
 * 
 *  Classe que armazena dados da tabela BCK_CARRIER_DM, chamado pela
 *  classe Carrier.java 
 */

package br.com.auster.billcheckout.param;

public class CarrierVO {
	
	//public CarrierVO() {}
	
	private int objID;
	private String carrierName;
	private String carrierCode;
	private String carrierState;
	private String carrierSerie;
	private String carrierSubSerie;
	
	public String getCarrierName() {
		return carrierName;
	}
	public void setCarrierName(String carrierName) {
		this.carrierName = carrierName;
	}
	public String getCarrierCode() {
		return carrierCode;
	}
	public void setCarrierCode(String carrierCode) {
		this.carrierCode = carrierCode;
	}
	public String getCarrierState() {
		return carrierState;
	}
	public void setCarrierState(String carrierState) {
		this.carrierState = carrierState;
	}
	public String getCarrierSerie() {
		return carrierSerie;
	}
	public void setCarrierSerie(String carrierSerie) {
		this.carrierSerie = carrierSerie;
	}
	public String getCarrierSubSerie() {
		return carrierSubSerie;
	}
	public void setCarrierSubSerie(String carrierSubSerie) {
		this.carrierSubSerie = carrierSubSerie;
	}
	public int getObjID() {
		return objID;
	}
	public void setObjID(int objID) {
		this.objID = objID;
	}

}
