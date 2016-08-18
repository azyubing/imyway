package com.imyway.mapper;

import java.util.Map;

import com.imyway.mapper.base.IBaseInfoMapper;
import com.imyway.model.ProductTemplate;

public interface ProductTemplateMapper extends IBaseInfoMapper<ProductTemplate> {
    Map<String,Object> selectByPtypeAndCode(Map<String,Object> param);
}