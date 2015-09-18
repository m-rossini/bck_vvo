/*
 * Copyright (c) 2008 Auster Solutions. All Rights Reserved. THIS SOFTWARE
 * IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 * THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * Created on 26/02/2008
 * 
 * @author anardo
 */

package br.com.auster.vivo.billcheckout.consequence;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.log4j.Logger;

import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;
import br.com.auster.om.util.ParserUtils;
import br.com.auster.vivo.billcheckout.cache.DataBarnQueryExecutor;
import br.com.auster.vivo.billcheckout.caches.R55NegotiableProductsCache;

public class R55ConsequenceHelper {
	
	private String seq_nbr;
	private String subscr;
	private String activationDatePlan; 		 //formato String YYYYMMDD, para poder passar na query
	private String finishDatePlan;	   		 //formato String YYYYMMDD, para poder passar na query
	private Date   activationDatePlanParse;  //Parse para formato Date, para poder comparar datas no método
	private Date   finishDatePlanParse;
	private R55NegotiableProductsCache negotProdCache;
	private DataBarnQueryExecutor dtbnQueryExecutor;
	private List listaConseq = new ArrayList();
	
	private static Logger log = Logger.getLogger(R55ConsequenceHelper.class);
	
	public R55ConsequenceHelper(String seqNbr, Object subscr, String activationDatePlan, String finishDatePlan, R55NegotiableProductsCache negotProdCache, DataBarnQueryExecutor dtbnQueryExecutor ) {
		this.seq_nbr = seqNbr;
		this.subscr = subscr.toString(); //Parse de Object para String
		this.activationDatePlan = activationDatePlan;  //formato String YYYYMMDD
		this.activationDatePlanParse = ParserUtils.getDate(activationDatePlan); //formato Date 
		this.finishDatePlan	= finishDatePlan;
		this.finishDatePlanParse = ParserUtils.getDate(finishDatePlan); //fazendo o Parse, de getDateLastMiliSecond para getDate();, fazendo  as horas ficarem idênticos na comparação posterior
		this.negotProdCache = negotProdCache;
		this.dtbnQueryExecutor = dtbnQueryExecutor;
	}
	//método que executa verificação da existência do svc_price_seq_nbr do produto na tabela BCK_NegotiableProducts
	public void validateRule() throws SQLException {
		if (negotProdCache.isProductNegotiated(this.seq_nbr)) {
			queryNegotiableProducts();
		}
	}
	//adiciona em uma lista as divergências encontradas nas negociações retornadas do DTBN, para cada caption
	public void createConsequence(String negot_efetivation, String negot_expiration, String negot_null, String dtbn_seq_nbr){
		listaConseq.add(negot_efetivation);
		listaConseq.add(negot_expiration);
		listaConseq.add(negot_null);
		listaConseq.add(dtbn_seq_nbr);
	}	
	//retorna a lista de divergências das datas negociadas
	public List getConsequence(){
		if (listaConseq.size()!=0){
			return listaConseq;		
		}else{
			  return null;
		 	 }
	}
	//método que consulta todos as negociações do caption e critica chamando a lista de consequencia na medida que itera 
	//o ResultSet
	private void queryNegotiableProducts() {
		long st = System.nanoTime();

		//Qdo for encontrado registro no DTBN, de negociações para este produto(caption), de negociação obrigatória
		StatsMapping stats = ProcessingStats.starting(getClass(), "R55_NegotProd");
		try {
			ResultSet rs = dtbnQueryExecutor.getResultSet("R55_NegotProd", new Object[] {seq_nbr, subscr, activationDatePlan, finishDatePlan});
			Map<String, Date> map = new HashMap<String, Date>(); // Map<serviceId,toDate>
			while (rs.next()) {
				String serviceId = rs.getString("SVC_PRICE_SEQ_NBR");
				Date fromDate = ParserUtils.getDate(rs.getString("NEGOT_EFF_DT"));
				Date toDate =   ParserUtils.getDate(rs.getString("NEGOT_EXPR_DT"));
				Date previousToDate = map.get(serviceId); //pega o toDate, sempre a última data final do período, ver o put()
				if (previousToDate == null) { //ak pode ser ==null, pois as negociações em aberto(null) no BD foi aplicado nvl()...
					if (fromDate.compareTo(activationDatePlanParse) > 0) {
						//Existe intervalo na data inicial de negociação
						createConsequence(ParserUtils.getString(fromDate,"yyyyMMdd"), "", activationDatePlan, serviceId);						
					}
				} else {
					Calendar yesterday = Calendar.getInstance();
					Calendar today = Calendar.getInstance();
					yesterday.setTime(previousToDate);
					yesterday.add(Calendar.DAY_OF_MONTH, 1); 
					today.setTime(fromDate); 				  
					if (yesterday.compareTo(today) != 0) {
						//Existe intervalo entre data final de um período com a data inicial do seguinte
						createConsequence("", ParserUtils.getString(previousToDate,"yyyyMMdd"), 
										  ParserUtils.getString(yesterday.getTime(),"yyyyMMdd"), serviceId );
					}
				}
				map.put(serviceId, toDate);
			}
			
			if (map.size() > 0) {
				for (Entry<String, Date> entry : map.entrySet()) { //ak ficou mapeado todos períodos finais de cada seq_nbr 
					String svcID = entry.getKey();
					Date  toDate = entry.getValue();				
					
					if (toDate.compareTo(finishDatePlanParse) < 0) {
						// Existe intervalo na negociação para o último período do Seq_nbr
						createConsequence("", ParserUtils.getString(toDate, "yyyyMMdd"), finishDatePlan, svcID);
					}
				}			
			} else {
				//Qdo não há nenhum registro de negociação para este produto(caption), de negociação obrigatória
				createConsequence("", "", "", "");
			}
		} 
		catch (IllegalArgumentException e) {
			log.error("Error running queryNegotiableProducts", e);
			throw e;
		} catch (SQLException e) {
			log.error("Error running queryNegotiableProducts", e);
			throw new RuntimeException("Error running queryNegotiableProducts ",e);
		} 		
		finally {
			stats.finished();
			this.dtbnQueryExecutor.closeResultSet();
			long et = System.nanoTime(); 
			log.debug("Acessing Databarn Time in milliseconds:"
					+ ((et - st) / 1000 / 1000)
					+ " for getting negotiable products");
		}
	}
}
