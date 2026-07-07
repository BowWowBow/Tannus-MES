package com.example.demo.api.mapper;

import com.example.demo.api.domain.ExportOrder;
import com.example.demo.api.domain.ExportOrderDetail;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ExportOrderMapper {

    void insertOrder(ExportOrder order);

    void insertDetail(ExportOrderDetail detail);

    List<ExportOrder> findAll();

    ExportOrder findById(@Param("id") Long id);

    List<ExportOrderDetail> findDetailsByOrderId(@Param("exportOrderId") Long exportOrderId);

    int countByStatus(@Param("status") String status);

    List<ExportOrder> findByStatus(@Param("status") String status);

    void updateStatus(@Param("id") Long id,
                      @Param("status") String status);

    void updateStockApplied(@Param("id") Long id,
                            @Param("stockApplied") String stockApplied);

    void updateDetailOutboundStatus(@Param("detailId") Long detailId);

    void cancelOutboundByOrderId(@Param("exportOrderId") Long exportOrderId);

    int countDetailDone(@Param("exportOrderId") Long exportOrderId);

    int countDetailAll(@Param("exportOrderId") Long exportOrderId);

    List<ExportOrder> findByMonth(@Param("month") String month);

    List<String> findOrderMonths();

    void updateOrder(ExportOrder order);

    void deleteDetails(Long exportOrderId);

    int countByYear(int year);

    int countDoneByYear(int year);

    int countByQuarter(int year, int quarter);

    int countDoneByQuarter(int year, int quarter);

    int countByMonthForStats(int year, int month);

    int countDoneByMonthForStats(int year, int month);

    int countByWeek(int year, int week);

    int countDoneByWeek(int year, int week);

    int countDMinus2();

    int countDMinus1();

    int countDDay();

    int countDPlus1();

    int countDPlus2Over();

    ExportOrder findWorkOrderById(@Param("id") Long id);


}