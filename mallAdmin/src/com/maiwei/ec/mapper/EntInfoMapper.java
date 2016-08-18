package com.maiwei.ec.mapper;

import java.util.Map;

import com.maiwei.ec.mapper.base.IBaseInfoMapper;
import com.maiwei.ec.model.EntInfo;

public interface EntInfoMapper extends IBaseInfoMapper<EntInfo>{
    
    EntInfo selectEntInfoByParam(Map<String,Object> param);

}