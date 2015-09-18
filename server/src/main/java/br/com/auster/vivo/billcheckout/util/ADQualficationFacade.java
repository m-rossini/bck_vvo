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
package br.com.auster.vivo.billcheckout.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.apache.commons.collections.map.MultiValueMap;
import org.apache.log4j.Logger;

import br.com.auster.billcheckout.param.SimpleObjectComparation;
import br.com.auster.common.io.IOUtils;
import br.com.auster.vivo.billcheckout.cache.SimpleFileFacade;

/**
 * @author mtengelm
 * 
 */
public class ADQualficationFacade extends SimpleFileFacade implements SimpleObjectComparation {
	private static Logger	log	= Logger.getLogger(ADQualficationFacade.class);
	private MultiValueMap	map;

	/**
	 * 
	 */
	public ADQualficationFacade() {
		super();
	}

	public void loadParms(String fName) throws IOException {
		InputStream stream = IOUtils.openFileForRead(fName);
		InputStreamReader isr = new InputStreamReader(stream);
		BufferedReader reader = new BufferedReader(isr);
		map = new MultiValueMap();
		String record;
		
		while ((record = reader.readLine()) != null) {
			String[] pieces = record.split(this.separator);
			for (int i = 0; i < pieces.length; i++) {
				for (int j = 0; j < pieces.length; j++) {
					map.put(pieces[i], pieces[j]);
				}
			}
		}
		log.info("Parameters loaded from file [" + fName + "]" + map);
	}

	public boolean isValid(Object from, Object to) {
		if (from == null || to == null) {
			return false;
		}
		return map.containsValue(from, to);
	}

	public boolean isFromValid(Object from) {
		if (from == null) {
			return false;
		}
		return map.containsKey(from);
	}
}
