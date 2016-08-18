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
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.imyway.common.utils.CommonUtils;
import com.imyway.common.utils.JSONProxy;
import com.imyway.model.Evaluation;
import com.imyway.model.TrafficCharteredPriceInfo;
import com.imyway.model.TrafficInfo;
import com.imyway.services.ICityService;
import com.imyway.services.IEvaluationService;
import com.imyway.services.ITrafficCharteredPriceInfoService;
import com.imyway.services.ITrafficInfoService;




/**
 * 
 * @author GM
 * 
 */
@Controller
public class TrafficController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(TrafficController.class);

    @Autowired private ITrafficInfoService trafficInfoService;
    @Autowired private ICityService cityService;
    @Autowired private IEvaluationService evaluationService;
    @Autowired private ITrafficCharteredPriceInfoService trafficCharteredPriceInfoService;

    
    

    /**
     * 交通详细页
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/product/traffic_detail")
    public ModelAndView trafficDetail(HttpServletResponse response, HttpServletRequest request,String pid) {
    	ModelAndView mav = new ModelAndView("/product/traffic_detail");
        try {
        	Map<String,Object> param = new HashMap<>(3);
            param.put("pid", pid);
        	
        	TrafficInfo row = trafficInfoService.selectTrafficInfoByParam(param);
        	int countryId = Integer.parseInt(row.getCountry());
        	int cityId =  Integer.parseInt(row.getCity());
        	
        	param.put("pid", pid);
        	param.put("time", "09:00");
            List<TrafficCharteredPriceInfo> rows = trafficCharteredPriceInfoService.selectPriceInfo(param);
        	
//          List<TrafficCharteredPriceInfo> rows = trafficCharteredPriceInfoService.selectAllListByParam(param);
        	
        	//评论
        	List<Evaluation> evaluationList = evaluationService.getEvaluationListByPid(pid);
        	
        	mav.addObject("country",cityService.getCity(countryId));
        	mav.addObject("city",cityService.getCity(cityId));
        	mav.addObject("row",row);
        	mav.addObject("pid",pid);
        	mav.addObject("rows",rows);
        	mav.addObject("productType","traffic");
        	mav.addObject("rowsstr", JSON.toJSONString(rows));
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
    @RequestMapping(value = "/product/traffic_priceItemDetail")
    public void selectPriceInfo(HttpServletResponse response, HttpServletRequest request,String pid,String time) {
        try {
        	Map<String,Object> param = new HashMap<>(3);
        	param.put("pid", pid);
        	if(time==null){
        		time="09:00";
        	}
        	param.put("time", time);
            List<TrafficCharteredPriceInfo> rows = trafficCharteredPriceInfoService.selectPriceInfo(param);
            
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
     * 交通list页
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/product/traffic_list")
    public ModelAndView trafficList(HttpServletResponse response, HttpServletRequest request,
            String pname) {
    	
    	ModelAndView mav = new ModelAndView("/product/traffic_list");
        
        try {
            
            //起点列表
            mav.addObject("startplace",trafficInfoService.selectStartplace());
            
            //终点列表
            mav.addObject("endplace",trafficInfoService.selectEndplace());
            
            //用车等级列表
            mav.addObject("carlvl",trafficInfoService.selectCarlvl());
            
            //车型列表
            mav.addObject("cartype",trafficInfoService.selectCartype());

            //产品分类：0:套餐，1:酒店，2:别墅，3:交通，4:娱乐
            mav.addObject("ptype",3);

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
     * 交通list页
     * 
     * @param response
     * @param request
     * @return
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/product/traffic_list_ajax")
    public void trafficListAajax(HttpServletResponse response, HttpServletRequest request,
            String pname, String country , String  city, String  tags,String themeIds,Integer limit,Integer offset,
            String startTime,String endTime,String ptype,
            //String startplace, String endplace, 
            String carlvl, String cartype,
            String cnt,String orderPrice) {
        
        try {
            Map<String,Object> param = new HashMap<>();
            param.put("pname", getTrimStringVal(pname));
            param.put("country", getTrimStringVal(country));
            param.put("city", getTrimStringVal(city));
            param.put("tags", getTrimStringVal(tags));
            param.put("startTime", getTrimStringVal(startTime));
            param.put("endTime", getTrimStringVal(endTime));
            
            //param.put("startplace", getTrimStringVal(startplace));
            //param.put("endplace", getTrimStringVal(endplace));
            param.put("carlvl", getTrimStringVal(carlvl));
            param.put("cartype", getTrimStringVal(cartype));
            
            param.put("ptype", getTrimStringVal(ptype));
            if(null != themeIds && !"".equals(themeIds)){
                param.put("themeIds", getTrimStringVal(themeIds).split(","));
            }
            param.put("cnt", getTrimStringVal(cnt));
            param.put("orderPrice", getTrimStringVal(orderPrice));
            
            //
            Integer totalCount = trafficInfoService.getTrafficListCount(param);
            
            Integer pageSize = Integer.valueOf(CommonUtils.getPropertiesBykey("pageSize"));
            param.put("limit", pageSize);
            offset = offset==null?0:offset;
            offset = (offset-1)*pageSize;
            param.put("offset", offset);
            
            List<Map<String, Object>> list = trafficInfoService.selectTrafficListByParam(param);
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
