package com.example.demo.api.mapper;

import com.example.demo.api.domain.Item;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ItemMapper {

    List<Item> findAll();

    List<Item> findByProductType(@Param("productType") String productType);

    List<Item> search(@Param("keyword") String keyword);

    Item findById(@Param("id") Long id);

    Item findByOption(@Param("productType") String productType,
                      @Param("modelName") String modelName,
                      @Param("color") String color,
                      @Param("hardness") String hardness);

    void increaseStock(@Param("id") Long id,
                       @Param("qty") int qty);

    void updateCurrentQty(@Param("id") Long id,
                          @Param("currentQty") int currentQty);

    void insertItem(Item item);

    List<String> findModelNamesByProductType(@Param("productType") String productType);

    Item findByProductTypeAndModelName(@Param("productType") String productType,
                                       @Param("modelName") String modelName);

    void updateBaseQty(@Param("id") Long id,
                       @Param("baseQty") int baseQty);


}