package com.imyway.mapper;

import java.util.List;

import com.imyway.model.PayBean;

public interface IPayMapper {
	/**
	 * 获取所有的 付款方式集合
	 * @return list
	 */
	public List<PayBean> getPayList();
}
