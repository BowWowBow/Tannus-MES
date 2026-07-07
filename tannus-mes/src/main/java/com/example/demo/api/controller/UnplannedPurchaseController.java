package com.example.demo.api.controller;

import com.example.demo.api.domain.UnplannedPurchase;
import com.example.demo.api.service.UnplannedPurchaseService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/logistics/unplanned")
public class UnplannedPurchaseController {

    private final UnplannedPurchaseService unplannedPurchaseService;

    public UnplannedPurchaseController(UnplannedPurchaseService unplannedPurchaseService) {
        this.unplannedPurchaseService = unplannedPurchaseService;
    }

    @PostMapping("/save")
    public String save(@ModelAttribute UnplannedPurchase purchase,
                       HttpSession session) {

        purchase.setRequestUser("포장팀");

        if (purchase.getStatus() == null || purchase.getStatus().isBlank()) {
            purchase.setStatus("PENDING");
        }

        if (purchase.getInboundStatus() == null || purchase.getInboundStatus().isBlank()) {
            purchase.setInboundStatus("WAITING");
        }

        unplannedPurchaseService.save(purchase);

        return "redirect:/logistics/detail/" + purchase.getPackingOrderId();
    }
}