package com.example.demo.api.controller;

import com.example.demo.api.domain.ExportChangeRequest;
import com.example.demo.api.domain.ExportOrder;
import com.example.demo.api.service.ExportChangeRequestService;
import com.example.demo.api.service.ExportOrderService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/export/change-request")
public class AdminExportChangeRequestController {

    private final ExportChangeRequestService changeRequestService;
    private final ExportOrderService exportOrderService;

    public AdminExportChangeRequestController(
            ExportChangeRequestService changeRequestService,
            ExportOrderService exportOrderService) {

        this.changeRequestService = changeRequestService;
        this.exportOrderService = exportOrderService;
    }

    private boolean isNotAdmin(HttpSession session) {
        Object loginUser = session.getAttribute("loginUser");
        Object loginRole = session.getAttribute("loginRole");

        return loginUser == null
                || loginRole == null
                || !"관리자".equals(String.valueOf(loginRole));
    }

    @GetMapping("/list")
    public String list(HttpSession session, Model model) {

        if (isNotAdmin(session)) {
            return "redirect:/";
        }

        model.addAttribute("requestList", changeRequestService.findAll());
        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("loginRole", session.getAttribute("loginRole"));

        return "admin/export-change-request-list";
    }

    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Long id,
                         HttpSession session,
                         Model model) {

        if (isNotAdmin(session)) {
            return "redirect:/";
        }

        ExportChangeRequest request = changeRequestService.findById(id);

        if (request == null) {
            return "redirect:/admin/export/change-request/list";
        }

        ExportOrder order = exportOrderService.findById(request.getExportOrderId());

        model.addAttribute("request", request);
        model.addAttribute("order", order);
        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("loginRole", session.getAttribute("loginRole"));

        return "admin/export-change-request-detail";
    }

    @PostMapping("/reject/{id}")
    public String reject(@PathVariable Long id,
                         HttpSession session) {

        if (isNotAdmin(session)) {
            return "redirect:/";
        }

        changeRequestService.reject(id);

        return "redirect:/admin/export/change-request/list";
    }

    @PostMapping("/rollback/{id}")
    public String rollback(@PathVariable Long id,
                           HttpSession session) {

        if (isNotAdmin(session)) {
            return "redirect:/";
        }

        changeRequestService.rollback(id);

        return "redirect:/admin/export/change-request/detail/" + id;
    }

    @PostMapping("/approve/{id}")
    public String approve(@PathVariable Long id,
                          HttpSession session) {

        if (isNotAdmin(session)) {
            return "redirect:/";
        }

        changeRequestService.approve(id);

        return "redirect:/admin/export/change-request/detail/" + id;
    }
}