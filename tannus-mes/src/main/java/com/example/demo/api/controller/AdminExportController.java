package com.example.demo.api.controller;

import com.example.demo.api.domain.ExportOrder;
import com.example.demo.api.domain.ExportOrderDetail;
import com.example.demo.api.service.ExportChangeRequestService;
import com.example.demo.api.service.ExportOrderService;
import com.example.demo.api.service.UnplannedExportService;
import com.example.demo.api.web.ExportOrderForm;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin/export")
public class AdminExportController {

    private final ExportOrderService exportOrderService;
    private final ExportChangeRequestService exportChangeRequestService;
    private final UnplannedExportService unplannedExportService;
    private final ObjectMapper objectMapper = new ObjectMapper();

    public AdminExportController(ExportOrderService exportOrderService,
                                 ExportChangeRequestService exportChangeRequestService,
                                 UnplannedExportService unplannedExportService) {
        this.exportOrderService = exportOrderService;
        this.exportChangeRequestService = exportChangeRequestService;
        this.unplannedExportService = unplannedExportService;
    }

    private boolean isNotAdmin(HttpSession session) {
        Object loginUser = session.getAttribute("loginUser");
        Object loginRole = session.getAttribute("loginRole");

        return loginUser == null
                || loginRole == null
                || !"관리자".equals(String.valueOf(loginRole));
    }

    @GetMapping("")
    public String newPage(HttpSession session) {

        if (isNotAdmin(session)) {
            return "redirect:/";
        }

        return "admin/export-order-form";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute ExportOrderForm form,
                       HttpSession session) throws Exception {

        if (isNotAdmin(session)) {
            return "redirect:/";
        }

        List<ExportOrderDetail> detailList = new ArrayList<>();

        if (form.getDetailJson() != null && !form.getDetailJson().isBlank()) {
            detailList = objectMapper.readValue(
                    form.getDetailJson(),
                    new TypeReference<List<ExportOrderDetail>>() {}
            );
        }

        ExportOrder order = new ExportOrder();
        order.setRequestDate(form.getRequestDate());
        order.setWorkerName(form.getWorkerName());
        order.setRemark(form.getRemark());
        order.setStatus("WAITING");
        order.setDetailList(detailList);

        exportOrderService.save(order);

        return "redirect:/admin/export/list";
    }

    @GetMapping("/list")
    public String list(@RequestParam(required = false) String month,
                       HttpSession session,
                       Model model) {

        if (isNotAdmin(session)) {
            return "redirect:/";
        }

        List<ExportOrder> orderList;

        if (month != null && !month.isBlank()) {
            orderList = exportOrderService.findByMonth(month);
        } else {
            orderList = exportOrderService.findAll();
        }

        for (ExportOrder order : orderList) {
            ExportOrder fullOrder = exportOrderService.findById(order.getId());

            if (fullOrder != null) {
                order.setDetailList(fullOrder.getDetailList());
            }
        }

        model.addAttribute("orderList", orderList);
        model.addAttribute("selectedMonth", month);
        model.addAttribute("monthList", exportOrderService.findOrderMonths());

        return "admin/export-list";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Long id,
                       @RequestParam(required = false) Long changeRequestId,
                       HttpSession session,
                       Model model) {

        if (isNotAdmin(session)) {
            return "redirect:/";
        }

        ExportOrder order = exportOrderService.findById(id);

        if (order == null) {
            return "redirect:/admin/export/list";
        }

        model.addAttribute("order", order);
        model.addAttribute("changeRequestId", changeRequestId);

        return "admin/export-order-edit";
    }

    @PostMapping("/update")
    public String update(@ModelAttribute ExportOrderForm form,
                         @RequestParam(required = false) Long changeRequestId,
                         HttpSession session) throws Exception {

        if (isNotAdmin(session)) {
            return "redirect:/";
        }

        List<ExportOrderDetail> detailList = new ArrayList<>();

        if (form.getDetailJson() != null && !form.getDetailJson().isBlank()) {
            detailList = objectMapper.readValue(
                    form.getDetailJson(),
                    new TypeReference<List<ExportOrderDetail>>() {}
            );
        }

        ExportOrder order = exportOrderService.findById(form.getId());

        if (order == null) {
            return "redirect:/admin/export/list";
        }

        order.setRemark(form.getRemark());
        order.setDetailList(detailList);
        order.setStatus("WAITING");

        exportOrderService.update(order);

        if (changeRequestId != null) {
            exportChangeRequestService.approve(changeRequestId);
        }

        return "redirect:/admin/export/detail/" + order.getId();
    }

    @PostMapping("/cancel/{id}")
    public String cancel(@PathVariable Long id,
                         HttpSession session) {

        if (isNotAdmin(session)) {
            return "redirect:/";
        }

        exportOrderService.cancelExportOrder(id);

        return "redirect:/admin/export/list";
    }

    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Long id,
                         HttpSession session,
                         Model model) {

        if (isNotAdmin(session)) {
            return "redirect:/";
        }

        ExportOrder order = exportOrderService.findById(id);

        if (order == null) {
            return "redirect:/admin/export/list";
        }

        model.addAttribute("order", order);
        model.addAttribute("unplannedExportList", unplannedExportService.findByExportOrderId(id));

        return "admin/export-detail";
    }
}