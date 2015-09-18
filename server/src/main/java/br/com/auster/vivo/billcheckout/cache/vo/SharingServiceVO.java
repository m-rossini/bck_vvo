package br.com.auster.vivo.billcheckout.cache.vo;
/**
 * author anardo 04/04/2008
 * 
 * classe utilizada na R74 para dados da query e consequência
 * Result set da tabela R74_sharing_service 
 */

public class SharingServiceVO {
	
	private String sbscrpId;
	private String svcName;
	private String captnText;
	private String freeUsageAcross;
	private String accesNbrRqrFlag;
	private String leaderSbscrpId;
	private String usageAcumSeqNbr;
	private String commSvcAreaId;	
	private String nameError;
	private String svcNameQuery2; //nome do plano retornado da Query2 para validacao NAO TIT-DEP
	
	public SharingServiceVO() {}

	public String getSbscrpId() {
		return sbscrpId;
	}
	
	public void setSbscrpId(String sbscrpId) {
		this.sbscrpId = sbscrpId;
	}
	
	public String getSvcName() {
		return svcName;
	}
	
	public void setSvcName(String svcName) {
		this.svcName = svcName;
	}
	
	public String getNameError() {
		return nameError;
	}
	
	public void setNameError(String nameError) {
		this.nameError = nameError;
	}

	public String getCaptnText() {
		return captnText;
	}

	public void setCaptnText(String captnText) {
		this.captnText = captnText;
	}

	public String getFreeUsageAcross() {
		return freeUsageAcross;
	}

	public void setFreeUsageAcross(String freeUsageAcross) {
		this.freeUsageAcross = freeUsageAcross;
	}

	public String getAccesNbrRqrFlag() {
		return accesNbrRqrFlag;
	}

	public void setAccesNbrRqrFlag(String accesNbrRqrFlag) {
		this.accesNbrRqrFlag = accesNbrRqrFlag;
	}

	public String getLeaderSbscrpId() {
		return leaderSbscrpId;
	}

	public void setLeaderSbscrpId(String leaderSbscrpId) {
		this.leaderSbscrpId = leaderSbscrpId;
	}

	public String getUsageAcumSeqNbr() {
		return usageAcumSeqNbr;
	}

	public void setUsageAcumSeqNbr(String usageAcumSeqNbr) {
		this.usageAcumSeqNbr = usageAcumSeqNbr;
	}

	public String getCommSvcAreaId() {
		return commSvcAreaId;
	}

	public void setCommSvcAreaId(String commSvcAreaId) {
		this.commSvcAreaId = commSvcAreaId;
	}

	public String getSvcNameQuery2() {
		return svcNameQuery2;
	}

	public void setSvcNameQuery2(String svcNameQuery2) {
		this.svcNameQuery2 = svcNameQuery2;
	}	
}
