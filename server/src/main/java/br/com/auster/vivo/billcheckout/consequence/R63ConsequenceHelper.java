package br.com.auster.vivo.billcheckout.consequence;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;

import br.com.auster.billcheckout.consequence.telco.AccountDimension;
import br.com.auster.billcheckout.consequence.telco.CarrierDimension;
import br.com.auster.billcheckout.consequence.telco.CycleDimension;
import br.com.auster.billcheckout.consequence.telco.GeographicDimension;
import br.com.auster.billcheckout.consequence.telco.TelcoConsequence;
import br.com.auster.billcheckout.consequence.telco.TelcoConsequenceBuilder;
import br.com.auster.billcheckout.consequence.telco.TimeDimension;
import br.com.auster.om.invoice.Section;
import br.com.auster.om.invoice.ServiceDetail;
import br.com.auster.om.pricing.ServicePrice;
import br.com.auster.vivo.billcheckout.util.DimensionCache;

public class R63ConsequenceHelper {

	public static TelcoConsequence createCannotHaveConsequence(
			TelcoConsequenceBuilder consequenceBuilder, DimensionCache dimensionCache,
			String code, String description,
			Section subsInfoSection, Map<String, String> serviceNameMapping,
			String service1, String service2) {
//		GlobalForLog.log("DEBUG", "Produto " + service1 + " está ativo com produto " + service2 + " indevidamente (cannot have).");
		TelcoConsequence c = createConsequence(consequenceBuilder, dimensionCache, code, subsInfoSection);
		c.setDescription(description);
		c.addAttribute("Serviço X", service1);
		c.addAttribute("Serviço Y", service2);
		c.addAttribute("Caption X", serviceNameMapping.get(service1));
		c.addAttribute("Caption Y", serviceNameMapping.get(service2));
	    return c;
	}

	public static TelcoConsequence createMustHaveConsequence(
			TelcoConsequenceBuilder consequenceBuilder, DimensionCache dimensionCache,
			String code, String description,
			Section subsInfoSection, Map<String, String> serviceNameMapping,
			String offendingService, Set<String> missingServices) {
//		GlobalForLog.log("DEBUG", "Produto " + offendingService + " ativo sem os produtos de sua convivência (must have): " + missingServices);
		TelcoConsequence c = createConsequence(consequenceBuilder, dimensionCache, code, subsInfoSection);
		c.setDescription(description);
		c.addAttribute("Serviço Ativo", offendingService);
		c.addAttribute("Serviços Ausentes", format(missingServices));
		c.addAttribute("Caption Ativo", serviceNameMapping.get(offendingService));
		// nao eh possivel obter os captions dos servicos ausentes, por isso nao ha um atributo "CaptionsAusentes"
	    return c;
	}

	public static Map<String, String> mapServiceNames(Collection<ServiceDetail> services) throws ServicePriceMissingException {
		Map<String, String> map = new HashMap<String, String>();
		for (ServiceDetail service : services) {
			map.put(extractServiceName(service), service.getCaption());
		}
		return map;
	}

	private static String extractServiceName(ServiceDetail serviceDetail) throws ServicePriceMissingException {
		ServicePrice servicePrice = serviceDetail.getServicePrice();
		if (servicePrice == null) {
			throw new ServicePriceMissingException(serviceDetail.getCaption());
		}
		return servicePrice.getService().getExternalId();
	}

	private static String format(Set<String> missingServices) {
		return StringUtils.join(missingServices.iterator(), ",");
	}

	private static TelcoConsequence createConsequence(TelcoConsequenceBuilder consequenceBuilder, DimensionCache dimensionCache, String code, Section subsInfoSection) {
		consequenceBuilder.setRule(code, "Convivência dos produtos");
		consequenceBuilder.setAccount((AccountDimension) dimensionCache.getFromCache("account"));
		consequenceBuilder.setGeographics((GeographicDimension) dimensionCache.getFromCache("geo"));
		consequenceBuilder.setTime((TimeDimension) dimensionCache.getFromCache("time"));
		CycleDimension cycle = (CycleDimension) dimensionCache.getFromCache("cycle");
		consequenceBuilder.setCycle(cycle);
		consequenceBuilder.setCarrier((CarrierDimension) dimensionCache.getFromCache(subsInfoSection.getInvoice().getAccount().getCarrierCode()));
		TelcoConsequence consequence = (TelcoConsequence) consequenceBuilder.getConsequence();
		consequence.addAttribute("Ciclo", cycle.getCycleCode());
		consequence.addAttribute("Subscrição", subsInfoSection.getSubscriptionid());
		consequence.addAttribute("Terminal", subsInfoSection.getAccessNbr());
		return consequence;
	}
}
