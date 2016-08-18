package com.imyway.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.imyway.common.utils.JSONProxy;
import com.imyway.services.IThemeService;
import com.imyway.services.impl.ThemeProductImpl;



/**
 * 
 * @author GM
 * 
 */
@Controller
public class ThemeController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(ThemeController.class);

    @Autowired private IThemeService themeService;
    @Autowired private ThemeProductImpl themeProductImpl;

    @RequestMapping(value = "/themeDetail")
    public ModelAndView themeDetail(
            HttpServletResponse response, HttpServletRequest request) {

    	ModelAndView mav = new ModelAndView("/themeDetail");
    	
        try {
        	//List<Map<String,Object>> themeList = randomList(themeService.getThemeDetailListMap());
        	List<Map<String,Object>> themeList = themeService.getThemeDetailListMap();
        	for(Map<String,Object> themeMap : themeList){
        		Map<String,Object> param = new HashMap<>(1);
        		param.put("themeId", themeMap.get("id"));
        		List<Map<String,Object>> themeProductList = themeProductImpl.getThemeProductDetailListMap(param);
        		themeMap.put("themeProductList", themeProductList);
        		List<Map<String,Object>> themeProductCityList = themeProductImpl.getThemeProductCityList(param);
        		themeMap.put("themeProductCityList", themeProductCityList);
        	}
        	
        	mav.addObject("themeList", themeList);
        	
        } catch (Exception e) {
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("themeDetail fail. " + e.toString());
        }
        return mav;
    }
    
    /**
     * ajax获取主题列表
     * @param response
     * @param request
     * @param menu
     * @return
     */
    @SuppressWarnings("rawtypes")
	@RequestMapping(value = "/themeList")
    public void themeList(HttpServletResponse response, HttpServletRequest request) {
        try {
            List themelist = themeService.getAllListMap(new HashMap());
        	response.getWriter().print(JSON.toJSONString(themelist, JSONProxy.SYSTEM_FEATURE));
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("themeList fail. " + e.toString());
        }
    }
    
    public static <V> List<V> randomList(List<V> sourceList) {  
        if (sourceList == null || sourceList.size() == 0) {  
            return sourceList;  
        }  
        List<V> random = new ArrayList<V>(sourceList.size());  
        do {  
            int index = Math.abs(new Random().nextInt(sourceList.size()));  
            random.add(sourceList.remove(index));  
      
        } while (sourceList.size() > 0);  
      
        return random;  
      
    } 
   
}
