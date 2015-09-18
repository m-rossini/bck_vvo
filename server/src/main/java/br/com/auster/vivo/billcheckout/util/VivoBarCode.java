/*
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
 * Created on Oct 15, 2005
 */
package br.com.auster.vivo.billcheckout.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import br.com.auster.common.util.CommonsServicesBarCode;
import br.com.auster.om.invoice.BarCode;

/**
 * @author framos
 * @version $Id$
 */
public abstract class VivoBarCode {

    protected static final int DUEDATE_START_POSITION = 23;
    protected static final int DUEDATE_END_POSITION   = 29;

    protected static final int ACCOUNT_START_POSITION =  8;
    protected static final int ACCOUNT__END_POSITION  = 18;
    

	/**
	 * Validates if the bar code is correct. Checks for : <br>
	 * <ul> bar code correctness
	 * <ul> value must match invoice total amount
	 * <ul> segment id must be TELECOM
	 * <ul> account number must be in barcode custom field
	 * <ul> due date must match invoice due date
	 * <ul> alpha-numeric representation 
	 */
	public static boolean validateCustomField(BarCode _barcode, String _accountId, Date _dueDate, double _totalAmount) {
		
		if ((_accountId == null) || (_dueDate == null) || (_barcode == null)) {
			return false;
		}
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyMMdd");
		String dueDate = formatter.format(_dueDate);
		try {
			
			// validates the bar code 
			return   (_accountId.equals(CommonsServicesBarCode.getCustomField(_barcode.getOCRRightLine()).substring(ACCOUNT_START_POSITION, ACCOUNT__END_POSITION)) &&
					  dueDate.equals(CommonsServicesBarCode.getCustomField(_barcode.getOCRRightLine()).substring(DUEDATE_START_POSITION, DUEDATE_END_POSITION)) &&
					  ((CommonsServicesBarCode.getValueAsDouble(_barcode.getOCRRightLine()) - _totalAmount) < 0.01D));
			
		} catch (IllegalStateException ise) {
			// log as invalid barcode
		}
		return false;
	}
	
}
