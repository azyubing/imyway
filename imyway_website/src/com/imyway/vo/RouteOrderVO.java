package com.imyway.vo;

import java.util.List;

import com.imyway.model.RouteOrder;

/**
 * 行程单
 * @author hyh
 *
 */
public class RouteOrderVO {
	private RouteOrder routeOrder;
	private List<ProductOrderVO> ProductOrderVOList;//产品订单
	
	public RouteOrder getRouteOrder() {
		return routeOrder;
	}
	public void setRouteOrder(RouteOrder routeOrder) {
		this.routeOrder = routeOrder;
	}
	public List<ProductOrderVO> getProductOrderVOList() {
		return ProductOrderVOList;
	}
	public void setProductOrderVOList(List<ProductOrderVO> productOrderVOList) {
		ProductOrderVOList = productOrderVOList;
	}
	
}
