package com.example.demo.api.controller;

import com.example.demo.api.domain.PackingChangeRequest;
import com.example.demo.api.domain.PackingOrder;
import com.example.demo.api.service.PackingChangeRequestService;
import com.example.demo.api.service.PackingOrderService;

import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/packing/change-request")
public class AdminPackingChangeRequestController {

    private final PackingChangeRequestService changeRequestService;
    private final PackingOrderService packingOrderService;

    public AdminPackingChangeRequestController(
            PackingChangeRequestService changeRequestService,
            PackingOrderService packingOrderService) {

        this.changeRequestService = changeRequestService;
        this.packingOrderService = packingOrderService;
    }

    private boolean isNotAdmin(HttpSession session) {

        Object loginUser = session.getAttribute("loginUser");
        Object loginRole = session.getAttribute("loginRole");

        return loginUser == null
                || loginRole == null
                || !"관리자".equals(String.valueOf(loginRole));
    }

    @GetMapping("/list")
    public String list(HttpSession session,
                       Model model) {

        if (isNotAdmin(session)) {
            return "redirect:/";
        }

        model.addAttribute(
                "requestList",
                changeRequestService.findAll()
        );

        model.addAttribute(
                "loginUser",
                session.getAttribute("loginUser")
        );

        model.addAttribute(
                "loginRole",
                session.getAttribute("loginRole")
        );

        return "admin/packing-change-request-list";
    }

    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Long id,
                         HttpSession session,
                         Model model) {

        if (isNotAdmin(session)) {
            return "redirect:/";
        }

        PackingChangeRequest request =
                changeRequestService.findById(id);

        PackingOrder order =
                packingOrderService.findById(
                        request.getPackingOrderId()
                );

        model.addAttribute("request", request);
        model.addAttribute("order", order);

        model.addAttribute(
                "loginUser",
                session.getAttribute("loginUser")
        );

        model.addAttribute(
                "loginRole",
                session.getAttribute("loginRole")
        );

        return "admin/packing-change-request-detail";
    }

    @PostMapping("/approve/{id}")
    public String approve(@PathVariable Long id,
                          HttpSession session) {

        if (isNotAdmin(session)) {
            return "redirect:/";
        }

        changeRequestService.approve(id);

        return "redirect:/admin/packing/change-request/detail/" + id;
    }

    @PostMapping("/reject/{id}")
    public String reject(@PathVariable Long id,
                         HttpSession session) {

        if (isNotAdmin(session)) {
            return "redirect:/";
        }

        changeRequestService.reject(id);

        return "redirect:/admin/packing/change-request/detail/" + id;
    }

    @PostMapping("/rollback/{id}")
    public String rollback(@PathVariable Long id,
                           HttpSession session) {

        if (isNotAdmin(session)) {
            return "redirect:/";
        }

        changeRequestService.rollback(id);

        return "redirect:/admin/packing/change-request/detail/" + id;
    }
}