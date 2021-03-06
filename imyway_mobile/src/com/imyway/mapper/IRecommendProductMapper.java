package com.imyway.mapper;

import java.util.List;
import java.util.Map;

import com.imyway.mobile.model.RecommendProduct;

public interface IRecommendProductMapper {
	List<Map<String, Object>> getRecommendProduct(Map<String, String> params);

	List<Map<String, Object>> searchProducts(Map<String, Object> params);
	
	int searchProductsCount(Map<String, Object> params);
}
