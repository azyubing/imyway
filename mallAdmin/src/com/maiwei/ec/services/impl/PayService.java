package com.maiwei.ec.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maiwei.ec.mapper.IPayMapper;
import com.maiwei.ec.model.PayBean;
import com.maiwei.ec.services.IPayService;

@Service
public class PayService implements IPayService {
	
	@Autowired
	private IPayMapper payMapper;

	@Override
	public List<PayBean> getPayList() {
		// TODO Auto-generated method stub
		return payMapper.getPayList();
	}
	

}
