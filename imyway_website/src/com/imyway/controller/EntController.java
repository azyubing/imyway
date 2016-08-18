package com.imyway.controller;

import java.text.SimpleDateFormat;
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
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.imyway.common.utils.CommonUtils;
import com.imyway.common.utils.JSONProxy;
import com.imyway.model.EntInfo;
import com.imyway.model.EntPriceInfo;
import com.imyway.model.EntRouteDetailInfo;
import com.imyway.model.Evaluation;
import com.imyway.model.PackagePriceInfo;
import com.imyway.services.ICityService;
import com.imyway.services.IEntInfoService;
import com.imyway.services.IEntPriceInfoService;
import com.imyway.services.IEntRouteDetailInfoService;
import com.imyway.services.IEvaluationService;



/**
 * 
 * @author GM
 * 
 */
@Controller
public class EntController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(EntController.class);

    @Autowired private IEntInfoService entInfoService;
    @Autowired private IEntPriceInfoService entPriceInfoService;
    @Autowired private ICityService cityService;
    @Autowired private IEvaluationService evaluationService;
    @Autowired private IEntRouteDetailInfoService entRouteDetailInfoService;
    
    /**
     * 娱乐详细页
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/product/ent_detail")
    public ModelAndView entDetail(HttpServletResponse response, HttpServletRequest request,String pid) {
    	ModelAndView mav = new ModelAndView("/product/ent_detail");
        try {
        	Map<String,Object> param = new HashMap<>(3);
            param.put("pid", pid);
            
            EntInfo row = entInfoService.selectEntInfoByParam(param);
            
            param.put("pday", 1);
            //娱乐行程详情
            List<EntRouteDetailInfo> entRouteDetailInfoList = entRouteDetailInfoService.selectAllListByParam(param);
            
          //评论
            List<Evaluation> evaluationList = evaluationService.getEvaluationListByPid(pid);
            
            int countryId = Integer.parseInt(row.getCountry());
        	int cityId =  Integer.parseInt(row.getCity());
        	
        	mav.addObject("country",cityService.getCity(countryId));
        	mav.addObject("city",cityService.getCity(cityId));
        	mav.addObject("entRouteDetailInfoList",entRouteDetailInfoList);
        	mav.addObject("row",row);
        	mav.addObject("pid",pid);
        	mav.addObject("productType","ent");
            mav.addObject("evaluationList",evaluationList);

        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("login fail. " + e.toString());
        }
        return mav;
    }
    
    /**
     * 有效价格项
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/product/ent_priceItemDetail")
    public void priceItemDetail(HttpServletResponse response, HttpServletRequest request,String pid,String date) {
        try {
        	Map<String,Object> param = new HashMap<>(3);
        	param.put("pid", pid);
        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            param.put("date", sdf.parse(date));
        	List<EntPriceInfo> rows = entPriceInfoService.selectAllListByParam(param);
            
        	response.getWriter().print(JSON.toJSONString(rows));
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("priceItemDetail fail. " + e.toString());
        }
    }
    
    /**
     * 价格日历
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/product/entPriceCal")
    public void entPriceCal(HttpServletResponse response, HttpServletRequest request,String pid,String date) {
        try {
        	
        	Map<String,Object> param = new HashMap<>(3);
        	param.put("pid", pid);
        	param.put("beginDate", CommonUtils.getMonthFirst(date, 0, 1));
            param.put("endDate", CommonUtils.getMonthEnd(date, 2));
            // 别墅价格日历
            List<PackagePriceInfo> rows = entPriceInfoService.getEntPriceCal(param);
        	response.getWriter().print(JSON.toJSONString(rows, JSONProxy.SYSTEM_FEATURE));
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("packagePriceCal fail. " + e.toString());
        }
    }
    
    
    /**
     * list页
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/product/ent_list")
    public ModelAndView entList(HttpServletResponse response, HttpServletRequest request) {
    	
    	ModelAndView mav = new ModelAndView("/product/ent_list");
    	
    	try {

            //娱乐类型
            mav.addObject("enttype",entInfoService.selectEnttype());
            
            //服务类型
            mav.addObject("servicetype",entInfoService.selectServicetype());
            
            //服务语言 
            mav.addObject("language",entInfoService.selectLanguage());

            //产品分类：0:套餐，1:酒店，2:别墅，3:交通，4:娱乐
            mav.addObject("ptype",4);

        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("login fail. " + e.toString());
        }
        return mav;
    }
    
    /**
     * 娱乐list页
     * 
     * @param response
     * @param request
     * @return
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/product/ent_list_ajax")
    public void entListAajax(HttpServletResponse response, HttpServletRequest request,
    		String pname, String country , String  city, String  tags,String themeIds,
            String startTime,String endTime,String ptype,Integer limit,Integer offset,
            String enttype,String servicetype,String language,String minPrice,String maxPrice,
            String cnt,String orderPrice) {
        
        try {
            Map<String,Object> param = new HashMap<>();
            param.put("pname", getTrimStringVal(pname));
            param.put("country", getTrimStringVal(country));
            param.put("city", getTrimStringVal(city));
            param.put("tags", getTrimStringVal(tags));
            param.put("startTime", getTrimStringVal(startTime));
            param.put("endTime", getTrimStringVal(endTime));
            
            param.put("enttype", getTrimStringVal(enttype));
            param.put("servicetype", getTrimStringVal(servicetype));
            param.put("language", getTrimStringVal(language));

            param.put("minPrice", getTrimStringVal(minPrice));
            param.put("maxPrice", getTrimStringVal(maxPrice));
            param.put("ptype", getTrimStringVal(ptype));
            if(null != themeIds && !"".equals(themeIds)){
                param.put("themeIds", getTrimStringVal(themeIds).split(","));
            }
            param.put("cnt", getTrimStringVal(cnt));
            param.put("orderPrice", getTrimStringVal(orderPrice));

            //
            Integer totalCount = entInfoService.getEntListCount(param);
            
            Integer pageSize = Integer.valueOf(CommonUtils.getPropertiesBykey("pageSize"));
            param.put("limit", pageSize);
            offset = offset==null?0:offset;
            offset = (offset-1)*pageSize;
            param.put("offset", offset);
            
            List<Map<String, Object>> list = entInfoService.selectEntListByParam(param);
            Map reslutMap = new HashMap();
            reslutMap.put("rows", list);
            reslutMap.put("totalCount", totalCount);
            reslutMap.put("pageSize", pageSize);
            response.getWriter().print(JSON.toJSONString(reslutMap,JSONProxy.SYSTEM_FEATURE));
            
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("login fail. " + e.toString());
        }

    }
}
