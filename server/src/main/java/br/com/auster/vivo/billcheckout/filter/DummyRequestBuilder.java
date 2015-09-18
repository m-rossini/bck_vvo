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

import java.util.Iterator;
import java.util.Map;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;

import br.com.auster.common.log.LogFactory;
import br.com.auster.dware.graph.Request;
import br.com.auster.dware.request.HashRequestFilter;
import br.com.auster.dware.request.RequestBuilder;
import br.com.auster.dware.request.RequestErrorHandler;
import br.com.auster.dware.request.RequestFilter;

/**
 * @author framos
 * @version $Id: DummyRequestBuilder.java 171 2005-09-24 03:32:32Z framos $
 */
public class DummyRequestBuilder implements RequestBuilder {

	protected static final Logger log = LogFactory.getLogger(DummyRequestBuilder.class);
	private String name;
	
	
	public DummyRequestBuilder(String _name, Element _element) {
		name = _name;
	}
	
	/* (non-Javadoc)
	 * @see br.com.auster.dware.request.RequestBuilder#getName()
	 */
	public String getName() {
		return name;
	}

	/* (non-Javadoc)
	 * @see br.com.auster.dware.request.RequestBuilder#createRequests(java.util.Map)
	 */
	public RequestFilter createRequests(Map arg0) {
		return createRequests(null, arg0);
	}

	/* (non-Javadoc)
	 * @see br.com.auster.dware.request.RequestBuilder#createRequests(br.com.auster.dware.request.RequestFilter, java.util.Map)
	 */
	public RequestFilter createRequests(RequestFilter arg0, Map arg1) {
		if ((arg0 == null) || (arg0.getAcceptedRequests() == null)) {
			log.error("or filter is NULL, or has no accept. requests : " + arg0);
			return new HashRequestFilter();
		}
		RequestFilter f = new StateRequestFilter(); 
		log.debug("created new request filter .. will try to accept " + arg0.getRemainingRequests().size() + " requests");
		for (Iterator it=arg0.getRemainingRequests().iterator(); it.hasNext();) {
			Request r = (Request)it.next();
			log.debug("trying to accept a new request " + r);
			if (! f.accept(r)) {
				RequestErrorHandler.handleError(r, new IllegalStateException("Cannot process this request"));
			}
		}
		return f;
	}

}
