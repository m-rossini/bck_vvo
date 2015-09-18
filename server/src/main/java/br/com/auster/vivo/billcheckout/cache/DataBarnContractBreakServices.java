package br.com.auster.vivo.billcheckout.cache;

import java.util.List;

/**
 * An interface for DataBarn service methods
 * 
 * @author etirelli
 */
public interface DataBarnContractBreakServices {

    /**
     * Returns a list of ContractBreakPenalty objects representing
     * each penalty for contract break for the given account, 
     * cycle code and cycle end date.
     * 
     * @param acctNumber
     * @param cycleCode
     * @param cycleEnd
     * @return
     */
    public List getPenaltyRecordsFor( String queryName, Object[] parameters );   
    
}
