package com.imyway.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.imyway.common.utils.JSONProxy;
import com.imyway.services.ICityService;
import com.imyway.services.IEntInfoService;
import com.imyway.services.IHotelInfoService;
import com.imyway.services.IPackageInfoService;
import com.imyway.services.IProductInfoService;
import com.imyway.services.IThemeService;
import com.imyway.services.ITrafficInfoService;
import com.imyway.services.IVillaInfoService;




/**
 * 
 * @author GM
 * 
 */
@Controller
public class ProductController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(ProductController.class);


    @Autowired private ICityService cityService;
    @Autowired private IThemeService themeService;
    @Autowired private IProductInfoService productInfoService;
    @Autowired private IPackageInfoService packageInfoService;
    @Autowired private IHotelInfoService hotelInfoService;
    @Autowired private IVillaInfoService villaInfoService;
    @Autowired private ITrafficInfoService trafficInfoService;
    @Autowired private IEntInfoService entInfoService; 
    
    /**
     * 商品list页
     * 
     * @param response
     * @param request
     * @param fromFlag,0:主页,1:主题主页,2:商品列表
     * @return
     */
    @RequestMapping(value = "/product/product_list2")
    public ModelAndView productList(HttpServletResponse response, HttpServletRequest request,
            String pname,String themeId,String ptype,String countryId,String cityId,String endTime,String fromFlag,
            String pcountry,String pcity,String pendTime,String pthemeIds ) {
    	
    	ModelAndView mav = new ModelAndView("/product/product_list2");
        
        try {
            if("0".equals(fromFlag)){
                //查询主题ID
            	if(StringUtils.isNotEmpty(themeId)){
            		mav.addObject("themeId",themeId);
            	}
                //查询国家
            	if(StringUtils.isNotEmpty(countryId)){
                	mav.addObject("pcountry",countryId);
            	}
//            	if(StringUtils.isNotEmpty(countryId)){
//            		City countryCity = cityService.getCity(Integer.valueOf(countryId));
//            		mav.addObject("countryCity",countryCity);
//            	}
                //查询城市

            	if(StringUtils.isNotEmpty(cityId)){
                	mav.addObject("pcity",cityId);
            	}
//            	if(StringUtils.isNotEmpty(cityId)){
//            		City cityCity = cityService.getCity(Integer.valueOf(cityId));
//                	mav.addObject("cityCity",cityCity);
//            	}
                //查询出发日期:yyyy-mm
            	if(StringUtils.isNotEmpty(endTime)){
            		Calendar cal = Calendar.getInstance();
            		Integer month = cal.get(Calendar.MONTH) + 1;
            		String nowMonth = month.toString();
            		String selectMonth = endTime.substring(5, 7);
            		if(nowMonth.equals(selectMonth)){
            			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            			Date now = new Date();
            			mav.addObject("pendTime",sdf.format(now));
            		}else{
            			mav.addObject("pendTime",endTime+"-01");            			
            		}
            	}
                //商品类型
            	if(StringUtils.isNotEmpty(ptype)){
            		mav.addObject("ptype",ptype);
            	}
            }else if("1".equals(fromFlag)){
            	//商品类型
            	if(StringUtils.isNotEmpty(ptype)){
            		mav.addObject("ptype",ptype);
            	}else{
            		mav.addObject("ptype",0);
            	}
            	mav.addObject("pname",pname);

            	mav.addObject("pcountry",pcountry);
            	mav.addObject("pcity",pcity);
            	mav.addObject("pendTime",pendTime);
            	
            	mav.addObject("themeId",pthemeIds);
            	
            }
            
            //国家
//            Map<String,Object> countryparam = new HashMap<>();
//            countryparam.put("parentId", 1);
            mav.addObject("country",cityService.getCityListAll());
            
            mav.addObject("theme",themeService.getAllList());
            
            mav.addObject("productList","list");
            
            Map<String,Object> param = new HashMap<>();
            param.put("pname", getTrimStringVal(pname));
            param.put("country", mav.getModel().get("pcountry"));
            param.put("city", mav.getModel().get("pcity"));
            param.put("tags", mav.getModel().get("pname"));
            param.put("startTime", null);
            param.put("endTime", mav.getModel().get("pendTime"));
            if(null != mav.getModel().get("themeId") && !"".equals(mav.getModel().get("themeId"))){
                param.put("themeIds", getTrimStringVal((String)mav.getModel().get("themeId")).split(","));
            }
            param.put("ptype", 0);
            //套餐商品数量
            int packageCount = packageInfoService.countPackageListByParam(param);
            param.put("ptype", 1);
            //酒店商品数量
            int hotelCount = hotelInfoService.countHotelListByParam(param);
            param.put("ptype", 2);
            //别墅商品数量
            int villaCount = villaInfoService.countVillaListByParam(param);
            param.put("ptype", 3);
            //交通商品数量
            int trafficCount = trafficInfoService.countTrafficListByParam(param);
            param.put("ptype", 4);
            //娱乐商品数量
            int entCount = entInfoService.countEntListByParam(param);
            
           
            mav.addObject("packageCount",packageCount);
            mav.addObject("hotelCount",hotelCount);
            mav.addObject("villaCount",villaCount);
            mav.addObject("trafficCount",trafficCount);
            mav.addObject("entCount",entCount);
            
            if(ptype == null || "".equals(ptype)){
            	ptype = checkShowPtype( packageCount, hotelCount, villaCount, trafficCount, entCount);
            }
            mav.addObject("ptype",ptype);
            
            if("0".equals(ptype)){
            	getPakageInfo(mav);
            }else if("1".equals(ptype)){
            	getHotelInfo(mav);
            }else if("2".equals(ptype)){
            	getVilliaInfo(mav);
            }else if("3".equals(ptype)){
            	getTraficInfo(mav);
            }else if("4".equals(ptype)){
            	getEntInfo(mav);
            }
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("login fail. " + e.toString());
        }
        return mav;
    }
    
    private void getPakageInfo(ModelAndView mav){
    	//套餐性质 
        mav.addObject("property",packageInfoService.selectProperty());
        
        //住宿等级
        mav.addObject("staylvl",packageInfoService.selectStaylvl());
        
        //包含天数
        List<Map<String,Object>> daycnt = packageInfoService.selectDaycnt();
        mav.addObject("daycnt",daycnt);
        
       
        Map<String,Object> param = new HashMap<>();
        param.put("pname", mav.getModel().get("pname"));
        param.put("country", mav.getModel().get("pcountry"));
        param.put("city", mav.getModel().get("pcity"));
        param.put("tags", mav.getModel().get("pname"));
        param.put("startTime", null);
        param.put("endTime", mav.getModel().get("pendTime"));
        param.put("ptype", "0");
        if(null != mav.getModel().get("themeId") && !"".equals(mav.getModel().get("themeId"))){
        	param.put("themeIds", getTrimStringVal((String)mav.getModel().get("themeId")).split(","));
        }
        
        List<Map<String, Object>> list = packageInfoService.selectPackageListByParam(param);
        
        mav.addObject("plist",list);
    }
    
    private void getHotelInfo(ModelAndView mav){
    	Map<String,Object> areaparam = new HashMap<>();
        areaparam.put("country", mav.getModel().get("pcountry"));
        areaparam.put("city", mav.getModel().get("pcity"));
        areaparam.put("pname", mav.getModel().get("pname"));
        
        //所在区域 
        mav.addObject("area",hotelInfoService.selectArea(areaparam));
        
        //酒店星级
        mav.addObject("staylvl",hotelInfoService.selectStaylvl());
        
        //卧室数
        mav.addObject("maxCnt",hotelInfoService.selectMaxCnt());

        Map<String,Object> param = new HashMap<>();
        param.put("pname", mav.getModel().get("pname"));
        param.put("country", mav.getModel().get("pcountry"));
        param.put("city", mav.getModel().get("pcity"));
        param.put("tags", mav.getModel().get("pname"));
        param.put("startTime", null);
        param.put("endTime", mav.getModel().get("pendTime"));
        param.put("ptype", "1");
        if(null != mav.getModel().get("themeId") && !"".equals(mav.getModel().get("themeId"))){
        	param.put("themeIds", getTrimStringVal((String)mav.getModel().get("themeId")).split(","));
        }
        
        List<Map<String, Object>> list = hotelInfoService.selectHotelListByParam(param);
        mav.addObject("plist",list);
    }
    
    private void getVilliaInfo(ModelAndView mav){
    	//国家
        Map<String,Object> countryparam = new HashMap<>();
        countryparam.put("parentId", 1);
        mav.addObject("country",cityService.getCityList(countryparam));
        
        Map<String,Object> areaparam = new HashMap<>();
        areaparam.put("country", mav.getModel().get("pcountry"));
        areaparam.put("city", mav.getModel().get("pcity"));
        areaparam.put("pname",  mav.getModel().get("pname"));
        
        //所在区域
        mav.addObject("area",villaInfoService.selectArea(areaparam));
        //地理特征
        mav.addObject("geography",villaInfoService.selectGeography());
        //卧室数
        mav.addObject("roomCnt",villaInfoService.selectRoomCnt());
       
        areaparam.put("tags", mav.getModel().get("pname"));
        areaparam.put("endTime", mav.getModel().get("pendTime"));
        if(null != mav.getModel().get("themeId") && !"".equals(mav.getModel().get("themeId"))){
        	areaparam.put("themeIds", getTrimStringVal((String)mav.getModel().get("themeId")).split(","));
        }
        
        List<Map<String, Object>> list = villaInfoService.selectVillaListByParam(areaparam);
        mav.addObject("plist",list);
    }
    
    private void getTraficInfo(ModelAndView mav){
    	//起点列表
        // mav.addObject("startplace",trafficInfoService.selectStartplace());
        //终点列表
        //mav.addObject("endplace",trafficInfoService.selectEndplace());
    	//用车等级列表
        mav.addObject("carlvl",trafficInfoService.selectCarlvl());
        //车型列表
        mav.addObject("cartype",trafficInfoService.selectCartype());

        Map<String,Object> param = new HashMap<>();
        param.put("pname", mav.getModel().get("pname"));
        param.put("country", mav.getModel().get("pcountry"));
        param.put("city", mav.getModel().get("pcity"));
        param.put("tags", mav.getModel().get("pname"));
        param.put("startTime", null);
        param.put("endTime", mav.getModel().get("pendTime"));
        param.put("ptype", "3");
        if(null != mav.getModel().get("themeId") && !"".equals(mav.getModel().get("themeId"))){
        	param.put("themeIds", getTrimStringVal((String)mav.getModel().get("themeId")).split(","));
        }
        
        List<Map<String, Object>> list = trafficInfoService.selectTrafficListByParam(param);
        mav.addObject("plist",list);
    }
    
    private void getEntInfo(ModelAndView mav){
    	 //娱乐类型
        mav.addObject("enttype",entInfoService.selectEnttype());
        
        //服务类型
        mav.addObject("servicetype",entInfoService.selectServicetype());
        
        //服务语言 
        mav.addObject("language",entInfoService.selectLanguage());

        Map<String,Object> param = new HashMap<>();
        param.put("pname", mav.getModel().get("pname"));
        param.put("country", mav.getModel().get("pcountry"));
        param.put("city", mav.getModel().get("pcity"));
        param.put("tags", mav.getModel().get("pname"));
        param.put("startTime", null);
        param.put("endTime", mav.getModel().get("pendTime"));
        param.put("ptype", "4");
        if(null != mav.getModel().get("themeId") && !"".equals(mav.getModel().get("themeId"))){
        	param.put("themeIds", getTrimStringVal((String)mav.getModel().get("themeId")).split(","));
        }
        
        List<Map<String, Object>> list = entInfoService.selectEntListByParam(param);
        mav.addObject("plist",list);
    }
    
    
    private String checkShowPtype(int packageCount,int hotelCount,int villaCount,int trafficCount,int entCount){
    	if(packageCount > 0){
    		return "0";
    	}
    	if(hotelCount > 0){
    		return "1";
    	}
    	if(villaCount > 0){
    		return "2";
    	}
    	if(trafficCount > 0){
    		return "3";
    	}
    	if(entCount > 0){
    		return "4";
    	}
    	return "0";
    }
    
    /**
     * 商品list页
     * 
     * @param response
     * @param request
     * @param fromFlag,0:主页,1:主题主页,2:商品列表
     * @return
     */
    @RequestMapping(value = "/product/product_list")
    public ModelAndView trafficList(HttpServletResponse response, HttpServletRequest request,
            String pname,String themeId,String ptype,String countryId,String cityId,String endTime,String fromFlag,
            String pcountry,String pcity,String pendTime,String pthemeIds ) {
    	
    	ModelAndView mav = new ModelAndView("/product/product_list");
        
        try {
            if("0".equals(fromFlag)){
                //查询主题ID
            	if(StringUtils.isNotEmpty(themeId)){
            		mav.addObject("themeId",themeId);
            	}
                //查询国家
            	if(StringUtils.isNotEmpty(countryId)){
                	mav.addObject("pcountry",countryId);
            	}
//            	if(StringUtils.isNotEmpty(countryId)){
//            		City countryCity = cityService.getCity(Integer.valueOf(countryId));
//            		mav.addObject("countryCity",countryCity);
//            	}
                //查询城市

            	if(StringUtils.isNotEmpty(cityId)){
                	mav.addObject("pcity",cityId);
            	}
//            	if(StringUtils.isNotEmpty(cityId)){
//            		City cityCity = cityService.getCity(Integer.valueOf(cityId));
//                	mav.addObject("cityCity",cityCity);
//            	}
                //查询出发日期:yyyy-mm
            	if(StringUtils.isNotEmpty(endTime)){
            		Calendar cal = Calendar.getInstance();
            		Integer month = cal.get(Calendar.MONTH) + 1;
            		String nowMonth = month.toString();
            		String selectMonth = endTime.substring(5, 7);
            		if(nowMonth.equals(selectMonth)){
            			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            			Date now = new Date();
            			mav.addObject("pendTime",sdf.format(now));
            		}else{
            			mav.addObject("pendTime",endTime+"-01");            			
            		}
            	}
                //商品类型
            	if(StringUtils.isNotEmpty(ptype)){
            		mav.addObject("ptype",ptype);
            	}
            }else if("1".equals(fromFlag)){
            	//商品类型
            	if(StringUtils.isNotEmpty(ptype)){
            		mav.addObject("ptype",ptype);
            	}else{
            		mav.addObject("ptype",0);
            	}
            	mav.addObject("pname",pname);

            	mav.addObject("pcountry",pcountry);
            	mav.addObject("pcity",pcity);
            	mav.addObject("pendTime",pendTime);
            	
            	mav.addObject("themeId",pthemeIds);
            	
            }
            
            mav.addObject("fromFlag",fromFlag);
            
            //国家
//            Map<String,Object> countryparam = new HashMap<>();
//            countryparam.put("parentId", 1);
            mav.addObject("country",cityService.getCityListAll());
            
            mav.addObject("theme",themeService.getAllList());
            
            mav.addObject("productList","list");
            
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
     * 商品list页,商品数量ajax
     * 
     * @param response
     * @param request
     * @param themeIds 
     * @return
     */
    @RequestMapping(value = "/product/product_count_ajax")
    public void productCountAajax(HttpServletResponse response, HttpServletRequest request, 
            String pname, String country , String  city, String  tags,String themeIds,
            String startTime,String endTime,String ptype) {
        
        
        try {
            
            Map<String,Object> param = new HashMap<>();
            param.put("pname", getTrimStringVal(pname));
            param.put("country", getTrimStringVal(country));
            param.put("city", getTrimStringVal(city));
            param.put("tags", getTrimStringVal(tags));
            param.put("startTime", getTrimStringVal(startTime));
            param.put("endTime", getTrimStringVal(endTime));
            if(null != themeIds && !"".equals(themeIds)){
                param.put("themeIds", getTrimStringVal(themeIds).split(","));
            }
            param.put("ptype", 0);
            //套餐商品数量
            int packageCount = packageInfoService.countPackageListByParam(param);
            param.put("ptype", 1);
            //酒店商品数量
            int hotelCount = hotelInfoService.countHotelListByParam(param);
            param.put("ptype", 2);
            //别墅商品数量
            int villaCount = villaInfoService.countVillaListByParam(param);
            param.put("ptype", 3);
            //交通商品数量
            int trafficCount = trafficInfoService.countTrafficListByParam(param);
            param.put("ptype", 4);
            //娱乐商品数量
            int entCount = entInfoService.countEntListByParam(param);
            
            Map<String,Object> resMap = new HashMap<>();
            resMap.put("packageCount",packageCount);
            resMap.put("hotelCount",hotelCount);
            resMap.put("villaCount",villaCount);
            resMap.put("trafficCount",trafficCount);
            resMap.put("entCount",entCount);
            response.getWriter().print(JSON.toJSONString(resMap,JSONProxy.SYSTEM_FEATURE));
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("login fail. " + e.toString());
        }

    }
    
    /**
     * 商品list页ajax
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/product/product_list_ajax")
    public void productListAajax(HttpServletResponse response, HttpServletRequest request,
            String pname, String country , String  city, String  tags,String themeIds,
            String startTime,String endTime,String ptype
            ) {
        
    	
        try {
            Map<String,Object> param = new HashMap<>();
            param.put("pname", pname.trim());
            param.put("country", country.trim());
            param.put("city", city.trim());
            param.put("tags", tags.trim());
            if(null != themeIds && !"".equals(themeIds)){
            	param.put("themeIds", themeIds.trim().split(","));
            }
            param.put("startTime", startTime.trim());
            param.put("endTime", endTime.trim());
            param.put("ptype", ptype.trim());
            
            List<Map<String, Object>> list = productInfoService.selectProductInfoListByParam(param);
            response.getWriter().print(JSON.toJSONString(list,JSONProxy.SYSTEM_FEATURE));
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("login fail. " + e.toString());
        }

    }
    
}
