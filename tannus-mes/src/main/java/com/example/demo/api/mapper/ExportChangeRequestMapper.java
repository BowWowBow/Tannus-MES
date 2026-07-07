package com.example.demo.api.mapper;

import com.example.demo.api.domain.ExportChangeRequest;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ExportChangeRequestMapper {

    void insertChangeRequest(ExportChangeRequest request);

    List<ExportChangeRequest> findAll();

    ExportChangeRequest findById(Long id);

    List<Long> findPendingOrderIds();

    void updateStatus(@Param("id") Long id,
                      @Param("status") String status);

    int countWaiting();


}