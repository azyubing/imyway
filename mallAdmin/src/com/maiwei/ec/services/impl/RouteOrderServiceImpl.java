package com.maiwei.ec.services.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maiwei.ec.mapper.BookCusInfoMapper;
import com.maiwei.ec.mapper.ProductOrderDetailMapper;
import com.maiwei.ec.mapper.ProductOrderMapper;
import com.maiwei.ec.mapper.RouteOrderMapper;
import com.maiwei.ec.model.BookCusInfo;
import com.maiwei.ec.model.ProductOrder;
import com.maiwei.ec.model.ProductOrderDetail;
import com.maiwei.ec.model.RouteOrder;
import com.maiwei.ec.services.IRouteOrderService;
import com.maiwei.ec.vo.ProductOrderVO;
import com.maiwei.ec.vo.RouteOrderVO;

@Service
public class RouteOrderServiceImpl implements IRouteOrderService {

	@Autowired
	private RouteOrderMapper routeOrderMapper;
	@Autowired
	private ProductOrderMapper productOrderMapper;
	@Autowired
	private ProductOrderDetailMapper productOrderDetailMapper;
	@Autowired
	private BookCusInfoMapper bookCusInfoMapper;
	
	@Override
	public String saveRouteOrder(RouteOrder routeOrder) {
		routeOrderMapper.saveRouteOrder(routeOrder);
		return routeOrder.getCusNo();
	}

	@Override
	public List<Map<String,Object>> getRouteOrderList(Map map) {
		return routeOrderMapper.getRouteOrderList(map);
	}

	@Override
	public RouteOrder getRouteOrder(Map map) {
		return routeOrderMapper.getRouteOrder(map);
	}

	@Override
	public long getRouteStatusCount(String status) {
		return routeOrderMapper.getRouteStatusCount(status);
	}

	@Override
	public int getRouteOrderCount(Map map) {
		return routeOrderMapper.getRouteOrderCount(map);
	}

	@Override
	public void updateRouteStatus(Map map) {
		routeOrderMapper.updateRouteStatus(map);
	}

	@Override
	public void updateRouteAmount(Map map) {
		routeOrderMapper.updateRouteAmount(map);
	}

}
