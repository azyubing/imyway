package com.imyway.services;

import java.util.Map;

import com.imyway.model.RoomTypeInfo;
import com.imyway.services.base.IBaseInfoService;

public interface IRoomTypeInfoService extends IBaseInfoService<RoomTypeInfo> {
    
    Map<String,Object> selectRoomInfoByParam(Map<String,Object> param);
}
