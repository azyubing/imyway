package com.maiwei.ec.mapper;

import java.util.Map;

import com.maiwei.ec.mapper.base.BaseMapper;
import com.maiwei.ec.vo.LoginInfoVO;

public interface LoginInfoMapper extends BaseMapper {

	/**
	 * 验证用户名和密码
	 * @param loginName
	 * @return
	 */
	int checkLoginName(String loginName);
	/**
	 * 登入
	 * @param map
	 * @return
	 */
	public int login(Map map);
	
	/**
	 * 登入讯息
	 * @param map
	 * @return
	 */
	public LoginInfoVO getLoginInfo(Map map);
	
}
