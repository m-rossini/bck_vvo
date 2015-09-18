/*
 * Copyright (c) 2004 TTI Tecnologia. All Rights Reserved.
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
 * Created on Sep 03, 2004
 */
package br.com.auster.vivo.billcheckout.sax;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;

/**
 * @author Marcos Tengelmann
 * 
 * This clas just produces an output in a different format and layout than the
 * one produced by SirsCAllDetailHandler class.
 * 
 * To do this, we just override thje buildOutputRecord(String[] fields) method,
 * and return a string with a different format.
 * 
 * To access the data in the array. we use the content indexes specified on base
 * class.
 */
public class SirsCallDetailHandlerBC extends SirsCallDetailHandler {
	private Logger log = Logger.getLogger(SirsCallDetailHandlerBC.class);
	/**
	 * @param config
	 *          Is exactly the same of the super class.
	 */
	public SirsCallDetailHandlerBC(Element config) {
		super(config);
	}

	protected final String buildOutputRecord(String[] fields) {
		final String sep = ";";
		final String qut = "\"";

		final double eventDuration = Double.parseDouble(fields[SirsCallDetailHandler.I_CALL_DURATION]
		    .trim());
		final double eventValue = Double
		    .parseDouble(fields[SirsCallDetailHandler.I_CALL_VALUE].trim());

		String destination = fields[SirsCallDetailHandler.I_DESTINATION_CITY].trim();
		String destinationState = fields[SirsCallDetailHandler.I_DESTINATION_STATE].trim();
		if (destinationState != null && destinationState.length() > 0) {
			destination += "/" + destinationState;
		}

		String origin = fields[SirsCallDetailHandler.I_ORIGIN_CITY].trim();
		String originState = fields[SirsCallDetailHandler.I_ORIGIN_STATE].trim();
		if (originState != null && originState.length() > 0) {
			origin += "/" + originState;
		}

		StringBuffer retVal = new StringBuffer();

		retVal.append(fields[SirsCallDetailHandler.I_ACCOUNT_NUMBER].trim());
		retVal.append(sep);
		retVal.append(fields[SirsCallDetailHandler.I_ACCESS_NUMBER].trim());
		retVal.append(sep);
		retVal.append(qut);
		retVal.append(fields[SirsCallDetailHandler.I_CALLED_NUMBER].trim());
		retVal.append(qut);
		retVal.append(sep);
		retVal.append(qut);
		retVal.append(destination);
		retVal.append(qut);
		retVal.append(sep);
		retVal.append(qut);
		retVal.append(fields[SirsCallDetailHandler.I_SUBSECTION_NAME].trim());
		retVal.append(qut);
		retVal.append(sep);
		retVal.append(( null == fields[SirsCallDetailHandler.I_CALL_DATE])? "0" : fields[SirsCallDetailHandler.I_CALL_DATE].trim());
		retVal.append(sep);
		retVal.append(( null == fields[SirsCallDetailHandler.I_CALL_TIME])? "0" : fields[SirsCallDetailHandler.I_CALL_TIME].trim());		
		retVal.append(sep);
		retVal.append(formatter.format(eventDuration));
		retVal.append(sep);
		retVal.append(formatter.format(eventValue));
		retVal.append(sep);
		retVal.append("0");
		retVal.append(sep);
		retVal.append(fields[SirsCallDetailHandler.I_CARRIER_CODE].trim());
		retVal.append(sep);
		retVal.append(qut);
		retVal.append(fields[SirsCallDetailHandler.I_CALL_TYPE].trim());
		retVal.append(qut);
		retVal.append(sep);
		retVal.append(fields[SirsCallDetailHandler.I_REGISTRATION_AREA].trim());
		retVal.append(sep);
		// retVal.append(fields[SirsCallDetailHandler.I_ORIGINATING_SID].trim());
		retVal.append(qut);
		retVal.append(origin);
		retVal.append(qut);
		retVal.append(sep);
		retVal.append(qut);
		retVal.append(fields[SirsCallDetailHandler.I_CALL_TARIFF].trim());
		retVal.append(qut);
		retVal.append(sep);
		retVal.append(qut);
		retVal.append(fields[SirsCallDetailHandler.I_PLAN_NAME].trim());
		retVal.append(qut);
		retVal.append(sep);
		retVal.append(fields[SirsCallDetailHandler.I_DURATION_RATE].trim());
		retVal.append(sep);
		retVal.append(fields[SirsCallDetailHandler.I_FREE_INDICATOR].trim());
		
		return retVal.toString();
	}

}
