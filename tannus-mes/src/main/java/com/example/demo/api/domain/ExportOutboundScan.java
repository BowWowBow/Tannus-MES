package com.example.demo.api.domain;

public class ExportOutboundScan {

    private Long id;

    // EXPORT / UNPLANNED_EXPORT
    private String qrType;

    // 수출지시번호
    private Long exportOrderId;

    // 정상수출: export_order_detail.id
    // 무발주수출: unplanned_export.id
    private Long detailId;

    // BOX / EACH / UNPLANNED
    private String unitType;

    // 박스1, 박스2, 낱개1, 무발주1
    private Integer unitNo;

    // 해당 QR 수량
    private Integer qty;

    // WAITING / DONE
    private String scanStatus;

    private String scannedAt;

    // 재고반영 여부 N / Y
    private String stockApplied;

    private String stockAppliedAt;

    private String createdAt;

    public ExportOutboundScan() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getQrType() {
        return qrType;
    }

    public void setQrType(String qrType) {
        this.qrType = qrType;
    }

    public Long getExportOrderId() {
        return exportOrderId;
    }

    public void setExportOrderId(Long exportOrderId) {
        this.exportOrderId = exportOrderId;
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

    public String getScannedAt() {
        return scannedAt;
    }

    public void setScannedAt(String scannedAt) {
        this.scannedAt = scannedAt;
    }

    public String getStockApplied() {
        return stockApplied;
    }

    public void setStockApplied(String stockApplied) {
        this.stockApplied = stockApplied;
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
}