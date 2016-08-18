package com.imyway.mapper;

import java.util.List;
import java.util.Map;

import com.imyway.mapper.base.IBaseInfoMapper;
import com.imyway.model.PackageInfo;

public interface PackageInfoMapper extends IBaseInfoMapper<PackageInfo> {

    PackageInfo selectPackageInfoByParam(Map<String,Object> param);
    List<Map<String,Object>> selectPackageListByParam(Map<String,Object> param);
    List<Map<String,Object>> selectDaycnt();
    List<Map<String,Object>> selectStaylvl();
    List<Map<String,Object>> selectProperty();
    
    int countPackageListByParam(Map<String,Object> param);
	int getPackageCount();
	int getPackageListCount(Map<String,Object> param);
}