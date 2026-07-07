package com.example.demo.api.service;

import com.example.demo.api.domain.PackingOrder;
import com.example.demo.api.domain.PackingOrderDetail;
import com.example.demo.api.domain.PackingOutboundScan;
import com.example.demo.api.domain.UnplannedPurchase;
import com.example.demo.api.mapper.PackingOrderMapper;
import com.example.demo.api.mapper.PackingOutboundScanMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PackingOutboundScanService {

    private final PackingOutboundScanMapper packingOutboundScanMapper;
    private final PackingOrderMapper packingOrderMapper;

    public PackingOutboundScanService(PackingOutboundScanMapper packingOutboundScanMapper,
                                      PackingOrderMapper packingOrderMapper) {
        this.packingOutboundScanMapper = packingOutboundScanMapper;
        this.packingOrderMapper = packingOrderMapper;
    }

    public List<PackingOutboundScan> findByOrderId(Long packingOrderId) {
        return packingOutboundScanMapper.findByOrderId(packingOrderId);
    }

    @Transactional
    public void createScanUnits(PackingOrder order, List<UnplannedPurchase> unplannedPackingList) {
        if (order == null || order.getId() == null) {
            return;
        }

        int waitingCount = packingOutboundScanMapper.countWaitingByOrderId(order.getId());
        int doneCount = packingOutboundScanMapper.countDoneByOrderId(order.getId());

        if (waitingCount + doneCount > 0) {
            return;
        }

        if (order.getDetailList() != null) {
            for (PackingOrderDetail detail : order.getDetailList()) {
                createNormalDetailUnits(detail);
            }
        }

        if (unplannedPackingList != null) {
            for (UnplannedPurchase item : unplannedPackingList) {
                if ("APPROVED".equals(item.getStatus())) {
                    createUnplannedUnits(order.getId(), item);
                }
            }
        }
    }

    private void createNormalDetailUnits(PackingOrderDetail detail) {
        if (detail == null || detail.getId() == null) {
            return;
        }

        Long orderId = detail.getPackingOrderId();
        Long detailId = detail.getId();

        int baseQty = detail.getBaseQty() == null ? 0 : detail.getBaseQty();
        int boxCount = detail.getBoxCount() == null ? 0 : detail.getBoxCount();
        int eachQty = detail.getEachQty() == null ? 0 : detail.getEachQty();

        if (baseQty > 0 && boxCount > 0) {
            for (int i = 1; i <= boxCount; i++) {
                insertUnit(orderId, detailId, "BOX", i, baseQty);
            }
        }

        if (eachQty > 0) {
            insertUnit(orderId, detailId, "EACH", 1, eachQty);
        }
    }

    private void createUnplannedUnits(Long orderId, UnplannedPurchase item) {
        if (item == null || item.getId() == null) {
            return;
        }

        Long detailId = item.getId();

        int baseQty = item.getBaseQty() == null ? 0 : item.getBaseQty();
        int boxCount = item.getBoxCount() == null ? 0 : item.getBoxCount();
        int eachQty = item.getEachQty() == null ? 0 : item.getEachQty();

        if (baseQty > 0 && boxCount > 0) {
            for (int i = 1; i <= boxCount; i++) {
                insertUnit(orderId, detailId, "UNPLANNED_BOX", i, baseQty);
            }
        }

        if (eachQty > 0) {
            insertUnit(orderId, detailId, "UNPLANNED_EACH", 1, eachQty);
        }
    }

    private void insertUnit(Long orderId,
                            Long detailId,
                            String scanType,
                            Integer scanSeq,
                            Integer qty) {
        PackingOutboundScan scan = new PackingOutboundScan();

        scan.setPackingOrderId(orderId);
        scan.setDetailId(detailId);
        scan.setScanType(scanType);
        scan.setScanSeq(scanSeq);
        scan.setQty(qty);

        packingOutboundScanMapper.insert(scan);
    }

    @Transactional
    public boolean completeScan(Long packingOrderId,
                                Long detailId,
                                String scanType,
                                Integer scanSeq) {
        PackingOutboundScan scan = packingOutboundScanMapper.findByQrInfo(
                packingOrderId,
                detailId,
                scanType,
                scanSeq
        );

        if (scan == null) {
            return false;
        }

        if ("DONE".equals(scan.getStatus())) {
            return isAllDone(packingOrderId);
        }

        packingOutboundScanMapper.updateScanDone(scan.getId());

        if ("BOX".equals(scan.getScanType()) || "EACH".equals(scan.getScanType())) {
            int waitingCount = packingOutboundScanMapper.countWaitingByDetailId(scan.getDetailId());

            if (waitingCount == 0) {
                packingOrderMapper.updatePackingScanDone(scan.getDetailId());
            }
        }

        return isAllDone(packingOrderId);
    }

    public boolean isAllDone(Long packingOrderId) {
        int waitingCount = packingOutboundScanMapper.countWaitingByOrderId(packingOrderId);
        int doneCount = packingOutboundScanMapper.countDoneByOrderId(packingOrderId);

        return doneCount > 0 && waitingCount == 0;
    }

    @Transactional
    public void cancelScan(Long scanId) {
        packingOutboundScanMapper.cancelScan(scanId);
    }
}