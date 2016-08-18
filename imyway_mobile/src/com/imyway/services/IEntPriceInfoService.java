package com.imyway.services;

import java.util.List;
import java.util.Map;

import com.imyway.model.EntPriceInfo;
import com.imyway.model.PackagePriceInfo;
import com.imyway.services.base.IBaseInfoService;

public interface IEntPriceInfoService extends IBaseInfoService<EntPriceInfo> {

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
