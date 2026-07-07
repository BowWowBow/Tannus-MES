package com.example.demo.api.mapper;

import com.example.demo.api.domain.UnplannedExport;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UnplannedExportMapper {

    void insert(UnplannedExport export);

    List<UnplannedExport> findAllList();

    List<UnplannedExport> findByMonth(String month);

    List<String> findMonths();

    List<UnplannedExport> findByExportOrderId(Long exportOrderId);

    List<UnplannedExport> findPendingList();

    UnplannedExport findById(Long id);

    int countPending();

    void approve(Long id);

    void reject(Long id);

    void delete(Long id);

    int countPendingByExportOrderId(Long exportOrderId);
}
