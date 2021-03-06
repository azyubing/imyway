package com.imyway.mapper;

import java.util.List;
import java.util.Map;

import com.imyway.mapper.base.IBaseInfoMapper;
import com.imyway.model.PackagePriceInfo;

public interface PackagePriceInfoMapper extends IBaseInfoMapper<PackagePriceInfo>  {

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