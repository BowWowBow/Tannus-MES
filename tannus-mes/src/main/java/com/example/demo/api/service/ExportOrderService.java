package com.example.demo.api.service;

import com.example.demo.api.domain.ExportOrder;
import com.example.demo.api.domain.ExportOrderDetail;
import com.example.demo.api.mapper.ExportOrderMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class ExportOrderService {

    private final ExportOrderMapper exportOrderMapper;

    public ExportOrderService(ExportOrderMapper exportOrderMapper) {
        this.exportOrderMapper = exportOrderMapper;
    }

    @Transactional
    public ExportOrder save(ExportOrder order) {

        if (order.getStatus() == null || order.getStatus().isBlank()) {
            order.setStatus("WAITING");
        }

        exportOrderMapper.insertOrder(order);

        if (order.getDetailList() != null) {
            for (ExportOrderDetail detail : order.getDetailList()) {
                detail.setExportOrderId(order.getId());
                exportOrderMapper.insertDetail(detail);
            }
        }

        return order;
    }

    public List<ExportOrder> findAll() {
        return exportOrderMapper.findAll();
    }

    public ExportOrder findById(Long id) {

        ExportOrder order = exportOrderMapper.findById(id);

        if (order != null) {
            order.setDetailList(
                    exportOrderMapper.findDetailsByOrderId(id)
            );
        }

        return order;
    }

    public int countAll() {
        return exportOrderMapper.findAll().size();
    }

    public int countWaiting() {
        return exportOrderMapper.countByStatus("WAITING");
    }

    public int countReady() {
        return exportOrderMapper.countByStatus("READY_DONE");
    }

    public int countDone() {
        return exportOrderMapper.countByStatus("DONE");
    }

    public List<ExportOrder> findByStatus(String status) {
        return exportOrderMapper.findByStatus(status);
    }

    public void updateStatus(Long id, String status) {
        exportOrderMapper.updateStatus(id, status);
    }

    @Transactional
    public boolean completeOutboundDetail(Long exportOrderId, Long detailId) {

        exportOrderMapper.updateDetailOutboundStatus(detailId);

        int doneCount = exportOrderMapper.countDetailDone(exportOrderId);
        int allCount = exportOrderMapper.countDetailAll(exportOrderId);

        return allCount > 0 && doneCount == allCount;
    }

    @Transactional
    public void cancelOutboundByOrderId(Long exportOrderId) {
        exportOrderMapper.cancelOutboundByOrderId(exportOrderId);
    }

    public void updateStockApplied(Long id, String stockApplied) {
        exportOrderMapper.updateStockApplied(id, stockApplied);
    }

    public List<ExportOrder> findByMonth(String month) {
        return exportOrderMapper.findByMonth(month);
    }

    public List<String> findOrderMonths() {
        return exportOrderMapper.findOrderMonths();
    }

    @Transactional
    public void update(ExportOrder order) {

        exportOrderMapper.updateOrder(order);
        exportOrderMapper.deleteDetails(order.getId());

        if (order.getDetailList() != null) {
            for (ExportOrderDetail detail : order.getDetailList()) {
                detail.setExportOrderId(order.getId());
                exportOrderMapper.insertDetail(detail);
            }
        }
    }

    public int getYearExportRate(int year) {
        int total = exportOrderMapper.countByYear(year);
        int done = exportOrderMapper.countDoneByYear(year);

        if (total == 0) {
            return 100;
        }

        return (int) Math.round(done * 100.0 / total);
    }

    public List<Integer> getQuarterExportRates(int year) {

        List<Integer> result = new ArrayList<>();

        for (int quarter = 1; quarter <= 4; quarter++) {
            int total = exportOrderMapper.countByQuarter(year, quarter);
            int done = exportOrderMapper.countDoneByQuarter(year, quarter);

            if (total == 0) {
                result.add(100);
            } else {
                result.add((int) Math.round(done * 100.0 / total));
            }
        }

        return result;
    }

    public List<Integer> getMonthExportRates(int year) {

        List<Integer> result = new ArrayList<>();

        for (int month = 1; month <= 12; month++) {
            int total = exportOrderMapper.countByMonthForStats(year, month);
            int done = exportOrderMapper.countDoneByMonthForStats(year, month);

            if (total == 0) {
                result.add(100);
            } else {
                result.add((int) Math.round(done * 100.0 / total));
            }
        }

        return result;
    }

    public List<Boolean> getMonthHasDataList(int year) {

        List<Boolean> result = new ArrayList<>();

        for (int month = 1; month <= 12; month++) {
            int total = exportOrderMapper.countByMonthForStats(year, month);
            result.add(total > 0);
        }

        return result;
    }

    public List<Integer> getWeekExportRates(int year) {

        List<Integer> result = new ArrayList<>();

        for (int week = 1; week <= 53; week++) {
            int total = exportOrderMapper.countByWeek(year, week);
            int done = exportOrderMapper.countDoneByWeek(year, week);

            if (total == 0) {
                result.add(100);
            } else {
                result.add((int) Math.round(done * 100.0 / total));
            }
        }

        return result;
    }

    public int countDMinus2() {
        return exportOrderMapper.countDMinus2();
    }

    public int countDMinus1() {
        return exportOrderMapper.countDMinus1();
    }

    public int countDDay() {
        return exportOrderMapper.countDDay();
    }

    public int countDPlus1() {
        return exportOrderMapper.countDPlus1();
    }

    public int countDPlus2Over() {
        return exportOrderMapper.countDPlus2Over();
    }

    @Transactional
    public void cancelExportOrder(Long id) {

        ExportOrder order = exportOrderMapper.findById(id);

        if (order == null) {
            return;
        }

        if ("DONE".equals(order.getStatus())) {
            return;
        }

        exportOrderMapper.cancelOutboundByOrderId(id);
        exportOrderMapper.updateStatus(id, "CANCELLED");
    }

    public ExportOrder findWorkOrderById(Long id) {
        ExportOrder order = exportOrderMapper.findWorkOrderById(id);

        if (order == null) {
            return null;
        }

        order.setDetailList(exportOrderMapper.findDetailsByOrderId(id));

        return order;
    }

    public List<ExportOrderDetail> findDetailsByOrderId(Long exportOrderId) {
        return exportOrderMapper.findDetailsByOrderId(exportOrderId);
    }

    public List<String> findDoneMonthList() {
        return exportOrderMapper.findOrderMonths();
    }

}