package com.imyway.mapper;

import java.util.List;
import java.util.Map;

import com.imyway.mapper.base.IBaseInfoMapper;
import com.imyway.model.HotelInfo;

public interface HotelInfoMapper extends IBaseInfoMapper<HotelInfo> {

    HotelInfo selectHotelInfoByParam(Map<String,Object> param);
    List<Map<String,Object>> selectHotelListByParam(Map<String,Object> param);
    List<Map<String,Object>> selectArea(Map<String,Object> param);
    List<Map<String,Object>> selectStaylvl();
    List<Map<String,Object>> selectMaxCnt();
    
    int countHotelListByParam(Map<String,Object> param);
	int getHotelListCount(Map<String, Object> param);
}