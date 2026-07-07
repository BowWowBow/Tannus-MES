package com.example.demo.api.domain;

public enum Role {
    ADMIN("관리자"),
    PACKING("포장팀"),
    LOGISTICS("물류팀");

    private final String label;

    Role(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}