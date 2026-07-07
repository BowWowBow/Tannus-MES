package com.example.demo.api.domain;

import java.time.LocalDateTime;

public class InoutHistory {

    private Long id;
    private String itemName;
    private int quantity;
    private String unit;
    private String ioType;
    private String location;
    private String workerName;
    private LocalDateTime createdAt;
    private String detailJson;

    // 추가
    private Integer boxQty;
    private String packDate;
    private String scanRaw;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }

    public String getIoType() { return ioType; }
    public void setIoType(String ioType) { this.ioType = ioType; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getWorkerName() { return workerName; }
    public void setWorkerName(String workerName) { this.workerName = workerName; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public String getDetailJson() { return detailJson; }
    public void setDetailJson(String detailJson) { this.detailJson = detailJson; }

    public Integer getBoxQty() { return boxQty; }
    public void setBoxQty(Integer boxQty) { this.boxQty = boxQty; }

    public String getPackDate() { return packDate; }
    public void setPackDate(String packDate) { this.packDate = packDate; }

    public String getScanRaw() { return scanRaw; }
    public void setScanRaw(String scanRaw) { this.scanRaw = scanRaw; }
}