package com.maiwei.ec.mapper;

import java.util.List;
import java.util.Map;

import com.maiwei.ec.mapper.base.IBaseInfoMapper;
import com.maiwei.ec.model.ProductInfo;

public interface ProductInfoMapper extends IBaseInfoMapper<ProductInfo> {
    
    List<Map<String,Object>> selectProductInfoListByParam(Map<String,Object> param);
    
}