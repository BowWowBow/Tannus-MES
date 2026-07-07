package com.example.demo.api.controller;

import com.example.demo.api.domain.PackingChangeRequest;
import com.example.demo.api.domain.PackingOrder;
import com.example.demo.api.domain.UnplannedPurchase;
import com.example.demo.api.service.ItemService;
import com.example.demo.api.service.PackingChangeRequestService;
import com.example.demo.api.service.PackingOrderService;
import com.example.demo.api.service.PackingOutboundScanService;
import com.example.demo.api.service.UnplannedPurchaseService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
@RequestMapping("/packing")
public class PackingDashboardController {

    private final PackingOrderService packingOrderService;
    private final PackingChangeRequestService packingChangeRequestService;
    private final UnplannedPurchaseService unplannedPurchaseService;
    private final ItemService itemService;
    private final PackingOutboundScanService packingOutboundScanService;

    public PackingDashboardController(PackingOrderService packingOrderService,
                                      PackingChangeRequestService packingChangeRequestService,
                                      UnplannedPurchaseService unplannedPurchaseService,
                                      ItemService itemService,
                                      PackingOutboundScanService packingOutboundScanService) {
        this.packingOrderService = packingOrderService;
        this.packingChangeRequestService = packingChangeRequestService;
        this.unplannedPurchaseService = unplannedPurchaseService;
        this.itemService = itemService;
        this.packingOutboundScanService = packingOutboundScanService;
    }

    private boolean isNotPackingTeam(HttpSession session) {
        Object loginUser = session.getAttribute("loginUser");
        Object loginRole = session.getAttribute("loginRole");

        return loginUser == null
                || loginRole == null
                || !"포장팀".equals(String.valueOf(loginRole));
    }

    private void noCache(HttpServletResponse response) {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate, max-age=0");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, HttpServletResponse response, Model model) {
        noCache(response);

        if (isNotPackingTeam(session)) {
            return "redirect:/";
        }

        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("loginRole", session.getAttribute("loginRole"));
        model.addAttribute("packingTotalCount", packingOrderService.countAll());
        model.addAttribute("packingWaitingCount", packingOrderService.countWaiting());
        model.addAttribute("packingDoneCount", packingOrderService.countPackingDone());
        model.addAttribute("shippedCount", packingOrderService.countShipped());

        return "packing/dashboard";
    }

