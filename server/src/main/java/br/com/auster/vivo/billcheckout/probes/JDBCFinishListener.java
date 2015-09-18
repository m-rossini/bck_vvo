/*
 * Copyright (c) 2004 TTI Tecnologia. All Rights Reserved.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 * 
 * Created on Sep 20, 2004
 */
package br.com.auster.vivo.billcheckout.probes;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;

import br.com.auster.common.log.LogFactory;
import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.dware.graph.FinishListener;
import br.com.auster.dware.graph.Graph;
import br.com.auster.dware.graph.Request;



/**
 * @author Ricardo Barone
 * @version $Id: RequestFinishListener.java,v 1.1 2004/11/08 15:54:21 rbarone
 *          Exp $
 */
public class JDBCFinishListener implements FinishListener {


	
	protected static final String SQL_FIND_PROC_REQUEST_ID = 
		"select a.proc_request_id from web_request_requests a "+
		" join proc_request b on a.proc_request_id = b.request_id " +
		" where a.web_request_id = ? and b.request_label = ? ";
	
	protected static final String SQL_INSERT_TRAIL = 
		"insert into proc_request_trail values ( PROC_TRAIL_SEQUENCE.nextval, ? , ?, sysdate, null)";
	
	protected static final String SQL_UPDATE_PROC_STATUS =
		"update proc_request set latest_status = ? where request_id = ? ";
	
	protected static final String SQL_SELECT_GROUPBY = 
		"select b.latest_status, count(b.latest_status) from proc_request b " +
		" join web_request_requests a on a.proc_request_id = b.request_id " +
		" where a.web_request_id = ? group by b.latest_status";
	
	protected static final String SQL_UPDATE_WEBREQUEST = 
		"update web_request set request_status = ? where request_id = ? ";
	
	
	private Logger log = LogFactory.getLogger(JDBCFinishListener.class);
	
	protected Element configuration;
	protected Connection conn;
  
  
	public JDBCFinishListener(Element _configuration) {
		if (_configuration == null) {
			throw new IllegalStateException("cannot connect to database without configuration parameters");
		}
		this.configuration = _configuration;
		this.connect();
	}
  
	private void connect() {
		try {
			String url = DOMUtils.getAttribute(configuration, "url", true);
			String user = DOMUtils.getAttribute(configuration, "user", true);
			String password = DOMUtils.getAttribute(configuration, "password", true);
			
			this.conn = DriverManager.getConnection(url, user, password);
			
		} catch (Exception e) {
			log.fatal("Could not initialize JDBCFinishListener!", e);
			throw new RuntimeException(e);
		}
	}

	public void graphFinished(Graph _graph, Request _request, Throwable _error, Date _datetime) {

		if ((_request.getTransactionId() == null) || (_request.getTransactionId().length() <= 0)) {
			log.warn("cannot send to web portal a request notification without transaction id", _error);
			return;
		}
		
		PreparedStatement st = null;
		int status = 3;
		if (_error != null) {
			status = 4;
		}
		
		long transactionId = Long.parseLong(_request.getTransactionId());
		
		StatsMapping stats = ProcessingStats.starting(getClass(), "graphFinished()");
		try {
			conn.setAutoCommit(true);
			// finding proc_request.request_id
			st = conn.prepareStatement(SQL_FIND_PROC_REQUEST_ID);
			st.setLong(1, transactionId);
			st.setString(2, _request.getUserKey());
			ResultSet rset = st.executeQuery();
			if (!rset.next()) {
				log.warn("Could not find request id for transaction " + transactionId + " and account " + _request.getUserKey());
				return;
			}
			long requestId = rset.getLong(1);
			rset.close();
			// updating proc_request status, and inserting new row in proc_request_trail
			st.close();
			st = conn.prepareStatement(SQL_UPDATE_PROC_STATUS);
      st.setInt(1, status);
			st.setLong(2, requestId);
			log.debug("Update in proc_request resulted in " + st.executeUpdate() + " rows updated");
			
			st.close();
			st = conn.prepareStatement(SQL_INSERT_TRAIL);
      st.setInt(1, status);
			st.setLong(2, requestId);
			log.debug("Insert in proc_request_trail resulted in " + st.executeUpdate() + " rows inserted");
			
			// couting if transaction finished
			st.close();
			st = conn.prepareStatement(SQL_SELECT_GROUPBY);
			st.setLong(1, transactionId);
			rset = st.executeQuery();
			int total = 0;
			int doneNOK = 0;
			int doneOK = 0;
			while (rset.next()) {
				int stat = rset.getInt(1);
				total++;
				if (stat == 3) {
					doneOK++;
				} else if (stat == 4) {
					doneNOK++;
				}
			}
			if ((total > 0) && ((doneOK+doneNOK) >= total)) {
				st.close();
				st = conn.prepareStatement(SQL_UPDATE_WEBREQUEST);
				st.setInt(1, (doneNOK > 0 ? 4 : 3));
				st.setLong(2, transactionId);
				log.debug("Update in web_request resulted in " + st.executeUpdate() + " rows updated");
				st.close();
			}
			conn.commit();
			log.debug("All SQLs commited");
		} catch (SQLException sqle) {
			log.error("Error while handing JDBC FinishListener for transaction " + transactionId + " and account " + _request.getUserKey(), sqle);
		} finally {
			stats.finished();
		}
	}

	public void graphCommiting(Graph _graph, Request _request) throws Exception {
		// do nothing. finish will do all the job
	}

    public void graphRollingBack(Graph _graph, Request _request, Throwable _error) throws Exception {
		// do nothing. finish will do all the job
    }
}
