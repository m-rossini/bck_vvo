package br.com.auster.billcheckout.om;

public class Person {

	private PersonAddress personAddress;	
	private String firstName;
	
	public Person() {
		
	}

	public PersonAddress getPersonAddress() {
		return personAddress;
	}

	public void setPersonAddress(PersonAddress personAddress) {
		this.personAddress = personAddress;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	
	public String toString() {
		return this.firstName;
	}
}
