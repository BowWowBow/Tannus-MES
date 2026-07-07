package com.example.demo.api.controller;

import com.example.demo.api.domain.Item;
import com.example.demo.api.service.ItemService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/items")
public class ItemApiController {

    private final ItemService itemService;

    public ItemApiController(ItemService itemService) {
        this.itemService = itemService;
    }

    @GetMapping("/search")
    public List<Item> search(@RequestParam(name = "q") String keyword) {
        return itemService.search(keyword);
    }

    @GetMapping("/models")
    public List<String> models(@RequestParam String productType) {
        return itemService.findModelNamesByProductType(productType);
    }

    @GetMapping("/by-type")
    public List<Item> byType(@RequestParam String productType) {
        return itemService.findByProductType(productType);
    }

    @GetMapping("/options")
    public List<Item> options(@RequestParam String productType) {
        return itemService.findByProductType(productType);
    }

    @GetMapping("/exists")
    public boolean exists(@RequestParam String productType,
                          @RequestParam String modelName,
                          @RequestParam String color,
                          @RequestParam String hardness) {

        Item item = itemService.findByOption(
                productType,
                modelName.trim(),
                color,
                hardness
        );

        return item != null;
    }

}
