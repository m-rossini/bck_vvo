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
 * Created on 12/07/2008
 */
package br.com.auster.vivo.billcheckout.util;

import java.util.Comparator;

import org.apache.log4j.Logger;

import br.com.auster.common.datastruct.IntRangeList.IntRangeNode;
import br.com.auster.om.invoice.VoiceUsageDetail;


/**
 * @author framos
 * @version $Id$
 *
 */
public class VoiceIntRangeListComparator implements Comparator<IntRangeNode> {



	private static final Logger log = Logger.getLogger(VoiceIntRangeListComparator.class);



	public int compare(IntRangeNode _previous, IntRangeNode _current) {
		try {
			// ordering first by start
			int comparison = _previous.getFrom() - _current.getFrom();
			if (comparison != 0) {return comparison;}
			// then by end
			comparison = _previous.getTo() - _current.getTo();
			if (comparison != 0) {return comparison;}
			// then by voice info
			VoiceUsageDetail previousCall = (VoiceUsageDetail) _previous.getValue();
			VoiceUsageDetail currentCall = (VoiceUsageDetail) _current.getValue();
			// first will be service id
			comparison = previousCall.getSvcId().compareTo(currentCall.getSvcId());
			if (comparison != 0) {return comparison;}
			// then split part
			comparison = previousCall.getSplitPart()-currentCall.getSplitPart();
			if (comparison != 0) {return comparison;}
			// then origin sid
			comparison = previousCall.getOriginSID().compareTo(currentCall.getOriginSID());
			if (comparison != 0) {return comparison;}
			// then caption
			comparison = previousCall.getCaption().compareTo(currentCall.getCaption());
			if (comparison != 0) {return comparison;}
			// then called number
			comparison = previousCall.getCalledNumber().compareTo(currentCall.getCalledNumber());
			if (comparison != 0) {return comparison;}

		} catch (Exception e) {
			log.info("Exception while running node comparator", e);
		}
		return 0;
	}

}
