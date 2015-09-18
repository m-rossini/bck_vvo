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
 * Created on 11/04/2007
 */
package br.com.auster.vivo.billcheckout;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.security.GeneralSecurityException;

import javax.xml.parsers.ParserConfigurationException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.xml.sax.SAXException;

import br.com.auster.minerva.Bootstrap;
import br.com.auster.minerva.ReportServer;
import br.com.auster.minerva.core.ReportInitializationException;


/**
 * TODO What this class is responsible for
 *
 * @author mtengelm
 * @version $Id$
 * @since 11/04/2007
 */
public class ReportBootStrap {

  private static final Log log = LogFactory.getLog(Bootstrap.class);
  
  

	// ----------------------------
	// MAIN
	// ----------------------------
    
	public static void main(String[] args) {
		ReportServer rs = new ReportServer();
		long results = rs.setArguments(args);
		if (results != 0) {
			//We got a parsing command line error
			shutDownReportBootStrap(99, null);
		}

		try {
			rs.process(rs.getParsedCommandLine());
		} catch (IllegalArgumentException e) {
			shutDownReportBootStrap(1, e);
		} catch (SecurityException e) {
			shutDownReportBootStrap(2, e);
		} catch (ParserConfigurationException e) {
			shutDownReportBootStrap(3, e);
		} catch (SAXException e) {
			shutDownReportBootStrap(4, e);
		} catch (IOException e) {
			shutDownReportBootStrap(5, e);
		} catch (GeneralSecurityException e) {
			shutDownReportBootStrap(6, e);
		} catch (InstantiationException e) {
			shutDownReportBootStrap(7, e);
		} catch (IllegalAccessException e) {
			shutDownReportBootStrap(8, e);
		} catch (ClassNotFoundException e) {
			shutDownReportBootStrap(9, e);
		} catch (ReportInitializationException e) {
			shutDownReportBootStrap(10, e);
		} catch (NoSuchMethodException e) {
			shutDownReportBootStrap(11, e);
		} catch (InvocationTargetException e) {
			shutDownReportBootStrap(12, e);
		}		
		
	}

	protected static void shutDownReportBootStrap(long code, Throwable t) {
		if (t != null) {
			log.fatal(t);
			t.printStackTrace();
			System.err.println(t);
		}
		System.out.println("Leaving report bootstrap with code:" + code);
		System.exit((int) code);
	}

}
