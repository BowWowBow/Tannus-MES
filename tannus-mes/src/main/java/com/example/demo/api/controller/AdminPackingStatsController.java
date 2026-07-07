package com.example.demo.api.controller;

import com.example.demo.api.service.ExportOrderService;
import com.example.demo.api.service.PackingOrderService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.time.LocalDate;

@Controller
public class AdminPackingStatsController {

    private final PackingOrderService packingOrderService;
    private final ExportOrderService exportOrderService;

    public AdminPackingStatsController(PackingOrderService packingOrderService,
                                       ExportOrderService exportOrderService) {
        this.packingOrderService = packingOrderService;
        this.exportOrderService = exportOrderService;
    }

    @GetMapping("/admin/stats/packing")
    public String packingStats(HttpSession session, Model model) {

        Object loginUser = session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/";
        }

        int year = LocalDate.now().getYear();

        model.addAttribute("loginUser", loginUser);
        model.addAttribute("year", year);

        model.addAttribute("yearRate", packingOrderService.getYearPackingRate(year));
        model.addAttribute("quarterRates", packingOrderService.getQuarterPackingRates(year));
        model.addAttribute("monthRates", packingOrderService.getMonthPackingRates(year));
        model.addAttribute("monthHasDataList", packingOrderService.getMonthHasDataList(year));
        model.addAttribute("weekRates", packingOrderService.getWeekPackingRates(year));

        return "admin/packing-stats";
    }

    @GetMapping("/admin/stats/export")
    public String exportStats(HttpSession session, Model model) {

        Object loginUser = session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/";
        }

        int year = LocalDate.now().getYear();

        model.addAttribute("loginUser", loginUser);
        model.addAttribute("year", year);

        model.addAttribute("yearRate", exportOrderService.getYearExportRate(year));
        model.addAttribute("quarterRates", exportOrderService.getQuarterExportRates(year));
        model.addAttribute("monthRates", exportOrderService.getMonthExportRates(year));
        model.addAttribute("monthHasDataList", exportOrderService.getMonthHasDataList(year));
        model.addAttribute("weekRates", exportOrderService.getWeekExportRates(year));

        return "admin/export-stats";
    }
}