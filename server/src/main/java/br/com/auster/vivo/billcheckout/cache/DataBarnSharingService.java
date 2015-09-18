/* Created on 19/03/2008
*  @author anardo
*/

// Esta classe implementa a R74

package br.com.auster.vivo.billcheckout.cache;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;

import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;
import br.com.auster.vivo.billcheckout.cache.vo.SharingServiceVO;
import br.com.auster.vivo.billcheckout.caches.R74SharingPlanCache;

public class DataBarnSharingService {

	private String accountNbr;
	private String cycleCode;
	private String endCycle;
	private String startCycle;	
	private List listaConseq = new ArrayList(); 
	private List<SharingServiceVO> listaTIT = new ArrayList<SharingServiceVO>(); //titulares   da seção TITDEP
	private List<SharingServiceVO> listaDEP = new ArrayList<SharingServiceVO>(); //dependentes da seção TITDEP
	private List<SharingServiceVO> listaService = new ArrayList<SharingServiceVO>(); //lista de serviços compartilhados NOT TIT-DEP
	private List<SharingServiceVO> listaPlan = new ArrayList<SharingServiceVO>(); // //lista de planos   compartilhados NOT TIT-DEP
	private DataBarnQueryExecutor dtbnQueryExecutor;
	private R74SharingPlanCache sharingPlanCache;
	private static Logger log = Logger.getLogger(DataBarnSharingService.class);
	
