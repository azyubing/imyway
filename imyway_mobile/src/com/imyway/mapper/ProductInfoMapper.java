package com.imyway.mapper;

import java.util.List;
import java.util.Map;

import com.imyway.mapper.base.IBaseInfoMapper;
import com.imyway.model.ProductInfo;

public interface ProductInfoMapper extends IBaseInfoMapper<ProductInfo> {
    
    List<Map<String,Object>> selectProductInfoListByParam(Map<String,Object> param);
    
    List<Map<String, Object>> queryProductsByParam(Map<String, Object> param);

	int getOutCount(Map<String, Object> param);
    
}