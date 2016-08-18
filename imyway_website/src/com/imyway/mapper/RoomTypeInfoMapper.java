package com.imyway.mapper;

import java.util.Map;

import com.imyway.mapper.base.IBaseInfoMapper;
import com.imyway.model.RoomTypeInfo;

public interface RoomTypeInfoMapper extends IBaseInfoMapper<RoomTypeInfo> {
    
    Map<String,Object> selectRoomInfoByParam(Map<String,Object> param);
}