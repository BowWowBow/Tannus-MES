package com.example.demo.api.domain;

public class ExportOrderDetail {

    private Long id;
    private Long exportOrderId;

    private String type;
    private String model;
    private String color;
    private String hardness;

    private Integer baseQty;
    private Integer boxCount;
    private Integer eachQty;
    private Integer totalQty;

    private String displayName;
    private String createdAt;

    private String outboundStatus;
    private String outboundAt;

    public ExportOrderDetail() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getExportOrderId() {
        return exportOrderId;
    }

    public void setExportOrderId(Long exportOrderId) {
        this.exportOrderId = exportOrderId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
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

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getOutboundStatus() {
        return outboundStatus;
    }

    public void setOutboundStatus(String outboundStatus) {
        this.outboundStatus = outboundStatus;
    }

    public String getOutboundAt() {
        return outboundAt;
    }

    public void setOutboundAt(String outboundAt) {
        this.outboundAt = outboundAt;
    }
}