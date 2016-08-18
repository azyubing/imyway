package com.imyway.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.imyway.common.utils.JSONProxy;
import com.imyway.model.City;
import com.imyway.services.ICityService;

@Controller
public class CityController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(CityController.class);
	@Autowired
	private ICityService cityService;
    /**
     * ajax获取城市列表
     * @param response
     * @param request
     * @param menu
     * @return
     */
    @RequestMapping(value = "/city/ajaxGetCityList")
    public void ajaxGetCityList(HttpServletResponse response, HttpServletRequest request,String parentId) {
        try {
            Map<String,Object> paramCity = new HashMap<>(1);
            paramCity.put("parentId", parentId);
            List<City> cityList = cityService.getCityList(paramCity);
            Map<String, Object> reslutMap = new HashMap<>();
            reslutMap.put("rows", cityList);
            reslutMap.put("total", cityList.size());
        	response.getWriter().print(JSON.toJSONString(reslutMap, JSONProxy.SYSTEM_FEATURE));
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("ajaxGetCityList fail. " + e.toString());
        }
    }
    
    /**
     * ajax获取城市列表
     * @param response
     * @param request
     * @param menu
     * @return
     */
    @RequestMapping(value = "/city/ajaxGetCityListAll")
    public void ajaxGetCityListAll(HttpServletResponse response, HttpServletRequest request) {
    	try {
    		List<City> cityList = cityService.getCityListAll();
    		Map<String, Object> reslutMap = new HashMap<>();
    		reslutMap.put("rows", cityList);
    		reslutMap.put("total", cityList.size());
    		response.getWriter().print(JSON.toJSONString(reslutMap, JSONProxy.SYSTEM_FEATURE));
    	} catch (Exception e) {
    		e.printStackTrace();
    		if (null != e.getMessage()) {
    			System.out.println(e.toString());
    		}
    		logger.info("ajaxGetCityList fail. " + e.toString());
    	}
    }
    
    /**
     * ajax获取热门城市列表
     * @param response
     * @param request
     * @param menu
     * @return
     */
    @RequestMapping(value = "/city/ajaxGetHotCityList")
    public void ajaxGetHotCityList(HttpServletResponse response, HttpServletRequest reques) {
        try {
            Map<String,Object> cityparam = new HashMap<>();
            cityparam.put("isHot", "1");
            cityparam.put("parentId", "1");
            List<City> cityList = cityService.getCityListByIsHot(cityparam);
            response.getWriter().print(JSON.toJSONString(cityList, JSONProxy.SYSTEM_FEATURE));
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("ajaxGetCityList fail. " + e.toString());
        }
    }
   
}
