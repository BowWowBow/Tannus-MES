package com.example.demo.api.mapper;

import com.example.demo.api.domain.UnplannedPurchase;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UnplannedPurchaseMapper {

    // 무발주 등록
    void insert(UnplannedPurchase purchase);

    // 지시번호별 조회
    List<UnplannedPurchase> findByPackingOrderId(@Param("packingOrderId") Long packingOrderId);

    // 승인대기 목록
    List<UnplannedPurchase> findPendingList();

    // 전체 이력 목록
    List<UnplannedPurchase> findAllList();

    // 월별 이력 목록
    List<UnplannedPurchase> findByMonth(@Param("month") String month);

    // 월 목록
    List<String> findMonths();

    // 단건 조회
    UnplannedPurchase findById(@Param("id") Long id);

    // 승인 처리
    void approve(@Param("id") Long id,
                 @Param("approvedBy") String approvedBy);

    // 반려 처리
    void reject(@Param("id") Long id,
                @Param("approvedBy") String approvedBy);

    // 입고 상태 조회
    String findInboundStatus(@Param("id") Long id);

    // 무발주 입고 완료 처리
    void updateInboundDone(@Param("id") Long id);

    // 무발주 입고 취소 처리
    void cancelInbound(@Param("id") Long id);

    // 무발주 삭제
    void delete(@Param("id") Long id);

    // 요청자별 건수 조회
    int countByRequestUser(@Param("requestUser") String requestUser);

    void updateStockApplied(Long id);

}