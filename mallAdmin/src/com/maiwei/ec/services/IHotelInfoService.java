package com.maiwei.ec.services;

import java.util.Map;

import com.maiwei.ec.model.HotelInfo;
import com.maiwei.ec.services.base.IBaseInfoService;


public interface IHotelInfoService extends IBaseInfoService<HotelInfo> {
    
    HotelInfo selectHotelInfoByParam(Map<String,Object> param);
    
    
}
