package com.example.demo.api.controller;

import com.example.demo.api.domain.LoginUser;
import com.example.demo.api.domain.Role;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class InboundOrderController {

    @GetMapping("/order/inbound")
    public String inboundOrder(HttpSession session) {
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }

        if (loginUser.getRole() != Role.ADMIN) {
            return "redirect:/dashboard";
        }

        return "order/inbound";
    }
}