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
public interface DatabarnPromotions {

	/***
	 * Returns a List with all promotions that aplies to a subscription, given its caption
	 * 
	 * @param subscriptionId Subscription Id we want to query
	 * @param promoCaption Caption of the promotion
	 * @return A List with all promotions 
	 * 	or an empty list (No promotions to this subscription) 
	 *  or null (No promotions to this subscription)
	 */
	public List getAccessNumberPromotions(String queryName, Object[] parameters);
//	public List getAccessNumberPromotions(String queryName, String subscriptionId);	
	
	/***
	 * Returns a List with all promotions that aplies to an account, given its caption
	 * @param accountNo
	 * @param promoCaption
	 * @return
	 */
	public List getAccountPromotions(String queryName, Object[] parameters);
	//public List getAccountPromotions(String queryName, String accountNo);	
	
	public List getMatchingPromotionsBySubscriptionId(List promoList, String subid, String promocaption);

	
	public List getMatchingPromotionsByAccount(List promoList, String accno, String promocaption);
	
	
	/***
	 * Given a subscription Id and a mkting pgm Id returns a list with already used rewards.
	 * Caller of this method, please use with discretion, once it can return null or empty list.
	 * The reason for null return can be:
	 * 1-No rewards used.
	 * 2-The call does not apply to to the sbscription, meaning it is not enrolled in the mkting program.
	 * 
	 * The second case can be previously checked using other information sources.
	 * 
	 * @param subscriptionId
	 * @param mktingPgmId
	 * @return A List or (null or empty list, in which case not used rewards was found)
	 */
	public List getUsedRewardsBySubcription(String queryName, Object[] parameters);
//	public List getUsedRewardsBySubcription(String queryName, String subscriptionId, String mktingPgmId);	
	
	/***
	 * Given an account number and a mkting pgm Id returns a list with already used rewards.
	 * @see getUsedRewardsBySubcription(String subscriptionId, String mktingPgmId) for further comments
	 * 
	 * @param subscriptionId
	 * @param mktingPgmId
	 * @return
	 */	
	public List getUsedRewardsByAccount(String queryName, Object[] parameters);
//	public List getUsedRewardsByAccount(String queryName, String accountNo, String mktingPgmId);	
}
