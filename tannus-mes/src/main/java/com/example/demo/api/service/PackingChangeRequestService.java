package com.example.demo.api.service;

import com.example.demo.api.domain.PackingChangeRequest;
import com.example.demo.api.mapper.PackingChangeRequestMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PackingChangeRequestService {

    private final PackingChangeRequestMapper packingChangeRequestMapper;

    public PackingChangeRequestService(PackingChangeRequestMapper packingChangeRequestMapper) {
        this.packingChangeRequestMapper = packingChangeRequestMapper;
    }

    @Transactional
    public void save(PackingChangeRequest request) {

        List<Long> pendingOrderIds = packingChangeRequestMapper.findPendingOrderIds();

        if (pendingOrderIds.contains(request.getPackingOrderId())) {
            throw new IllegalStateException("이미 처리 대기 중인 수정요청이 있습니다.");
        }

        if (request.getStatus() == null || request.getStatus().isBlank()) {
            request.setStatus("WAITING");
        }

        packingChangeRequestMapper.insertChangeRequest(request);
    }

    public List<PackingChangeRequest> findAll() {
        return packingChangeRequestMapper.findAll();
    }

    public PackingChangeRequest findById(Long id) {
        return packingChangeRequestMapper.findById(id);
    }

    public List<Long> findPendingOrderIds() {
        return packingChangeRequestMapper.findPendingOrderIds();
    }

    @Transactional
    public void reject(Long id) {
        packingChangeRequestMapper.updateStatus(id, "REJECTED");
    }

    @Transactional
    public void approve(Long id) {
        packingChangeRequestMapper.updateStatus(id, "APPROVED");
    }

    @Transactional
    public void rollback(Long id) {
        packingChangeRequestMapper.updateStatus(id, "WAITING");
    }

    public int countWaiting() {
        return packingChangeRequestMapper.countWaiting();
    }
}

