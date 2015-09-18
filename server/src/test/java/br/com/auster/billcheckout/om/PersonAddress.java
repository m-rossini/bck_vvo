package br.com.auster.billcheckout.om;

public class PersonAddress implements Comparable {

	private String streetName;
	
	public PersonAddress() {
		
	}

	public String getStreetName() {
		return streetName;
	}

	public void setStreetName(String streetName) {
		this.streetName = streetName;
	}

	public int compareTo(Object other) {
		if (!other.getClass().isAssignableFrom(this.getClass())) {
			throw  new ClassCastException("cannot compare " + other.getClass().getName() + " with " + this.getClass().getName());
		}
		
		//Hash Code here is just for example, meaning nothing
		return (int) (this.hashCode() - other.hashCode());
	}
	
	public boolean equals(Object other) {
		System.out.println("This Equals:" + this + ".Other Equals:" + other);
		if (other == null) {
			return false;
		}
		return ((this.compareTo(other) == 0));
	}
	
	public int hashCode() {
		int result = 17;
		result = result*37 + (int) super.hashCode();
		return result;
	}
	
	public String toString() {
		return "PA:" + this.streetName;
	}
}
