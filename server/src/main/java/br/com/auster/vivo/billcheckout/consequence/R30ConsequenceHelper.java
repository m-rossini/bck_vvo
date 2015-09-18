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
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;
import br.com.auster.om.util.ParserUtils;
import br.com.auster.vivo.billcheckout.cache.DataBarnQueryExecutor;
import br.com.auster.vivo.billcheckout.cache.vo.FavoriteVO;

public class R30ConsequenceHelper {
	private static Logger log = Logger.getLogger(R30ConsequenceHelper.class);

	private String acctNbr;
	private String cycleCd;
	private String startDate;
	private String endDate;
	
	private DataBarnQueryExecutor dtbnQueryExecutor;


	public R30ConsequenceHelper(String acctNbr, String cycleCd, String startDate, String endDate, DataBarnQueryExecutor dtbnQueryExecutor ) {
		this.acctNbr = acctNbr;
		this.cycleCd = cycleCd;
		this.startDate = startDate;
		this.endDate = endDate;
		this.dtbnQueryExecutor = dtbnQueryExecutor;
	}

	public Map<String, HashMap> createFavoritesMap() {
		long st = System.nanoTime();
		String queryName = "R30_FavoriteList";
		
		Map<String, HashMap> allFavoritesMap = new HashMap<String, HashMap>();
		StatsMapping stats = ProcessingStats.starting(getClass(), queryName);
		try {
			ResultSet rs = dtbnQueryExecutor.getResultSet(queryName, new Object[] {acctNbr, cycleCd, endDate, startDate, endDate, endDate, startDate, endDate});
			while (rs.next()) {
				FavoriteVO favoriteVo = new FavoriteVO(); 
				favoriteVo.setOrigSubId(rs.getString("SBSCRP_ORIGEM"));
				favoriteVo.setEffDate(ParserUtils.getDate(rs.getString("DT_EFF_FAVORITO")));
				favoriteVo.setExpDate(ParserUtils.getDate(rs.getString("DT_EXP_FAVORITO")));
				favoriteVo.setDstnAccNbr(rs.getString("LINHA_DESTINO"));
				
				HashMap<String, FavoriteVO> favoriteMap = allFavoritesMap.get(favoriteVo.getOrigSubId());
				if (favoriteMap == null) {
					favoriteMap = new HashMap<String, FavoriteVO>();
					allFavoritesMap.put(favoriteVo.getOrigSubId(), favoriteMap);
				}
				favoriteMap.put(favoriteVo.getDstnAccNbr(), favoriteVo);
			}
		}
		catch (IllegalArgumentException e) {
			log.error("Error running " + queryName, e);
			throw e;
		} catch (SQLException e) {
			log.error("Error running " + queryName, e);
			throw new RuntimeException("Error running " + queryName,e);
		} 		
		finally {
			stats.finished();
			this.dtbnQueryExecutor.closeResultSet();
			long et = System.nanoTime(); 
			log.debug("Acessing Databarn Time in milliseconds:"
					+ ((et - st) / 1000 / 1000)
					+ " for query " + queryName);
		}
		return allFavoritesMap;
	}

		
}
