package com.example.demo.api.service;

import com.example.demo.api.domain.StockHistory;
import com.example.demo.api.mapper.StockHistoryMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StockHistoryService {

    private final StockHistoryMapper stockHistoryMapper;

    public StockHistoryService(StockHistoryMapper stockHistoryMapper) {
        this.stockHistoryMapper = stockHistoryMapper;
    }

    public void save(StockHistory history) {
        stockHistoryMapper.insert(history);
    }

    public List<StockHistory> findAll() {
        return stockHistoryMapper.findAll();
    }

    public List<StockHistory> findByProductType(String productType) {
        return stockHistoryMapper.findByProductType(productType);
    }

    public List<StockHistory> findByHistoryType(String historyType) {
        return stockHistoryMapper.findByHistoryType(historyType);
    }

    public List<StockHistory> findByOption(String productType,
                                           String modelName,
                                           String color,
                                           String hardness) {
        return stockHistoryMapper.findByOption(
                productType,
                modelName,
                color,
                hardness
        );
    }

    public StockHistory findById(Long id) {
        return stockHistoryMapper.findById(id);
    }

    public void delete(Long id) {
        stockHistoryMapper.delete(id);
    }


}