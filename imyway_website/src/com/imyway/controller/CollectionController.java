package com.imyway.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.imyway.common.utils.JSONProxy;
import com.imyway.model.Collection;
import com.imyway.model.User;
import com.imyway.services.ICollectionService;

@Controller
public class CollectionController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(CollectionController.class);

	@Autowired private ICollectionService collectionService;
	
	/**
     * ajax新增我的收藏
     * @param response
     * @param request
     * @param menu
     * @return
     */
    @RequestMapping(value = "/collection/ajaxAddCollection")
    public void ajaxGetCityList(HttpServletResponse response, HttpServletRequest request,Collection collection) {
        try {
            String resString = "";
            User user = (User) request.getSession().getAttribute("loginUser");
            if(user == null ){
            	resString = "请先登陆"; 
            	response.getWriter().print(JSON.toJSONString(resString, JSONProxy.SYSTEM_FEATURE));
            	return;
            }
            collection.setUserId(user.getId());
            collection.setCtuser(user.getUsername());
        	collection.setCtdt(new Date());
        	
        	int isPid = collectionService.selectByPid(collection);
        	
        	if(isPid > 0){
        		resString = "您已收藏此产品"; 
        	}else{

                if(collectionService.insert(collection)){
                	resString = "保存成功";
                }else{
                	resString = "保存失败";
                }
        	}
        	
        	response.getWriter().print(JSON.toJSONString(resString, JSONProxy.SYSTEM_FEATURE));
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("ajaxAddCollection fail. " + e.toString());
        }
    }
    
	/**
     * ajax删除我的收藏
     * @param response
     * @param request
     * @param menu
     * @return
     */
    @RequestMapping(value = "/collection/ajaxDelCollection")
    public void ajaxDelCollection(HttpServletResponse response, HttpServletRequest request,Collection collection) {
        try {
        	String resString = "";
            if(collectionService.deleteByPrimaryKey(collection)){
            	resString = "删除成功";
            }else{
            	resString = "删除失败";
            }
        	response.getWriter().print(JSON.toJSONString(resString, JSONProxy.SYSTEM_FEATURE));
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("ajaxDelCollection fail. " + e.toString());
        }
    }
    
}
