package com.maiwei.ec.mapper;

import java.util.Map;

import com.maiwei.ec.mapper.base.IBaseInfoMapper;
import com.maiwei.ec.model.VillaInfo;

public interface VillaInfoMapper extends IBaseInfoMapper<VillaInfo>{
    VillaInfo selectVillaInfoByParam(Map<String,Object> param);
}