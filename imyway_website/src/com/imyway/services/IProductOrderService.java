package com.imyway.services;

import java.util.List;
import java.util.Map;

import com.imyway.model.ProductOrder;

public interface IProductOrderService {
	
	public void saveProductOrder(ProductOrder productOrder);
	
	/**
	 * 产品订单详情
	 * @param map
	 * @return
	 */
	public List<Map<String,Object>> getRouteOrderInfo(String orderNo);
	/**
	 * 供应商产品订单详情
	 * @param orderNo
	 * @return
	 */
	public List<Map<String,Object>> getSupplierOrderInfo(Map map);
	
	/**
	 * 获取订单中某个产品的订单详细
	 * @param map
	 * @return
	 */
	public List<Map<String, Object>> getProductOrderDetail(Map map);
	
	/**
	 * 获取预订人详情
	 * @param orderNo
	 * @return
	 */
	public List<Map<String, Object>> getOrderCusInfo(String orderNo);

	/**
	 * 供应商订单
	 * @param supplierId
	 * @return
	 */
	public List<Map<String, Object>> getProductOrderBySupplierNo(Map map);
	public int getCountBySupplierNo(Map map);
	/**
	 * 修改产品订单
	 * @param productOrder
	 */
	public void updateProductOrder(ProductOrder productOrder);
}
