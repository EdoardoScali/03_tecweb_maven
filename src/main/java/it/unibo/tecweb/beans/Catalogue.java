package it.unibo.tecweb.beans;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class Catalogue implements Serializable {

	private static final long serialVersionUID = 1L;

	private Map<Item, Integer> catalogue = new HashMap<Item, Integer>();

	
	public Set<Item> getItems() {
		return catalogue.keySet();
	}

	public Integer getQuantity(Item item) {
		return catalogue.getOrDefault(item, 0);
	}
	
	public synchronized void addItem(Item item, Integer quantity) {
		if(catalogue.containsKey(item)) {
			catalogue.put(item, catalogue.get(item) + quantity);
		}
		else {
			catalogue.put(item, quantity);
		}
	}
	
	public synchronized void addItems(Map<Item, Integer> items) {
		for(Item item: items.keySet()) {
			if(items.containsKey(item)) {
				catalogue.put(item, catalogue.get(item)+ items.get(item));
			}
			else {
				catalogue.put(item, items.get(item));
			}
		}
	}
	
	public synchronized Map<Item, Integer> removeItems(Map<Item, Integer> items){
		Map<Item, Integer> removedItems = new HashMap<Item, Integer>();
		for(Item item: items.keySet()) {
			if(catalogue.containsKey(item)) {
				Integer availableQuantity = catalogue.get(item);
				if(availableQuantity >= items.get(item)) {
					removedItems.put(item, items.get(item));
					catalogue.put(item, catalogue.get(item) - items.get(item));
					if( catalogue.get(item) == 0) catalogue.remove(item); 
				} 
				else {
					removedItems.put(item, catalogue.get(item));
					catalogue.remove(item); 
				}
			}
			else {
				removedItems.put(item, 0);
			}
		}
		return removedItems;
	}
	
	public void emptyItem(String id) {
		Item item = new Item();
		item.setId(id);
		emptyItem(item);
	}
	
	public synchronized void emptyItem(Item item) {
		catalogue.remove(item);
	}
	
	public synchronized void empty() {
		this.catalogue = new HashMap<Item, Integer>();
	}

}
