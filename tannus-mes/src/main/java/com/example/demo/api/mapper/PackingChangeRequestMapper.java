package com.example.demo.api.mapper;

import com.example.demo.api.domain.PackingChangeRequest;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface PackingChangeRequestMapper {

    void insertChangeRequest(PackingChangeRequest request);

    List<PackingChangeRequest> findAll();

    PackingChangeRequest findById(Long id);

    List<Long> findPendingOrderIds();

    void updateStatus(@Param("id") Long id,
                      @Param("status") String status);

    int countWaiting();
}