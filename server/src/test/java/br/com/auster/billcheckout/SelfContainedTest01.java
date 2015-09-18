package br.com.auster.billcheckout;

import java.io.FileReader;

import org.drools.RuleBase;
import org.drools.RuleBaseFactory;
import org.drools.StatefulSession;
import org.drools.compiler.PackageBuilder;
import org.drools.rule.Package;

import br.com.auster.billcheckout.om.Person;
import br.com.auster.billcheckout.om.PersonAddress;

public class SelfContainedTest01 {

	public SelfContainedTest01() {
		
	}
	
	public static void main(String[] args) throws Exception {
		SelfContainedTest01 test = new SelfContainedTest01();
		
		test.createAll();
	}
	
	public void createAll() throws Exception {
		RuleBase ruleBase = RuleBaseFactory.newRuleBase();		
		PackageBuilder builder = new PackageBuilder();
		builder.addPackageFromDrl(new FileReader("src/test/java/br/com/auster/billcheckout/om/person.drl"));
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
