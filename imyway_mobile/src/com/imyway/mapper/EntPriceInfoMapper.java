package com.imyway.mapper;

import java.util.List;
import java.util.Map;

import com.imyway.mapper.base.IBaseInfoMapper;
import com.imyway.model.EntPriceInfo;
import com.imyway.model.PackagePriceInfo;

public interface EntPriceInfoMapper extends IBaseInfoMapper<EntPriceInfo> {

	/**
	 * 通过id查找价格项
	 * @param id
	 * @return
	 */
	EntPriceInfo selectEntPriceInfoById(int id);

	/**
	 * 价格日历
	 * @param param
	 * @return
	 */
	List<PackagePriceInfo> getEntPriceCal(Map<String, Object> param);

}