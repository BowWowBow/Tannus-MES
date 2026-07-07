package com.example.demo.api.service;

import com.example.demo.api.domain.PackingOrder;
import com.example.demo.api.domain.PackingOrderDetail;
import com.example.demo.api.domain.UnplannedPurchase;
import com.example.demo.api.mapper.PackingOrderMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class PackingOrderService {

    private final PackingOrderMapper packingOrderMapper;
    private final PackingInboundScanService packingInboundScanService;
    private final PackingOutboundScanService packingOutboundScanService;
    private final UnplannedPurchaseService unplannedPurchaseService;

    public PackingOrderService(PackingOrderMapper packingOrderMapper,
                               PackingInboundScanService packingInboundScanService,
                               PackingOutboundScanService packingOutboundScanService,
                               UnplannedPurchaseService unplannedPurchaseService) {
        this.packingOrderMapper = packingOrderMapper;
        this.packingInboundScanService = packingInboundScanService;
        this.packingOutboundScanService = packingOutboundScanService;
        this.unplannedPurchaseService = unplannedPurchaseService;
    }

    public List<PackingOrder> findByStatus(String status) {
        return packingOrderMapper.findByStatus(status);
    }

    @Transactional
    public void save(PackingOrder order) {
        packingOrderMapper.insertOrder(order);

        if (order.getDetailList() != null) {
            for (PackingOrderDetail detail : order.getDetailList()) {
                detail.setPackingOrderId(order.getId());
                packingOrderMapper.insertDetail(detail);
            }
        }
    }

    public List<PackingOrder> findAll() {
        return packingOrderMapper.findAllOrders();
    }

    public PackingOrder findById(Long id) {
        PackingOrder order = packingOrderMapper.findOrderById(id);

        if (order != null) {
            order.setDetailList(packingOrderMapper.findDetailsByOrderId(id));
        }

        return order;
    }

    public PackingOrder findLogisticsDetailById(Long id) {

        PackingOrder order = packingOrderMapper.findOrderById(id);

        if (order != null) {
            order.setDetailList(packingOrderMapper.findDetailsByOrderId(id));
        }

        return order;
    }

    public long countAll() {
        return packingOrderMapper.countAll();
    }

    public long countWaiting() {
        return packingOrderMapper.countByStatus("REQUESTED");
    }

    public long countPackingDone() {
        return packingOrderMapper.countByStatus("READY_TO_SHIP");
    }

    public long countShipped() {
        return packingOrderMapper.countByStatus("SHIPPED");
    }

    public long countInboundWaiting() {
        return packingOrderMapper.countByStatus("SHIPPED");
    }

    public long countInboundDone() {
        return packingOrderMapper.countByStatus("RECEIVED");
    }

    public int getTodayPackingRate() {
        return calcRate(
                packingOrderMapper.countTodayDone(),
                packingOrderMapper.countTodayAll()
        );
    }

    public int getMonthPackingRate() {
        return calcRate(
                packingOrderMapper.countMonthDone(),
                packingOrderMapper.countMonthAll()
        );
    }

    public int getYearPackingRate(int year) {
        return calcRate(
                packingOrderMapper.countYearDone(year),
                packingOrderMapper.countYearAll(year)
        );
    }

    public List<Integer> getQuarterPackingRates(int year) {
        List<Integer> rates = new ArrayList<>();

        for (int q = 1; q <= 4; q++) {
            long total = packingOrderMapper.countQuarterAll(year, q);
            long done = packingOrderMapper.countQuarterDone(year, q);
            rates.add(calcRate(done, total));
        }

        return rates;
    }

    public List<Integer> getMonthPackingRates(int year) {
        List<Integer> rates = new ArrayList<>();

        for (int m = 1; m <= 12; m++) {
            long total = packingOrderMapper.countStatsMonthAll(year, m);
            long done = packingOrderMapper.countStatsMonthDone(year, m);
            rates.add(calcRate(done, total));
        }

        return rates;
    }

    public List<Boolean> getMonthHasDataList(int year) {
        List<Boolean> list = new ArrayList<>();

        for (int m = 1; m <= 12; m++) {
            long total = packingOrderMapper.countStatsMonthAll(year, m);
            list.add(total > 0);
        }

        return list;
    }

    public List<Integer> getWeekPackingRates(int year) {
        List<Integer> rates = new ArrayList<>();

        for (int w = 1; w <= 53; w++) {
            long total = packingOrderMapper.countWeekAll(year, w);
            long done = packingOrderMapper.countWeekDone(year, w);
            rates.add(calcRate(done, total));
        }

        return rates;
    }

    private int calcRate(long done, long total) {
        if (total == 0) {
            return 0;
        }

        return (int) Math.round((done * 100.0) / total);
    }

    @Transactional
    public void updateStatus(Long id, String status) {
        packingOrderMapper.updateStatus(id, status);
    }

    @Transactional
    public void updateOrder(PackingOrder order) {
        packingOrderMapper.updateOrder(order);
    }

    @Transactional
    public void update(PackingOrder order) {
        PackingOrder origin = packingOrderMapper.findOrderById(order.getId());

        if (origin != null && "SHIPPED".equals(origin.getStatus())) {
            throw new RuntimeException("출고완료 상태는 수정할 수 없습니다.");
        }

        order.setStatus("REQUESTED");

        packingOrderMapper.updateOrder(order);
        packingOrderMapper.deleteDetails(order.getId());

        if (order.getDetailList() != null) {
            for (PackingOrderDetail detail : order.getDetailList()) {
                detail.setPackingOrderId(order.getId());
                packingOrderMapper.insertDetail(detail);
            }
        }
    }

    public List<PackingOrder> findByMonth(String month) {
        return packingOrderMapper.findOrdersByMonth(month);
    }

    public List<String> findOrderMonths() {
        return packingOrderMapper.findOrderMonths();
    }

    @Transactional
    public void completePacking(Long id) {
        packingOrderMapper.updateStatus(id, "READY_TO_SHIP");
        packingOrderMapper.updateCompletedAt(id);
    }

    @Transactional
    public void createPackingOutboundScanUnits(Long id) {
        PackingOrder order = findById(id);

        if (order == null) {
            return;
        }

        List<UnplannedPurchase> unplannedPackingList =
                unplannedPurchaseService.findByPackingOrderId(id);

        packingOutboundScanService.createScanUnits(order, unplannedPackingList);
    }

    @Transactional
    public boolean completePackingOutboundScan(Long orderId,
                                               Long detailId,
                                               String scanType,
                                               Integer scanSeq) {
        boolean allDone = packingOutboundScanService.completeScan(
                orderId,
                detailId,
                scanType,
                scanSeq
        );

        if (allDone) {
            completePacking(orderId);
        }

        return allDone;
    }

    @Transactional
    public void completeShipping(Long id) {
        packingOrderMapper.updateStatus(id, "SHIPPED");

        PackingOrder order = findLogisticsDetailById(id);

        if (order == null || order.getDetailList() == null) {
            return;
        }

        for (PackingOrderDetail detail : order.getDetailList()) {
            packingInboundScanService.createScanUnits(id, detail);
        }
    }

    @Transactional
    public void completeInbound(Long id) {
        packingOrderMapper.updateStatus(id, "RECEIVED");
    }

    @Transactional
    public void completeInboundDetail(Long orderId, Long detailId) {
        packingOrderMapper.updateDetailInboundStatus(orderId, detailId, "DONE");

        long totalCount = packingOrderMapper.countDetailsByOrderId(orderId);
        long receivedCount = packingOrderMapper.countDetailByInboundStatus(orderId, "DONE");

        if (totalCount > 0 && totalCount == receivedCount) {
            packingOrderMapper.updateStatus(orderId, "RECEIVED");
        } else {
            packingOrderMapper.updateStatus(orderId, "SHIPPED");
        }
    }

    @Transactional
    public boolean completePackingScanDetail(Long orderId, Long detailId) {
        packingOrderMapper.updatePackingScanDone(detailId);

        long totalCount = packingOrderMapper.countDetailsByOrderId(orderId);
        long scanDoneCount = packingOrderMapper.countPackingScanDone(orderId);

        return totalCount > 0 && totalCount == scanDoneCount;
    }

    public String findPackingScanStatus(Long detailId) {
        return packingOrderMapper.findPackingScanStatus(detailId);
    }

    public long countDMinus2() {
        return packingOrderMapper.countDMinus2();
    }

    public long countDMinus1() {
        return packingOrderMapper.countDMinus1();
    }

    public long countDDay() {
        return packingOrderMapper.countDDay();
    }

    public long countDPlus1() {
        return packingOrderMapper.countDPlus1();
    }

    public long countDPlus2Over() {
        return packingOrderMapper.countDPlus2Over();
    }

    public List<PackingOrder> findReadyToShipOrders() {
        return packingOrderMapper.findOrdersByStatus("READY_TO_SHIP");
    }

    public List<PackingOrder> findInboundWaitingOrders() {
        return packingOrderMapper.findOrdersByStatus("SHIPPED");
    }

    public List<PackingOrder> findInboundDoneOrders() {
        List<PackingOrder> orderList = packingOrderMapper.findOrdersByStatus("RECEIVED");

        for (PackingOrder order : orderList) {
            order.setDetailList(
                    packingOrderMapper.findDoneDetailsByOrderId(order.getId())
            );
        }

        return orderList;
    }

    public String findInboundStatus(Long detailId) {
        return packingOrderMapper.findInboundStatus(detailId);
    }

    @Transactional
    public void updateInboundDone(Long detailId) {
        packingOrderMapper.updateInboundDone(detailId);
    }

    @Transactional
    public void cancelInbound(Long detailId) {
        packingOrderMapper.cancelInbound(detailId);
    }

    public PackingOrder findForPrint(Long id) {
        PackingOrder order = packingOrderMapper.findOrderById(id);

        if (order != null) {
            order.setDetailList(packingOrderMapper.findDetailsByOrderId(id));
        }

        return order;
    }
}