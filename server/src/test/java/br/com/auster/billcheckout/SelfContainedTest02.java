package br.com.auster.billcheckout;

import java.io.FileReader;
import java.util.Properties;
import org.drools.RuleBase;
import org.drools.RuleBaseConfiguration;
import org.drools.RuleBaseFactory;
import org.drools.StatefulSession;
import org.drools.compiler.PackageBuilder;
import org.drools.rule.Package;
import br.com.auster.common.io.IOUtils;

public class SelfContainedTest02 {

	public SelfContainedTest02() {
		
	}
	
	public static void main(String[] args) throws Exception {
		SelfContainedTest02 test = new SelfContainedTest02();
		
		test.createAll();
	}
	
	public void createAll() throws Exception {
		Properties prop = new Properties();
		prop.load(IOUtils.openFileForRead("src/main/conf/rulebasebusiness.properties"));
		RuleBaseConfiguration cfg = new RuleBaseConfiguration(prop);
		RuleBase ruleBase = RuleBaseFactory.newRuleBase(cfg);		
		PackageBuilder builder = new PackageBuilder();
		builder.addPackageFromDrl(new FileReader("src/test/java/br/com/auster/billcheckout/om/mapas.drl"));
		Package pack = builder.getPackage();
		ruleBase.addPackage(pack);
		
		StatefulSession session = ruleBase.newStatefulSession();
		
//		Person p1 = new Person();
//		p1.setFirstName("Person1");
//		p1.setPersonAddress(null);		
//		session.insert(p1);
//		
//		Person p2 = new Person();
//		p2.setFirstName("Person2");
//		PersonAddress p2a = new PersonAddress();
//		p2a.setStreetName("Street A");
//		p2.setPersonAddress(p2a);
//		session.insert(p2);
//		session.insert(p2a);
		
		session.fireAllRules();
		session.dispose();
	}
}
