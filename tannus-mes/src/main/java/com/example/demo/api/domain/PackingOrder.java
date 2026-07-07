package com.example.demo.api.domain;

import java.util.List;

public class PackingOrder {

    private Long id;
    private String requestDate;
    private String requestedBy;
    private String targetTeam;
    private String status;
    private String remark;
    private String createdAt;

    // 추가
    private String completedAt;

    private List<PackingOrderDetail> detailList;

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

    public String getRequestedBy() {
        return requestedBy;
    }

    public void setRequestedBy(String requestedBy) {
        this.requestedBy = requestedBy;
    }

    public String getTargetTeam() {
        return targetTeam;
    }

    public void setTargetTeam(String targetTeam) {
        this.targetTeam = targetTeam;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    // 추가 getter/setter
    public String getCompletedAt() {
        return completedAt;
    }

    public void setCompletedAt(String completedAt) {
        this.completedAt = completedAt;
    }

    public List<PackingOrderDetail> getDetailList() {
        return detailList;
    }

    public void setDetailList(List<PackingOrderDetail> detailList) {
        this.detailList = detailList;
    }
}