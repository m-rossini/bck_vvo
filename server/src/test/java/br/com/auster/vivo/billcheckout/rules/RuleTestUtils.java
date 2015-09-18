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
 * Created on 09/01/2007
 */
package br.com.auster.vivo.billcheckout.rules;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.security.GeneralSecurityException;
import java.util.HashMap;
import java.util.Map;

import javax.xml.parsers.ParserConfigurationException;

import org.apache.log4j.Logger;
import org.apache.log4j.xml.DOMConfigurator;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;

import br.com.auster.billcheckout.rules.RulesEngineProcessor;
import br.com.auster.billcheckout.rules.assertion.AssertionEngine;
import br.com.auster.common.io.NIOUtils;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.common.xml.sax.NIOInputSource;
import br.com.auster.om.invoice.InvoiceModelObject;
import br.com.auster.udd.reader.TaggedFileReader;

/**
 * @author mtengelm
 * 
 */
public class RuleTestUtils {
	private static Logger log = Logger.getLogger(RuleTestUtils.class);
	 
	public static final String		FILTER_CONFIG_ENGINE_PLUGIN				= "rules-engine";
	public static final String		FILTER_CONFIG_ENGINE_PLUGIN_CLASS	= "class-name";	
	public static final String FILTER_CONFIG_GLOBALSLIST_ELEMENT = "globals-list";
	public static final String FILTER_CONFIG_GLOBAL_ELEMENT = "global";
	public static final String FILTER_CONFIG_GLOBAL_NAME = "name";
	public static final String FILTER_CONFIG_GLOBAL_CLASS = "class-name";
	public static final String		ASSERTION_ELMT										= "assertionEngine";
	
	private static AssertionEngine assertionEngine;
	
	public static void configureLog(String fname)
			throws ParserConfigurationException, SAXException, IOException,
			GeneralSecurityException {
		DOMConfigurator.configure(DOMUtils.openDocument(fname, false));
	} 
  
	public static XMLReader parseUDDMapping(String confname)
			throws ParserConfigurationException, SAXException, IOException,
			GeneralSecurityException {
		Element config = DOMUtils.openDocument(confname, false);
		XMLReader reader = new TaggedFileReader(config);
		return reader;
	}

	public static InputSource getSource(String fname) throws IOException {
		return new NIOInputSource(NIOUtils.openFileForRead(fname));
	}

	public static RulesEngineProcessor getEngine(String confName)
			throws Exception {
		Element config = DOMUtils.openDocument(confName, false);
		
		//IN ORDER TO KEEP THIS CLASS WITH LESS CHANGES POSSIBLE, WE ARE GOING TO CONFIGURE
		// THE ASSERTION ENGINE HERE.
		configureAssertion(config);
		
		
		//Configure Rules Engine
		Element engineElement = DOMUtils.getElement(config,
				FILTER_CONFIG_ENGINE_PLUGIN, true);
		
		String engineKlass = DOMUtils.getAttribute(engineElement,
				FILTER_CONFIG_ENGINE_PLUGIN_CLASS, true);


		RulesEngineProcessor rulesEngine=null;
		try {
			rulesEngine = createEngine(engineKlass, "testCase");

		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		
		rulesEngine.configure(engineElement);
		return rulesEngine;
	}

	private static void configureAssertion(Element config) throws ClassNotFoundException, InstantiationException, IllegalAccessException {
		Element assertion = DOMUtils.getElement(config, ASSERTION_ELMT, false);
		if (assertion == null) {
			String msg = "Assertion Configuration not found. Unable to assume a default one.";
			log.fatal(msg);
			throw new RuntimeException(msg);
		}

		String klassName = DOMUtils.getAttribute(assertion, FILTER_CONFIG_GLOBAL_CLASS, true);

		Class<?> klass = Class.forName(klassName);
		assertionEngine = (AssertionEngine) klass.newInstance();
		assertionEngine.configure(assertion);
		
	}

	public static RulesEngineProcessor createEngine(String engineKlass,
			String filterName) throws IllegalArgumentException,
			SecurityException, InstantiationException, IllegalAccessException,
			InvocationTargetException, NoSuchMethodException,
			ClassNotFoundException {
		
		Class[] c = { String.class };
		Object[] o = { filterName };
		return (RulesEngineProcessor) Class.forName(engineKlass)
				.getConstructor(c).newInstance(o);
	}

	public static void initEngine(RulesEngineProcessor re, Map globalsMap)
			throws Exception {
		re.init(globalsMap);
	}

	public static void prepareEngine(RulesEngineProcessor re, Map globalsMap)
			throws Exception {
		re.prepare(globalsMap);
		// RuleBase rl;
		// rl.n

	}

	public static void fireRules(RulesEngineProcessor re) throws Exception {
		re.fireRules();
	}

	public static Map getGlobals(String confFile)
			throws ParserConfigurationException, SAXException, IOException,
			GeneralSecurityException {
		Element config = DOMUtils.openDocument(confFile, false);
		Map globals = new HashMap<String, Object>();
		Element globalsListElmt = DOMUtils.getElement(config,
				FILTER_CONFIG_GLOBALSLIST_ELEMENT, false);
		if (globalsListElmt != null) {
			NodeList globalsList = DOMUtils.getElements(globalsListElmt,
					FILTER_CONFIG_GLOBAL_ELEMENT);
			for (int i = 0; globalsList.getLength() > i; i++) {
				Element currentGlobal = (Element) globalsList.item(i);
				String klassName = DOMUtils.getAttribute(currentGlobal,
						FILTER_CONFIG_GLOBAL_CLASS, true);
				String name = DOMUtils.getAttribute(currentGlobal,
						FILTER_CONFIG_GLOBAL_NAME, true);
				try {
					Class klass = Class.forName(klassName);
					Object globalInstance = klass.newInstance();
					try {
						Method method = klass.getMethod("configure",
								new Class[] { Element.class });
						method.invoke(globalInstance,
								new Object[] { currentGlobal });
					} catch (NoSuchMethodException nsme) {
					} catch (IllegalArgumentException e) {
						throw new RuntimeException(e);
					} catch (InvocationTargetException e) {
						throw new RuntimeException(e);
					}
					globals.put(DOMUtils.getAttribute(currentGlobal,
							FILTER_CONFIG_GLOBAL_NAME, true), globalInstance);
				} catch (ClassNotFoundException e) {
				} catch (InstantiationException e) {
					throw new RuntimeException(e);
				} catch (IllegalAccessException e) {
					throw new RuntimeException(e);
				}
			}
		}
		return globals;
	}

	public static void assertFacts(RulesEngineProcessor re, Object obj)
			throws Exception {
		
		assertionEngine.assertObjects(re, (InvoiceModelObject) obj);

	}
}
