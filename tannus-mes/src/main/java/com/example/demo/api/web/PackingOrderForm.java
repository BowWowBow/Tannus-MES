package com.example.demo.api.web;

public class PackingOrderForm {

    private Long id;
    private String requestDate;
    private String workerName;
    private String remark;
    private String detailJson;

    public PackingOrderForm() {
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

    public String getWorkerName() {
        return workerName;
    }

    public String getRemark() {
        return remark;
    }

    public String getDetailJson() {
        return detailJson;
    }

    public void setRequestDate(String requestDate) {
        this.requestDate = requestDate;
    }

    public void setWorkerName(String workerName) {
        this.workerName = workerName;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public void setDetailJson(String detailJson) {
        this.detailJson = detailJson;
    }
}