package br.com.auster.vivo.billcheckout.caches;

import java.sql.ResultSet;
import java.sql.SQLException;

import br.com.auster.billcheckout.utils.GenericQueryExecutorCache;

/**
 * This class holds the cache that holds the city for each given zip code.
 * It is currently in use by Rule 69/82.
 * It should be configured as a global in order to initialize the query executors.
 * The cache is a singleton, so that, even though configure() method will be called
 * several times, there will only be one (static) instance of the cache.
 */
public class ZipCodeCache extends GenericQueryExecutorCache<String, String> {

	@Override
	protected Object[] buildQueryParameters(String key) {
		return new Object[] { key };
	}

	@Override
	protected String getQueryName() {
		return "R69_CityByZipCode";
	}

	@Override
	protected String retrieve(ResultSet rs) throws SQLException {
		if (rs.next()) {
			return rs.getString("cidade");
		} else {
			return null;
		}
	}
}
