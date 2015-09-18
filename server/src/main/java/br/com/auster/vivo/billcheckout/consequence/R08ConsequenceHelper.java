package br.com.auster.vivo.billcheckout.consequence;

import java.util.Date;
import java.util.List;

import br.com.auster.vivo.billcheckout.caches.vo.AccountAndCycleChangeVO;

public class R08ConsequenceHelper {

	public static AccountAndCycleChangeVO getAccountAndCycleChange(List <AccountAndCycleChangeVO> list, String acctNbr, String cycleCd, Date endDt, Date startDt ){
		if ((list == null) || (list.size() == 0) || (acctNbr == null) || (cycleCd == null)) {
			return null;
		}
		AccountAndCycleChangeVO vo = null;
		
		for (AccountAndCycleChangeVO voChange : list) {
			if (acctNbr.equals(voChange.getAcctNbr()) && cycleCd.equals(voChange.getCycleCd())) {
				if (vo == null) {
					vo = voChange;			
				} else if (vo.getAcctCycleEffTm() != null && voChange.getAcctCycleEffTm() != null) {
					if (voChange.getAcctCycleEffTm().compareTo(vo.getAcctCycleEffTm()) > 0) {
						vo = voChange;
					}
				}
			}
		}

		return vo;
	}
}
