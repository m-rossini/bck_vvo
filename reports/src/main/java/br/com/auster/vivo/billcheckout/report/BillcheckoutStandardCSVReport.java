/*
 * Copyright (c) 2004-2006 Auster Solutions do Brasil. All Rights Reserved.
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
 * Created on 19/10/2006
 */
package br.com.auster.vivo.billcheckout.report;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import br.com.auster.minerva.billcheckout.report.BillcheckoutRequest;
import br.com.auster.minerva.core.MinervaException;
import br.com.auster.minerva.core.ReportInitializationException;
import br.com.auster.minerva.csv.report.DatabaseReport;
import br.com.auster.minerva.csv.report.RowFlipCSVReport;
import br.com.auster.minerva.spi.ReportRequest;

/**
 * @author framos
 * @version $Id$
 */
public class BillcheckoutStandardCSVReport extends RowFlipCSVReport implements DatabaseReport {

	private ThreadLocal dateFormatter = new ThreadLocal() {
		
		protected synchronized Object initialValue() {
			return new SimpleDateFormat("yyyyMMdd-HHmmss");
		}
	};
	
	public String getFilenamePattern(ReportRequest _request) {
		Date now = Calendar.getInstance().getTime();
		String pattern = super.getFilenamePattern(_request);  
		if (_request instanceof BillcheckoutRequest) {
			BillcheckoutRequest request = (BillcheckoutRequest)_request;
			pattern = this.filePattern + "." + request.getRuleId() + "." + request.getTransactionId();
		}
		File  fileName = new File(pattern + "." + ((SimpleDateFormat)this.dateFormatter.get()).format(now));
		return fileName.getAbsolutePath();
	}

	public Object clone() {
		BillcheckoutStandardCSVReport cloned = new BillcheckoutStandardCSVReport();
		try {
			cloned.configure(this.configuration);
		} catch (ReportInitializationException e) {
			MinervaException ex = new MinervaException("Unable to clone report.");
			ex.initCause(e);
			throw ex;
		}
		return cloned;
	}
}
