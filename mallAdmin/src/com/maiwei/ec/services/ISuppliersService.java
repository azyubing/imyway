package com.maiwei.ec.services;

import java.util.List;
import java.util.Map;

import com.maiwei.ec.model.SuppliersBean;
import com.maiwei.ec.vo.SuppliersVO;

public interface ISuppliersService {
	/**
	 * 添加
	 * @param suppliersBean
	 */
	public void save(SuppliersBean suppliersBean);
	
	/**
	 * 添加
	 * @param suppliersBean
	 */
	public void update(SuppliersBean suppliersBean);
	
	/**
	 * 查找
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> getSuppliersBeanList(Map map);
	
	/**
	 * 查找所有
	 * @param map
	 * @return
	 */
	public List<SuppliersBean> getAllList();
	
	/**
	 * 总记录数
	 * @param map
	 * @return
	 */
	public int getCount(Map map);
	
	/**
	 * 查找供应商
	 * @param sid
	 * @return
	 */
	public SuppliersVO getSuppliersVO(int sid);
}
