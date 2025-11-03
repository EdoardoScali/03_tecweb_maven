package it.unibo.tecweb.beans;

import java.io.Serializable;

public class Item implements Serializable {

	private static final long serialVersionUID = 1L;

	String id;
	double price;
	
	// --- constructor ----------
	
	public Item() {
	}

	// --- getters and setters --------------
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}	
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}

	// --- utilities ----------------------------
	
	@Override
	public boolean equals(Object o) {
		if ( ! ( o instanceof Item ) ) return false;
		Item i = (Item)o;
		return i.getId().equals(this.id);
	}
	
	@Override
	public int hashCode() {
		return this.id.hashCode();
	}
}
