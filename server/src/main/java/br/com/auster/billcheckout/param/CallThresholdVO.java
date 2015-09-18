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
import br.com.auster.om.util.UnitCounter;

/**
 * @author mtengelm
 * @version $Id: CallThresholds.java 645 2006-10-13 21:12:15Z mtengelm $
 */
public class CallThresholdVO extends PKEnabledEntity implements CachedVO {
	private String	callClass;
	private String	callSubClass; 
	private String	callTariff;
//	private long		minDuration;
//	private long		maxDuration;
	private double	minValue;
	private double	maxValue;
	private UnitCounter maxDuration;
	private String currentKey;
	private String currentAlternateKey;

	/**
	 * 
	 */
	public CallThresholdVO() {
		this(0);
	}

	public CallThresholdVO(String callClass, String callSubClass, String callTariff,
			UnitCounter minDuration, UnitCounter maxDuration, double minValue, double maxValue) {
		
		super();
		this.callClass = callClass;
		this.callSubClass = callSubClass;
		this.callTariff = callTariff;
		this.maxDuration = maxDuration;
		this.minValue = minValue;
		this.maxValue = maxValue;		
	}
	
	public String getCallClass() {
		return callClass;
	}

	public void setCallClass(String callClass) {
		this.callClass = callClass;
	}

	public String getCallSubClass() {
		return callSubClass;
	}

	public void setCallSubClass(String callSubClass) {
		this.callSubClass = callSubClass;
	}

	public String getCallTariff() {
		return callTariff;
	}

	public void setCallTariff(String callTariff) {
		this.callTariff = callTariff;
	}

	/*** 
	 * Always in minor unit of the type/
	 * If type is TIME, then it is in Seconds
	 * If type is DATA, then it is in Bytes 
	 * @return
	 */
	public UnitCounter getMaxDuration() {
		return maxDuration;
	}

	public void setMaxDuration(UnitCounter maxDuration) {
		this.maxDuration = maxDuration;
	}

	public double getMaxValue() {
		return maxValue;
	}

	public void setMaxValue(double maxValue) {
		this.maxValue = maxValue;
	}

	public double getMinValue() {
		return minValue;
	}

	public void setMinValue(double minValue) {
		this.minValue = minValue;
	}

	/**
	 * @param uid
	 */
	public CallThresholdVO(long _uid) {
		setUid(_uid);
	}

	public boolean equals(Object obj) {
		CallThresholdVO inObj;
		if (obj instanceof CallThresholdVO) {
			inObj = (CallThresholdVO) obj;
			if (   (inObj.getCallClass().equals(this.getCallClass()))
					&& (inObj.getCallSubClass().equals(this.getCallSubClass()))
					&& (inObj.getCallTariff().equals(this.getCallTariff()) ) 
					)
					{
				return true;
			}
		}
		return false;
	}

	public int hashCode() {
		int result = super.hashCode();
		result = result * 37 + (this.getCallClass() == null ? 0 : this.getCallClass().hashCode());
		result = result * 37 + (this.getCallSubClass() == null ? 0 : this.getCallSubClass().hashCode());
		result = result * 37 + (this.getCallTariff() == null ? 0 : this.getCallTariff().hashCode());		
		return result;
	}

	public String toString() {
		return "Class=" + this.getCallClass() + ".CallSubClass=" + this.getCallSubClass()
				+ ".CallTariff=" + this.getCallTariff();
	}

	public String getKey() {
		if (currentKey == null) {
			currentKey = createKey(this.getCallClass(), this.getCallSubClass() , this.getCallTariff());
		}
		return currentKey;
	}
	
	public String getAlternateKey() {
		return getKey();
	}
	
	public static String createKey(String callClass, String callSubclass, String tariff) {
		return (callClass == null ? "" : callClass) + "." +
		(callSubclass == null ? "" : callSubclass) + "." +
		(tariff == null ? "" : tariff)
		;
	}
	
	public static String createAlternateKey(String country, String state, String taxTypeCode, String fiscalCode) {
		return country + "." + state + "." + taxTypeCode + "." + fiscalCode;		
	}	
}
