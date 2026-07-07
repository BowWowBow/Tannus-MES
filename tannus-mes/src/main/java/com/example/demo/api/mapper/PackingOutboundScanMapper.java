package com.example.demo.api.mapper;

import com.example.demo.api.domain.PackingOutboundScan;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface PackingOutboundScanMapper {

    void insert(PackingOutboundScan scan);

    List<PackingOutboundScan> findByOrderId(@Param("packingOrderId") Long packingOrderId);

    List<PackingOutboundScan> findByDetailId(@Param("detailId") Long detailId);

    PackingOutboundScan findByQrInfo(@Param("packingOrderId") Long packingOrderId,
                                     @Param("detailId") Long detailId,
                                     @Param("scanType") String scanType,
                                     @Param("scanSeq") Integer scanSeq);

    int countByDetailId(@Param("detailId") Long detailId);

    int countWaitingByOrderId(@Param("packingOrderId") Long packingOrderId);

    int countDoneByOrderId(@Param("packingOrderId") Long packingOrderId);

    void updateScanDone(@Param("id") Long id);

    void cancelScan(@Param("id") Long id);

    void deleteByOrderId(@Param("packingOrderId") Long packingOrderId);

    int countWaitingByDetailId(Long detailId);


}