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
import com.imyway.model.Evaluation;
import com.imyway.model.PackagePriceInfo;
import com.imyway.model.VillaDetailPriceInfo;
import com.imyway.model.VillaInfo;
import com.imyway.services.ICityService;
import com.imyway.services.IEvaluationService;
import com.imyway.services.IVillaDetailPriceInfoService;
import com.imyway.services.IVillaInfoService;



/**
 * 
 * @author GM
 * 
 */
@Controller
public class VillaController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(VillaController.class);
    
    @Autowired private IVillaInfoService villaInfoService;
    @Autowired private ICityService cityService;
    @Autowired private IVillaDetailPriceInfoService villaDetailPriceInfoService;
    @Autowired private IEvaluationService evaluationService;

    /**
     * 别墅详细页
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/product/villa_detail")
    public ModelAndView villaDetail(HttpServletResponse response, HttpServletRequest request,String pid) {
    	ModelAndView mav =  new ModelAndView("/product/villa_detail");
        try {
        	 Map<String,Object> param = new HashMap<>(3);
             param.put("pid", pid);
             VillaInfo row = villaInfoService.selectVillaInfoByParam(param);
             int countryId = Integer.parseInt(row.getCountry());
         	 int cityId =  Integer.parseInt(row.getCity());
             
         	 param.put("show_page", 1);
         	List<VillaDetailPriceInfo> villaDetailPriceInfoList = villaDetailPriceInfoService.selectAllListByParam(param);
           //评论
         	List<Evaluation> evaluationList = evaluationService.getEvaluationListByPid(pid);
         	
         	mav.addObject("country",cityService.getCity(countryId));
         	mav.addObject("city",cityService.getCity(cityId));
         	mav.addObject("row",row);
         	mav.addObject("villaDetailPriceInfoList",villaDetailPriceInfoList);
         	mav.addObject("pid",pid);
         	mav.addObject("productType","villa");
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
    @RequestMapping(value = "/product/villa_priceItemDetail")
    public void priceItemDetail(HttpServletResponse response, HttpServletRequest request,String pid,String starttime) {
        try {
        	Map<String,Object> param = new HashMap<>(3);
        	param.put("pid", pid);
        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            param.put("starttime", sdf.parse(starttime));
        	List<VillaDetailPriceInfo> rows = villaDetailPriceInfoService.selectAllListByParam(param);
            
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
    @RequestMapping(value = "/product/villaPriceCal")
    public void villaPriceCal(HttpServletResponse response, HttpServletRequest request,String pid,String date) {
        try {
        	
        	Map<String,Object> param = new HashMap<>(3);
        	param.put("pid", pid);
        	param.put("beginDate", CommonUtils.getMonthFirst(date, 0, 1));
            param.put("endDate", CommonUtils.getMonthEnd(date, 2));
            // 别墅价格日历
            List<PackagePriceInfo> rows = villaDetailPriceInfoService.getVillaPriceCal(param);
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
    @RequestMapping(value = "/product/villa_list")
    public ModelAndView villaList(HttpServletResponse response, HttpServletRequest request,String pname,String country,String city) {
    	
    	ModelAndView mav = new ModelAndView("/product/villa_list");
        try {
        	
        	//国家
            Map<String,Object> countryparam = new HashMap<>();
            countryparam.put("parentId", 1);
            mav.addObject("country",cityService.getCityList(countryparam));
            
            Map<String,Object> areaparam = new HashMap<>();
            areaparam.put("country", country);
            areaparam.put("city", city);
            areaparam.put("pname", pname);
            
            //所在区域 
            mav.addObject("area",villaInfoService.selectArea(areaparam));
            
            //地理特征
            mav.addObject("geography",villaInfoService.selectGeography());
            
            //卧室数
            mav.addObject("roomCnt",villaInfoService.selectRoomCnt());

            //产品分类：0:套餐，1:酒店，2:别墅，3:交通，4:娱乐
            mav.addObject("ptype",2);

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
    @SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/product/villa_list_ajax")
    public void villaListAajax(HttpServletResponse response, HttpServletRequest request,
    		String pname, String country , String  city, String  tags,String themeIds,
            String startTime,String endTime,String ptype,Integer limit,Integer offset,
            //String roomCnt,
            String area,String geography,String minPrice,String maxPrice,
            String cnt,String orderPrice) {
        
        try {
            Map<String,Object> param = new HashMap<>();      
            param.put("pname", getTrimStringVal(pname));
            param.put("country", getTrimStringVal(country));
            param.put("city", getTrimStringVal(city));
            param.put("tags", getTrimStringVal(tags));
            param.put("startTime", getTrimStringVal(startTime));
            param.put("endTime", getTrimStringVal(endTime));
            
            //param.put("roomCnt", getTrimStringVal(roomCnt));
            param.put("area", getTrimStringVal(area));
            param.put("geography", getTrimStringVal(geography));
            param.put("minPrice", getTrimStringVal(minPrice));
            param.put("maxPrice", getTrimStringVal(maxPrice));

            param.put("ptype", getTrimStringVal(ptype));
            if(null != themeIds && !"".equals(themeIds)){
                param.put("themeIds", getTrimStringVal(themeIds).split(","));
            }
            param.put("cnt", getTrimStringVal(cnt));
            param.put("orderPrice", getTrimStringVal(orderPrice));
            
            //
            Integer pageSize = Integer.valueOf(CommonUtils.getPropertiesBykey("pageSize"));
            param.put("limit", pageSize);
            offset = offset==null?0:offset;
            offset = (offset-1)*pageSize;
            param.put("offset", offset);
            
            List<Map<String, Object>> list = villaInfoService.selectVillaListByParam(param);
            Integer totalCount = villaInfoService.getVillaListCount(param);
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
