package br.com.auster.vivo.billcheckout.listeners;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;

import br.com.auster.dware.manager.QueueProcessedListener;
import br.com.auster.vivo.billcheckout.hierarchy.HierarchyHelper;

public class CleanUpListener implements QueueProcessedListener  {

	private Logger log = Logger.getLogger(getClass());

	public void init(Element config) {
		// no configuration required
	}

	public void onQueueProcessed(String transactionId, int size) {
		log.info("Cleaning up account hierarchy.");
		HierarchyHelper.requestFinished();
	}
}
