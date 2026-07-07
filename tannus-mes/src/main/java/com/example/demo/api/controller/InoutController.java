package com.example.demo.api.controller;

import com.example.demo.api.domain.InoutHistory;
import com.example.demo.api.service.InoutService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.format.DateTimeFormatter;

@Controller
@RequestMapping("/inout")
public class InoutController {

    private final InoutService inoutService;
    private final DateTimeFormatter createdAtFormatter =
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public InoutController(InoutService inoutService) {
        this.inoutService = inoutService;
    }

    @GetMapping("/list")
    public String list(HttpSession session, Model model) {
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }

        model.addAttribute("loginUser", loginUser);
        model.addAttribute("historyList", inoutService.findAll());
        return "inout/list";
    }

    @GetMapping("/in")
    public String inForm(HttpSession session, Model model) {
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }

        model.addAttribute("loginUser", loginUser);
        return "inout/in-form";
    }

    @PostMapping("/in")
    public String doIn(@RequestParam("detailJson") String detailJson,
                       @RequestParam(value = "remark", required = false) String remark,
                       @RequestParam(value = "workerName", required = false) String workerName,
                       HttpSession session) {

        Object loginUser = session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }

        int totalQty = 0;
        String[] parts = detailJson.split("\"qty\":");
        for (int i = 1; i < parts.length; i++) {
            String num = parts[i].split("[,}]")[0].trim();
            try {
                totalQty += Integer.parseInt(num);
            } catch (Exception ignored) {
            }
        }

        String itemName = "입고";
        int idx = detailJson.indexOf("\"displayName\":\"");
        if (idx > -1) {
            int start = idx + 15;
            int end = detailJson.indexOf("\"", start);
            if (end > start) {
                itemName = detailJson.substring(start, end) + " 외";
            }
        }

        inoutService.in(itemName, totalQty, detailJson);

        return "redirect:/inout/list";
    }

    @GetMapping("/out")
    public String outForm(HttpSession session, Model model) {
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }

        model.addAttribute("loginUser", loginUser);
        return "inout/out-form";
    }

    @PostMapping("/out")
    public String doOut(@RequestParam String itemName,
                        @RequestParam int quantity,
                        HttpSession session) {

        Object loginUser = session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }

        inoutService.out(itemName, quantity);
        return "redirect:/inout/list";
    }

    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Long id, HttpSession session, Model model) {
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }

        InoutHistory history = inoutService.findById(id);
        if (history == null) {
            return "redirect:/inout/list";
        }

        model.addAttribute("loginUser", loginUser);
        model.addAttribute("history", history);

        if (history.getCreatedAt() != null) {
            String createdAtStr = history.getCreatedAt().format(createdAtFormatter);
            model.addAttribute("createdAtStr", createdAtStr);
        }

        model.addAttribute("detailJson", history.getDetailJson());

        return "inout/detail";
    }
}