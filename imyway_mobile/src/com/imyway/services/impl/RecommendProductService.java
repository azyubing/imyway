package com.imyway.services.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.imyway.mapper.IRecommendProductMapper;
import com.imyway.services.IRecommendProductService;

@Service
public class RecommendProductService implements IRecommendProductService {
	@Autowired
	IRecommendProductMapper recommendProductMapper;

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String,Object>> getRecommendProduct(Map<String, String> params) {
		return recommendProductMapper.getRecommendProduct(params);
	}

	@Override
	public List<Map<String, Object>> searchProducts(Map<String, Object> params) {
		return recommendProductMapper.searchProducts(params);
	}

}
