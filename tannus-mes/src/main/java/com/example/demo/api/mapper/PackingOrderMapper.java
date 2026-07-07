package com.example.demo.api.mapper;

import com.example.demo.api.domain.PackingOrder;
import com.example.demo.api.domain.PackingOrderDetail;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface PackingOrderMapper {

    void insertOrder(PackingOrder order);

    void insertDetail(PackingOrderDetail detail);

    List<PackingOrder> findAllOrders();

    PackingOrder findOrderById(@Param("id") Long id);

    List<PackingOrderDetail> findDetailsByOrderId(@Param("packingOrderId") Long packingOrderId);

    List<PackingOrderDetail> findDoneDetailsByOrderId(@Param("packingOrderId") Long packingOrderId);

    List<PackingOrderDetail> findPackingDoneDetailsByOrderId(@Param("packingOrderId") Long packingOrderId);

    List<PackingOrder> findByStatus(@Param("status") String status);

    List<PackingOrder> findOrdersByStatus(@Param("status") String status);

    long countAll();

    long countByStatus(@Param("status") String status);

    long countTodayAll();

    long countTodayDone();

    long countMonthAll();

    long countMonthDone();

    long countYearAll(@Param("year") int year);

    long countYearDone(@Param("year") int year);

    long countQuarterAll(@Param("year") int year,
                         @Param("quarter") int quarter);

    long countQuarterDone(@Param("year") int year,
                          @Param("quarter") int quarter);

    long countStatsMonthAll(@Param("year") int year,
                            @Param("month") int month);

    long countStatsMonthDone(@Param("year") int year,
                             @Param("month") int month);

    long countWeekAll(@Param("year") int year,
                      @Param("week") int week);

    long countWeekDone(@Param("year") int year,
                       @Param("week") int week);

    long countDMinus2();

    long countDMinus1();

    long countDDay();

    long countDPlus1();

    long countDPlus2Over();

    void updateStatus(@Param("id") Long id,
                      @Param("status") String status);

    void updateOrder(PackingOrder order);

    void deleteDetails(@Param("packingOrderId") Long packingOrderId);

    void updateCompletedAt(@Param("id") Long id);

    List<PackingOrder> findOrdersByMonth(@Param("month") String month);

    List<String> findOrderMonths();

    void updateDetailInboundStatus(@Param("orderId") Long orderId,
                                   @Param("detailId") Long detailId,
                                   @Param("status") String status);

    long countDetailByInboundStatus(@Param("orderId") Long orderId,
                                    @Param("status") String status);

    long countDetailsByOrderId(@Param("orderId") Long orderId);

    String findInboundStatus(@Param("detailId") Long detailId);

    void updateInboundDone(@Param("detailId") Long detailId);

    void cancelInbound(@Param("detailId") Long detailId);

    void updatePackingScanDone(@Param("detailId") Long detailId);

    String findPackingScanStatus(@Param("detailId") Long detailId);

    long countPackingScanDone(@Param("orderId") Long orderId);

    List<PackingOrder> findAll();
}
