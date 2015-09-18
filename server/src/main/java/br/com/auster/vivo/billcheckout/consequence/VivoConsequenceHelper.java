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
 * Created on Sep 7, 2005
 */
package br.com.auster.vivo.billcheckout.consequence;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;

import br.com.auster.billcheckout.consequence.ConsequenceBuilder;
import br.com.auster.billcheckout.consequence.ConsequenceAttributeList.AttributeType;
import br.com.auster.billcheckout.consequence.telco.AccountDimension;
import br.com.auster.billcheckout.consequence.telco.CarrierDimension;
import br.com.auster.billcheckout.consequence.telco.CycleDimension;
import br.com.auster.billcheckout.consequence.telco.GeographicDimension;
import br.com.auster.billcheckout.consequence.telco.TelcoConsequence;
import br.com.auster.billcheckout.consequence.telco.TelcoConsequenceBuilder;
import br.com.auster.billcheckout.consequence.telco.TimeDimension;
import br.com.auster.common.datastruct.RangeEntry;
import br.com.auster.common.datastruct.RangeMap;
import br.com.auster.common.log.LogFactory;
import br.com.auster.om.invoice.Account;
import br.com.auster.om.invoice.UsageDetail;
import br.com.auster.om.util.UnitCounter;
import br.com.auster.vivo.billcheckout.util.DimensionCache;

/**
 * @author framos
 * @version $Id: VivoConsequenceHelper.java 1147 2007-02-07 23:01:08Z mtengelm $
 */
public class VivoConsequenceHelper {

	public static final long	 TIME_DISCARDABLE_RANGE	       = 10000;	                                  // in
	// millis
	public static final long	 TIME_MIN_CALL_DURATION	       = 30;	                                      // in
	// secs

	private Logger	           log	                         = LogFactory
	                                                             .getLogger(VivoConsequenceHelper.class);

	private Comparator	       usageDetailCronologicalSorter	= new Comparator() {

		                                                         public int compare(Object _usage1,
		                                                             Object _usage2) {
			                                                         UsageDetail usage1 = (UsageDetail) _usage1;
			                                                         UsageDetail usage2 = (UsageDetail) _usage2;
			                                                         return usage1
			                                                             .getDatetime()
			                                                             .compareTo(usage2.getDatetime());
		                                                         }

	                                                         };

	private TelcoConsequenceBuilder	builder;
	private DimensionCache dimensionCache;
	private Account account;

	public VivoConsequenceHelper(ConsequenceBuilder builder, DimensionCache dimensionCache, Account account) {
		this.builder = (TelcoConsequenceBuilder) builder;
		this.dimensionCache = dimensionCache;
		this.account = account;
	}

	public Map checkRangesForAllSubscriptions(Map _subscriptions) {
		Map resultingMap = new HashMap();
		for (Iterator it = _subscriptions.entrySet().iterator(); it.hasNext();) {
			Map.Entry entry = (Map.Entry) it.next();
			log.debug("checking overlapping ranges for subscription " + entry.getKey());
			List consequences = checkRangesBySubscription((RangeMap) entry.getValue());
			if (consequences != null) {
				resultingMap.put(entry.getKey(), consequences);
			}
		}
		log.debug("final map of consequences is : " + resultingMap);
		return resultingMap;
	}

	public List checkRangesBySubscription(RangeMap _ranges) {
		return checkRangesBySubscription(_ranges.getOverlappingRanges());
	}

