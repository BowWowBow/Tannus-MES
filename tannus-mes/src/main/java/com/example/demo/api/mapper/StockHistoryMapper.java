package com.example.demo.api.mapper;

import com.example.demo.api.domain.StockHistory;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface StockHistoryMapper {

    void insert(StockHistory history);

    List<StockHistory> findAll();

    List<StockHistory> findByProductType(
            @Param("productType") String productType
    );

    List<StockHistory> findByHistoryType(
            @Param("historyType") String historyType
    );

    List<StockHistory> findByOption(
            @Param("productType") String productType,
            @Param("modelName") String modelName,
            @Param("color") String color,
            @Param("hardness") String hardness
    );

    StockHistory findById(
            @Param("id") Long id
    );

    void delete(
            @Param("id") Long id
    );


}