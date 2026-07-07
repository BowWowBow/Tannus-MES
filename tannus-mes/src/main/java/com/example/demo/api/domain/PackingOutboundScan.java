package com.example.demo.api.domain;

import java.time.LocalDateTime;

public class PackingOutboundScan {

    private Long id;

    private Long packingOrderId;
    private Long detailId;

    // BOX / EACH
    private String scanType;

    // 박스번호 또는 낱개번호
    private Integer scanSeq;

    private Integer qty;

    // WAITING / DONE
    private String status;

    private LocalDateTime scannedAt;
    private LocalDateTime createdAt;

    public Long getId() {
        return id;
    }

    public Long getPackingOrderId() {
        return packingOrderId;
    }

    public Long getDetailId() {
        return detailId;
    }

    public String getScanType() {
        return scanType;
    }

    public Integer getScanSeq() {
        return scanSeq;
    }

    public Integer getQty() {
        return qty;
    }

    public String getStatus() {
        return status;
    }

    public LocalDateTime getScannedAt() {
        return scannedAt;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setPackingOrderId(Long packingOrderId) {
        this.packingOrderId = packingOrderId;
    }

    public void setDetailId(Long detailId) {
        this.detailId = detailId;
    }

    public void setScanType(String scanType) {
        this.scanType = scanType;
    }

    public void setScanSeq(Integer scanSeq) {
        this.scanSeq = scanSeq;
    }

    public void setQty(Integer qty) {
        this.qty = qty;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setScannedAt(LocalDateTime scannedAt) {
        this.scannedAt = scannedAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}