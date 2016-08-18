package com.imyway.services;

import java.util.List;
import java.util.Map;

import com.imyway.model.ProductInfo;
import com.imyway.services.base.IBaseInfoService;

public interface IProductInfoService extends IBaseInfoService<ProductInfo> {

    List<Map<String,Object>> selectProductInfoListByParam(Map<String,Object> param);

	int getOutCount(Map<String, Object> param);
}
