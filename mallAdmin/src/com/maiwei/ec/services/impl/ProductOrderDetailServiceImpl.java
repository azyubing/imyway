package com.maiwei.ec.services.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maiwei.ec.mapper.ProductOrderDetailMapper;
import com.maiwei.ec.model.ProductOrderDetail;
import com.maiwei.ec.services.IProductOrderDetailService;

@Service
public class ProductOrderDetailServiceImpl implements IProductOrderDetailService {

	@Autowired
	private ProductOrderDetailMapper productOrderDetailMapper;
	
	@Override
	public void saveProductOrderDetail(ProductOrderDetail productOrderDetail) {
		productOrderDetailMapper.saveProductOrderDetail(productOrderDetail);
	}

}
