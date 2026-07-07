package com.example.demo.api.service;

import com.example.demo.api.domain.ExportOrderDetail;
import com.example.demo.api.domain.ExportOutboundScan;
import com.example.demo.api.domain.UnplannedExport;
import com.example.demo.api.mapper.ExportOutboundScanMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ExportOutboundScanService {

    private final ExportOutboundScanMapper exportOutboundScanMapper;

    public ExportOutboundScanService(ExportOutboundScanMapper exportOutboundScanMapper) {
        this.exportOutboundScanMapper = exportOutboundScanMapper;
    }

    @Transactional
    public void createScanUnits(ExportOrderDetail detail) {
        if (detail == null || detail.getId() == null) {
            return;
        }

        int existsCount = exportOutboundScanMapper.countByDetailId(detail.getId());

        if (existsCount > 0) {
            return;
        }

        int boxCount = detail.getBoxCount() == null ? 0 : detail.getBoxCount();
        int baseQty = detail.getBaseQty() == null ? 0 : detail.getBaseQty();
        int eachQty = detail.getEachQty() == null ? 0 : detail.getEachQty();

        for (int i = 1; i <= boxCount; i++) {
            ExportOutboundScan scan = new ExportOutboundScan();

            scan.setQrType("EXPORT");
            scan.setExportOrderId(detail.getExportOrderId());
            scan.setDetailId(detail.getId());
            scan.setUnitType("BOX");
            scan.setUnitNo(i);
            scan.setQty(baseQty);

            exportOutboundScanMapper.insert(scan);
        }

        if (eachQty > 0) {
            ExportOutboundScan scan = new ExportOutboundScan();

            scan.setQrType("EXPORT");
            scan.setExportOrderId(detail.getExportOrderId());
            scan.setDetailId(detail.getId());
            scan.setUnitType("EACH");
            scan.setUnitNo(1);
            scan.setQty(eachQty);

            exportOutboundScanMapper.insert(scan);
        }
    }

    @Transactional
    public void createUnplannedScanUnit(UnplannedExport item) {
        if (item == null || item.getId() == null) {
            return;
        }

        if (!"APPROVED".equals(item.getStatus())) {
            return;
        }

        int totalQty = item.getTotalQty() == null ? 0 : item.getTotalQty();

        if (totalQty <= 0) {
            return;
        }

        ExportOutboundScan exists = exportOutboundScanMapper.findByQrInfo(
                item.getExportOrderId(),
                item.getId(),
                "UNPLANNED",
                1
        );

        if (exists != null) {
            return;
        }

        ExportOutboundScan scan = new ExportOutboundScan();

        scan.setQrType("UNPLANNED_EXPORT");
        scan.setExportOrderId(item.getExportOrderId());
        scan.setDetailId(item.getId());
        scan.setUnitType("UNPLANNED");
        scan.setUnitNo(1);
        scan.setQty(totalQty);

        exportOutboundScanMapper.insert(scan);
    }

    public List<ExportOutboundScan> findByOrderId(Long exportOrderId) {
        return exportOutboundScanMapper.findByOrderId(exportOrderId);
    }

    public List<ExportOutboundScan> findByDetailId(Long detailId) {
        return exportOutboundScanMapper.findByDetailId(detailId);
    }

    public ExportOutboundScan findByQrInfo(Long exportOrderId,
                                           Long detailId,
                                           String unitType,
                                           Integer unitNo) {
        return exportOutboundScanMapper.findByQrInfo(
                exportOrderId,
                detailId,
                unitType,
                unitNo
        );
    }

    @Transactional
    public String scanDone(Long exportOrderId,
                           Long detailId,
                           String unitType,
                           Integer unitNo) {

        ExportOutboundScan scan = exportOutboundScanMapper.findByQrInfo(
                exportOrderId,
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

        exportOutboundScanMapper.updateScanDone(scan.getId());

        return "OK";
    }

    public int countWaitingByOrderId(Long exportOrderId) {
        return exportOutboundScanMapper.countWaitingByOrderId(exportOrderId);
    }

    public int countDoneByOrderId(Long exportOrderId) {
        return exportOutboundScanMapper.countDoneByOrderId(exportOrderId);
    }

    public int countWaitingByDetailId(Long detailId) {
        return exportOutboundScanMapper.countWaitingByDetailId(detailId);
    }

    public int countDoneByDetailId(Long detailId) {
        return exportOutboundScanMapper.countDoneByDetailId(detailId);
    }

    @Transactional
    public void cancelScan(Long id) {
        exportOutboundScanMapper.cancelScan(id);
    }

    public List<ExportOutboundScan> findDoneNotAppliedByOrderId(Long exportOrderId) {
        return exportOutboundScanMapper.findDoneNotAppliedByOrderId(exportOrderId);
    }

    @Transactional
    public void updateStockApplied(Long id) {
        exportOutboundScanMapper.updateStockApplied(id);
    }

    public int sumDoneQtyNotApplied(Long detailId) {
        return exportOutboundScanMapper.sumDoneQtyNotApplied(detailId);
    }

    @Transactional
    public void applyStockByDetailId(Long detailId) {
        exportOutboundScanMapper.applyStockByDetailId(detailId);
    }

    public void cancelExportScan(Long orderId, Long scanId) {
        exportOutboundScanMapper.cancelScan(scanId);

    }

    @Transactional
    public void refreshScanUnits(Long exportOrderId,
                                 List<ExportOrderDetail> detailList,
                                 List<UnplannedExport> unplannedExportList) {

        exportOutboundScanMapper.deleteByOrderId(exportOrderId);

        if (detailList != null) {
            for (ExportOrderDetail detail : detailList) {
                createScanUnits(detail);
            }
        }

        if (unplannedExportList != null) {
            for (UnplannedExport item : unplannedExportList) {
                createUnplannedScanUnit(item);
            }
        }
    }

}