package br.com.auster.dware.console.vivo.web.test;

import java.io.File;
import java.io.IOException;
import java.security.GeneralSecurityException;

import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Element;
import org.xml.sax.SAXException;

import br.com.auster.common.io.NIOUtils;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.common.xml.sax.NIOInputSource;
import br.com.auster.dware.console.vivo.web.SirsAccountParser;
import br.com.auster.udd.reader.TaggedFileReader;

public class TestSirsParser {

	/**
	 * @param args
	 */
	public static void main(String[] args) {

		
		if (args.length < 2) {
			System.out.println("usage: TestSirsParser <UDD-file> <sirs-file>");
			return;
		}
		
		try {
	        Element config = DOMUtils.openDocument(args[0], false);
			TaggedFileReader sirsHandler = new TaggedFileReader(config);
			
			SirsAccountParser handler = new SirsAccountParser();
	        sirsHandler.setContentHandler(handler);
	        NIOInputSource input = new NIOInputSource(NIOUtils.openFileForRead( new File(args[1])) );                
	        sirsHandler.parse(input);
			System.out.println("Some");
		} catch (IOException ioe) {
			ioe.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (GeneralSecurityException e) {
			e.printStackTrace();
		}
	}

}