	public List checkRangesBySubscription(Set _overlappingRanges) {

		List callList = null;
		Set overlappingCalls = new HashSet();
		Set duplicatedCalls = new HashSet();
		Set selectedCalls = new HashSet();
		Set singleRangeCalls = new HashSet();
		Map calledNumbers = new HashMap();
		Map overlapByCalledNumber = new HashMap();

		for (Iterator i1 = _overlappingRanges.iterator(); i1.hasNext();) {

			RangeEntry entry = (RangeEntry) i1.next();
			if ((entry.getTo() - entry.getFrom()) < TIME_DISCARDABLE_RANGE) {
				// skipping all ranges with less than 10secs
				log.debug("skipping range lower than " + TIME_DISCARDABLE_RANGE + "ms. := "
				    + (entry.getTo() - entry.getFrom()) + ".Entry:" + entry);
				continue;
			}

			// clear range set of selected calls
			singleRangeCalls.clear();
			// clear list of called number for this range
			calledNumbers.clear();

			// sorting by start time
			callList = entry.getValues();
			Collections.sort(callList, usageDetailCronologicalSorter);
			log.debug("sorted list of usage events : " + callList);

			// for all usage events in the current range
			for (Iterator i2 = callList.iterator(); i2.hasNext();) {
				UsageDetail usage = (UsageDetail) i2.next();
				log.debug("analysing usage event : " + usage);
				// building map of called numbers, to check if there were 2 diff. calls
				// to the same number
				UsageDetail savedUsage = (UsageDetail) calledNumbers.get(usage.getCalledNumber());
				if (savedUsage == null) {
					// this is the first usage to this number
					log.debug("this is the first usage found for the called number : "
					    + usage.getCalledNumber());
					calledNumbers.put(usage.getCalledNumber(), usage);
				} else {
					// this is AT LEAST the second call to this number
					singleRangeCalls.add(usage);
					singleRangeCalls.add(savedUsage);
					// usage marked to report...skiping to next
					log.debug("reporting and skipping since we got another call to this number : "
					    + usage.getCalledNumber());
					continue;
				}
				// checking min. call duration
				if ((usage.getUsageDuration() != null)
				    && UnitCounter.TIME_COUNTER.equals(usage.getUsageDuration().getType())
				    && (usage.getUsageDuration().getSeconds() <= TIME_MIN_CALL_DURATION)) {
					// skipping since its duration is <= 30s
					log.debug("discarding call with less then " + TIME_MIN_CALL_DURATION + "secs");
					continue;
				}
				singleRangeCalls.add(usage);
			}

			// cannot report this situations with less than 1 usage detail
			// or, if the number of different called numbers is less then 2
			if (singleRangeCalls.size() < 2) {
				log.debug("there were not enough calls to report in this range.");
				continue;
			}
			selectedCalls.addAll(singleRangeCalls);
		}
		// finished checking all overlapping ranges

		List sortedSelectedCalls = new ArrayList(selectedCalls);
		Collections.sort(sortedSelectedCalls, this.usageDetailCronologicalSorter);

		// splitting the selected events into duplicated or overlapping calls
		UsageDetail previousCall = null;
		for (Iterator it = sortedSelectedCalls.iterator(); it.hasNext();) {
			UsageDetail currentUsage = (UsageDetail) it.next();
			if (previousCall != null) {
				if (checkDuplicateCalls(previousCall, currentUsage)) {
					duplicatedCalls.add(currentUsage);
					duplicatedCalls.add(previousCall);
				} else {
					//TODO Analize if we can verify if one is DSL and other is (VC or AD). If so they are not overlapped
					// if calling and called numebers are the same
					overlappingCalls.add(currentUsage);
					overlappingCalls.add(previousCall);
				}
			}
			previousCall = currentUsage;
		}

		ArrayList consequences = new ArrayList();
		// creating consequence for overlapping calls
		List cList = createConsequenceWithCalls(overlappingCalls, "R07-1","Uso Sobreposto",
		    "Eventos sobrepostos para assinante");
		if ((cList != null) && (cList.size() > 0)) {
			consequences.addAll(cList);
		}
		// creating consequence for duplicated calls
		cList = createConsequenceWithCalls(duplicatedCalls, "R06-1","Uso Duplicado",
				"Eventos duplicados para assinante");
		if ((cList != null) && (cList.size() > 0)) {
			consequences.addAll(cList);
		}
		cList = createConsequencesWithCalls(overlapByCalledNumber, "R07-2","Uso Sobreposto",
		    "Eventos sobrepostos para mesmo número chamado");
		if ((cList != null) && (cList.size() > 0)) {
			consequences.addAll(cList);
		}
		return consequences;
	}

