package com.example.demo.api.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class LoginController {

    @GetMapping("/login")
    public String loginForm(HttpSession session,
                            @RequestParam(value = "fromIntro", required = false) String fromIntro) {

        // 로그인 상태면 바로 대시보드
        if (session.getAttribute("loginUser") != null) {
            return "redirect:/dashboard";
        }

        // 🔥 intro를 거치지 않고 직접 접근하면 intro로 보냄
        if (fromIntro == null) {
            return "redirect:/";
        }

        return "login/login";
    }

    @PostMapping("/login")
    public String doLogin(@RequestParam String userId,
                          @RequestParam String password,
                          HttpSession session,
                          Model model) {

        // 관리자
        if ("admin".equals(userId) && "1234".equals(password)) {
            session.setAttribute("loginUser", "관리자");
            session.setAttribute("loginRole", "관리자");
            return "redirect:/dashboard";
        }

        // 물류팀
        if ("logi".equals(userId) && "1234".equals(password)) {
            session.setAttribute("loginUser", "물류팀");
            session.setAttribute("loginRole", "물류팀");
            return "redirect:/logistics/dashboard";
        }

        // 포장팀
        if ("pack".equals(userId) && "1234".equals(password)) {
            session.setAttribute("loginUser", "포장팀");
            session.setAttribute("loginRole", "포장팀");
            return "redirect:/packing/dashboard";
        }

        model.addAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
        model.addAttribute("userId", userId);
        return "login/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}