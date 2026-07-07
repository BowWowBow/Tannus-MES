package com.example.demo.api.domain;

public class Item {

    private Long id;
    private String productType;
    private String modelName;
    private String color;
    private String hardness;

    private int baseQty;
    private int currentQty;

    private String location;
    private String lastInDate;
    private String lastOutDate;
    private String createdAt;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getProductType() {
        return productType;
    }

    public void setProductType(String productType) {
        this.productType = productType;
    }

    public String getModelName() {
        return modelName;
    }

    public void setModelName(String modelName) {
        this.modelName = modelName;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getHardness() {
        return hardness;
    }

    public void setHardness(String hardness) {
        this.hardness = hardness;
    }

    public int getBaseQty() {
        return baseQty;
    }

    public void setBaseQty(int baseQty) {
        this.baseQty = baseQty;
    }

    public int getCurrentQty() {
        return currentQty;
    }

    public void setCurrentQty(int currentQty) {
        this.currentQty = currentQty;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getLastInDate() {
        return lastInDate;
    }

    public void setLastInDate(String lastInDate) {
        this.lastInDate = lastInDate;
    }

    public String getLastOutDate() {
        return lastOutDate;
    }

    public void setLastOutDate(String lastOutDate) {
        this.lastOutDate = lastOutDate;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
}