	public DataBarnSharingService(String accountNbr, Object cycleCode, Object endCycle, Object startCycle, DataBarnQueryExecutor dtbnQueryExecutor, R74SharingPlanCache sharingPlanCache) {
		this.accountNbr = accountNbr;
		this.cycleCode = cycleCode.toString(); 
		this.endCycle = endCycle.toString();  
		this.startCycle = startCycle.toString();
		this.dtbnQueryExecutor = dtbnQueryExecutor;
		this.sharingPlanCache = sharingPlanCache;
	}
	/**
	 * executa todos os métodos da regra
	 * @throws SQLException 
	 */
	public void validateRule() throws SQLException {
		queryAllSharing();
		consultQuery2(listaService);
		validateTITDEP();		
	}	
	/**
	 * retorna a lista de criticas
	 */
	public List getConsequence(){
		if (listaConseq.size()!=0){
			return listaConseq;		
		}else{
			  return null;
		 	 }
	}	
	/**
	 * adiciona em uma lista as divergências encontradas dos registros do DTBN, para cada conta do Sirs 
	 */  
	public void createConsequence(String descError, String subscrp, String planName, String caption, String freeUsage,
								  String accessNbr, String leaderSubscr, String usageAcum, String commSvcArea){
		SharingServiceVO sharingVO = new SharingServiceVO();
		sharingVO.setNameError(descError);
		sharingVO.setSbscrpId(subscrp);
		sharingVO.setSvcName(planName);
		sharingVO.setCaptnText(caption);
		sharingVO.setFreeUsageAcross(freeUsage);
		sharingVO.setAccesNbrRqrFlag(accessNbr);
		sharingVO.setLeaderSbscrpId(leaderSubscr);
		sharingVO.setUsageAcumSeqNbr(usageAcum);
		sharingVO.setCommSvcAreaId(commSvcArea);
		listaConseq.add(sharingVO);
	}	
	/**
	 * método que valida serviços TITDEP
	 */
	private void validateTITDEP() {
		boolean existsTIT; //valida se existe pelo menos um TIT correspondente para cada DEP ativo
		for(SharingServiceVO depItera : listaDEP){
			existsTIT=false;
			for(SharingServiceVO titItera : listaTIT){
				if( depItera.getUsageAcumSeqNbr().equals(titItera.getUsageAcumSeqNbr()) 
				   && titItera.getLeaderSbscrpId().equals(depItera.getLeaderSbscrpId()) ){//leader igual senão não é titular
					existsTIT=true;											  //se na lista TIT, já foi comparado subscrp_id
				}
			}
			if(existsTIT==false){
				createConsequence("Nenhum TIT correspondente ao DEP ativo", depItera.getSbscrpId(), depItera.getSvcName(),
								  depItera.getCaptnText(), depItera.getFreeUsageAcross(), depItera.getAccesNbrRqrFlag(),
								  depItera.getLeaderSbscrpId(), depItera.getUsageAcumSeqNbr(), depItera.getCommSvcAreaId());
			}
		}		
	}
	/*
	 * método que consulta no DTBN e popula VO dividindo TIT-DEP e NAO TIT-DEP em listas distintas
	 * 
	 */
	private void queryAllSharing() {
		long st = System.nanoTime();
		StatsMapping stats = ProcessingStats.starting(getClass(), "R74_SharingServ");
		try {
			ResultSet rs = dtbnQueryExecutor.getResultSet("R74_SharingServ", new Object[] {accountNbr, cycleCode, endCycle,
					  startCycle, endCycle, endCycle, startCycle, endCycle});			
			
			while (rs.next()) {
				SharingServiceVO sharingVO = new SharingServiceVO();
				sharingVO.setSbscrpId(rs.getString("SBSCRP_ID"));
				sharingVO.setSvcName(rs.getString("SVC_NAME"));
				sharingVO.setCaptnText(rs.getString("CAPTN_TEXT"));
				sharingVO.setFreeUsageAcross(rs.getString("FREE_USAGE_ACROSS_ACCT_IND"));
				sharingVO.setAccesNbrRqrFlag(rs.getString("ACCESS_NBR_RQR_FLAG"));
				sharingVO.setLeaderSbscrpId(rs.getString("LEADER_SBSCRP_ID"));
				sharingVO.setUsageAcumSeqNbr(rs.getString("USAGE_ACUM_SEQ_NBR"));
				sharingVO.setCommSvcAreaId(rs.getString("COMM_SVC_AREA_ID"));
				//TIT-DEP para flag 'R'
				if(sharingVO.getFreeUsageAcross().equals("R")){
					if(sharingVO.getSbscrpId().equals(sharingVO.getLeaderSbscrpId())){					
						listaTIT.add(sharingVO); 
					}else{
						listaDEP.add(sharingVO); 
					}
				}
				//Servicos NOT TIT-DEP com flag Free_Usage igual a 'Y' e access_nbr_rqr_flag igual a 'N'
				if ( "N".equalsIgnoreCase(sharingVO.getAccesNbrRqrFlag()) && "Y".equalsIgnoreCase(sharingVO.getFreeUsageAcross()) ){
					//serviços que executarao Query2
					listaService.add(sharingVO);
				}				
				//Planos da conta para validar NOT TIT-DEP	Free_usage considerando poder ser apenas Y e N, pois R seria TIT-DEP
				if("Y".equalsIgnoreCase(sharingVO.getAccesNbrRqrFlag()) && !("R".equalsIgnoreCase(sharingVO.getFreeUsageAcross())) ){
					listaPlan.add(sharingVO);
				}
			}//while
		}//try 
		catch (IllegalArgumentException e) {
			log.error("Error running queryAllSharing", e);
			throw e;
		} catch (SQLException e) {
			log.error("Error running queryAllSharing", e);
			throw new RuntimeException("Error running queryAllSharing ",e);
		} finally {
			stats.finished();
			this.dtbnQueryExecutor.closeResultSet();
			long et = System.nanoTime();
			log.debug("Acessing Databarn Time in milliseconds:"
					+ (((double) et - st) / 1000 / 1000)
					+ " for getting sharing services");
		}
	}
	/**
     * Aqui ele já consulta e valida os serviços que precisam ter pelo menos um plano da lista
     * retornada da Query2. Caso não retorne plano(s) da Query 2 para o serviço, não existe validação.	
	 *  
	 * @throws SQLException 
	 */
	private void consultQuery2(List<SharingServiceVO> listServ) throws SQLException{
		for (SharingServiceVO sharingService : listServ){
			String cacheKey = sharingService.getUsageAcumSeqNbr() + "_" +sharingService.getCommSvcAreaId() + "_" +
				endCycle + "_" + startCycle;
			Set<String> requiredSharingPlans = sharingPlanCache.get(cacheKey);
			if (!requiredSharingPlans.isEmpty()) {
				if (isRequiredSharingPlanMissing(requiredSharingPlans, listaPlan)) {
					createConsequence("Nenhum Plano compartilhado para o servico", sharingService.getSbscrpId(), sharingService.getSvcName(),
							sharingService.getCaptnText(), sharingService.getFreeUsageAcross(), sharingService.getAccesNbrRqrFlag(),
							sharingService.getLeaderSbscrpId(), sharingService.getUsageAcumSeqNbr(), sharingService.getCommSvcAreaId());
				}
			}
		}
	}

