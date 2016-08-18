package com.maiwei.ec.services;

import java.util.List;
import java.util.Map;

import com.maiwei.ec.model.ProductInfo;
import com.maiwei.ec.services.base.IBaseInfoService;

public interface IProductInfoService extends IBaseInfoService<ProductInfo> {

    List<Map<String,Object>> selectProductInfoListByParam(Map<String,Object> param);
}
