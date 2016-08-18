package com.imyway.mobile.utils;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import com.google.gson.Gson;
import com.imyway.mobile.constants.Constants;
import com.imyway.model.User;

public class Utils {

	/**
	 * is the value valid with the regExpression
	 * 
	 * @param pNumber
	 * @param regEx
	 * @param isCaseSensitive
	 * @return
	 */
	public static boolean isValid(String pNumber, String regEx, boolean isCaseSensitive) {
		Pattern pattern;
		if (isCaseSensitive) {
			pattern = Pattern.compile(regEx);
		} else {
			pattern = Pattern.compile(regEx, Pattern.CASE_INSENSITIVE);
		}
		Matcher matcher = pattern.matcher(pNumber);
		return matcher.find();
	}

	/**
	 * generate the returned ajax result
	 * 
	 * @param status
	 * @param object
	 * @param information
	 * @return
	 */
	public static String getReturnedData(String status, Object object, String information) {
		Gson gson = new Gson();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("status", status);
		map.put("body", object);
		map.put("message", information);
		return gson.toJson(map);
	}

	/**
	 * 获取用户信息
	 * @param request
	 * @return
	 */
	public static User getUserInstance(HttpServletRequest request) {
		User user = (User) request.getSession().getAttribute(Constants.USER);
		if (null == user) {
			user = new User();
			user.setId(75);
			user.setUsername("junking1983");
			user.setPhoto("http://www.imyway.cn/images/2.jpg");
		}
		return user;
	}
	
	
}
