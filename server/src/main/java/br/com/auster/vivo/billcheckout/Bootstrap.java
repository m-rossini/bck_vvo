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
 * @version $Id: Bootstrap.java 2285 2008-04-24 22:19:40Z gportuga $
 */
public class Bootstrap extends br.com.auster.dware.Bootstrap {
     
	private static final String	UPBOUND_OPT	      = "up-bound";
	private static final String	UPBOUNDSORTED_OPT	= "sort-order";
	private static Bootstrap boot;

	/**
	 * @param configRoot
	 */
	public Bootstrap() throws java.rmi.RemoteException {
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
		    && productID.charAt(17) == '4' && productID.charAt(18) == '.'
		    && productID.charAt(19) == 'X') {
			return 0;
		}
		return -1;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see br.com.auster.dware.Bootstrap#enqueueRequests(java.util.Collection)
	 */
	/*****************************************************************************
	 * This is a customized enqueue method. It filters out requests above a limit.
	 * The filtered out request can be then sorted in ascending (the default
	 * behavior), descending or not sorte at all. The sort is done thrught the
	 * request weight. After the sort (If specified or by default) these requests
	 * are put to the end of request list, and finally the super enqueueRequests
	 * is called with the changed request list.
	 */
	public void enqueueRequests(Collection<Request> requests) {
		List<Request> toPassAhead = new ArrayList<Request>();
		String lval = OptionsParser.getOptionValue(UPBOUND_OPT);
		if (lval != null) {
			String order = OptionsParser.getOptionValue(UPBOUNDSORTED_OPT);
			// we are assuming an ascending order to to upper bounded requests
			int ordered = 1;
			if (order != null) {
				if (order.equalsIgnoreCase("DSC")) {
					ordered = -1;
				} else if (order.equalsIgnoreCase("NONE")) {
					ordered = 0;
				}
			}
			log.info("Ordering is:" + ordered);
			log.debug("Enter:" + requests);
			long limit = Long.parseLong(lval);
			log.info("Limiting requests on queue to " + limit);

			List<Request> toBeLast = new ArrayList<Request>();

			// Decides if goes immediattly to the list or to the last positions
			for (Iterator<Request> itr = requests.iterator(); itr.hasNext();) {
				Request req = (Request) itr.next();
				if (req.getWeight() > limit) {
					toBeLast.add(req);
				} else {
					toPassAhead.add(req);
				}
			}
			// Should we order the list with Weighests requests
			if (ordered != 0) {
				boolean ascending = (ordered > 0) ? true : false;
				RequestWeightComparator comparator = new RequestWeightComparator(ascending);
				Collections.sort(toBeLast, comparator);
			}

			toPassAhead.addAll(toBeLast);
			log.debug("Leave:" + toPassAhead);
		} else {
			log.info("No up bound limit. Passing the requests as it comes to enqueue");
			toPassAhead.addAll(requests);
		}

		super.enqueueRequests(toPassAhead);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see br.com.auster.dware.Bootstrap#execute(java.lang.String[])
	 */
	/*****************************************************************************
	 * This method currently adds no options to the command line call of Bootstrap
	 * (it could be done through addOption() method call).
	 */
	protected void execute(String[] args) throws Exception {
		super.execute(args);
	}

	public static void main(String[] args) throws Exception {
		boot = new Bootstrap();
		String msg="";
		try {
			boot.execute(args);
		} catch (AccessControlException e) {
			shutdown(1,e,msg);
		} catch (Throwable e) {
			shutdown(2,e,msg);
		}
		
		//Bootstrap.shutdown(0, null, "Processing Finished OK.");
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
		System.exit(exitcode);
	  
  }

}
