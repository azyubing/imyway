package com.imyway.services;

import java.util.List;
import java.util.Map;

import com.imyway.services.base.BaseService;
import com.imyway.vo.ThemeCatalogVO;

public interface IThemeCatalogService extends BaseService {
	/**
	 * 主题分类vo
	 * @param id
	 * @return
	 */
	public ThemeCatalogVO getThemeCatalogVO(int id);
	
	/**
	 * 查询分类下绑定的商品
	 * @param id
	 * @return
	 */
	public List<Map<String,Object>> getAllProductList(int id);
	
	/**
	 * 查询分类下绑定的商品count
	 * @param id
	 * @return
	 */
	public int getAllProductCount(int id);
}
