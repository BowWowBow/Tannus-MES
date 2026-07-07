package com.example.demo.api.service;

import com.example.demo.api.domain.UnplannedExport;
import com.example.demo.api.mapper.UnplannedExportMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UnplannedExportService {

    private final UnplannedExportMapper unplannedExportMapper;

    public UnplannedExportService(UnplannedExportMapper unplannedExportMapper) {
        this.unplannedExportMapper = unplannedExportMapper;
    }

    @Transactional
    public void save(UnplannedExport export) {

        if (export.getBaseQty() == null) {
            export.setBaseQty(0);
        }

        if (export.getBoxCount() == null) {
            export.setBoxCount(0);
        }

        if (export.getEachQty() == null) {
            export.setEachQty(0);
        }

        int totalQty = (export.getBaseQty() * export.getBoxCount())
                + export.getEachQty();

        export.setTotalQty(totalQty);
        export.setQty(totalQty);
        export.setStatus("PENDING");

        unplannedExportMapper.insert(export);
    }

    public List<UnplannedExport> findAllList() {
        return unplannedExportMapper.findAllList();
    }

    public List<UnplannedExport> findByMonth(String month) {
        return unplannedExportMapper.findByMonth(month);
    }

    public List<String> findMonths() {
        return unplannedExportMapper.findMonths();
    }

    public List<UnplannedExport> findByExportOrderId(Long exportOrderId) {
        return unplannedExportMapper.findByExportOrderId(exportOrderId);
    }

    public List<UnplannedExport> findPendingList() {
        return unplannedExportMapper.findPendingList();
    }

    public UnplannedExport findById(Long id) {
        return unplannedExportMapper.findById(id);
    }

    public int countPending() {
        return unplannedExportMapper.countPending();
    }

    @Transactional
    public void approve(Long id) {
        unplannedExportMapper.approve(id);
    }

    @Transactional
    public void approve(Long id, String approvedBy) {
        unplannedExportMapper.approve(id);
    }

    @Transactional
    public void reject(Long id) {
        unplannedExportMapper.reject(id);
    }

    @Transactional
    public void reject(Long id, String approvedBy) {
        unplannedExportMapper.reject(id);
    }

    @Transactional
    public void delete(Long id) {
        unplannedExportMapper.delete(id);
    }

    public boolean hasPendingByExportOrderId(Long exportOrderId) {
        return unplannedExportMapper.countPendingByExportOrderId(exportOrderId) > 0;
    }
}
