package com.example.demo.api.domain;

public class PackingInboundScan {

    private Long id;
    private Long packingOrderId;
    private Long detailId;

    private String unitType; // BOX / EACH
    private Integer unitNo;
    private Integer qty;

    private String productType;
    private String modelName;
    private String color;
    private String hardness;

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

    private String scanStatus; // WAITING / DONE
    private String stockApplied; // N / Y

    private String scannedAt;
    private String stockAppliedAt;
    private String createdAt;

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

    public Long getDetailId() {
        return detailId;
    }

    public void setDetailId(Long detailId) {
        this.detailId = detailId;
    }

    public String getUnitType() {
        return unitType;
    }

    public void setUnitType(String unitType) {
        this.unitType = unitType;
    }

    public Integer getUnitNo() {
        return unitNo;
    }

    public void setUnitNo(Integer unitNo) {
        this.unitNo = unitNo;
    }

    public Integer getQty() {
        return qty;
    }

    public void setQty(Integer qty) {
        this.qty = qty;
    }

    public String getScanStatus() {
        return scanStatus;
    }

    public void setScanStatus(String scanStatus) {
        this.scanStatus = scanStatus;
    }

    public String getStockApplied() {
        return stockApplied;
    }

    public void setStockApplied(String stockApplied) {
        this.stockApplied = stockApplied;
    }

    public String getScannedAt() {
        return scannedAt;
    }

    public void setScannedAt(String scannedAt) {
        this.scannedAt = scannedAt;
    }

    public String getStockAppliedAt() {
        return stockAppliedAt;
    }

    public void setStockAppliedAt(String stockAppliedAt) {
        this.stockAppliedAt = stockAppliedAt;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    private String qrType;

    public String getQrType() {
        return qrType;
    }

    public void setQrType(String qrType) {
        this.qrType = qrType;
    }

}