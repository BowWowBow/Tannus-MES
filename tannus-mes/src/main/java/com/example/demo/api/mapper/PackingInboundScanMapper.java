package com.example.demo.api.mapper;

import com.example.demo.api.domain.PackingInboundScan;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface PackingInboundScanMapper {

    void insert(PackingInboundScan scan);

    List<PackingInboundScan> findByOrderId(@Param("packingOrderId") Long packingOrderId);

    List<PackingInboundScan> findByDetailId(@Param("detailId") Long detailId);

    PackingInboundScan findByQrInfo(@Param("packingOrderId") Long packingOrderId,
                                    @Param("detailId") Long detailId,
                                    @Param("unitType") String unitType,
                                    @Param("unitNo") Integer unitNo);

    int countByDetailId(@Param("detailId") Long detailId);

    int countWaitingByOrderId(@Param("packingOrderId") Long packingOrderId);

    int countDoneByOrderId(@Param("packingOrderId") Long packingOrderId);

    Integer sumDoneQtyNotAppliedByDetailId(@Param("detailId") Long detailId);

    List<PackingInboundScan> findDoneNotAppliedByOrderId(@Param("packingOrderId") Long packingOrderId);

    void updateScanDone(@Param("id") Long id);

    void updateStockApplied(@Param("id") Long id);

    void cancelScan(@Param("id") Long id);

    int countByUnplannedId(@Param("unplannedId") Long unplannedId);

    int countWaitingByUnplannedId(@Param("unplannedId") Long unplannedId);

}
