package com.imyway.services;

import java.util.Map;

import com.imyway.model.ProductTemplate;
import com.imyway.services.base.IBaseInfoService;

public interface IProductTemplateService extends IBaseInfoService<ProductTemplate> {
    Map<String,Object> selectByIdAndPtype(Map<String,Object> param);
}
