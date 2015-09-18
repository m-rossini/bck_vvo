/*
 * Copyright (c) 2004-2007 Auster Solutions. All Rights Reserved.
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
 * Created on 21/03/2007
 */
package br.com.auster.vivo.billcheckout.probes;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;


/**
 * TODO What this class is responsible for
 *
 * @author mtengelm
 * @version $Id$
 * @since 21/03/2007
 */
public class DBConnectionProbe  implements DBProbe {
	private int	times;	
	private String uRL;
	private String userName;
	private String userPassword;

	/**
	 * Creates a new instance of the class <code>DBConnectionTimer</code>.
	 * @throws ClassNotFoundException 
	 */
	public DBConnectionProbe() {
				
	}

	public void stressConnection() throws SQLException {
		long ttConn = 0;
		long ttClse = 0;
		long st = 0;

		for (int i=0; i < this.getTimes(); i++) {
			st = System.nanoTime();
			Connection conn = this.getConnection();
			ttConn += (System.nanoTime() - st);
			
			if (conn.isClosed()) {
				System.err.println("ERROR-Connection is closed and should not be.");
			}
			
			System.out.println(Thread.currentThread().getName() + ".Iteration:" + i + ".Auto-commit is:" + conn.getAutoCommit());
			st = System.nanoTime();
			conn.close();			
			ttClse += (System.nanoTime() - st);
		}
		
		System.out.println("+------------------------------------------------------------+");
		System.out.println(Thread.currentThread().getName() + ".After [" + this.getTimes() + "] iterations:" );
//		System.out.println(Thread.currentThread().getName() + ".Connect Time in nanos:" + ttConn);
//		System.out.println(Thread.currentThread().getName() + ".Close   Time in nanos:" + ttClse);
//		System.out.println(Thread.currentThread().getName() + ".Connect Time in micro:" + (ttConn/1000));
//		System.out.println(Thread.currentThread().getName() + ".Close   Time in micro:" + (ttClse/1000));
		System.out.println(Thread.currentThread().getName() + ".Connect Time in milli:" + (ttConn/1000/1000));
		System.out.println(Thread.currentThread().getName() + ".Close   Time in milli:" + (ttClse/1000/1000));
		System.out.println("+------------------------------------------------------------+");
	}
	
	public void setParameters(String args[]) throws ClassNotFoundException {
		loadDriver(args[0]);
		setURL(args[1]);
		setUserName(args[2]);
		setUserPassword(args[3]);
		setTimes(Integer.parseInt(args[4]));
		System.out.println("**************************************");
	}
	
	protected void loadDriver(String driverName) throws ClassNotFoundException {
		Class.forName(driverName);
		System.out.println("Driver Loaded:" + driverName);
	}

	
	public void setTimes(int times) {
		this.times = times;
		System.out.println("Setting times:" + times);
	}
	
	/**
	 * Return the value of a attribute <code>times</code>.
	 * @return return the value of <code>times</code>.
	 */
	public int getTimes() {
		return this.times;
	}
	
	public Connection getConnection() throws SQLException {
		return DriverManager.getConnection(getURL(), getUserName(), getUserPassword());
	}
	
	/**
	 * Return the value of a attribute <code>uRL</code>.
	 * @return return the value of <code>uRL</code>.
	 */
	public String getURL() {
		return this.uRL;
	}
	
	/**
	 * Set the value of attribute <code>uRL</code>.
	 * @param url
	 */
	public void setURL(String url) {
		this.uRL = url;
		System.out.println("Setting URL:" + url);
	}
	
	/**
	 * Return the value of a attribute <code>userName</code>.
	 * @return return the value of <code>userName</code>.
	 */
	public String getUserName() {
		return this.userName;
	}
	
	/**
	 * Set the value of attribute <code>userName</code>.
	 * @param userName
	 */
	public void setUserName(String userName) {
		this.userName = userName;
		System.out.println("Setting user name:" + userName);
	}
	
	/**
	 * Return the value of a attribute <code>userPassword</code>.
	 * @return return the value of <code>userPassword</code>.
	 */
	public String getUserPassword() {
		return this.userPassword;
	}

	
	/**
	 * Set the value of attribute <code>userPassword</code>.
	 * @param userPassword
	 */
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
		System.out.println("Setting password:" + "I WILL NOT SHOW IT.");
	}

	/**
	 * TODO why this methods was overriden, and what's the new expected behavior.
	 * 
	 * @return
	 * @throws Exception
	 * @see java.util.concurrent.Callable#call()
	 */
	public Object call() throws Exception {
		System.out.println("Starting Connection Probe.Thread" + 
				"->" + Thread.currentThread().getName());
		
		this.stressConnection();
		
		System.out.println("Finished Connection Probe.Thread" + 
				"->" + Thread.currentThread().getName());
		return null;
	}
}
