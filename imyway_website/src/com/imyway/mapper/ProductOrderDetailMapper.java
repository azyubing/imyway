package com.imyway.mapper;

import com.imyway.model.ProductOrderDetail;

public interface ProductOrderDetailMapper {
	public void saveProductOrderDetail(ProductOrderDetail productOrderDetail);

	public void deleteProductOrderDetail(String orderNo);
}
