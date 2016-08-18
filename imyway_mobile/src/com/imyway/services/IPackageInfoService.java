package com.imyway.services;

import java.util.List;
import java.util.Map;

import com.imyway.model.PackageInfo;
import com.imyway.services.base.IBaseInfoService;

public interface IPackageInfoService extends IBaseInfoService<PackageInfo> {
    
    PackageInfo selectPackageInfoByParam(Map<String,Object> param);
    List<Map<String,Object>> selectPackageListByParam(Map<String,Object> param);
    List<Map<String,Object>> selectDaycnt();
    List<Map<String,Object>> selectStaylvl();
    List<Map<String,Object>> selectProperty();
    
    int countPackageListByParam(Map<String,Object> param);
	int getPackageCount();
	Integer getPackageListCount(Map<String, Object> param);
}
