package br.com.auster.vivo.billcheckout.consequence;

/**
 * Class used by R63 in order to indicate that the ServicePrice
 * has not been loaded into a given ServiceDetail.
 *
 * @author Luciano Morozowski Junior
 * @version $Id$
 * @since JDK1.4
 */
public class ServicePriceMissingException extends Exception {

	private String misconfiguredService;

	public ServicePriceMissingException(String serviceCaption) {
		super("Servico " + serviceCaption + " nao possui ServiceDetail!");
		this.misconfiguredService = serviceCaption;
	}

	public ServicePriceMissingException(String serviceCaption, Throwable cause) {
		super("Servico " + serviceCaption + " nao possui ServiceDetail!", cause);
		this.misconfiguredService = serviceCaption;
	}

	public String getMisconfiguredService() {
		return this.misconfiguredService;
	}
}
