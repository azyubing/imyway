package com.imyway.mapper;

import java.util.List;
import java.util.Map;

import com.imyway.mapper.base.BaseMapper;

public interface ThemeMapper extends BaseMapper{
    List<Map<String,Object>> getAllListMapByIsHome();
    List<Map<String,Object>> getAllListMapByIsMore();
	List<Map<String, Object>> getAllListMapByIsMore2();
	List<Map<String, Object>> getThemeDetailListMap();
}
