package br.com.auster.vivo.billcheckout.filter;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.naming.NamingException;

import org.apache.log4j.Logger;
import org.w3c.dom.Element;

import br.com.auster.common.log.LogFactory;
import br.com.auster.common.sql.SQLConnectionManager;
import br.com.auster.common.stats.ProcessingStats;
import br.com.auster.common.stats.StatsMapping;
import br.com.auster.common.xml.DOMUtils;
import br.com.auster.dware.graph.ConnectException;
import br.com.auster.dware.graph.DefaultFilter;
import br.com.auster.dware.graph.FilterException;
import br.com.auster.dware.graph.ObjectProcessor;
import br.com.auster.dware.graph.Request;
import br.com.auster.productreport.report.ProductReport;
import br.com.auster.productreport.util.ProductReportingException;

/**
 * <p>
 * <b>Title:</b> ProductDataReportFilter
 * </p>
 * <p>
 * <b>Description:</b> Product report data saver filter. This filter collects
 * information from the Object Model and feed the report´s database tables.
 * </p>
 * <p>
 * <b>Copyright:</b> Copyright (c) 2008
 * </p>
 * <p>
 * <b>Company:</b> Auster Solutions
 * </p>
 * 
 * @author dcunha
 * @version $Id: ProductDataReportFilter.java 412 2008-04-20 09:57:01Z dcunha $
 */
public class ProductDataReportFilter extends DefaultFilter implements
		ObjectProcessor {
	private static final Logger log = LogFactory
			.getLogger(ProductDataReportFilter.class);
	private static final String INVOICE_OM = "invoice-om";
	public static final String DATABASE_CONFIG = "database";
	public static final String DATABASE_CONFIG_POOL = "pool-name";
	private Connection connection;
	private SQLConnectionManager sqlMan;
	private ObjectProcessor objProcessor;
	private ProductReport productReport;

	public ProductDataReportFilter(String name) {
		super(name);
	}

	/**
	 * @inheritDoc
	 */
	public void prepare(Request request) throws FilterException {
	}

	/**
	 * @see br.com.auster.dware.graph.DefaultFilter#configure(org.w3c.dom.Element)
	 */
	public void configure(Element configuration) throws FilterException {
		try {
			Element dbElement = DOMUtils.getElement(configuration,
					DATABASE_CONFIG, true);
			String poolName = DOMUtils.getAttribute(dbElement,
					DATABASE_CONFIG_POOL, true);

			if ((poolName == null) || (poolName.trim().length() == 0))
				throw new RuntimeException("pool-name was not informed.");

			sqlMan = SQLConnectionManager.getInstance(poolName);			
		} catch (NamingException e) {
			log.error(e.getMessage());
			throw new FilterException(e);
		}
	}

	public void processElement(Object map) throws FilterException {
		try {
			List accountList;
			Map dataMap = (Map) map;
			Object invoiceOm = dataMap.get(INVOICE_OM);
			this.connection = sqlMan.getConnection();
			this.connection.setAutoCommit(true);
			this.productReport = new ProductReport(this.connection);

			if (invoiceOm == null)
				throw new FilterException("Error reading om Data, invoice "
						+ "OM account list is null.");

			if (invoiceOm instanceof List) {
				accountList = (List) invoiceOm;
				this.productReport.createReport(accountList);
				log.debug("ProductReport sucessfully created.");
			} else
				throw new FilterException("Error reading om Data, "
						+ "invoice OM is not an Account List.");
			
			this.connection.commit();
			this.connection.close();
			StatsMapping stats = ProcessingStats.starting(this.objProcessor.getClass(), "processElement()");
			try {
				this.objProcessor.processElement(dataMap);
			} finally {
				stats.finished();
			}
		} catch (Exception e) {
			log.error(e.getMessage());
			throw new FilterException("Error retrieving data", e);
		}
	}

	/**
	 * @inheritDoc
	 */
	public Object getInput(String filterName) throws ConnectException,
			UnsupportedOperationException {
		return this;
	}

	/**
	 * @inheritDoc
	 * 
	 * @param _filterName
	 * @param _output
	 * @return
	 * @throws ConnectException
	 * @throws UnsupportedOperationException
	 */
	public Object getOutput(String _filterName, Object _output)
			throws ConnectException, UnsupportedOperationException {
		throw new UnsupportedOperationException();
	}

	/**
	 * Sets the Output for this filter.
	 */
	public void setOutput(String sourceName, Object objProcessor) {
		this.objProcessor = (ObjectProcessor) objProcessor;
	}
}