	private boolean isRequiredSharingPlanMissing(Set<String> requiredSharingPlans, List<SharingServiceVO> subscribedPlans) {
		for (SharingServiceVO subscribedPlan : subscribedPlans) {
			if (requiredSharingPlans.contains(subscribedPlan.getSvcName())) {
				return false; //retorna false para não criticar, pois existe plano em pelo menos uma subscrição
			}
		}
		return true;
	}

	//método que mostra lista titulares TIT-DEP
	private void shownTIT() {
		System.out.println("TIT\n");
		for(int i=0; i<listaTIT.size();i++ ){ 
			System.out.print(" " +listaTIT.get(i).getSbscrpId());
			System.out.print(" " +listaTIT.get(i).getSvcName());
			System.out.print(" " +listaTIT.get(i).getCaptnText());
			System.out.print(" " +listaTIT.get(i).getFreeUsageAcross());
			System.out.print(" " +listaTIT.get(i).getAccesNbrRqrFlag());
			System.out.print(" " +listaTIT.get(i).getLeaderSbscrpId());
			System.out.print(" " +listaTIT.get(i).getUsageAcumSeqNbr() + "\n");
		}				
	}
	//método que mostra lista dependentes TIT-DEP
	private void shownDEP() {
		System.out.println("DEP\n");
		for(int i=0; i<listaDEP.size();i++ ){ 
			System.out.print(" " +listaDEP.get(i).getSbscrpId());
			System.out.print(" " +listaDEP.get(i).getSvcName());
			System.out.print(" " +listaDEP.get(i).getCaptnText());
			System.out.print(" " +listaDEP.get(i).getFreeUsageAcross());
			System.out.print(" " +listaDEP.get(i).getAccesNbrRqrFlag());
			System.out.print(" " +listaDEP.get(i).getLeaderSbscrpId());
			System.out.print(" " +listaDEP.get(i).getUsageAcumSeqNbr() + "\n");
		}				
	}
	//método que mostra servicos NAO TIT-DEP
	private void shownService(){
		System.out.print("ShownService\n");
		for(int i=0; i<listaService.size();i++ ){ 
			System.out.print(" " +listaService.get(i).getSbscrpId());
			System.out.print(" " +listaService.get(i).getSvcName());
			System.out.print(" " +listaService.get(i).getCaptnText());
			System.out.print(" " +listaService.get(i).getFreeUsageAcross());
			System.out.print(" " +listaService.get(i).getAccesNbrRqrFlag());
			System.out.print(" " +listaService.get(i).getUsageAcumSeqNbr());
			System.out.print(" " +listaService.get(i).getSvcNameQuery2() + "\n");
		}		
	}
	//método que mostra planos NAO TIT-DEP
	private void shownPlan(){
		System.out.print("ShownPlan\n");
		for(int i=0; i<listaPlan.size();i++ ){ 
			System.out.print(" " +listaPlan.get(i).getSbscrpId());
			System.out.print(" " +listaPlan.get(i).getSvcName());
			System.out.print(" " +listaPlan.get(i).getCaptnText());
			System.out.print(" " +listaPlan.get(i).getFreeUsageAcross());
			System.out.print(" " +listaPlan.get(i).getAccesNbrRqrFlag());
			System.out.print(" " +listaPlan.get(i).getUsageAcumSeqNbr());
			System.out.print(" " +listaPlan.get(i).getSvcNameQuery2() + "\n");
		}		
	}	
} //classe
