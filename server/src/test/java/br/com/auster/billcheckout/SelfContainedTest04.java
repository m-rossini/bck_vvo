package br.com.auster.billcheckout;

import java.io.FileReader;
import java.util.Properties;
import org.drools.RuleBase;
import org.drools.RuleBaseConfiguration;
import org.drools.RuleBaseFactory;
import org.drools.StatefulSession;
import org.drools.compiler.PackageBuilder;
import org.drools.rule.Package;
import br.com.auster.billcheckout.om.Person;
import br.com.auster.common.io.IOUtils;

public class SelfContainedTest04 {

	public SelfContainedTest04() {
		
	}
	
	public static void main(String[] args) throws Exception {
		SelfContainedTest04 test = new SelfContainedTest04();
		
		test.createAll();
	}
	
	public void createAll() throws Exception {
		Properties prop = new Properties();
		prop.load(IOUtils.openFileForRead("src/main/conf/asr1/rulebasebusiness.properties"));
		RuleBaseConfiguration cfg = new RuleBaseConfiguration(prop);
		RuleBase ruleBase = RuleBaseFactory.newRuleBase(cfg);		
		PackageBuilder builder = new PackageBuilder();
		builder.addPackageFromDrl(new FileReader("src/test/java/br/com/auster/billcheckout/om/forall.drl"));
		Package pack = builder.getPackage();
		ruleBase.addPackage(pack);
		
		StatefulSession session = ruleBase.newStatefulSession();
		
		Person p1 = new Person();
		p1.setFirstName("Person1");
		p1.setPersonAddress(null);		
		session.insert(p1);
	
		Person p2 = new Person();
		p1.setFirstName("Person1");
		p1.setPersonAddress(null);		
		session.insert(p2);		
		
//		Person p3 = new Person();
//		p1.setFirstName("Person2");
//		p1.setPersonAddress(null);		
//		session.insert(p3);	
		
		session.fireAllRules();
		session.dispose();
	}
}
