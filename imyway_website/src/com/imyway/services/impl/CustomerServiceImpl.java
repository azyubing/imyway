package com.imyway.services.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.imyway.mapper.CustomerMapper;
import com.imyway.services.ICustomerService;

/**
 * 客户管理
 * @author hyh
 *
 */
@Service
public class CustomerServiceImpl implements ICustomerService {

	@Autowired
	private CustomerMapper customerMapper;
	@Override
	public int insert(Object o) {
		customerMapper.insert(o);
		return 0;
	}

	@Override
	public void deleteByPrimaryKey(int id) {
		customerMapper.deleteByPrimaryKey(id);
	}

	@Override
	public List<Object> getAllList() {
		return customerMapper.getAllList();
	}

	@Override
	public List<Object> getAllListByMap(Map map) {
		return customerMapper.getAllListByMap(map);
	}

	@Override
	public List<Map<String, Object>> getAllListMap(Map map) {
		return customerMapper.getAllListMap(map);
	}

	@Override
	public Object getOneByPrimaryKey(int id) {
		return customerMapper.getOneByPrimaryKey(id);
	}

	@Override
	public long getCount(Map map) {
		return customerMapper.getCount(map);
	}

	@Override
	public void updateObject(Object o) {
		customerMapper.updateObject(o);
	}

	@Override
	public void deleteBucthCustomer(String[] str) {
		customerMapper.deleteBucthCustomer(str);
	}

}
