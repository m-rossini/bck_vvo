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
 * Created on 28/02/2007
 */
package br.com.auster.vivo.billcheckout.cache;

import java.util.List;
import java.util.Map;

/**
 * @author mtengelm
 *
 */
public interface DataBarnUsagePromotions {

	/***
	 * Returns a List of Promotion Types from external database.
	 * Never returns NULL. If no data is found on data base, returns an Empty List
	 * @return
	 */
	public List getPromotionTypes(String queryName);

	/***
	 * Returns a Map of Enrollments of all subscriptions of one given account.
	 * Never returns NULL. If no data is found on data base, returns an Empty Map
	 * @return
	 */	
	public Map getSubscriptionEnrollmentByAccount(String queryName, Object[] parameters);
//	public Map getSubscriptionEnrollmentByAccount(String queryName, String accountNumber);	
	
	/***
	 * Returns a Map of Ranges of a given Promotion (Or Marketing Program)
	 * Never returns NULL. If no data is found on data base, returns an Empty Map
	 * @return
	 */	
	public Map getPromotionRangesById(String queryName, Object[] parameters);
//	public Map getPromotionRangesById(String queryName, String promotionID);	
	
}
