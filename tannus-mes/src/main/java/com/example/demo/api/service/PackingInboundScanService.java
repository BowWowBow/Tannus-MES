package com.example.demo.api.service;

import com.example.demo.api.domain.PackingInboundScan;
import com.example.demo.api.domain.PackingOrderDetail;
import com.example.demo.api.mapper.PackingInboundScanMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.example.demo.api.domain.UnplannedPurchase;

import java.util.List;

@Service
public class PackingInboundScanService {

    private final PackingInboundScanMapper packingInboundScanMapper;

    public PackingInboundScanService(PackingInboundScanMapper packingInboundScanMapper) {
        this.packingInboundScanMapper = packingInboundScanMapper;
    }

    @Transactional
    public void createScanUnits(Long packingOrderId, PackingOrderDetail detail) {
        if (packingOrderId == null || detail == null || detail.getId() == null) {
            return;
        }

        int existsCount = packingInboundScanMapper.countByDetailId(detail.getId());

        if (existsCount > 0) {
            return;
        }

        int boxCount = detail.getBoxCount() == null ? 0 : detail.getBoxCount();
        int baseQty = detail.getBaseQty() == null ? 0 : detail.getBaseQty();
        int eachQty = detail.getEachQty() == null ? 0 : detail.getEachQty();

        for (int i = 1; i <= boxCount; i++) {
            PackingInboundScan scan = new PackingInboundScan();
            scan.setPackingOrderId(packingOrderId);
            scan.setDetailId(detail.getId());
            scan.setUnitType("BOX");
            scan.setUnitNo(i);
            scan.setQty(baseQty);

            packingInboundScanMapper.insert(scan);
        }

        if (eachQty > 0) {
            PackingInboundScan scan = new PackingInboundScan();
            scan.setPackingOrderId(packingOrderId);
            scan.setDetailId(detail.getId());
            scan.setUnitType("EACH");
            scan.setUnitNo(1);
            scan.setQty(eachQty);

            packingInboundScanMapper.insert(scan);
        }
    }

    @Transactional
    public void createScanUnits(PackingOrderDetail detail) {
        if (detail == null) {
            return;
        }

        createScanUnits(detail.getPackingOrderId(), detail);
    }

    public List<PackingInboundScan> findByOrderId(Long packingOrderId) {
        return packingInboundScanMapper.findByOrderId(packingOrderId);
    }

    public List<PackingInboundScan> findByDetailId(Long detailId) {
        return packingInboundScanMapper.findByDetailId(detailId);
    }

    public PackingInboundScan findByQrInfo(Long packingOrderId,
                                           Long detailId,
                                           String unitType,
                                           Integer unitNo) {
        return packingInboundScanMapper.findByQrInfo(
                packingOrderId,
                detailId,
                unitType,
                unitNo
        );
    }

    @Transactional
    public String scanDone(Long packingOrderId,
                           Long detailId,
                           String unitType,
                           Integer unitNo) {

        PackingInboundScan scan = packingInboundScanMapper.findByQrInfo(
                packingOrderId,
                detailId,
                unitType,
                unitNo
        );

        if (scan == null) {
            return "NOT_FOUND";
        }

        if ("DONE".equals(scan.getScanStatus())) {
            return "ALREADY_DONE";
        }

        packingInboundScanMapper.updateScanDone(scan.getId());

        return "OK";
    }

    public int countWaitingByOrderId(Long packingOrderId) {
        return packingInboundScanMapper.countWaitingByOrderId(packingOrderId);
    }

    public int countDoneByOrderId(Long packingOrderId) {
        return packingInboundScanMapper.countDoneByOrderId(packingOrderId);
    }

    public List<PackingInboundScan> findDoneNotAppliedByOrderId(Long packingOrderId) {
        return packingInboundScanMapper.findDoneNotAppliedByOrderId(packingOrderId);
    }

    public int sumDoneQtyNotApplied(Long detailId) {
        Integer qty = packingInboundScanMapper.sumDoneQtyNotAppliedByDetailId(detailId);
        return qty == null ? 0 : qty;
    }

    @Transactional
    public void applyStockByDetailId(Long detailId) {
        List<PackingInboundScan> scanList = packingInboundScanMapper.findByDetailId(detailId);

        if (scanList == null || scanList.isEmpty()) {
            return;
        }

        for (PackingInboundScan scan : scanList) {
            if (!"DONE".equals(scan.getScanStatus())) {
                continue;
            }

            if ("Y".equals(scan.getStockApplied())) {
                continue;
            }

            packingInboundScanMapper.updateStockApplied(scan.getId());
        }
    }

    @Transactional
    public void updateStockApplied(Long id) {
        packingInboundScanMapper.updateStockApplied(id);
    }

    @Transactional
    public void cancelScan(Long id) {
        packingInboundScanMapper.cancelScan(id);
    }

    @Transactional
    public void createUnplannedScanUnits(Long packingOrderId, UnplannedPurchase item) {
        if (packingOrderId == null || item == null || item.getId() == null) {
            return;
        }

        int existsCount = packingInboundScanMapper.countByUnplannedId(item.getId());

        if (existsCount > 0) {
            return;
        }

        int boxCount = item.getBoxCount() == null ? 0 : item.getBoxCount();
        int baseQty = item.getBaseQty() == null ? 0 : item.getBaseQty();
        int eachQty = item.getEachQty() == null ? 0 : item.getEachQty();

        for (int i = 1; i <= boxCount; i++) {
            PackingInboundScan scan = new PackingInboundScan();
            scan.setPackingOrderId(packingOrderId);
            scan.setDetailId(item.getId());
            scan.setUnitType("UNPLANNED_BOX");
            scan.setUnitNo(i);
            scan.setQty(baseQty);

            packingInboundScanMapper.insert(scan);
        }

        if (eachQty > 0) {
            PackingInboundScan scan = new PackingInboundScan();
            scan.setPackingOrderId(packingOrderId);
            scan.setDetailId(item.getId());
            scan.setUnitType("UNPLANNED_EACH");
            scan.setUnitNo(1);
            scan.setQty(eachQty);

            packingInboundScanMapper.insert(scan);
        }
    }

    public int countWaitingByUnplannedId(Long unplannedId) {
        return packingInboundScanMapper.countWaitingByUnplannedId(unplannedId);
    }



}