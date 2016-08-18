package com.maiwei.ec.service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.maiwei.ec.model.Theme;
import com.maiwei.ec.service.base.BaseServiceTest;
import com.maiwei.ec.services.IThemeService;

/**
 * 主题test
 * @author hyh
 *
 */
public class ThemeServiceTest extends BaseServiceTest{
	@Autowired
	private IThemeService themeService;
	
	@Test
	public void insertTeset() {
		Theme t = new Theme();
		t.setName("test-name");
		t.setIsHome(0);
		t.setHomeShowOrder(100);
		t.setIsMore(1);
		t.setMoreShowOrder(100);
		t.setCtdt(new Date());
		t.setCtuser("1");
		themeService.insert(t);
		System.out.println(t.getId());
	}

	@Test
	public void deleteByPrimaryKeyTest() {
		int id=1;
		themeService.deleteByPrimaryKey(id);
	}

	@Test
	public void getAllListTest() {
		System.out.println(themeService.getAllList());
	}

	@Test
	public void getAllListMapTest() {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("name", "t");
		map.put("offset", 0);
    	map.put("limit", 10);
		System.out.println(themeService.getAllListMap(map));
	}

	@Test
	public void getOneByPrimaryKeyTest() {
		System.out.println(themeService.getOneByPrimaryKey(3));
	}

	@Test
	public void getCountTest() {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("name", "t");
		System.out.println(themeService.getCount(map));
	}

	@Test
	public void updateObjectTest() {
		Theme t =(Theme) themeService.getOneByPrimaryKey(3);
		t.setUpdt(new Date());
		t.setUpuser("2222");
		t.setName("name-update");
		themeService.updateObject(t);
	}

	@Test
	public void getAllListByMap() {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("name", "t");
		map.put("offset", 0);
    	map.put("limit", 3);
		System.out.println(themeService.getAllListByMap(map));
	}
}
