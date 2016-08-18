package com.imyway.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.imyway.common.utils.JSONProxy;
import com.imyway.model.User;


abstract class BaseController {


    protected boolean getReturnErr(HttpServletResponse response, HttpServletRequest request,
            Map<String, Object> resMap) {
        boolean bool = false;
        Integer err = Integer.valueOf(resMap.get("err").toString());
        if (err > 0) {
            try {
                bool = true;
                response.getWriter().print(JSON.toJSONString(resMap, JSONProxy.SYSTEM_FEATURE));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return bool;
    }
    
    public int getAdminId(HttpServletRequest request) {
    	User user = (User) request.getSession().getAttribute("loginUser");
    	return user.getId();
	}

    protected String getTrimStringVal(String obj){
    	return obj == null ? "":obj.trim();
    }

}
