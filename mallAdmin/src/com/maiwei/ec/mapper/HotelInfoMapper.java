package com.maiwei.ec.mapper;

import java.util.Map;

import com.maiwei.ec.mapper.base.IBaseInfoMapper;
import com.maiwei.ec.model.HotelInfo;

public interface HotelInfoMapper extends IBaseInfoMapper<HotelInfo> {

    HotelInfo selectHotelInfoByParam(Map<String,Object> param);
    
    
}