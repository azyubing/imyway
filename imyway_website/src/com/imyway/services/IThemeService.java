package com.imyway.services;

import java.util.List;
import java.util.Map;

import com.imyway.services.base.BaseService;

public interface IThemeService extends BaseService{
    List<Map<String,Object>> getAllListMapByIsHome();
    List<Map<String,Object>> getAllListMapByIsMore();
	List<Map<String, Object>> getAllListMapByIsMore2();
	/**
     * 主题首页显示的主题
     */
	List<Map<String, Object>> getThemeDetailListMap();
}
