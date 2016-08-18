package com.maiwei.ec.service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.maiwei.ec.model.Theme;
import com.maiwei.ec.model.ThemeCatalog;
import com.maiwei.ec.service.base.BaseServiceTest;
import com.maiwei.ec.services.IThemeCatalogService;

/**
 * 主题test
 * @author hyh
 *
 */
public class ThemeCatalogServiceTest extends BaseServiceTest{
	@Autowired
	private IThemeCatalogService service;
	
	@Test
	public void insertTeset() {
		ThemeCatalog t = new ThemeCatalog();
		t.setName("test-name");
		t.setThemeId(3);
		t.setHasProduct(0);
		t.setCtdt(new Date());
		t.setCtuser("1");
		service.insert(t);
		System.out.println(t.getId());
	}

	@Test
	public void deleteByPrimaryKeyTest() {
		int id=1;
		service.deleteByPrimaryKey(id);
	}

	@Test
	public void getAllListTest() {
		System.out.println(service.getAllList());
	}

	@Test
	public void getAllListMapTest() {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("name", "t");
		map.put("offset", 0);
    	map.put("limit", 10);
		System.out.println(service.getAllListMap(map));
	}

	@Test
	public void getOneByPrimaryKeyTest() {
		System.out.println(service.getOneByPrimaryKey(3));
	}

	@Test
	public void getCountTest() {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("name", "t");
		System.out.println(service.getCount(map));
	}

	@Test
	public void updateObjectTest() {
		ThemeCatalog t =(ThemeCatalog) service.getOneByPrimaryKey(7);
		t.setUpdt(new Date());
		t.setHasProduct(0);
		service.updateObject(t);
	}

	@Test
	public void getAllListByMap() {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("name", "t");
		map.put("offset", 0);
    	map.put("limit", 3);
		System.out.println(service.getAllListByMap(map));
	}
}
