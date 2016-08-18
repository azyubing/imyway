package com.imyway.mapper;

import java.util.List;
import java.util.Map;

import com.imyway.mapper.base.IBaseInfoMapper;
import com.imyway.model.PackagePriceInfo;
import com.imyway.model.VillaDetailPriceInfo;

public interface VillaDetailPriceInfoMapper extends IBaseInfoMapper<VillaDetailPriceInfo> {

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