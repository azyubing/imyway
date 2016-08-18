package com.imyway.services;

import java.util.List;
import java.util.Map;

import com.imyway.model.PackagePriceInfo;
import com.imyway.services.base.IBaseInfoService;

public interface IPackagePriceInfoService extends IBaseInfoService<PackagePriceInfo> {

	/**
	 * 通过id查找价格项
	 * @param id
	 * @return
	 */
	PackagePriceInfo selectPackagePriceInfoById(int id);

	/**
	 * 价格日历
	 * @param param
	 * @return
	 */
	List<PackagePriceInfo> getPackagePriceCal(Map<String, Object> param);

}
