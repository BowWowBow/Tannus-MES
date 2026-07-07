package com.example.demo.api.service;

import com.example.demo.api.domain.LoginUser;
import com.example.demo.api.domain.Role;
import org.springframework.stereotype.Service;

@Service
public class LoginService {

    public LoginUser login(String userId, String password) {

        if ("admin".equals(userId) && "1234".equals(password)) {
            return new LoginUser("admin", "총관리자", Role.ADMIN);
        }

        if ("packing".equals(userId) && "1234".equals(password)) {
            return new LoginUser("packing", "포장팀", Role.PACKING);
        }

        if ("warehouse".equals(userId) && "1234".equals(password)) {
            return new LoginUser("warehouse", "물류팀", Role.LOGISTICS);
        }

        return null;
    }
}