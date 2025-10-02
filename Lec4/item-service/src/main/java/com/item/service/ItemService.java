package com.item.service;

import java.util.List;

import com.item.model.Item;

public interface ItemService {
	
	Boolean addItem(Item item);
	Boolean updateItem(Item item);
	Boolean deleteItem(long id);
	List<Item> getAllItems();
	Item getItem(long id);

}
