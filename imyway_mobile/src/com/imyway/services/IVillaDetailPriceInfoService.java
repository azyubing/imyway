package com.imyway.services;

import java.util.List;
import java.util.Map;

import com.imyway.model.PackagePriceInfo;
import com.imyway.model.VillaDetailPriceInfo;
import com.imyway.services.base.IBaseInfoService;

public interface IVillaDetailPriceInfoService extends IBaseInfoService<VillaDetailPriceInfo> {

	/**
	 * 通过id查找价格项
	 * @param id
	 * @return
	 */
	VillaDetailPriceInfo selectVillaDetailPriceInfoById(int id);

	/**
	 * 别墅价格日历
	 * @param param
	 * @return
	 */
	List<PackagePriceInfo> getVillaPriceCal(Map<String, Object> param);

}
