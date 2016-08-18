package com.maiwei.ec.mapper;

import java.util.Map;

import com.maiwei.ec.mapper.base.IBaseInfoMapper;
import com.maiwei.ec.model.ProductTemplate;

public interface ProductTemplateMapper extends IBaseInfoMapper<ProductTemplate> {
    Map<String,Object> selectByPtypeAndCode(Map<String,Object> param);
}