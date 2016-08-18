package com.imyway.services;

import java.util.List;
import java.util.Map;

import com.imyway.mobile.model.RecommendProduct;

public interface IRecommendProductService {
	List<Map<String,Object>> getRecommendProduct(Map<String, String> params);
	List<Map<String, Object>> searchProducts(Map<String, Object> params);
}
