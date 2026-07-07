package com.example.demo.api.service;

import com.example.demo.api.domain.ExportChangeRequest;
import com.example.demo.api.mapper.ExportChangeRequestMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ExportChangeRequestService {

    private final ExportChangeRequestMapper exportChangeRequestMapper;

    public ExportChangeRequestService(ExportChangeRequestMapper exportChangeRequestMapper) {
        this.exportChangeRequestMapper = exportChangeRequestMapper;
    }

    @Transactional
    public void save(ExportChangeRequest request) {

        List<Long> pendingOrderIds =
                exportChangeRequestMapper.findPendingOrderIds();

        if (pendingOrderIds.contains(request.getExportOrderId())) {
            throw new IllegalStateException("이미 처리 대기중인 수정요청이 있습니다.");
        }

        if (request.getStatus() == null ||
                request.getStatus().isBlank()) {

            request.setStatus("WAITING");
        }

        exportChangeRequestMapper.insertChangeRequest(request);
    }

    public List<ExportChangeRequest> findAll() {
        return exportChangeRequestMapper.findAll();
    }

    public ExportChangeRequest findById(Long id) {
        return exportChangeRequestMapper.findById(id);
    }

    public List<Long> findPendingOrderIds() {
        return exportChangeRequestMapper.findPendingOrderIds();
    }

    @Transactional
    public void reject(Long id) {
        exportChangeRequestMapper.updateStatus(id, "REJECTED");
    }

    @Transactional
    public void approve(Long id) {
        exportChangeRequestMapper.updateStatus(id, "APPROVED");
    }

    @Transactional
    public void rollback(Long id) {
        exportChangeRequestMapper.updateStatus(id, "WAITING");
    }

    public int countWaiting() {
        return exportChangeRequestMapper.countWaiting();
    }
}