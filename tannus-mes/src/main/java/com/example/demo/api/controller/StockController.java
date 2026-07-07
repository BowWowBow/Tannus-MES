package com.example.demo.api.controller;

import com.example.demo.api.service.ItemService;
import com.example.demo.api.service.StockHistoryService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/stock")
public class StockController {

    private final ItemService itemService;
    private final StockHistoryService stockHistoryService;

    public StockController(ItemService itemService,
                           StockHistoryService stockHistoryService) {
        this.itemService = itemService;
        this.stockHistoryService = stockHistoryService;
    }

    private boolean isStockViewRole(Object loginRole) {
        String role = String.valueOf(loginRole);

        return "ADMIN".equals(role)
                || "PACKING".equals(role)
                || "LOGISTICS".equals(role)
                || "관리자".equals(role)
                || "포장팀".equals(role)
                || "물류팀".equals(role);
    }

    private boolean isAdmin(Object loginRole) {
        String role = String.valueOf(loginRole);

        return "ADMIN".equals(role)
                || "관리자".equals(role);
    }

    @GetMapping("/list")
    public String list(@RequestParam(required = false) String productType,
                       HttpSession session,
                       Model model) {

        Object loginUser = session.getAttribute("loginUser");
        Object loginRole = session.getAttribute("loginRole");

        if (loginUser == null || loginRole == null) {
            return "redirect:/";
        }

        if (!isStockViewRole(loginRole)) {
            return "redirect:/";
        }

        model.addAttribute("loginUser", loginUser);
        model.addAttribute("loginRole", loginRole);
        model.addAttribute("selectedProductType", productType);

        if (productType != null && !productType.isBlank()) {
            model.addAttribute("itemList", itemService.findByProductType(productType));
        } else {
            model.addAttribute("itemList", itemService.findAll());
        }

        return "stock/list";
    }

    @GetMapping("/history")
    public String history(@RequestParam(required = false) String productType,
                          @RequestParam(required = false) String modelName,
                          @RequestParam(required = false) String color,
                          @RequestParam(required = false) String hardness,
                          HttpSession session,
                          Model model) {

        Object loginUser = session.getAttribute("loginUser");
        Object loginRole = session.getAttribute("loginRole");

        if (loginUser == null || loginRole == null) {
            return "redirect:/";
        }

        if (!isStockViewRole(loginRole)) {
            return "redirect:/";
        }

        model.addAttribute("loginUser", loginUser);
        model.addAttribute("loginRole", loginRole);

        model.addAttribute("itemList", itemService.findAll());

        model.addAttribute("selectedProductType", productType);
        model.addAttribute("selectedModelName", modelName);
        model.addAttribute("selectedColor", color);
        model.addAttribute("selectedHardness", hardness);

        if (modelName != null && !modelName.isBlank()) {
            model.addAttribute("historyList",
                    stockHistoryService.findByOption(
                            productType,
                            modelName,
                            color,
                            hardness
                    ));
        }

        return "stock/history";
    }

    @GetMapping("/adjust")
    public String adjust(@RequestParam(required = false) String productType,
                         @RequestParam(required = false) String modelName,
                         @RequestParam(required = false) String color,
                         @RequestParam(required = false) String hardness,
                         HttpSession session,
                         Model model) {

        Object loginUser = session.getAttribute("loginUser");
        Object loginRole = session.getAttribute("loginRole");

        if (loginUser == null || loginRole == null) {
            return "redirect:/";
        }

        if (!isAdmin(loginRole)) {
            return "redirect:/stock/list";
        }

        model.addAttribute("loginUser", loginUser);
        model.addAttribute("loginRole", loginRole);

        model.addAttribute("itemList", itemService.findAll());

        model.addAttribute("selectedProductType", productType);
        model.addAttribute("selectedModelName", modelName);
        model.addAttribute("selectedColor", color);
        model.addAttribute("selectedHardness", hardness);

        if (modelName != null && !modelName.isBlank()) {
            model.addAttribute("selectedItem",
                    itemService.findByOption(
                            productType,
                            modelName,
                            color,
                            hardness
                    ));
        }

        return "stock/adjust";
    }

    @PostMapping("/adjust")
    public String adjustStock(@RequestParam Long itemId,
                              @RequestParam int adjustQty,
                              @RequestParam String reason,
                              HttpSession session,
                              RedirectAttributes rttr) {

        Object loginUser = session.getAttribute("loginUser");
        Object loginRole = session.getAttribute("loginRole");

        if (loginUser == null || loginRole == null) {
            return "redirect:/";
        }

        if (!isAdmin(loginRole)) {
            return "redirect:/stock/list";
        }

        if (adjustQty == 0) {
            rttr.addFlashAttribute("errorMsg", "조정수량은 0으로 등록할 수 없습니다.");
            return "redirect:/stock/adjust";
        }

        if (reason == null || reason.isBlank()) {
            rttr.addFlashAttribute("errorMsg", "조정 사유를 입력해주세요.");
            return "redirect:/stock/adjust";
        }

        itemService.adjustStock(
                itemId,
                adjustQty,
                reason,
                String.valueOf(loginUser)
        );

        rttr.addFlashAttribute("successMsg", "재고 조정이 완료되었습니다.");

        return "redirect:/stock/adjust";
    }
}