package it.unibo.tecweb.beans;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class Cart implements Serializable {

	private static final long serialVersionUID = 1L;

	private Map<Item,Integer> items = new HashMap<Item,Integer>();

	public  Map<Item,Integer> getCartItems(){
		return new HashMap<>(items);
	}
	
	public Set<Item> getItems() {
		return items.keySet();
	}

	public int getQuantity(Item item) {
		return items.get(item);
	}

	public void put(Item item, int quantity) {
		items.put(item, quantity);
	}
	
	public void empty() {
		this.items = new HashMap<Item,Integer>();
	}

	public Double getTotal() {
		double total = 0;
		for ( Item item : getItems() ) {
			total += item.getPrice() * getQuantity(item);
		}
		return total;
	}

}
