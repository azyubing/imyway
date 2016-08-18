package com.imyway.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.SimpleFormatter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.imyway.common.utils.JSONProxy;
import com.imyway.services.IDestinationService;

@Controller
public class DestinationController extends BaseController{

    private static final Logger logger = LoggerFactory.getLogger(AuthcController.class);
	@Autowired
	private IDestinationService destinationService;

    /**
     * 目的地列表
     * @param response
     * @param request
     * @param offset
     * @param limit
     */
	@RequestMapping(value = "/destination/destinationAdminSearchList")
    public void destinationAdminSearchList(HttpServletResponse response, HttpServletRequest request) {
        try {
			Map map = new HashMap();
			List<Map<String, Object>> rows = destinationService.getAllListMap(map);
			response.getWriter().print(JSON.toJSONString(rows, JSONProxy.SYSTEM_FEATURE));

        } catch (Exception e) {
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("destinationAdminSearchList fail. " + e.toString());
        }
    }
    
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "destination/destinationDetail")
	public void destinationDetail(HttpServletResponse response, HttpServletRequest request, Long desId) {
		try {
			List desdetails = destinationService.getDestinationDetail(desId);
			for (Object object : desdetails) {
				Map map = (Map)object;
				Date startdate = (Date) map.get("startdate");
				Date enddate = (Date) map.get("enddate");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				map.put("startdate", sdf.format(startdate));
				map.put("enddate", sdf.format(enddate));
			}
			response.getWriter().print(JSON.toJSONString(desdetails, JSONProxy.SYSTEM_FEATURE));
			
		} catch (Exception e) {
			if (null != e.getMessage()) {
				System.out.println(e.toString());
			}
			logger.info("destinationDetail fail. " + e.toString());
		}
	}
   
	
    
}
