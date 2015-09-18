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
 * Created on 30/01/2007
 */
package br.com.auster.vivo.billcheckout.cache;

import java.util.List;

/**
 * @author mtengelm
 *
 */
public interface DataBarnIntraGroup {

	/***
	 * Gets all intra-groups subscriptions for a given account number.
	 * @param accNo
	 * @param cycleCode
	 * @param billDate
	 * @return
	 */
	
	public List getIntraGroupEntries(String queryName, Object[] parameters);
//	public List getIntraGroupEntries(String queryName, String accNo, String cycleCode, String billDate);
	
	/**
	 * If returns true, then both access numbers are in the same hierarchy
	 * Otherwise returns false.
	 * 
	 * @param accessNoOri
	 * @param accessNoDst
	 * @return
	 */
	public boolean isSameHierarchy(String queryName, Object[] parameters );
//	public boolean isSameHierarchy(String queryName, String acctNo, String accessNoDst );
	
	/***
	 * Returns a List of all accounts in the same hierarchy of the given access number
	 * @param accesNo
	 * @return
	 */
	public List getAllAccountsInHierarchy(String queryName, Object[] parameters);
//	public List getAllAccountsInHierarchy(String queryName, String accesNo);
}
