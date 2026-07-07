package com.example.demo.api.controller;

import com.example.demo.api.domain.Item;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import com.example.demo.api.service.ItemService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/item")
public class AdminItemController {

    private final ItemService itemService;

    public AdminItemController(ItemService itemService) {
        this.itemService = itemService;
    }

    @GetMapping("/new")
    public String newForm(HttpSession session) {

        Object loginUser = session.getAttribute("loginUser");
        String loginRole = (String) session.getAttribute("loginRole");

        if (loginUser == null) {
            return "redirect:/";
        }

        if (!"관리자".equals(loginRole)) {
            return "redirect:/dashboard";
        }

        return "admin/item-new";
    }

    @PostMapping("/new")
    public String save(Item item,
                       HttpSession session,
                       RedirectAttributes redirectAttributes) {

        Object loginUser = session.getAttribute("loginUser");
        String loginRole = (String) session.getAttribute("loginRole");

        if (loginUser == null) {
            return "redirect:/";
        }

        if (!"관리자".equals(loginRole)) {
            return "redirect:/dashboard";
        }

        item.setModelName(item.getModelName().trim());

        if (item.getBaseQty() <= 0) {
            redirectAttributes.addFlashAttribute("error", "기본수량은 1 이상 입력해야 합니다.");
            return "redirect:/admin/item/new";
        }

        Item existItem = itemService.findByOption(
                item.getProductType(),
                item.getModelName(),
                item.getColor(),
                item.getHardness()
        );

        if (existItem != null) {
            redirectAttributes.addFlashAttribute(
                    "error",
                    "이미 등록된 상품입니다. 같은 상품종류 / 모델 / 색상 / 경도는 중복 등록할 수 없습니다."
            );
            return "redirect:/admin/item/new";
        }

        itemService.saveNewItem(item, String.valueOf(loginUser));

        redirectAttributes.addFlashAttribute("message", "상품이 등록되었습니다.");
        return "redirect:/stock/list";
    }
    @GetMapping("/base-qty/edit")
    public String baseQtyEdit(@RequestParam(required = false) String productType,
                              @RequestParam(required = false) String modelName,
                              Model model) {

        if (productType != null && !productType.isBlank()
                && modelName != null && !modelName.isBlank()) {

            Item item = itemService.findByProductTypeAndModelName(productType, modelName);

            if (item == null) {
                model.addAttribute("error", "조회된 상품이 없습니다.");
            } else {
                model.addAttribute("item", item);
            }
        }

        model.addAttribute("productType", productType);
        model.addAttribute("modelName", modelName);

        return "admin/item-edit";
    }

    @PostMapping("/base-qty/update")
    public String updateBaseQty(@RequestParam Long id,
                                @RequestParam int baseQty,
                                RedirectAttributes redirectAttributes) {

        if (baseQty <= 0) {
            redirectAttributes.addFlashAttribute("error", "기본수량은 1 이상이어야 합니다.");
            return "redirect:/admin/item/base-qty/edit";
        }

        itemService.updateBaseQty(id, baseQty);

        redirectAttributes.addFlashAttribute("message", "기본수량이 수정되었습니다.");
        return "redirect:/admin/item/base-qty/edit";
    }
}