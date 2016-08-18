package com.maiwei.ec.mapper;

import java.util.Map;

import com.maiwei.ec.mapper.base.IBaseInfoMapper;
import com.maiwei.ec.model.PackageInfo;

public interface PackageInfoMapper extends IBaseInfoMapper<PackageInfo> {

    PackageInfo selectPackageInfoByParam(Map<String,Object> param);
    
}