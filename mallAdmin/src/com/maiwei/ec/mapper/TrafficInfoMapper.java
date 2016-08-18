package com.maiwei.ec.mapper;

import java.util.Map;

import com.maiwei.ec.mapper.base.IBaseInfoMapper;
import com.maiwei.ec.model.TrafficInfo;

public interface TrafficInfoMapper extends IBaseInfoMapper<TrafficInfo> {
    TrafficInfo selectTrafficInfoByParam(Map<String,Object> param);
}