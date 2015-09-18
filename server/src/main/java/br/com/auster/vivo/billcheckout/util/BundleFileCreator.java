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
 * Created on 13/03/2007
 */
package br.com.auster.vivo.billcheckout.util;

import java.io.File;
import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;

import br.com.auster.common.io.CompressUtils;

/**
 * TODO What this class is responsible for
 * 
 * @author mtengelm
 * @version $Id$
 * @since 13/03/2007
 */
public class BundleFileCreator {

	private static Logger					log										= Logger
																													.getLogger(BundleFileCreator.class);

	protected static final String	PROP_REPORT_NAME			= "auster.pva.output.name";
	protected static final String	PROP_REPORT_DIR				= "auster.pva.output.dir";
	protected static final String	PROP_PVA_FILES_DIR		= "auster.pva.workdir";
	protected static final String	DEFAULT_REPORT_NAME		= "PVA_REPORT_DEFAULT";
	protected static final String	DEFAULT_REPORT_DIR		= ".";
	protected static final String	DEFAULT_PVA_FILES_DIR	= "output/pva";

	private String	reportName;
	private String	reportDirName;
	private String	workingDirectoryName;

	/**
	 * Creates a new instance of the class <code>BundleFileCreator</code>.
	 */
	public BundleFileCreator() {
		reportName = System.getProperty(PROP_REPORT_NAME);
		if (null == reportName || "".equals(reportName)) {
			log.warn("Report Name was not informed in system property:"
					+ PROP_REPORT_NAME + ".Defaulting to:" + DEFAULT_REPORT_NAME);
			this.setReportNameAsDefault();
		}
		
		reportDirName = System.getProperty(PROP_REPORT_DIR);
		if (null == reportDirName || "".equals(reportDirName)) {
			log.warn("Report Directory was not informed in system property:"
					+ PROP_REPORT_DIR + ".Defaulting to:" + DEFAULT_REPORT_DIR);
			this.setReportDirectoryAsDefault();
		}
		
		workingDirectoryName = System.getProperty(PROP_PVA_FILES_DIR);
		if (null == workingDirectoryName || "".equals(workingDirectoryName)) {
			log.warn("Report Directory was not informed in system property:"
					+ PROP_PVA_FILES_DIR + ".Defaulting to:" + DEFAULT_PVA_FILES_DIR);
			this.setWorkingDirectoryAsDefault();
		}		
	}

	public File getCompressedReports() throws IOException {
		File base = new File(this.getWorkingDirectoryName());	
		Set<File> fileSet = new HashSet<File>();
		fileSet.add(base);
		
		
		File repDir = new File(this.getReportDirName());
		if (!repDir.exists()) {
			repDir.mkdirs();
		}
		
		File reportFile = new File(repDir.getAbsolutePath() + System.getProperty("file.separator", "/") + this.getReportName());

		return CompressUtils.createZIPBundle(fileSet, reportFile.getAbsolutePath());
	}
	
	public File getReportFile() {
		return null;		
	}
	
	protected void setReportNameAsDefault() {
		this.setReportName(DEFAULT_REPORT_NAME);
	}

	protected void setReportDirectoryAsDefault() {
		this.setReportDirName(DEFAULT_REPORT_DIR);
	}
	
	protected void setWorkingDirectoryAsDefault() {
		this.setWorkingDirectoryName(DEFAULT_PVA_FILES_DIR);
	}
	/**
	 * Return the value of a attribute <code>reportName</code>.
	 * @return return the value of <code>reportName</code>.
	 */
	public String getReportName() {
		return this.reportName;
	}

	
	/**
	 * Set the value of attribute <code>reportName</code>.
	 * @param reportName
	 */
	public void setReportName(String reportName) {
		this.reportName = reportName;
	}

	
	/**
	 * Return the value of a attribute <code>reportDirName</code>.
	 * @return return the value of <code>reportDirName</code>.
	 */
	public String getReportDirName() {
		return this.reportDirName;
	}

	
	/**
	 * Set the value of attribute <code>reportDirName</code>.
	 * @param reportDirName
	 */
	public void setReportDirName(String reportDirName) {
		this.reportDirName = reportDirName;
	}

	
	/**
	 * Return the value of a attribute <code>workingDirectoryName</code>.
	 * @return return the value of <code>workingDirectoryName</code>.
	 */
	public String getWorkingDirectoryName() {
		return this.workingDirectoryName;
	}

	
	/**
	 * Set the value of attribute <code>workingDirectoryName</code>.
	 * @param workingDirectoryName
	 */
	public void setWorkingDirectoryName(String workingDirectoryName) {
		this.workingDirectoryName = workingDirectoryName;
	}
}
