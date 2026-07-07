package com.example.demo.api.domain;

public class LoginUser {

    private String userId;
    private String userName;
    private Role role;

    public LoginUser(String userId, String userName, Role role) {
        this.userId = userId;
        this.userName = userName;
        this.role = role;
    }

    public String getUserId() {
        return userId;
    }

    public String getUserName() {
        return userName;
    }

    public Role getRole() {
        return role;
    }

    public boolean isAdmin() {
        return role == Role.ADMIN;
    }

    public boolean isPacking() {
        return role == Role.PACKING;
    }

    public boolean isLogistics() {
        return role == Role.LOGISTICS;
    }
}