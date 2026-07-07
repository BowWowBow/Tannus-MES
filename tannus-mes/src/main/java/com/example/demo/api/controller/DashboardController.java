package com.example.demo.api.controller;

import com.example.demo.api.service.ExportChangeRequestService;
import com.example.demo.api.service.ExportOrderService;
import com.example.demo.api.service.PackingChangeRequestService;
import com.example.demo.api.service.PackingOrderService;
import com.example.demo.api.service.UnplannedExportService;
import com.example.demo.api.service.UnplannedPurchaseService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.time.LocalDate;

@Controller
public class DashboardController {

    private final PackingOrderService packingOrderService;
    private final ExportOrderService exportOrderService;
    private final PackingChangeRequestService packingChangeRequestService;
    private final ExportChangeRequestService exportChangeRequestService;
    private final UnplannedPurchaseService unplannedPurchaseService;
    private final UnplannedExportService unplannedExportService;

    public DashboardController(PackingOrderService packingOrderService,
                               ExportOrderService exportOrderService,
                               PackingChangeRequestService packingChangeRequestService,
                               ExportChangeRequestService exportChangeRequestService,
                               UnplannedPurchaseService unplannedPurchaseService,
                               UnplannedExportService unplannedExportService) {
        this.packingOrderService = packingOrderService;
        this.exportOrderService = exportOrderService;
        this.packingChangeRequestService = packingChangeRequestService;
        this.exportChangeRequestService = exportChangeRequestService;
        this.unplannedPurchaseService = unplannedPurchaseService;
        this.unplannedExportService = unplannedExportService;
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session,
                            Model model,
                            HttpServletResponse response) {

        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        Object loginUser = session.getAttribute("loginUser");
        String loginRole = (String) session.getAttribute("loginRole");

        if (loginUser == null) {
            return "redirect:/";
        }

        model.addAttribute("loginUser", loginUser);
        model.addAttribute("loginRole", loginRole);

        if ("관리자".equals(loginRole)) {

            int year = LocalDate.now().getYear();

            model.addAttribute("packingTotalCount", packingOrderService.countAll());
            model.addAttribute("exportTotalCount", exportOrderService.countAll());

            model.addAttribute("packingChangeCount", packingChangeRequestService.countWaiting());
            model.addAttribute("exportChangeCount", exportChangeRequestService.countWaiting());

            model.addAttribute("unplannedPackingCount", unplannedPurchaseService.countByRequestUser("포장팀"));
            model.addAttribute("unplannedLogisticsCount", unplannedExportService.countPending());

            model.addAttribute("year", year);

            model.addAttribute("yearPackingRate", packingOrderService.getYearPackingRate(year));
            model.addAttribute("yearExportRate", exportOrderService.getYearExportRate(year));

            // 포장 납기 현황
            model.addAttribute("dMinus2Count", packingOrderService.countDMinus2());
            model.addAttribute("dMinus1Count", packingOrderService.countDMinus1());
            model.addAttribute("dDayCount", packingOrderService.countDDay());
            model.addAttribute("dPlus1Count", packingOrderService.countDPlus1());
            model.addAttribute("dPlus2Count", packingOrderService.countDPlus2Over());

            // 수출 납기 현황
            model.addAttribute("exportDMinus2Count", exportOrderService.countDMinus2());
            model.addAttribute("exportDMinus1Count", exportOrderService.countDMinus1());
            model.addAttribute("exportDDayCount", exportOrderService.countDDay());
            model.addAttribute("exportDPlus1Count", exportOrderService.countDPlus1());
            model.addAttribute("exportDPlus2Count", exportOrderService.countDPlus2Over());

            return "admin/dashboard";
        }

        if ("포장팀".equals(loginRole)) {
            return "redirect:/packing/dashboard";
        }

        if ("물류팀".equals(loginRole)) {
            return "logistics/dashboard";
        }

        return "redirect:/";
    }
}