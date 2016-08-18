package com.imyway.services;

import java.util.List;
import java.util.Map;

import com.imyway.model.Collection;
import com.imyway.services.base.IBaseInfoService;

public interface ICollectionService extends IBaseInfoService<Collection> {
	List<Map<String,Object>> selectCollectionProductListByParam(Map<String, Object> param);
	int selectByPid(Collection collection);
}
