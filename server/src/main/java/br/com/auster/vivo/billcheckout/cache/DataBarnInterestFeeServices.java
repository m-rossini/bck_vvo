package br.com.auster.vivo.billcheckout.cache;

import java.util.List;

/**
 * An interface for DataBarn service methods
 * 
 * @author etirelli
 */
public interface DataBarnInterestFeeServices {

  /***
   * Retunrs a List of InterestFeePenalty objects representing each
   * occurrency of late payment fees from data barn, for a given account
   * Concrete implementations MUST return an empty list instead of Null for the cases
   * where there are not late payment fee, interest penalties.
   * 
   * @param acctNumber
   * @return
   */
	public List getInterestRecordsFor (String queryName, Object[] parametersString);
	
}
