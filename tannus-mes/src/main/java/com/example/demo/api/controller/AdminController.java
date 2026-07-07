package com.example.demo.api.controller;

import com.example.demo.api.service.ExportOrderService;
import com.example.demo.api.service.PackingOrderService;
import com.example.demo.api.service.UnplannedPurchaseService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {

    private final PackingOrderService packingOrderService;
    private final ExportOrderService exportOrderService;
    private final UnplannedPurchaseService unplannedPurchaseService;

    public AdminController(PackingOrderService packingOrderService,
                           ExportOrderService exportOrderService,
                           UnplannedPurchaseService unplannedPurchaseService) {
        this.packingOrderService = packingOrderService;
        this.exportOrderService = exportOrderService;
        this.unplannedPurchaseService = unplannedPurchaseService;
    }

    private boolean isAdmin(HttpSession session) {
        return "관리자".equals(session.getAttribute("loginRole"));
    }

    @GetMapping("/admin/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/dashboard";
        }

        model.addAttribute("packingTotalCount", packingOrderService.countAll());
        model.addAttribute("exportTotalCount", exportOrderService.countAll());
        model.addAttribute("unplannedPendingCount", unplannedPurchaseService.findPendingList().size());
        model.addAttribute("loginUser", session.getAttribute("loginUser"));

        return "admin/dashboard";
    }

    @GetMapping("/admin/packing")
    public String packingForm(HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/dashboard";
        }
        return "admin/packing-order-form";
    }
}