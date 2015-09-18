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
 * Created on Oct 10, 2005
 */
package br.com.auster.vivo.billcheckout.util;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;


import br.com.auster.common.datastruct.RangeEntry;
import br.com.auster.common.datastruct.RangeMap;
import br.com.auster.common.log.LogFactory;
import br.com.auster.om.invoice.ServiceDetail;
import br.com.auster.om.pricing.ServicePrice;

/**
 * @author framos
 * @version $Id: SubscriptionTimeline.java 2346 2008-05-12 16:14:37Z gportuga $
 */
public class SubscriptionTimeline {

	
	public static final long MAX_UNCHARGED_MILLISECS = 1000;
	
	protected static final Logger log = LogFactory.getLogger(SubscriptionTimeline.class);
	
	private Map accessNumbers;
	private Date start;
	private Date end;
	
	public SubscriptionTimeline() {
		//DOES NOTHING
	}
	
	public SubscriptionTimeline(Date _start, Date _end) {
		start = _start;
		end = _end;
		accessNumbers = new HashMap();
		log.debug("timeline limits : " + start + "(" + start.getTime() + ")  =>  " + end + "(" + end.getTime() + ")");
	}
	
	
	public Date getCycleStartDate() {
		return start;
	}

	public Date getCycleEndDate() {
		return end;
	}

	public void addAccessNumber(String _accessNumber) {
		accessNumbers.put(_accessNumber, new RangeMap());
	}
	
	public void addSubscription(String _accessNumber, long _from, long _to, Object _value) {
		RangeMap map = (RangeMap) accessNumbers.get(_accessNumber);
		if (map == null) {
			map = new RangeMap();			
			accessNumbers.put(_accessNumber, map);
		}
		log.debug("adding subscription period [" + _from + " : " + _to + "] to access number : " + _accessNumber);		
		map.add(_from, _to+1, _value);
	}
	
	public Map hasOverlappingChargesAndCredits(boolean _ignoreZeroCharges) {
		Map overlaps = new HashMap();
		// for each subscription number
		
		Map subscriptionMap = new HashMap();
		Map creditsMap = new HashMap();
		
		for (Iterator accessNumberIt=accessNumbers.entrySet().iterator(); accessNumberIt.hasNext();) {
			// get access number range map
			Map.Entry accNumberEntry = (Map.Entry) accessNumberIt.next();
			// create set for overlapped service details
			Set overlapServices = new HashSet();
			// get set of overlapping ranges
			Set overlapsForAccessNumber = ((RangeMap)accNumberEntry.getValue()).getOverlappingRanges();
			// for each overlapped range of the current access number
			for (Iterator overlapsIt=overlapsForAccessNumber.iterator();overlapsIt.hasNext();) {				
				RangeEntry rangeEntry = (RangeEntry) overlapsIt.next();
				List details = rangeEntry.getValues();
				// clear control maps
				subscriptionMap.clear();
				creditsMap.clear();
				// for each service detail in the overlapped range
				for (Iterator it=details.iterator(); it.hasNext();) {
					ServiceDetail svcDetail =  (ServiceDetail) it.next();
					if (_ignoreZeroCharges && (svcDetail.getTotalAmount() == 0)) {
						continue;
					}
					ServicePrice price = svcDetail.getServicePrice();
					if (price != null && "F".equals(price.getChargeType())) {
						// ignore charge_type like "franquias"
						continue;
					}
					if (svcDetail.getTotalAmount() >= 0) {
						if (subscriptionMap.containsKey(svcDetail.getCaption())) {
							// overlapping subscription charge for the same caption
							overlapServices.add(svcDetail);
							overlapServices.add(subscriptionMap.get(svcDetail.getCaption()));
						} else {
							subscriptionMap.put(svcDetail.getCaption(), svcDetail);
						}
					} else {
						if (creditsMap.containsKey(svcDetail.getCaption())) {
							// overlapping credit for the same caption
							overlapServices.add(svcDetail);
							overlapServices.add(creditsMap.get(svcDetail.getCaption()));
						} else {
							creditsMap.put(svcDetail.getCaption(), svcDetail);
						}
					}
				}
			}
			// if found any overlapping service details, then report them
			if (overlapServices.size() > 0) {
				overlaps.put(accNumberEntry.getKey(), overlapServices);
			}
		}
		// return map of accessNumber x ServiceDetail[]
		return overlaps;
	}
	
	public Map hasUnchargedPeriods(boolean _ignoreZeroCharges) {		
		Map unchargedPeriods = new HashMap();
		// for each subscription number
		for (Iterator accessNumberIt=accessNumbers.entrySet().iterator(); accessNumberIt.hasNext();) {
			Map.Entry accNumberEntry = (Map.Entry) accessNumberIt.next();
			// get range map for current access number
			RangeMap map = (RangeMap) accNumberEntry.getValue();
			// starting time and map of uncharged periods : startTime -> endTime
			long lastTime = 0L;
			Map unchargedForSubscription = new HashMap();
			// for each range in the current range map
			for (Iterator rangeIt=map.iterator(); rangeIt.hasNext();) {
				RangeEntry rangeEntry = (RangeEntry) rangeIt.next();
				List details = rangeEntry.getValues();
				// checking if range has at least one charge detail 
				for (Iterator it=details.iterator(); it.hasNext();) {
					ServiceDetail svcDetail =  (ServiceDetail) it.next();
					if ((svcDetail.getTotalAmount() < 0) || (_ignoreZeroCharges && (svcDetail.getTotalAmount() == 0))) {
						continue;
					}
					// found one charge detail
					if ((lastTime > 0L) && (Math.abs(rangeEntry.getFrom() - lastTime) > MAX_UNCHARGED_MILLISECS)) {
						// +1 on startDate and -1 on endDate, since the variables are
						//	pointing the last instant of each subscription charge.
						unchargedForSubscription.put(String.valueOf(lastTime+1L), String.valueOf(rangeEntry.getFrom()-1)); 
					}
					lastTime = rangeEntry.getTo();
					// We need only one charge to know if there is a uncharged window in the current subscription.   
					break;
				}
			}
			if (unchargedForSubscription.size() > 0) {
				unchargedPeriods.put(accNumberEntry.getKey(), unchargedForSubscription);
			}
		}
		return unchargedPeriods;
	}
	
	public RangeMap getChargesOfAccessNumber(String accessNumber) {
		return (RangeMap) accessNumbers.get(accessNumber);
	}
	
	public List hasNoChargeAtAll() {
		List noChargesAtAll = new ArrayList();
		// for each subscription number
		for (Iterator accessNumberIt=accessNumbers.entrySet().iterator(); accessNumberIt.hasNext();) {
			Map.Entry accNumberEntry = (Map.Entry) accessNumberIt.next();
			log.debug("checking access number = " + accNumberEntry.getKey());
			// get range map for current access number
			RangeMap map = (RangeMap) accNumberEntry.getValue();
			if ((map == null) || (map.getSize() <= 0)) {
				log.debug("access number " + accNumberEntry.getKey() + " has no charges/credits at all");
				noChargesAtAll.add(accNumberEntry.getKey());
			}
		}
		return noChargesAtAll;
	}
}
