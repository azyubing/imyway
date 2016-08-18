package com.maiwei.ec.services;

import java.util.Map;

import com.maiwei.ec.model.TrafficInfo;
import com.maiwei.ec.services.base.IBaseInfoService;

public interface ITrafficInfoService extends IBaseInfoService<TrafficInfo> {
    TrafficInfo selectTrafficInfoByParam(Map<String,Object> param);

}
