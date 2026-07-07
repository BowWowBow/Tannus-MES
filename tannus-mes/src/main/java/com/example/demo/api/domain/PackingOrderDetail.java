package com.example.demo.api.domain;

public class PackingOrderDetail {

    private Long id;
    private Long packingOrderId;

    private String productType;
    private String modelName;
    private String color;
    private String hardness;

    private Integer baseQty;
    private Integer boxCount;
    private Integer eachQty;
    private Integer totalQty;

    // 물류팀 입고용
    private String inboundStatus;
    private String inboundAt;

    // 포장 QR 스캔용
    private String packingScanStatus;
    private String packingScanAt;

    public PackingOrderDetail() {
    }

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

    public String getPackingScanStatus() {
        return packingScanStatus;
    }

    public void setPackingScanStatus(String packingScanStatus) {
        this.packingScanStatus = packingScanStatus;
    }

    public String getPackingScanAt() {
        return packingScanAt;
    }

    public void setPackingScanAt(String packingScanAt) {
        this.packingScanAt = packingScanAt;
    }
}