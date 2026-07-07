package com.example.demo.api.service;

import com.example.demo.api.domain.InoutHistory;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.atomic.AtomicLong;

@Service
public class InoutService {

    private final List<InoutHistory> store = new CopyOnWriteArrayList<>();
    private final AtomicLong seq = new AtomicLong(1);

    public List<InoutHistory> findAll() {
        return new ArrayList<>(store);
    }

    public void in(String itemName,
                   int quantity,
                   String detailJson,
                   String workerName,
                   String location,
                   Integer boxQty,
                   String packDate,
                   String scanRaw) {

        InoutHistory h = new InoutHistory();
        h.setId(seq.getAndIncrement());
        h.setItemName(itemName);
        h.setQuantity(quantity);
        h.setUnit("EA");
        h.setIoType("IN");
        h.setLocation(location != null && !location.isBlank() ? location : "기본창고");
        h.setWorkerName(workerName != null && !workerName.isBlank() ? workerName : "MES-USER01");
        h.setCreatedAt(LocalDateTime.now());
        h.setDetailJson(detailJson);

        h.setBoxQty(boxQty);
        h.setPackDate(packDate);
        h.setScanRaw(scanRaw);

        store.add(h);
    }

    public void out(String itemName, int quantity) {
        InoutHistory h = new InoutHistory();
        h.setId(seq.getAndIncrement());
        h.setItemName(itemName);
        h.setQuantity(quantity);
        h.setUnit("EA");
        h.setIoType("OUT");
        h.setLocation("기본창고");
        h.setWorkerName("MES-USER01");
        h.setCreatedAt(LocalDateTime.now());
        h.setDetailJson(null);
        store.add(h);
    }

    public InoutHistory findById(Long id) {
        return store.stream()
                .filter(h -> h.getId().equals(id))
                .findFirst()
                .orElse(null);
    }
    public void in(String itemName, int quantity, String detailJson) {
        in(itemName, quantity, detailJson, "IN", "기본창고", 1, "MES-USER01", "");
    }
}
