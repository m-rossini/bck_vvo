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
 * Created on Mar 18, 2005
 */
package br.com.auster.dware.console.vivo.parser;

import java.io.File;
import java.nio.channels.ReadableByteChannel;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;
import org.xml.sax.Attributes;
import org.xml.sax.ContentHandler;
import org.xml.sax.Locator;
import org.xml.sax.SAXException;

import br.com.auster.common.io.IOUtils;
import br.com.auster.common.io.NIOUtils;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.common.xml.sax.NIOInputSource;
import br.com.auster.dware.console.request.parsers.IncomingFileParser;
import br.com.auster.udd.reader.TaggedFileReader;

/**
 * @author framos
 * @version $Id: SirsAccountParser.java 495 2006-05-17 18:12:05Z framos $
 */
public class SirsAccountParser implements IncomingFileParser, ContentHandler {

	public static final String	PARSER_ACCOUNTMAP_INFO	   = "accounts";
	public static final String	PARSER_CYCLEID_INFO	       = "cycle";
	public static final String	PARSER_CYCLEDATE_INFO	     = "cycleDate";

	public static final String	ACCOUNT_XML_ATTRIBUTE	     = "account-id";
	public static final String	CUSTOMERNAME_XML_ATTRIBUTE	= "customer-name";
	public static final String	CICLE_XML_ATTRIBUTE	       = "cycle-code";
	public static final String	CYCLEDATE_XML_ATTRIBUTE	   = "cycle-date";

	public static final String	UDD_DEFINITION_FILE	       = "parsers.sirs.udd";

	private static Logger	     log	                       = Logger
	                                                           .getLogger(SirsAccountParser.class);

	private Map	               accounts;
	private String	           cycle;
	private String	           cycleDate;

	private String	           currentAccountId;

	TaggedFileReader	         sirsHandler;

	public SirsAccountParser(String _cfgFile) {
		accounts = new HashMap();
		try {
			if (_cfgFile != null) {
				Element config = DOMUtils.openDocument(IOUtils.openFileForRead(_cfgFile));
				sirsHandler = new TaggedFileReader(config);
			} else {
				log.error("UDD configuration file not found : " + _cfgFile);
			}
		} catch (Exception e) {
			log.error("could not initialize UDD parser", e);
		}
	}

	public void parse(File _file) {
		log.debug("starting to parse incoming file " + _file);
		ReadableByteChannel channel = null;
		try {
			accounts.clear();
			sirsHandler.setContentHandler(this);
			channel = NIOUtils.openFileForRead(_file);
			NIOInputSource input = new NIOInputSource(channel);
			sirsHandler.parse(input);
		} catch (Exception e) {
			log.error("Problems with File(Will not be processed):" + _file, e);
		} finally {
			try {
				if (channel != null) {
					channel.close();
				}
			} catch (Exception e) {
				log.error("exception raised while parsing file named:" + _file, e);
			}
		}
	}

	public Object getParsedInfo(String _token) {
		if (PARSER_ACCOUNTMAP_INFO.equals(_token)) {
			return accounts;
		} else if (PARSER_CYCLEID_INFO.equals(_token)) {
			return cycle;
		} else if (PARSER_CYCLEDATE_INFO.equals(_token)) {
			return cycleDate;
		}
		return null;
	}

	public void endDocument() throws SAXException {
	}

	public void startDocument() throws SAXException {
	}

	public void characters(char[] ch, int start, int length) throws SAXException {
	}

	public void ignorableWhitespace(char[] ch, int start, int length) throws SAXException {
	}

	public void endPrefixMapping(String prefix) throws SAXException {
	}

	public void skippedEntity(String name) throws SAXException {
	}

	public void setDocumentLocator(Locator locator) {
	}

	public void processingInstruction(String target, String data) throws SAXException {
	}

	public void startPrefixMapping(String prefix, String uri) throws SAXException {
	}

	public void endElement(String namespaceURI, String localName, String qName) throws SAXException {
	}

	public void startElement(String namespaceURI, String localName, String qName, Attributes atts)
	    throws SAXException {
		if (atts.getValue(ACCOUNT_XML_ATTRIBUTE) != null) {
			currentAccountId = atts.getValue(ACCOUNT_XML_ATTRIBUTE);
		}

		if (atts.getValue(CUSTOMERNAME_XML_ATTRIBUTE) != null) {
			String customerName = atts.getValue(CUSTOMERNAME_XML_ATTRIBUTE);
			if (currentAccountId != null) {
				accounts.put(currentAccountId, customerName);
				currentAccountId = null;
			}
		}

		if (atts.getValue(CICLE_XML_ATTRIBUTE) != null) {
			cycle = atts.getValue(CICLE_XML_ATTRIBUTE);
			cycleDate = atts.getValue(CYCLEDATE_XML_ATTRIBUTE);
		}

	}

}
