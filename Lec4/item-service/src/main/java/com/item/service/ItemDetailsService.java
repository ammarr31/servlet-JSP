package com.item.service;

import java.util.List;

import com.item.model.Item;
import com.item.model.ItemDetails;

public interface ItemDetailsService {
    boolean addItemDetails(ItemDetails details);
    boolean deleteItemDetails(int itemId);
    List<ItemDetails> getAllDetails();
}
