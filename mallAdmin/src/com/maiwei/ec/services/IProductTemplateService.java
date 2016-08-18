package com.maiwei.ec.services;

import java.util.Map;

import com.maiwei.ec.model.ProductTemplate;
import com.maiwei.ec.services.base.IBaseInfoService;

public interface IProductTemplateService extends IBaseInfoService<ProductTemplate> {
    Map<String,Object> selectByIdAndPtype(Map<String,Object> param);
}
