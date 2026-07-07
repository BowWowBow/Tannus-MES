package com.example.demo.api.service;

import com.example.demo.api.domain.ExportOrderDetail;
import com.example.demo.api.domain.Item;
import com.example.demo.api.domain.PackingOrderDetail;
import com.example.demo.api.domain.StockHistory;
import com.example.demo.api.domain.UnplannedPurchase;
import com.example.demo.api.mapper.ItemMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.example.demo.api.domain.UnplannedExport;
import java.util.List;

@Service
public class ItemService {

    private final ItemMapper itemMapper;
    private final StockHistoryService stockHistoryService;

    public ItemService(ItemMapper itemMapper,
                       StockHistoryService stockHistoryService) {

        this.itemMapper = itemMapper;
        this.stockHistoryService = stockHistoryService;
    }

    public List<Item> findAll() {
        return itemMapper.findAll();
    }

    public List<Item> findByProductType(String productType) {
        return itemMapper.findByProductType(productType);
    }

    public List<Item> search(String keyword) {
        return itemMapper.search(keyword);
    }

    public Item findById(Long id) {
        return itemMapper.findById(id);
    }

    public Item findByOption(String productType,
                             String modelName,
                             String color,
                             String hardness) {
        return itemMapper.findByOption(productType, modelName, color, hardness);
    }

    @Transactional
    public void saveNewItem(Item item, String loginUser) {

        if (item == null) {
            return;
        }

        if (item.getBaseQty() < 0) {
            item.setBaseQty(0);
        }

        if (item.getCurrentQty() < 0) {
            item.setCurrentQty(0);
        }

        if (item.getLocation() == null || item.getLocation().isBlank()) {
            item.setLocation("미지정");
        }

        itemMapper.insertItem(item);

        saveHistory(
                "ADJUST",
                item.getProductType(),
                item.getModelName(),
                item.getColor(),
                item.getHardness(),
                0,
                item.getCurrentQty(),
                item.getCurrentQty(),
                loginUser,
                "관리자 상품정보 등록"
        );
    }

    @Transactional
    public void adjustStock(Long itemId,
                            int adjustQty,
                            String reason,
                            String loginUser) {

        Item item = itemMapper.findById(itemId);

        if (item == null) {
            return;
        }

        int beforeQty = item.getCurrentQty();
        int afterQty = beforeQty + adjustQty;

        if (afterQty < 0) {
            afterQty = 0;
        }

        itemMapper.updateCurrentQty(itemId, afterQty);

        saveHistory(
                "ADJUST",
                item.getProductType(),
                item.getModelName(),
                item.getColor(),
                item.getHardness(),
                beforeQty,
                adjustQty,
                afterQty,
                loginUser,
                reason
        );
    }

    @Transactional
    public void increaseStockFromPackingDetail(PackingOrderDetail detail) {

        if (detail == null) {
            return;
        }

        int addQty = detail.getTotalQty() == null ? 0 : detail.getTotalQty();

        if (addQty <= 0) {
            return;
        }

        Item item = itemMapper.findByOption(
                detail.getProductType(),
                detail.getModelName(),
                detail.getColor(),
                detail.getHardness()
        );

        int beforeQty = 0;
        int afterQty = addQty;

        if (item == null) {

            Item newItem = new Item();

            newItem.setProductType(detail.getProductType());
            newItem.setModelName(detail.getModelName());
            newItem.setColor(detail.getColor());
            newItem.setHardness(detail.getHardness());
            newItem.setBaseQty(detail.getBaseQty() == null ? 0 : detail.getBaseQty());
            newItem.setCurrentQty(addQty);
            newItem.setLocation("미지정");

            itemMapper.insertItem(newItem);

        } else {

            beforeQty = item.getCurrentQty();
            afterQty = beforeQty + addQty;

            itemMapper.increaseStock(item.getId(), addQty);
        }

        saveHistory(
                "IN",
                detail.getProductType(),
                detail.getModelName(),
                detail.getColor(),
                detail.getHardness(),
                beforeQty,
                addQty,
                afterQty,
                "물류팀",
                "정상입고"
        );
    }

    @Transactional
    public void increaseStockFromUnplanned(UnplannedPurchase purchase) {

        if (purchase == null) {
            return;
        }

        int addQty = purchase.getTotalQty() == null ? 0 : purchase.getTotalQty();

        if (addQty <= 0) {
            return;
        }

        Item item = itemMapper.findByOption(
                purchase.getProductType(),
                purchase.getModelName(),
                purchase.getColor(),
                purchase.getHardness()
        );

        int beforeQty = 0;
        int afterQty = addQty;

        if (item == null) {

            Item newItem = new Item();

            newItem.setProductType(purchase.getProductType());
            newItem.setModelName(purchase.getModelName());
            newItem.setColor(purchase.getColor());
            newItem.setHardness(purchase.getHardness());
            newItem.setBaseQty(purchase.getBaseQty() == null ? 0 : purchase.getBaseQty());
            newItem.setCurrentQty(addQty);
            newItem.setLocation("미지정");

            itemMapper.insertItem(newItem);

        } else {

            beforeQty = item.getCurrentQty();
            afterQty = beforeQty + addQty;

            itemMapper.increaseStock(item.getId(), addQty);
        }

        saveHistory(
                "IN",
                purchase.getProductType(),
                purchase.getModelName(),
                purchase.getColor(),
                purchase.getHardness(),
                beforeQty,
                addQty,
                afterQty,
                "물류팀",
                "무발주 입고"
        );
    }

