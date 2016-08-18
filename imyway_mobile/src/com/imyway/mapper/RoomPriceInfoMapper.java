package com.imyway.mapper;

import java.util.List;
import java.util.Map;

import com.imyway.mapper.base.IBaseInfoMapper;
import com.imyway.model.PackagePriceInfo;
import com.imyway.model.RoomPriceInfo;

public interface RoomPriceInfoMapper extends IBaseInfoMapper<RoomPriceInfo> {

	/**
	 * 通过id查找价格项
	 * @param id
	 * @return
	 */
	RoomPriceInfo selectRoomPriceInfoById(int id);

	/**
	 * 酒店价格日历
	 * @param param
	 * @return
	 */
	List<PackagePriceInfo> gethotelPriceCal(Map<String, Object> param);
    
}