	private List createConsequenceWithCalls(Collection _listOfCalls, String _ruleCode, String _ruleName, String _desc) {

		if (_listOfCalls.size() < 2) {
			return null;
		}

		log.debug("starting consequence creation");

		List conseqList = new ArrayList();
		UsageDetail usage = null;
		for (Iterator it = _listOfCalls.iterator(); it.hasNext();) {
			usage = (UsageDetail) it.next();
			this.builder.setRule(_ruleCode, _ruleName);
			builder.setAccount((AccountDimension) dimensionCache.getFromCache("account"));			
			builder.setGeographics((GeographicDimension) dimensionCache.getFromCache("geo"));		
			builder.setTime((TimeDimension) dimensionCache.getFromCache("time"));		
			builder.setCycle((CycleDimension) dimensionCache.getFromCache("cycle"));			
			builder.setCarrier((CarrierDimension) dimensionCache.getFromCache(usage.getCarrierCode()));		
			TelcoConsequence consequence = (TelcoConsequence) this.builder.getConsequence();
			consequence.setDescription(_desc);		
			
			consequence.addAttribute("Número de Acesso", usage.getChannelId());
			consequence.addAttribute("Número Chamado", usage.getCalledNumber());
			consequence.addAttribute("Duração", usage.getUsageDuration().toString());
			consequence.addDateTimeAttribute("Data da Chamada", usage.getDatetime());
			consequence.addAttribute("Classe da Chamada",  usage.getCallClass());
			conseqList.add(consequence);
		}
		log.debug("created consequence to report overlapping calls to subscription : "
		    + usage.getChannelId());
		
		return conseqList;
	}

	private List createConsequencesWithCalls(Map _mapOfNumbers, String _ruleCode, String _ruleName, String _desc) {

		if (_mapOfNumbers == null) {
			return null;
		}
		// running at the list of overlap calls, grouped by called number
		List consequences = new LinkedList();
		log.debug("starting consequence creation");
		for (Iterator it = _mapOfNumbers.entrySet().iterator(); it.hasNext();) {
			Map.Entry entry = (Map.Entry) it.next();
			// checking if the related object is a list, and has size greater then 1
			if ((entry.getValue() != null) && (entry.getValue() instanceof Collection)
			    && (((Collection) entry.getValue()).size() > 1)) {				
				for (Iterator it2 = ((Collection) entry.getValue()).iterator(); it2.hasNext();) {
					
					UsageDetail usage = (UsageDetail) it.next();
					
					// building the consequence object
					this.builder.setRule(_ruleCode, _ruleName);
					builder.setAccount((AccountDimension) dimensionCache.getFromCache("account"));	
					builder.setGeographics((GeographicDimension) dimensionCache.getFromCache("geo"));		
					builder.setTime((TimeDimension) dimensionCache.getFromCache("time"));		
					builder.setCycle((CycleDimension) dimensionCache.getFromCache("cycle"));					
					builder.setCarrier((CarrierDimension) dimensionCache.getFromCache(usage.getCarrierCode()));
					TelcoConsequence consequence = (TelcoConsequence) this.builder.getConsequence();
					consequence.setDescription(_desc);					
					
					consequence.addAttribute("Número de Acesso", usage.getChannelId());
					consequence.addAttribute("Número Chamado", usage.getCalledNumber());
					consequence.addAttribute("Duração", usage.getUsageDuration().toString());
					consequence.addAttribute("Data da Chamada", usage.getDatetime(), AttributeType.DATETIME);
					consequence.addAttribute("Classe da Chamada",  usage.getCallClass());
					consequences.add(consequence);					
				}				
				// adding the consequence to the returning list				
			} else {
				log.debug("skipping called number " + entry.getKey()
				    + " since no usage was associated with it.");
			}
		}
		return consequences;
	}

	private boolean checkDuplicateCalls(UsageDetail _call1, UsageDetail _call2) {
		boolean equalTariffClass=false;
		if (_call1.getTariffClass() == null) {
			if (_call2.getTariffClass() == null) {
				equalTariffClass=true;
			}
		} else {
			if (_call2.getTariffClass() == null) {
				equalTariffClass=false;
			} else {
				if (_call1.getTariffClass().equals(_call2.getTariffClass())) {
					equalTariffClass=true;
				}				
			}
		}
		return // subscriber phone number
		_call1.getChannelId().equals(_call2.getChannelId()) &&
		// called number
		    _call1.getCalledNumber().equals(_call2.getCalledNumber()) &&
		    // start date/time of the call
		    _call1.getDatetime().equals(_call2.getDatetime()) &&
		    // caption
		    _call1.getCaption().equals(_call2.getCaption()) &&
		    // duration type
		    _call1.getUsageDuration().getType().equals(_call2.getUsageDuration().getType()) &&
		    // duration unit
		    (_call1.getUsageDuration().getUnits() == _call2.getUsageDuration().getUnits()) && 
		    // TariffClass
		     (equalTariffClass) &&
		     //TotalAmount
		     (_call1.getTotalAmount() ==_call2.getTotalAmount());
	}
	
}
