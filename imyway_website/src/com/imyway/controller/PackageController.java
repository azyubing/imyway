package com.imyway.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

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
import com.imyway.model.Evaluation;
import com.imyway.model.PackageInfo;
import com.imyway.model.PackagePriceInfo;
import com.imyway.model.RouteDayInfo;
import com.imyway.model.RouteDetailInfo;
import com.imyway.services.ICityService;
import com.imyway.services.IEvaluationService;
import com.imyway.services.IPackageInfoService;
import com.imyway.services.IPackagePriceInfoService;
import com.imyway.services.IRouteDayInfoService;
import com.imyway.services.IRouteDetailInfoService;
import com.sun.org.apache.xalan.internal.xsltc.runtime.Hashtable;



/**
 * 
 * @author GM
 * 
 */
@Controller
public class PackageController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(PackageController.class);
    @Autowired private IPackageInfoService packageInfoService;
    @Autowired private IPackagePriceInfoService packagePriceInfoService;
    @Autowired private IEvaluationService evaluationService;
    @Autowired private ICityService cityService;
    @Autowired private IRouteDayInfoService routeDayInfoService;
    @Autowired private IRouteDetailInfoService routeDetailInfoService;

    /**
     * 详细页
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/product/package_detail")
    public ModelAndView packageDetail(HttpServletResponse response, HttpServletRequest request,String pid) {
    	ModelAndView mav = new ModelAndView("/product/package_detail");
    	try {
    		Map<String,Object> param = new HashMap<>(3);
    		Date date = new Date();
    		param.put("pid", pid);
    		param.put("date", date);
    		//套餐详情
    		PackageInfo row = packageInfoService.selectPackageInfoByParam(param);
    		
    		//行程日信息
    		List<RouteDayInfo> routeDayInfoList = routeDayInfoService.selectAllListByParam(param);
//    		Map<String,List<RouteDetailInfo>> map = new Hashtable<String, List<RouteDetailInfo>>();
    		List map = new ArrayList();
    		int index = 0;
    		for(RouteDayInfo r:routeDayInfoList){
    			Map<String,Object> param_ = new HashMap<>(5);
    			param_.put("pid", pid);
    			param_.put("pday", r.getPday());
    			List<RouteDetailInfo> rows_ = routeDetailInfoService.selectAllListByParam(param_);
    			param_.put("key", r.getPday()+"");
    			param_.put("rows_", rows_);
    			map.add(param_);
    			index++;
    		}
    		
    		//评论
    		List<Evaluation> evaluationList = evaluationService.getEvaluationListByPid(pid);
    		
    		int countryId = Integer.parseInt(row.getCountry());
    		int cityId =  Integer.parseInt(row.getCity());
    		
    		mav.addObject("country",cityService.getCity(countryId));
    		mav.addObject("city",cityService.getCity(cityId));
    		mav.addObject("pid",pid);
    		mav.addObject("date",date);
    		mav.addObject("row",row);
    		mav.addObject("index",index);
    		mav.addObject("productType","package");
    		mav.addObject("routeDayInfoList",routeDayInfoList);
    		mav.addObject("routeDetailInfoMap",map);
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
    @RequestMapping(value = "/product/package_priceItemDetail")
    public void priceItemDetail(HttpServletResponse response, HttpServletRequest request,String pid,String date) {
        try {
        	Map<String,Object> param = new HashMap<>(3);
        	param.put("pid", pid);
        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            param.put("date", sdf.parse(date));
            // 套餐价格项
            List<PackagePriceInfo> rows = packagePriceInfoService.selectAllListByParam(param);
            //主价格项
            List<PackagePriceInfo> mainRows = new ArrayList<PackagePriceInfo>();
            //附加价格项
            List<PackagePriceInfo> additionalRows = new ArrayList<PackagePriceInfo>();
            for(PackagePriceInfo r:rows){
            	if(r.getPriceGroup().equalsIgnoreCase("0")){
            		mainRows.add(r);
            	}else{
            		additionalRows.add(r);
            	}
            }
            Map<String, Object> reslutMap = new HashMap<>();
            reslutMap.put("mainRows", mainRows);
            reslutMap.put("additionalRows", additionalRows);
        	response.getWriter().print(JSON.toJSONString(reslutMap, JSONProxy.SYSTEM_FEATURE));
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
    @RequestMapping(value = "/product/packagePriceCal")
    public void packagePriceCal(HttpServletResponse response, HttpServletRequest request,String pid,String date) {
        try {
        	
        	Map<String,Object> param = new HashMap<>(3);
        	param.put("pid", pid);
        	param.put("beginDate", CommonUtils.getMonthFirst(date, 0, 1));
            param.put("endDate", CommonUtils.getMonthEnd(date, 2));
            // 套餐价格项
            List<PackagePriceInfo> rows = packagePriceInfoService.getPackagePriceCal(param);
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
    @RequestMapping(value = "/product/package_list")
    public ModelAndView packageList(HttpServletResponse response, HttpServletRequest request) {
    	
    	ModelAndView mav = new ModelAndView("/product/package_list");
    	
    	try {
            //套餐性质 
            mav.addObject("property",packageInfoService.selectProperty());
            
            //住宿等级
            mav.addObject("staylvl",packageInfoService.selectStaylvl());
            
            //包含天数
            List<Map<String,Object>> daycnt = packageInfoService.selectDaycnt();
            mav.addObject("daycnt",daycnt);
            
            //产品分类：0:套餐，1:酒店，2:别墅，3:交通，4:娱乐
            mav.addObject("ptype",0);

        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("login fail. " + e.toString());
        }
        return mav;
    }
    @RequestMapping(value = "/product/package2_list")
    public ModelAndView package2_list(HttpServletResponse response, HttpServletRequest request,
    		String pname, String country , String  city, String  tags,String themeIds,
            String startTime,String endTime,String ptype,
            String property,String daycnt,String staylvl,String minPrice,String maxPrice,
            String cnt,String orderPrice) {
    	
    	ModelAndView mav = new ModelAndView("/product/package2_list");
    	ptype = "0";
    	try {
            //套餐性质 
            mav.addObject("property",packageInfoService.selectProperty());
            
            //住宿等级
            mav.addObject("staylvl",packageInfoService.selectStaylvl());
            
            //包含天数
            List<Map<String,Object>> daycnts = packageInfoService.selectDaycnt();
            mav.addObject("daycnt",daycnts);
            
            //产品分类：0:套餐，1:酒店，2:别墅，3:交通，4:娱乐
            mav.addObject("ptype",ptype);

            Map<String,Object> param = new HashMap<>();
            param.put("pname", getTrimStringVal(pname));
            param.put("country", getTrimStringVal(country));
            param.put("city", getTrimStringVal(city));
            param.put("tags", getTrimStringVal(tags));
            param.put("startTime", getTrimStringVal(startTime));
            param.put("endTime", getTrimStringVal(endTime));
            
            param.put("property", getTrimStringVal(property));
            param.put("daycnt", getTrimStringVal(daycnt));
            param.put("staylvl", getTrimStringVal(staylvl));
            
            param.put("minPrice", getTrimStringVal(minPrice));
            param.put("maxPrice", getTrimStringVal(maxPrice));
            param.put("ptype", getTrimStringVal(ptype));
            if(null != themeIds && !"".equals(themeIds)){
                param.put("themeIds", getTrimStringVal(themeIds).split(","));
            }
            param.put("cnt", getTrimStringVal(cnt));
            param.put("orderPrice", getTrimStringVal(orderPrice));
            
            List<Map<String, Object>> list = packageInfoService.selectPackageListByParam(param);
            mav.addObject("list",list);
            
            
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
     * 套餐list页
     * 
     * @param response
     * @param request
     * @return
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/product/package_list_ajax")
    public void packageListAajax(HttpServletResponse response, HttpServletRequest request,
    		String pname, String country , String  city, String  tags,String themeIds,
            String startTime,String endTime,String ptype,Integer limit,Integer offset,
            String property,String daycnt,String staylvl,String minPrice,String maxPrice,
            String cnt,String orderPrice) {
        
        try {
            Map<String,Object> param = new HashMap<>();
            param.put("pname", getTrimStringVal(pname));
            param.put("country", getTrimStringVal(country));
            param.put("city", getTrimStringVal(city));
            param.put("tags", getTrimStringVal(tags));
            param.put("startTime", getTrimStringVal(startTime));
            param.put("endTime", getTrimStringVal(endTime));
            
            param.put("property", getTrimStringVal(property));
            param.put("daycnt", getTrimStringVal(daycnt));
            param.put("staylvl", getTrimStringVal(staylvl));
            
            param.put("minPrice", getTrimStringVal(minPrice));
            param.put("maxPrice", getTrimStringVal(maxPrice));
            param.put("ptype", getTrimStringVal(ptype));
            if(null != themeIds && !"".equals(themeIds)){
                param.put("themeIds", getTrimStringVal(themeIds).split(","));
            }
            param.put("cnt", getTrimStringVal(cnt));
            param.put("orderPrice", getTrimStringVal(orderPrice));
            
            
           
            //
            Integer totalCount = packageInfoService.getPackageListCount(param);
            
            Integer pageSize = Integer.valueOf(CommonUtils.getPropertiesBykey("pageSize"));
            param.put("limit", pageSize);
            offset = offset==null?0:offset;
            offset = (offset-1)*pageSize;
            param.put("offset", offset);
            
            List<Map<String, Object>> list = packageInfoService.selectPackageListByParam(param);
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
