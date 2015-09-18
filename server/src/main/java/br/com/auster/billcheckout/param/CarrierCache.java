/*
 * Copyright (c) 2007 Auster Solutions do Brasil. All Rights Reserved.
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
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. *
 * 
 */

/**
 * @author anardo
 * Created on 21/12/2007
 * 
 *  Classe que busca dados da tabela BCK_CARRIER_DM do DB, utilizando
 *  da classe CarrierVO para armazená-los 
 */

package br.com.auster.billcheckout.param;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.NamingException;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;

import br.com.auster.common.log.LogFactory;
import br.com.auster.common.sql.SQLConnectionManager;
import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.om.reference.facade.ConfigurationException;
import br.com.auster.om.util.ParserUtils;

public class CarrierCache{	

	private SQLConnectionManager sqlMan;

	private static Logger log = LogFactory.getLogger(CarrierCache.class);
	public static final String SQL = "select * from bck_carrier_dm where carrier_code = ? and carrier_state= ?";

	//função para acessar o arquivo billcheckout.xml e verificar configurações de acesso ao DB	
	public void configure(Element config) {
		try {
			Element dbElement = DOMUtils.getElement(config, "database", true);
			String poolName = DOMUtils.getAttribute(dbElement, "pool-name", true);

			if ((poolName == null) || (poolName.trim().length() == 0)) {
				throw new ConfigurationException("pool-name was not informed.");
			}			
			sqlMan = SQLConnectionManager.getInstance(poolName);		
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}	

	public CarrierVO getSerieSub(String carrierID, String carrierUF) {

		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs = null;
		StatsMapping stats = ProcessingStats.starting("CarrierCache");
		try {
			conn = sqlMan.getConnection();
			stmt = conn.prepareStatement(SQL);
			stmt.setString(1, carrierID);
			stmt.setString(2, carrierUF);
			rs = stmt.executeQuery();
			if (rs.next()) {
				CarrierVO objVO = new CarrierVO();
				log.debug("Data found in DB.Obj: " + objVO);
				objVO.setObjID(rs.getInt("OBJID"));
				objVO.setCarrierName(rs.getString("CARRIER_NAME"));
				objVO.setCarrierCode(rs.getString("CARRIER_CODE"));
				objVO.setCarrierState(rs.getString("CARRIER_STATE"));
				objVO.setCarrierSerie(ParserUtils.getString(rs.getString("CUSTOM_1")));
				objVO.setCarrierSubSerie(ParserUtils.getString(rs.getString("CUSTOM_2")));
				return objVO;
			}
			log.debug("Obj is not found in cache neither in DB");
			
		} catch (SQLException e) {
			e.printStackTrace();
		  } 
		finally 			
		{	stats.finished();
			try {
				if (rs != null) 	{rs.close();  }
				if (stmt != null) 	{stmt.close();}
				if (conn != null) 	{conn.close();}
			} catch (SQLException e) {
					e.printStackTrace();
			  }
		}
		return null;
	}	
}//fim da classe