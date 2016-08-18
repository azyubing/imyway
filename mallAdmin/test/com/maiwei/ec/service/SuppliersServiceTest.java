package com.maiwei.ec.service;

import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.maiwei.ec.service.base.BaseServiceTest;
import com.maiwei.ec.services.ISuppliersService;
import com.maiwei.ec.vo.SuppliersVO;

/**
 * 供应商测试
 * @author hyh
 *
 */
public class SuppliersServiceTest extends BaseServiceTest {
	@Autowired
	private ISuppliersService suppliersService;

	@Test
	public void getCountTest() {
		Map map = new HashMap();
		System.out.println(suppliersService.getCount(map));
	}
	
	@Test
	public void getGetOneTest() {
		int sid = 4;
		System.out.println(suppliersService.getSuppliersVO(sid));
	}
	
	@Test
	public void getAllListTest(){
		System.out.println(suppliersService.getAllList());
	}
	
	
	@Test
	public void updateTest() {
		int sid = 4;
		SuppliersVO vo = suppliersService.getSuppliersVO(sid);
		vo.setS_name("123131");
//		suppliersService.update(suppliersBean);
	}
}
