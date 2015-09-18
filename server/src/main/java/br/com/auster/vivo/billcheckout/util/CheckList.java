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
 * Created on 16/10/2006
 */
package br.com.auster.vivo.billcheckout.util;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
//TODO Criar metodo para gerar Consequence Attributes a partir dos atributos
//TODO Criar metodo para gerar Consequence Completa.
//TODO Ver regra RT_FU_BucketCheck1 (rating-checking) para os metodos acima.
public class CheckList {
	public static final String CHECK_NAME = "Nome";
	public static final String PLAN_NAME = "Planoserviço";
	
	protected Map attributes = new HashMap();
	
	/**
   * 
   */
	public CheckList() {
    super();
  }

	public void putAttribute(String key, Object value) {
		attributes.put(key, value);
	}
	
	public Object getAttribute(String key) {
		return attributes.get(key);
	}
	
	public Map getAttributes() {
		return Collections.unmodifiableMap(attributes);
	}
	
	public String toString() {
		return attributes.toString();
	}
}