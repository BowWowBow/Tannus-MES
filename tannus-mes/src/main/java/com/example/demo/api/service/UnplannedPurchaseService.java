package com.example.demo.api.service;

import com.example.demo.api.domain.UnplannedPurchase;
import com.example.demo.api.mapper.UnplannedPurchaseMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UnplannedPurchaseService {

    private final UnplannedPurchaseMapper unplannedPurchaseMapper;

    public UnplannedPurchaseService(UnplannedPurchaseMapper unplannedPurchaseMapper) {
        this.unplannedPurchaseMapper = unplannedPurchaseMapper;
    }

    @Transactional
    public void save(UnplannedPurchase purchase) {

        if (purchase.getBaseQty() == null) {
            purchase.setBaseQty(0);
        }

        if (purchase.getBoxCount() == null) {
            purchase.setBoxCount(0);
        }

        if (purchase.getEachQty() == null) {
            purchase.setEachQty(0);
        }

        int totalQty = (purchase.getBaseQty() * purchase.getBoxCount())
                + purchase.getEachQty();

        purchase.setTotalQty(totalQty);
        purchase.setQty(totalQty);
        purchase.setStatus("PENDING");
        purchase.setInboundStatus("WAITING");

        unplannedPurchaseMapper.insert(purchase);
    }

    public List<UnplannedPurchase> findByPackingOrderId(Long packingOrderId) {
        return unplannedPurchaseMapper.findByPackingOrderId(packingOrderId);
    }

    public List<UnplannedPurchase> findPendingList() {
        return unplannedPurchaseMapper.findPendingList();
    }

    public List<UnplannedPurchase> findAllList() {
        return unplannedPurchaseMapper.findAllList();
    }

    public List<UnplannedPurchase> findByMonth(String month) {
        return unplannedPurchaseMapper.findByMonth(month);
    }

    public List<String> findMonths() {
        return unplannedPurchaseMapper.findMonths();
    }

    public UnplannedPurchase findById(Long id) {
        return unplannedPurchaseMapper.findById(id);
    }

    public int countByRequestUser(String requestUser) {
        return unplannedPurchaseMapper.countByRequestUser(requestUser);
    }

    @Transactional
    public void approve(Long id, String approvedBy) {
        unplannedPurchaseMapper.approve(id, approvedBy);
    }

    @Transactional
    public void reject(Long id, String approvedBy) {
        unplannedPurchaseMapper.reject(id, approvedBy);
    }

    public String findInboundStatus(Long id) {
        return unplannedPurchaseMapper.findInboundStatus(id);
    }

    @Transactional
    public void updateInboundDone(Long id) {
        unplannedPurchaseMapper.updateInboundDone(id);
    }

    @Transactional
    public void cancelInbound(Long id) {
        unplannedPurchaseMapper.cancelInbound(id);
    }

    @Transactional
    public void delete(Long id) {
        unplannedPurchaseMapper.delete(id);
    }

    public void updateStockApplied(Long id) {
        unplannedPurchaseMapper.updateStockApplied(id);
    }
}