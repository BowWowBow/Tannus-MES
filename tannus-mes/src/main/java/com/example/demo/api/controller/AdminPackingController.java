package com.example.demo.api.controller;

import com.example.demo.api.domain.PackingOrder;
import com.example.demo.api.domain.PackingOrderDetail;
import com.example.demo.api.service.PackingChangeRequestService;
import com.example.demo.api.service.PackingOrderService;
import com.example.demo.api.web.PackingOrderForm;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.example.demo.api.service.UnplannedPurchaseService;

import java.util.List;

@Controller
@RequestMapping("/admin/packing")
public class AdminPackingController {

    private final PackingOrderService packingOrderService;
    private final PackingChangeRequestService packingChangeRequestService;
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final UnplannedPurchaseService unplannedPurchaseService;

    public AdminPackingController(PackingOrderService packingOrderService,
                                  PackingChangeRequestService packingChangeRequestService,
                                  UnplannedPurchaseService unplannedPurchaseService) {
        this.packingOrderService = packingOrderService;
        this.packingChangeRequestService = packingChangeRequestService;
        this.unplannedPurchaseService = unplannedPurchaseService;
    }

    @GetMapping("/new")
    public String newPage(HttpSession session, Model model) {
        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        return "admin/packing-order-form";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute PackingOrderForm form,
                       HttpSession session) throws Exception {

        String loginUser = String.valueOf(session.getAttribute("loginUser"));

        List<PackingOrderDetail> detailList = objectMapper.readValue(
                form.getDetailJson(),
                new TypeReference<List<PackingOrderDetail>>() {}
        );

        PackingOrder order = new PackingOrder();
        order.setRequestDate(form.getRequestDate());
        order.setRequestedBy(loginUser);
        order.setTargetTeam("포장팀");
        order.setRemark(form.getRemark());
        order.setStatus("REQUESTED");
        order.setDetailList(detailList);

        packingOrderService.save(order);

        return "redirect:/admin/packing/list";
    }

    @GetMapping("/list")
    public String list(@RequestParam(required = false) String month,
                       Model model) {

        List<PackingOrder> orderList;

        if (month != null && !month.isBlank()) {
            orderList = packingOrderService.findByMonth(month);
        } else {
            orderList = packingOrderService.findAll();
        }

        for (PackingOrder order : orderList) {
            PackingOrder fullOrder = packingOrderService.findById(order.getId());

            if (fullOrder != null) {
                order.setDetailList(fullOrder.getDetailList());
            }
        }

        model.addAttribute("orderList", orderList);
        model.addAttribute("selectedMonth", month);
        model.addAttribute("monthList", packingOrderService.findOrderMonths());

        return "admin/packing-list";
    }

    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Long id, Model model) {
        model.addAttribute("order", packingOrderService.findById(id));
        model.addAttribute("unplannedList", unplannedPurchaseService.findByPackingOrderId(id));
        return "admin/packing-detail";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Long id,
                       @RequestParam(required = false) Long changeRequestId,
                       Model model) {

        PackingOrder order = packingOrderService.findById(id);

        model.addAttribute("order", order);
        model.addAttribute("changeRequestId", changeRequestId);

        if (changeRequestId != null) {
            model.addAttribute("changeRequest", packingChangeRequestService.findById(changeRequestId));
        }

        return "admin/packing-order-edit";
    }

    @PostMapping("/update")
    public String update(@ModelAttribute PackingOrderForm form,
                         @RequestParam(required = false) Long changeRequestId) throws Exception {

        List<PackingOrderDetail> detailList = objectMapper.readValue(
                form.getDetailJson(),
                new TypeReference<List<PackingOrderDetail>>() {}
        );

        PackingOrder order = packingOrderService.findById(form.getId());

        if (order == null) {
            return "redirect:/admin/packing/list";
        }

        if (!"REQUESTED".equals(order.getStatus())) {
            return "redirect:/admin/packing/detail/" + order.getId();
        }

        order.setRemark(form.getRemark());
        order.setDetailList(detailList);
        order.setStatus("REQUESTED");

        packingOrderService.update(order);

        if (changeRequestId != null) {
            packingChangeRequestService.approve(changeRequestId);
        }

        return "redirect:/admin/packing/detail/" + order.getId();
    }

    // 포장팀이 아직 포장을 시작하지 않은 지시만 취소 가능
    // REQUESTED = 포장대기 상태이므로 이 상태에서만 CANCELLED 처리한다.
    @PostMapping("/cancel/{id}")
    public String cancel(@PathVariable Long id,
                         @RequestParam(required = false) Long changeRequestId) {

        PackingOrder order = packingOrderService.findById(id);

        if (order == null) {
            return "redirect:/admin/packing/list";
        }

        if (!"REQUESTED".equals(order.getStatus())) {
            return "redirect:/admin/packing/detail/" + id;
        }

        packingOrderService.updateStatus(id, "CANCELLED");

        if (changeRequestId != null) {
            return "redirect:/admin/packing/change-request/detail/" + changeRequestId;
        }

        return "redirect:/admin/packing/list";
    }
}
