package com.example.demo.api.mapper;

import com.example.demo.api.domain.ExportOutboundScan;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ExportOutboundScanMapper {

    void insert(ExportOutboundScan scan);

    int countByDetailId(@Param("detailId") Long detailId);

    List<ExportOutboundScan> findByOrderId(@Param("exportOrderId") Long exportOrderId);

    List<ExportOutboundScan> findByDetailId(@Param("detailId") Long detailId);

    ExportOutboundScan findByQrInfo(@Param("exportOrderId") Long exportOrderId,
                                    @Param("detailId") Long detailId,
                                    @Param("unitType") String unitType,
                                    @Param("unitNo") Integer unitNo);

    void updateScanDone(@Param("id") Long id);

    int countWaitingByOrderId(@Param("exportOrderId") Long exportOrderId);

    int countDoneByOrderId(@Param("exportOrderId") Long exportOrderId);

    int countWaitingByDetailId(@Param("detailId") Long detailId);

    int countDoneByDetailId(@Param("detailId") Long detailId);

    void cancelScan(@Param("id") Long id);

    List<ExportOutboundScan> findDoneNotAppliedByOrderId(@Param("exportOrderId") Long exportOrderId);

    void updateStockApplied(@Param("id") Long id);

    int sumDoneQtyNotApplied(@Param("detailId") Long detailId);

    void applyStockByDetailId(@Param("detailId") Long detailId);

    void deleteWaitingByOrderId(@Param("exportOrderId") Long exportOrderId);

    void deleteWaitingUnplannedByOrderId(@Param("exportOrderId") Long exportOrderId);

    void deleteByOrderId(@Param("exportOrderId") Long exportOrderId);

}