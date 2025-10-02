package com.item.model;

import java.sql.Date;

public class ItemDetails {
    private int itemId;
    private String name;
	private double price;
	private int totalNumber;
    private String model;
    private String issuedBy;
    private Date expiryDate;

    public ItemDetails() {}

    public ItemDetails(int itemId, String model, String issuedBy, Date expiryDate) {
        this.itemId = itemId;
        this.model = model;
        this.issuedBy = issuedBy;
        this.expiryDate = expiryDate;
    }

    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }

    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }

    public String getIssuedBy() { return issuedBy; }
    public void setIssuedBy(String issuedBy) { this.issuedBy = issuedBy; }

    public Date getExpiryDate() { return expiryDate; }
    public void setExpiryDate(Date expiryDate) { this.expiryDate = expiryDate; }

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getTotalNumber() {
		return totalNumber;
	}

	public void setTotalNumber(int totalNumber) {
		this.totalNumber = totalNumber;
	}
}
