package com.example.demo.api.controller;

import com.example.demo.api.domain.UnplannedExport;
import com.example.demo.api.domain.UnplannedPurchase;
import com.example.demo.api.service.UnplannedExportService;
import com.example.demo.api.service.UnplannedPurchaseService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@Controller
@RequestMapping("/admin/unplanned")
public class AdminUnplannedPurchaseController {

    private final UnplannedPurchaseService unplannedPurchaseService;
    private final UnplannedExportService unplannedExportService;

    public AdminUnplannedPurchaseController(UnplannedPurchaseService unplannedPurchaseService,
                                            UnplannedExportService unplannedExportService) {
        this.unplannedPurchaseService = unplannedPurchaseService;
        this.unplannedExportService = unplannedExportService;
    }

    private boolean isNotAdmin(HttpSession session) {
        Object loginUser = session.getAttribute("loginUser");
        Object loginRole = session.getAttribute("loginRole");

        return loginUser == null
                || loginRole == null
                || !"관리자".equals(String.valueOf(loginRole));
    }

    private String redirectList(String requestUser, String month) {
        StringBuilder url = new StringBuilder("redirect:/admin/unplanned/list");
        boolean hasParam = false;

        if (requestUser != null && !requestUser.trim().isEmpty()) {
            url.append("?requestUser=")
                    .append(URLEncoder.encode(requestUser, StandardCharsets.UTF_8));
            hasParam = true;
        }

        if (month != null && !month.trim().isEmpty()) {
            url.append(hasParam ? "&" : "?")
                    .append("month=")
                    .append(URLEncoder.encode(month, StandardCharsets.UTF_8));
        }

        return url.toString();
    }

    @GetMapping("/list")
    public String list(@RequestParam(value = "requestUser", required = false, defaultValue = "포장팀") String requestUser,
                       @RequestParam(value = "month", required = false) String month,
                       HttpSession session,
                       Model model) {

        if (isNotAdmin(session)) {
            return "redirect:/";
        }

        boolean exportMode = "물류팀".equals(requestUser);

        if (exportMode) {
            List<UnplannedExport> unplannedList;

            if (month != null && !month.trim().isEmpty()) {
                unplannedList = unplannedExportService.findByMonth(month);
                model.addAttribute("selectedMonth", month);
            } else {
                unplannedList = unplannedExportService.findAllList();
            }

            model.addAttribute("unplannedList", unplannedList);
            model.addAttribute("monthList", unplannedExportService.findMonths());
            model.addAttribute("mode", "EXPORT");
            model.addAttribute("pageTitle", "무발주 출고 승인관리");
            model.addAttribute("pageDescText", "물류팀 무발주 출고 요청 이력입니다.");
        } else {
            List<UnplannedPurchase> unplannedList;

            if (month != null && !month.trim().isEmpty()) {
                unplannedList = unplannedPurchaseService.findByMonth(month);
                model.addAttribute("selectedMonth", month);
            } else {
                unplannedList = unplannedPurchaseService.findAllList();
            }

            model.addAttribute("unplannedList", unplannedList);
            model.addAttribute("monthList", unplannedPurchaseService.findMonths());
            model.addAttribute("mode", "PURCHASE");
            model.addAttribute("pageTitle", "무발주 매입 승인관리");
            model.addAttribute("pageDescText", "포장팀 무발주 매입 요청 이력입니다.");
        }

        model.addAttribute("requestUser", requestUser);
        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("loginRole", session.getAttribute("loginRole"));

        return "admin/unplanned-list";
    }

    @PostMapping("/approve/{id}")
    public String approve(@PathVariable Long id,
                          @RequestParam(value = "requestUser", required = false, defaultValue = "포장팀") String requestUser,
                          @RequestParam(value = "month", required = false) String month,
                          HttpSession session) {

        if (isNotAdmin(session)) {
            return "redirect:/";
        }

        Object loginUser = session.getAttribute("loginUser");
        String approvedBy = loginUser == null ? "관리자" : String.valueOf(loginUser);

        if ("물류팀".equals(requestUser)) {
            UnplannedExport export = unplannedExportService.findById(id);

            if (export != null && "PENDING".equals(export.getStatus())) {
                unplannedExportService.approve(id, approvedBy);
            }

            return redirectList("물류팀", month);
        }

        UnplannedPurchase purchase = unplannedPurchaseService.findById(id);

        if (purchase != null && "PENDING".equals(purchase.getStatus())) {
            unplannedPurchaseService.approve(id, approvedBy);
        }

        return redirectList("포장팀", month);
    }

    @PostMapping("/reject/{id}")
    public String reject(@PathVariable Long id,
                         @RequestParam(value = "requestUser", required = false, defaultValue = "포장팀") String requestUser,
                         @RequestParam(value = "month", required = false) String month,
                         HttpSession session) {

        if (isNotAdmin(session)) {
            return "redirect:/";
        }

        Object loginUser = session.getAttribute("loginUser");
        String approvedBy = loginUser == null ? "관리자" : String.valueOf(loginUser);

        if ("물류팀".equals(requestUser)) {
            UnplannedExport export = unplannedExportService.findById(id);

            if (export != null && "PENDING".equals(export.getStatus())) {
                unplannedExportService.reject(id, approvedBy);
            }

            return redirectList("물류팀", month);
        }

        UnplannedPurchase purchase = unplannedPurchaseService.findById(id);

        if (purchase != null && "PENDING".equals(purchase.getStatus())) {
            unplannedPurchaseService.reject(id, approvedBy);
        }

        return redirectList("포장팀", month);
    }
}
