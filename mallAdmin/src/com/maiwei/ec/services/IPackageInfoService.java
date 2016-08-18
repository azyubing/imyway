package com.maiwei.ec.services;

import java.util.Map;

import com.maiwei.ec.model.PackageInfo;
import com.maiwei.ec.services.base.IBaseInfoService;

public interface IPackageInfoService extends IBaseInfoService<PackageInfo> {
    
    PackageInfo selectPackageInfoByParam(Map<String,Object> param);

}
