package com.example.demo.api.domain;

import java.util.List;

public class ExportOrder {

    private Long id;
    private String requestDate;
    private String workerName;
    private String remark;
    private String status;
    private String stockApplied;
    private String createdAt;

    private List<ExportOrderDetail> detailList;

    public ExportOrder() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(String requestDate) {
        this.requestDate = requestDate;
    }

    public String getWorkerName() {
        return workerName;
    }

    public void setWorkerName(String workerName) {
        this.workerName = workerName;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStockApplied() {
        return stockApplied;
    }

    public void setStockApplied(String stockApplied) {
        this.stockApplied = stockApplied;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public List<ExportOrderDetail> getDetailList() {
        return detailList;
    }

    public void setDetailList(List<ExportOrderDetail> detailList) {
        this.detailList = detailList;
    }
}