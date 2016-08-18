package com.maiwei.ec.services;

import java.util.Map;

import com.maiwei.ec.model.VillaInfo;
import com.maiwei.ec.services.base.IBaseInfoService;

public interface IVillaInfoService extends IBaseInfoService<VillaInfo> {
    VillaInfo selectVillaInfoByParam(Map<String,Object> param);
}
