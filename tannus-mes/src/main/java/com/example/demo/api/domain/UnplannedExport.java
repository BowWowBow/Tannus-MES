package com.example.demo.api.domain;

public class UnplannedExport {

    private Long id;
    private Long exportOrderId;

    private String productType;
    private String modelName;
    private String color;
    private String hardness;

    // DB에는 qty 컬럼이 없지만, 기존 컨트롤러/폼 호환을 위해 필드만 유지
    private Integer qty;

    private Integer baseQty;
    private Integer boxCount;
    private Integer eachQty;
    private Integer totalQty;

    private String reason;
    private String status;

    // DB에는 request_user 컬럼이 없지만, 기존 LogisticsDashboardController의 setRequestUser 호출 호환용
    private String requestUser;

    // DB에는 approved_by / approved_at 컬럼이 없음. 화면 호환용으로만 유지
    private String approvedBy;
    private String approvedAt;

    private String createdAt;
    private String checkedAt;

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

    public String getApprovedAt() {
        return approvedAt;
    }

    public void setApprovedAt(String approvedAt) {
        this.approvedAt = approvedAt;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getCheckedAt() {
        return checkedAt;
    }

    public void setCheckedAt(String checkedAt) {
        this.checkedAt = checkedAt;
    }
}
