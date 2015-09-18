/*
 * Copyright (c) 2004 Auster Solutions. All Rights Reserved.
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
 * Created on 07/10/2006
 */
package br.com.auster.vivo.billcheckout.cache;

import java.io.IOException;
import java.security.GeneralSecurityException;

import javax.xml.parsers.ParserConfigurationException;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;
import org.xml.sax.SAXException;

import br.com.auster.common.xml.DOMUtils;
import br.com.auster.om.reference.facade.ConfigurationException;
import br.com.auster.om.reference.facade.ReferenceFacades;

/**
 * @author mtengelm
 *
 */
public abstract class SimpleFileFacade implements ReferenceFacades {

	private static Logger log = Logger.getLogger(SimpleFileFacade.class);
	public static final String DATA_FILE_ATTR = "data-file";
	public static final String SEPARATOR_ATTR = "sep";	
	
	public static final String DEFAULT_SEPARATOR = ";";
	protected String	separator;

	/**
	 * 
	 */
	public SimpleFileFacade() {
	}

	/* (non-Javadoc)
   * @see br.com.auster.om.reference.facade.ReferenceFacades#configure(org.w3c.dom.Element)
   */
  public void configure(Element _configuration) throws ConfigurationException {
  	//handle Separator
  	String sep = DOMUtils.getAttribute(_configuration, SEPARATOR_ATTR, false);
  	if ( null == sep || "".equals(sep)) {
  		this.separator = DEFAULT_SEPARATOR;
  	} else {
  		this.separator = sep;
  	}
  	
  	//Handle File
  	String dfile = DOMUtils.getAttribute(_configuration, DATA_FILE_ATTR, false);
  	log.info("About to read file parm name " + dfile);
	  if ( dfile!=null && dfile.length() > 0) {
	  	try {
	      this.loadParms(dfile);
      } catch (IOException e) {
      	log.fatal("Unable to read file named " + dfile, e);
	      e.printStackTrace();
      }
	  }
  }

	/* (non-Javadoc)
   * @see br.com.auster.om.reference.facade.ReferenceFacades#configure(java.lang.String)
   */
  public void configure(String _configurationFile) throws ConfigurationException {
  	this.configure(_configurationFile, true);	  
  }

	/* (non-Javadoc)
   * @see br.com.auster.om.reference.facade.ReferenceFacades#configure(java.lang.String, boolean)
   */
  public void configure(String _configurationFile, boolean _encrypted) throws ConfigurationException {
  	try {
	    this.configure(DOMUtils.openDocument(_configurationFile, _encrypted));
    } catch (ParserConfigurationException e) {
    	throw new ConfigurationException(e);
    } catch (SAXException e) {
    	throw new ConfigurationException(e);
    } catch (IOException e) {
    	throw new ConfigurationException(e);
    } catch (GeneralSecurityException e) {
    	throw new ConfigurationException(e);	    
    }	  
  }

  public abstract void loadParms(String fName) throws IOException;
}
