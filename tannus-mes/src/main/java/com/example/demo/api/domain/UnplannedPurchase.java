package com.example.demo.api.domain;

public class UnplannedPurchase {

    private Long id;
    private Long packingOrderId;

    private String productType;
    private String modelName;
    private String color;
    private String hardness;

    private Integer qty;

    private Integer baseQty;
    private Integer boxCount;
    private Integer eachQty;
    private Integer totalQty;

    private String reason;

    private String status;

    private String inboundStatus;
    private String inboundAt;

    private String requestUser;
    private String approvedBy;

    private String createdAt;
    private String approvedAt;

    private String stockApplied;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getPackingOrderId() {
        return packingOrderId;
    }

    public void setPackingOrderId(Long packingOrderId) {
        this.packingOrderId = packingOrderId;
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

    public Integer getQty() {
        return qty;
    }

    public void setQty(Integer qty) {
        this.qty = qty;
    }

    public Integer getBaseQty() {
        return baseQty;
    }

    public void setBaseQty(Integer baseQty) {
        this.baseQty = baseQty;
    }

    public Integer getBoxCount() {
        return boxCount;
    }

    public void setBoxCount(Integer boxCount) {
        this.boxCount = boxCount;
    }

    public Integer getEachQty() {
        return eachQty;
    }

    public void setEachQty(Integer eachQty) {
        this.eachQty = eachQty;
    }

    public Integer getTotalQty() {
        return totalQty;
    }

    public void setTotalQty(Integer totalQty) {
        this.totalQty = totalQty;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getInboundStatus() {
        return inboundStatus;
    }

    public void setInboundStatus(String inboundStatus) {
        this.inboundStatus = inboundStatus;
    }

    public String getInboundAt() {
        return inboundAt;
    }

    public void setInboundAt(String inboundAt) {
        this.inboundAt = inboundAt;
    }

    public String getRequestUser() {
        return requestUser;
    }

    public void setRequestUser(String requestUser) {
        this.requestUser = requestUser;
    }

    public String getApprovedBy() {
        return approvedBy;
    }

    public void setApprovedBy(String approvedBy) {
        this.approvedBy = approvedBy;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getApprovedAt() {
        return approvedAt;
    }

    public void setApprovedAt(String approvedAt) {
        this.approvedAt = approvedAt;
    }

    public String getStockApplied() {
        return stockApplied;
    }

    public void setStockApplied(String stockApplied) {
        this.stockApplied = stockApplied;
    }

}
