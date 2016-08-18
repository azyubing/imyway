package com.imyway.services.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.imyway.mapper.ProductOrderDetailMapper;
import com.imyway.model.ProductOrderDetail;
import com.imyway.services.IProductOrderDetailService;

@Service
public class ProductOrderDetailServiceImpl implements IProductOrderDetailService {

	@Autowired
	private ProductOrderDetailMapper productOrderDetailMapper;
	
	@Override
	public void saveProductOrderDetail(ProductOrderDetail productOrderDetail) {
		productOrderDetailMapper.saveProductOrderDetail(productOrderDetail);
	}

}
