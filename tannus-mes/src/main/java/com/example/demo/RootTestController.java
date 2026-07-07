package com.example.demo;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RootTestController {

    @GetMapping("/")
    public String root(HttpSession session) {
        if (session.getAttribute("loginUser") != null) {
            return "redirect:/dashboard";
        }
        return "intro";
    }

    @GetMapping("/root-test")
    public String rootTest(HttpSession session) {
        if (session.getAttribute("loginUser") != null) {
            return "redirect:/dashboard";
        }
        return "intro";
    }
}