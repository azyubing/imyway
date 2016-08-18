package com.maiwei.ec.services;

import java.util.Map;

import com.maiwei.ec.model.EntInfo;
import com.maiwei.ec.services.base.IBaseInfoService;

public interface IEntInfoService extends IBaseInfoService<EntInfo> {
    
    EntInfo selectEntInfoByParam(Map<String,Object> param);
}
