/*
 * Copyright (c) 2004-2005 Auster Solutions do Brasil. All Rights Reserved.
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
 * Created on May 31, 2005
 */
package br.com.auster.vivo.billcheckout;

import java.security.AccessControlException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import br.com.auster.common.cli.OptionsParser;
import br.com.auster.dware.graph.Request;

/**
 * A bootstrap class for Billcheckout
 * 
 * @author Edson Tirelli
 * @version $Id: Bootstrap.java 1252 2007-03-09 17:58:44Z mtengelm $
 */
public class BootstrapPVA extends br.com.auster.dware.Bootstrap {

	private static BootstrapPVA boot;

	/**
	 * @param configRoot
	 */
	public BootstrapPVA() throws java.rmi.RemoteException {
		super();
	}

	/**
	 * This method is called in order to check if the resource manage by this run
	 * of data-aware is for the same product as this main class
	 * 
	 * @return Returns 0 if the productID is the same or -1 otherwise
	 */
	protected int check() {
		String productID = this.dataAware.getLicense().getProductID();
		if (productID.charAt(0) == 'V' && productID.charAt(1) == 'V' && productID.charAt(2) == '#'
		    && productID.charAt(3) == 'B' && productID.charAt(4) == 'I' && productID.charAt(5) == 'L'
		    && productID.charAt(6) == 'L' && productID.charAt(7) == 'C' && productID.charAt(8) == 'H'
		    && productID.charAt(9) == 'E' && productID.charAt(10) == 'C'
		    && productID.charAt(11) == 'K' && productID.charAt(12) == 'O'
		    && productID.charAt(13) == 'U' && productID.charAt(14) == 'T'
		    && productID.charAt(15) == '#' && productID.charAt(16) == 'V'
		    && productID.charAt(17) == '3' && productID.charAt(18) == '.'
		    && productID.charAt(19) == '2') {
			return 0;
		}
		return -1;
	}


	public static void main(String[] args) throws Exception {
		boot = new BootstrapPVA();
		String msg="";
		try {
			boot.execute(args);
			shutdown(0,null,"Processing finished successfully.");
			
		} catch (AccessControlException e) {
			shutdown(1,e,msg);
		} catch (Throwable e) {
			shutdown(2,e,msg);
		}
		
	}

	/**
   * @param exitcode
   * @param e
   * @param msg
   */
  private static void shutdown(int exitcode, Throwable e, String msg) {
  	if (e != null) {
  		e.printStackTrace();
  	}
  	
		if (boot.dataAware != null) {
			boot.dataAware.shutdown(true);
		}
		log.info(msg);
		System.out.println(msg);
//		System.exit(exitcode);
	  
  }

}