    @Transactional
    public void decreaseStockFromExportDetail(ExportOrderDetail detail) {

        if (detail == null) {
            return;
        }

        int outQty = detail.getTotalQty() == null ? 0 : detail.getTotalQty();

        if (outQty <= 0) {
            return;
        }

        Item item = itemMapper.findByOption(
                detail.getType(),
                detail.getModel(),
                detail.getColor(),
                detail.getHardness()
        );

        if (item == null) {
            return;
        }

        int beforeQty = item.getCurrentQty();
        int afterQty = beforeQty - outQty;

        if (afterQty < 0) {
            afterQty = 0;
        }

        itemMapper.updateCurrentQty(item.getId(), afterQty);

        saveHistory(
                "OUT",
                detail.getType(),
                detail.getModel(),
                detail.getColor(),
                detail.getHardness(),
                beforeQty,
                -outQty,
                afterQty,
                "물류팀",
                "수출출고"
        );
    }

    @Transactional
    public void decreaseStockFromUnplannedExport(UnplannedExport export) {

        if (export == null) {
            return;
        }

        int outQty = export.getTotalQty() == null ? 0 : export.getTotalQty();

        if (outQty <= 0) {
            return;
        }

        Item item = itemMapper.findByOption(
                export.getProductType(),
                export.getModelName(),
                export.getColor(),
                export.getHardness()
        );

        if (item == null) {
            return;
        }

        int beforeQty = item.getCurrentQty();
        int afterQty = beforeQty - outQty;

        if (afterQty < 0) {
            afterQty = 0;
        }

        itemMapper.updateCurrentQty(item.getId(), afterQty);

        saveHistory(
                "OUT",
                export.getProductType(),
                export.getModelName(),
                export.getColor(),
                export.getHardness(),
                beforeQty,
                -outQty,
                afterQty,
                "물류팀",
                "무발주 출고"
        );
    }

    @Transactional
    public void increaseStockFromPackingDetailQty(PackingOrderDetail detail,
                                                  int addQty,
                                                  String memo) {

        if (detail == null) {
            return;
        }

        if (addQty <= 0) {
            return;
        }

        Item item = itemMapper.findByOption(
                detail.getProductType(),
                detail.getModelName(),
                detail.getColor(),
                detail.getHardness()
        );

        int beforeQty = 0;
        int afterQty = addQty;

        if (item == null) {

            Item newItem = new Item();

            newItem.setProductType(detail.getProductType());
            newItem.setModelName(detail.getModelName());
            newItem.setColor(detail.getColor());
            newItem.setHardness(detail.getHardness());
            newItem.setBaseQty(detail.getBaseQty() == null ? 0 : detail.getBaseQty());
            newItem.setCurrentQty(addQty);
            newItem.setLocation("미지정");

            itemMapper.insertItem(newItem);

        } else {

            beforeQty = item.getCurrentQty();
            afterQty = beforeQty + addQty;

            itemMapper.increaseStock(item.getId(), addQty);
        }

        saveHistory(
                "IN",
                detail.getProductType(),
                detail.getModelName(),
                detail.getColor(),
                detail.getHardness(),
                beforeQty,
                addQty,
                afterQty,
                "물류팀",
                memo
        );
    }

    private void saveHistory(String historyType,
                             String productType,
                             String modelName,
                             String color,
                             String hardness,
                             int beforeQty,
                             int changeQty,
                             int afterQty,
                             String createdBy,
                             String memo) {

        try {

            StockHistory history = new StockHistory();

            history.setHistoryType(historyType);
            history.setProductType(productType);
            history.setModelName(modelName);
            history.setColor(color);
            history.setHardness(hardness);
            history.setBeforeQty(beforeQty);
            history.setChangeQty(changeQty);
            history.setAfterQty(afterQty);
            history.setCreatedBy(createdBy);
            history.setMemo(memo);

            stockHistoryService.save(history);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<String> findModelNamesByProductType(String productType) {
        return itemMapper.findModelNamesByProductType(productType);
    }

    public Item findByProductTypeAndModelName(String productType, String modelName) {
        return itemMapper.findByProductTypeAndModelName(productType, modelName);
    }

    public void updateBaseQty(Long id, int baseQty) {
        itemMapper.updateBaseQty(id, baseQty);
    }
}