    @GetMapping("/list")
    public String list(@RequestParam(required = false) String month,
                       HttpSession session,
                       HttpServletResponse response,
                       Model model) {
        noCache(response);

        if (isNotPackingTeam(session)) {
            return "redirect:/";
        }

        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("loginRole", session.getAttribute("loginRole"));

        if (month != null && !month.isBlank()) {
            model.addAttribute("orderList", packingOrderService.findByMonth(month));
            model.addAttribute("selectedMonth", month);
        } else {
            model.addAttribute("orderList", packingOrderService.findAll());
            model.addAttribute("selectedMonth", "");
        }

        model.addAttribute("monthList", packingOrderService.findOrderMonths());
        model.addAttribute("pendingChangeOrderIds", packingChangeRequestService.findPendingOrderIds());

        return "packing/list";
    }

    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Long id,
                         HttpSession session,
                         HttpServletResponse response,
                         Model model,
                         @RequestParam(required = false) String duplicateRequest) {
        noCache(response);

        if (isNotPackingTeam(session)) {
            return "redirect:/";
        }

        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("loginRole", session.getAttribute("loginRole"));
        model.addAttribute("order", packingOrderService.findById(id));
        model.addAttribute("unplannedPackingList", unplannedPurchaseService.findByPackingOrderId(id));
        model.addAttribute("itemList", itemService.findAll());

        boolean pendingChange = packingChangeRequestService.findPendingOrderIds().contains(id);
        model.addAttribute("pendingChange", pendingChange);

        if ("true".equals(duplicateRequest)) {
            model.addAttribute("duplicateRequest", true);
        }

        return "packing/detail";
    }

    @GetMapping("/print/{id}")
    public String print(@PathVariable Long id,
                        HttpSession session,
                        HttpServletResponse response,
                        Model model) {
        noCache(response);

        if (isNotPackingTeam(session)) {
            return "redirect:/";
        }

        PackingOrder order = packingOrderService.findForPrint(id);

        if (order == null) {
            return "redirect:/packing/list";
        }

        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("loginRole", session.getAttribute("loginRole"));
        model.addAttribute("order", order);
        model.addAttribute("unplannedPackingList", unplannedPurchaseService.findByPackingOrderId(id));

        return "packing/print";
    }

    @PostMapping("/unplanned/save/{id}")
    public String saveUnplannedPacking(@PathVariable Long id,
                                       @ModelAttribute UnplannedPurchase purchase,
                                       HttpSession session) {
        if (isNotPackingTeam(session)) {
            return "redirect:/";
        }

        PackingOrder order = packingOrderService.findById(id);

        if (order == null) {
            return "redirect:/packing/list";
        }

        if (!"REQUESTED".equals(order.getStatus())) {
            return "redirect:/packing/detail/" + id;
        }

        purchase.setPackingOrderId(id);
        purchase.setRequestUser(String.valueOf(session.getAttribute("loginUser")));

        unplannedPurchaseService.save(purchase);

        return "redirect:/packing/detail/" + id;
    }

    @PostMapping("/unplanned/delete/{id}")
    @ResponseBody
    public String deleteUnplannedPacking(@PathVariable Long id,
                                         HttpSession session) {
        if (isNotPackingTeam(session)) {
            return "NO_AUTH";
        }

        unplannedPurchaseService.delete(id);

        return "OK";
    }

    @PostMapping("/ready/{id}")
    public String readyToShip(@PathVariable Long id, HttpSession session) {
        if (isNotPackingTeam(session)) {
            return "redirect:/";
        }

        packingOrderService.completePacking(id);

        return "redirect:/packing/detail/" + id;
    }

    @GetMapping("/scan/{id}")
    public String scan(@PathVariable Long id,
                       HttpSession session,
                       HttpServletResponse response,
                       Model model) {
        noCache(response);

        if (isNotPackingTeam(session)) {
            return "redirect:/";
        }

        PackingOrder order = packingOrderService.findById(id);

        if (order == null) {
            return "redirect:/packing/list";
        }

        if (!"REQUESTED".equals(order.getStatus())) {
            return "redirect:/packing/detail/" + id;
        }

        packingOrderService.createPackingOutboundScanUnits(id);

        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("loginRole", session.getAttribute("loginRole"));
        model.addAttribute("order", packingOrderService.findById(id));
        model.addAttribute("unplannedPackingList", unplannedPurchaseService.findByPackingOrderId(id));
        model.addAttribute("scanList", packingOutboundScanService.findByOrderId(id));

        return "packing/scan";
    }

    @PostMapping("/complete/{id}")
    public String complete(@PathVariable Long id,
                           @RequestParam(required = false) Long detailId,
                           @RequestParam(required = false) String scanType,
                           @RequestParam(required = false) Integer scanSeq,
                           HttpSession session) {
        if (isNotPackingTeam(session)) {
            return "redirect:/";
        }

        if (detailId == null || scanType == null || scanType.isBlank() || scanSeq == null) {
            return "redirect:/packing/scan/" + id;
        }

        boolean allDone = packingOrderService.completePackingOutboundScan(
                id,
                detailId,
                scanType,
                scanSeq
        );

        if (allDone) {
            return "redirect:/packing/detail/" + id;
        }

        return "redirect:/packing/scan/" + id;
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id,
                           HttpSession session,
                           HttpServletResponse response,
                           Model model) {
        noCache(response);

        if (isNotPackingTeam(session)) {
            return "redirect:/";
        }

        PackingOrder order = packingOrderService.findById(id);

        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("loginRole", session.getAttribute("loginRole"));
        model.addAttribute("order", order);

        return "packing/edit";
    }

    @PostMapping("/edit/{id}")
    public String edit(@PathVariable Long id,
                       PackingOrder order,
                       HttpSession session) {
        if (isNotPackingTeam(session)) {
            return "redirect:/";
        }

        order.setId(id);
        packingOrderService.updateOrder(order);

        return "redirect:/packing/detail/" + id;
    }

    @GetMapping("/change-request/{id}")
    public String changeRequestForm(@PathVariable Long id,
                                    HttpSession session,
                                    HttpServletResponse response,
                                    Model model) {
        noCache(response);

        if (isNotPackingTeam(session)) {
            return "redirect:/";
        }

        PackingOrder order = packingOrderService.findById(id);

        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("loginRole", session.getAttribute("loginRole"));
        model.addAttribute("order", order);

        return "packing/change-request";
    }

    @PostMapping("/change-request/{id}")
    public String saveChangeRequest(@PathVariable Long id,
                                    PackingChangeRequest request,
                                    HttpSession session) {
        if (isNotPackingTeam(session)) {
            return "redirect:/";
        }

        Object loginUser = session.getAttribute("loginUser");

        request.setPackingOrderId(id);
        request.setRequestUser(String.valueOf(loginUser));
        request.setStatus("WAITING");

        try {
            packingChangeRequestService.save(request);
            packingOrderService.updateStatus(id, "REQUESTED");
        } catch (IllegalStateException e) {
            return "redirect:/packing/detail/" + id + "?duplicateRequest=true";
        }

        return "redirect:/packing/list";
    }

    @PostMapping("/rollback/{id}")
    public String rollback(@PathVariable Long id, HttpSession session) {
        if (isNotPackingTeam(session)) {
            return "redirect:/";
        }

        PackingOrder order = packingOrderService.findForPrint(id);

        if ("SHIPPED".equals(order.getStatus())) {
            packingOrderService.updateStatus(id, "READY_TO_SHIP");
        } else if ("READY_TO_SHIP".equals(order.getStatus())) {
            packingOrderService.updateStatus(id, "REQUESTED");
        }

        return "redirect:/packing/detail/" + id;
    }

    @PostMapping("/ship/{id}")
    public String ship(@PathVariable Long id, HttpSession session) {

        if (isNotPackingTeam(session)) {
            return "redirect:/";
        }

        packingOrderService.completeShipping(id);

        return "redirect:/packing/list";
    }

    @PostMapping("/cancel-scan/{id}")
    public String cancelPackingScan(@PathVariable Long id,
                                    @RequestParam Long scanId,
                                    HttpSession session) {
        if (isNotPackingTeam(session)) {
            return "redirect:/";
        }

        packingOutboundScanService.cancelScan(scanId);

        return "redirect:/packing/scan/" + id;
    }

    @GetMapping("/report/{id}")
    public String report(@PathVariable Long id,
                         HttpSession session,
                         Model model) {

        Object loginUser = session.getAttribute("loginUser");
        Object loginRole = session.getAttribute("loginRole");

        if (loginUser == null || loginRole == null) {
            return "redirect:/";
        }

        PackingOrder order = packingOrderService.findById(id);

        model.addAttribute("order", order);
        model.addAttribute("unplannedPackingList",
                unplannedPurchaseService.findByPackingOrderId(id));

        return "packing/report";
    }

    @GetMapping("/work-order/{id}")
    public String packingWorkOrder(@PathVariable Long id,
                                   Model model) {

        PackingOrder order = packingOrderService.findById(id);

        if (order == null) {
            return "redirect:/packing/list";
        }

        model.addAttribute("order", order);
        model.addAttribute("unplannedList", unplannedPurchaseService.findByPackingOrderId(id));

        return "packing/packing-work-order";
    }
}