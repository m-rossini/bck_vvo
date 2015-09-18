/*
 * Copyright (c) 2004-2006 Auster Solutions. All Rights Reserved.
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
 * Created on May 17, 2006
 */
package br.com.auster.billcheckout.om;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**

 */
public class NamedHashMap {
	
	private static final long serialVersionUID = 2558870508388331789L;
	
	private String name; 
	private HashMap attr = new HashMap();

	public NamedHashMap() {
	}
	
	public NamedHashMap(String name) {
		super();
		this.name = name;
	}

//	public NamedHashMap(String name, int initialCapacity) {
//		super(initialCapacity);
//		this.name = name;
//	}
//
//	public NamedHashMap(String name, Map m) {
//		super(m);
//		this.name = name;
//	}
//
//	public NamedHashMap(String name, int initialCapacity, float loadFactor) {
//		super(initialCapacity, loadFactor);
//		this.name = name;
//	}
	
	public String getName() {
		return this.name;
	}

	public boolean containsKey(Object arg0) {
		return attr.containsKey(arg0);
	}

	public boolean containsValue(Object arg0) {
		return attr.containsValue(arg0);
	}

	public Set entrySet() {
		return attr.entrySet();
	}

	public Object get(Object arg0) {
		return attr.get(arg0);
	}

	public boolean isEmpty() {
		return attr.isEmpty();
	}

	public Set keySet() {
		return attr.keySet();
	}

	public Object put(Object arg0, Object arg1) {
		return attr.put(arg0, arg1);
	}

	public void putAll(Map arg0) {
		attr.putAll(arg0);
	}

	public Object remove(Object arg0) {
		return attr.remove(arg0);
	}

	public int size() {
		return attr.size();
	}

	public Collection values() {
		return attr.values();
	}

}
