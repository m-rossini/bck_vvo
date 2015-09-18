/*
 * Copyright (c) 2004 TTI Tecnologia. All Rights Reserved.
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
 * Created on May 24, 2004
 */
package br.com.auster.dware.console.vivo.web;


import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import br.com.auster.common.log.LogFactory;
import br.com.auster.dware.console.commons.RequestScopeConstants;
import br.com.auster.dware.console.commons.SessionScopeConstants;
import br.com.auster.dware.console.request.ParseUploadForAccountsAction;
import br.com.auster.dware.console.request.parsers.IncomingFileParser;
import br.com.auster.dware.console.vivo.parser.SirsAccountParser;
import br.com.auster.facelift.requests.web.model.WebRequest;
import br.com.auster.facelift.services.ServiceLocator;
import br.com.auster.facelift.services.properties.PropertyHandler;



public class ParseUploadedSirsAction extends ParseUploadForAccountsAction {

	
	
	private Logger log = LogFactory.getLogger(ParseUploadedSirsAction.class);
	
	
	protected void parseFile(String _filename, HttpServletRequest _request)  {
		
		PropertyHandler handler = (PropertyHandler) ServiceLocator.getInstance().getPropertiesService();
		String cfgFile = handler.getProperty(SirsAccountParser.UDD_DEFINITION_FILE);
		
		SirsAccountParser parser = new SirsAccountParser(cfgFile);
		parser.parse(new File(_filename));
	   
		Map accounts = (Map) parser.getParsedInfo(SirsAccountParser.PARSER_ACCOUNTMAP_INFO);
		_request.getSession(false).setAttribute(SessionScopeConstants.SESSION_LISTOFRESULTS_KEY, accounts);
		_request.setAttribute(RequestScopeConstants.REQUEST_UPLOADFILECYCLE_KEY, parser.getParsedInfo(SirsAccountParser.PARSER_CYCLEID_INFO));
	   
		_request.getSession(false).setAttribute(SessionScopeConstants.SESSION_NEWREQUEST_KEY, createRequest(_filename, parser));
		_request.getSession(false).setAttribute(SessionScopeConstants.SESSION_UPLOADEDFILE_KEY, _filename);
		
	}
	
    private WebRequest createRequest(String _filename, IncomingFileParser _parser) {

        WebRequest request = new WebRequest();
        log.debug("created request for file '" + _filename + "'");
        
        Map addInfo = new HashMap();
        
        //addInfo.put("request.size",  Integer.valueOf(((Map)_parser.getParsedInfo(SirsAccountParser.PARSER_ACCOUNTMAP_INFO)).size()));
        addInfo.put("request.size",  String.valueOf(((Map)_parser.getParsedInfo(SirsAccountParser.PARSER_ACCOUNTMAP_INFO)).size()));
        
        addInfo.put("cycle.id", _parser.getParsedInfo(SirsAccountParser.PARSER_CYCLEID_INFO));
//        addInfo.put("cycle.date", _parser.getParsedInfo(SirsAccountParser.PARSER_CYCLEDATE_INFO));
        request.setAdditionalInformation(addInfo);
        return request;
    }	
}
