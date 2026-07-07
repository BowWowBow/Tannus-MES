package com.example.demo.api.domain;

public class StockHistory {

    private Long id;

    private String historyType;

    private String productType;
    private String modelName;
    private String color;
    private String hardness;

    private Integer beforeQty;
    private Integer changeQty;
    private Integer afterQty;

    private String createdBy;
    private String memo;

    private String createdAt;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getHistoryType() {
        return historyType;
    }

    public void setHistoryType(String historyType) {
        this.historyType = historyType;
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

    public Integer getBeforeQty() {
        return beforeQty;
    }

    public void setBeforeQty(Integer beforeQty) {
        this.beforeQty = beforeQty;
    }

    public Integer getChangeQty() {
        return changeQty;
    }

    public void setChangeQty(Integer changeQty) {
        this.changeQty = changeQty;
    }

    public Integer getAfterQty() {
        return afterQty;
    }

    public void setAfterQty(Integer afterQty) {
        this.afterQty = afterQty;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
}