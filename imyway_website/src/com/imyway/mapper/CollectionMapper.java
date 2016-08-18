package com.imyway.mapper;

import java.util.List;
import java.util.Map;

import com.imyway.mapper.base.IBaseInfoMapper;
import com.imyway.model.Collection;

public interface CollectionMapper extends IBaseInfoMapper<Collection> {
    
	List<Map<String,Object>> selectCollectionProductListByParam(Map<String, Object> param);
	int selectByPid(Collection collection);
	
}