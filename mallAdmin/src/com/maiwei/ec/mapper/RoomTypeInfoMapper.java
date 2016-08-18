package com.maiwei.ec.mapper;

import java.util.Map;

import com.maiwei.ec.mapper.base.IBaseInfoMapper;
import com.maiwei.ec.model.RoomTypeInfo;

public interface RoomTypeInfoMapper extends IBaseInfoMapper<RoomTypeInfo> {
    
    Map<String,Object> selectRoomInfoByParam(Map<String,Object> param);
}