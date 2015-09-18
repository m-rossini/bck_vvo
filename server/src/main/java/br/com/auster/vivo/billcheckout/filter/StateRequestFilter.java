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
 * Created on Sep 23, 2005
 */
package br.com.auster.vivo.billcheckout.filter;

import java.util.Collection;

import org.apache.log4j.Logger;

import br.com.auster.common.log.LogFactory;
import br.com.auster.dware.graph.Request;
import br.com.auster.dware.request.HashRequestFilter;

/**
 * @author framos
 * @version $Id: StateRequestFilter.java 171 2005-09-24 03:32:32Z framos $
 */
public class StateRequestFilter extends HashRequestFilter {

	
	protected static final Logger log = LogFactory.getLogger(StateRequestFilter.class);
	
	
	public StateRequestFilter() {
		super();
	}
	
	public StateRequestFilter(Collection allowedRequests, boolean acceptOnlyOnce) {
		super(allowedRequests, acceptOnlyOnce);
	}
	
	
	

	public boolean accept(Request request, boolean ignore) {
		
		log.debug("attributes for request : " + request.getAttributes());
		if ((request.getAttributes().get("stateID") != null) &&
		    (request.getAttributes().get("stateID").equals("RS"))) {
			return false;
		}
		return super.accept(request, ignore);
	}

	/**
	 * @inheritDoc
	 */
	public boolean willAccept(Request request) {

		log.debug("attributes for request : " + request.getAttributes());
		if ((request.getAttributes().get("stateID") != null) &&
		    (request.getAttributes().get("stateID").equals("RS"))) {
				return false;
		}
		return super.willAccept(request);
	}	
	
}
