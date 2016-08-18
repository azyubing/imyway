package com.maiwei.ec.services;

import java.util.Map;

import com.maiwei.ec.model.RoomTypeInfo;
import com.maiwei.ec.services.base.IBaseInfoService;

public interface IRoomTypeInfoService extends IBaseInfoService<RoomTypeInfo> {
    
    Map<String,Object> selectRoomInfoByParam(Map<String,Object> param);
}
