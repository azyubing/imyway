package com.imyway.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.imyway.common.utils.CommonUtils;
import com.imyway.common.utils.JSONProxy;
import com.imyway.model.Evaluation;
import com.imyway.model.HotelInfo;
import com.imyway.model.PackagePriceInfo;
import com.imyway.model.RoomPriceInfo;
import com.imyway.model.RoomTypeInfo;
import com.imyway.services.ICityService;
import com.imyway.services.IEvaluationService;
import com.imyway.services.IHotelInfoService;
import com.imyway.services.IRoomPriceInfoService;
import com.imyway.services.IRoomTypeInfoService;



/**
 * 
 * @author GM
 * 
 */
@Controller
public class HotelController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(HotelController.class);
    @Autowired private IHotelInfoService hotelInfoService;
    @Autowired private IRoomTypeInfoService roomTypeInfoService; 
    @Autowired private ICityService cityService;
    @Autowired private IEvaluationService evaluationService;
    @Autowired private IRoomPriceInfoService roomPriceInfoService;

    /**
     * 酒店详细页
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/product/hotel_detail")
    public ModelAndView hotelDetail(HttpServletResponse response, HttpServletRequest request,String pid) {
    	ModelAndView mav = new ModelAndView("/product/hotel_detail");
        try {

        	Map<String,Object> param = new HashMap<>(3);
            param.put("pid", pid);
            // 酒店详情
            HotelInfo row = hotelInfoService.selectHotelInfoByParam(param);
            int countryId = Integer.parseInt(row.getCountry());
        	int cityId =  Integer.parseInt(row.getCity());
            //房型
            List<RoomTypeInfo> rows = roomTypeInfoService.selectAllListByParam(param);
            //详情页显示的房型
            List<RoomTypeInfo> showInpageList = new ArrayList<RoomTypeInfo>();
            
            if(rows!=null&&!rows.isEmpty()){
            	for(RoomTypeInfo r:rows){
            		if(r.getShowInpage().equalsIgnoreCase("1")){
            			showInpageList.add(r);
            		}
            		
            	}
            }
            
            Map<String,Object> param_ = new HashMap<>(3);
            param_.put("pid", pid);
           //评论
        	List<Evaluation> evaluationList = evaluationService.getEvaluationListByPid(pid);
            
            mav.addObject("country",cityService.getCity(countryId));
        	mav.addObject("city",cityService.getCity(cityId));
            mav.addObject("row",row);
            mav.addObject("pid",pid);
            mav.addObject("productType","hotel");
            mav.addObject("showInpageList",showInpageList);
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
    @RequestMapping(value = "/product/hotel_priceItemDetail")
    public void priceItemDetail(HttpServletResponse response, HttpServletRequest request,String pid,String date) {
        try {
        	Map<String,Object> param = new HashMap<>(3);
        	param.put("pid", pid);
        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            
            //房型对应的价格项
            List<RoomTypeInfo> rows = roomTypeInfoService.selectAllListByParam(param);
            
            
            Map<String,Object> roomPriceMap = new HashMap<String, Object>();
            List<RoomTypeInfo> newRows = new ArrayList<RoomTypeInfo>();
            if(rows!=null&&!rows.isEmpty()){
            	for(RoomTypeInfo r:rows){
            		Map<String,Object> params = new HashMap<>(3);
            		params.put("pid", pid);
            		params.put("roomType", r.getRoomType());
            		params.put("date", sdf.parse(date));
            		List<RoomPriceInfo> roomPriceList = roomPriceInfoService.selectAllListByParam(params);
            		if(!roomPriceList.isEmpty()){
            			for(RoomPriceInfo rp:roomPriceList){
            				if(rp.getPriceGroup().equalsIgnoreCase("0")){
            					roomPriceMap.put(r.getRoomType(), roomPriceList);
            					newRows.add(r);
            					break;
            				}
            			}
            		}
            	}
            }
            
            Map<String, Object> reslutMap = new HashMap<>();
            reslutMap.put("newRows", newRows);
            reslutMap.put("roomPriceMap", roomPriceMap);
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
    @RequestMapping(value = "/product/hotelPriceCal")
    public void hotelPriceCal(HttpServletResponse response, HttpServletRequest request,String pid,String date) {
        try {
        	
        	Map<String,Object> param = new HashMap<>(3);
        	param.put("pid", pid);
        	param.put("beginDate", CommonUtils.getMonthFirst(date, 0, 1));
            param.put("endDate", CommonUtils.getMonthEnd(date, 2));
            // 酒店价格日历
            List<PackagePriceInfo> rows = roomPriceInfoService.gethotelPriceCal(param);
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
     * 酒店list页
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/product/hotel_list")
    public ModelAndView hotelList(HttpServletResponse response, HttpServletRequest request,String pname,String country,String city) {
        
    	ModelAndView mav = new ModelAndView("/product/hotel_list");
    	
    	try {
    		Map<String,Object> areaparam = new HashMap<>();
            areaparam.put("country", country);
            areaparam.put("city", city);
            areaparam.put("pname", pname);
            
            //所在区域 
            mav.addObject("area",hotelInfoService.selectArea(areaparam));
            
            //酒店星级
            mav.addObject("staylvl",hotelInfoService.selectStaylvl());
            
            //卧室数
            mav.addObject("maxCnt",hotelInfoService.selectMaxCnt());

            //产品分类：0:套餐，1:酒店，2:别墅，3:交通，4:娱乐
            mav.addObject("ptype",1);

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
     * 酒店list页
     * 
     * @param response
     * @param request
     * @return
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/product/hotel_list_ajax")
    public void hotelListAajax(HttpServletResponse response, HttpServletRequest request,
    		String pname, String country , String  city, String  tags,String themeIds,
            String startTime,String endTime,String ptype,Integer limit,Integer offset,
            //String maxCnt,
            String area,String staylvl,String minPrice,String maxPrice,
            String cnt,String orderPrice) {
        
        try {
            Map<String,Object> param = new HashMap<>();
            param.put("pname", getTrimStringVal(pname));
            param.put("country", getTrimStringVal(country));
            param.put("city", getTrimStringVal(city));
            param.put("tags", getTrimStringVal(tags));
            param.put("startTime", getTrimStringVal(startTime));
            param.put("endTime", getTrimStringVal(endTime));
            
            //param.put("maxCnt", getTrimStringVal(maxCnt));
            param.put("area", getTrimStringVal(area));
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
            Integer totalCount = hotelInfoService.getHotelListCount(param);
            
            Integer pageSize = Integer.valueOf(CommonUtils.getPropertiesBykey("pageSize"));
            param.put("limit", pageSize);
            offset = offset==null?0:offset;
            offset = (offset-1)*pageSize;
            param.put("offset", offset);
            
            List<Map<String, Object>> list = hotelInfoService.selectHotelListByParam(param);
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
    
   /**
    * 验证酒店价格项是否有效
    * @param response
    * @param request
    * @param startDate 开始时间
    * @param endDate  结束时间
    * @param roomPriceInfoIds 价格项ids
    * @param taxRate 税率
    * @param serviceFeeRate 服务率
    */
    /*
     * hotelRouteJson:{priceItemList:[{"id":id,"number":number,"roomTypeId":roomTypeId}],"taxRate":taxRate,"serviceFeeRate":serviceFeeRate,"startDate":startDate,"endDate":endDate}
     * 
     */
    @RequestMapping(value = "/product/checkAddHotelRoute")
    public void hotelListAajax(HttpServletResponse response, HttpServletRequest request,String hotelRouteJson) {
        try {
        	JSONObject hotelJson = JSONObject.parseObject(hotelRouteJson);
        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        	Date startDate = sdf.parse(hotelJson.getString("startDate"));//开始时间
        	Date endDate = sdf.parse(hotelJson.getString("endDate"));//结束时间
        	BigDecimal taxRate = hotelJson.getBigDecimal("taxRate");
        	BigDecimal serviceFeeRate = hotelJson.getBigDecimal("serviceFeeRate");
        	JSONArray priceItemArray = hotelJson.getJSONArray("priceItemList");
			List<Date> dateList = CommonUtils.getDateArrays(startDate, endDate,Calendar.DAY_OF_YEAR);
			
			JSONObject paramJson = new JSONObject();

			BigDecimal total = new BigDecimal(0);//总价
			BigDecimal taxRateTotal = new BigDecimal(0);//税费
			BigDecimal serviceFeeRateTotal = new BigDecimal(0);//服务费
			JSONObject dateJson = new JSONObject();
			//验证每一天每一个价格项的有效性，有效则计算价格
			for (Date d : dateList) {
				for(int i=0;i<priceItemArray.size();i++){
					JSONObject json = priceItemArray.getJSONObject(i);
					int id = json.getIntValue("id");
					BigDecimal number = json.getBigDecimal("number");
					RoomPriceInfo roomPriceInfo = roomPriceInfoService.selectRoomPriceInfoById(id);
					if(roomPriceInfo==null){
						paramJson.put("type", "error");
						paramJson.put("msg", "存在非法价格项");
						response.getWriter().print(paramJson);
						return;
					}else{
						//在价格项在有效日期之内
						if(d.before(roomPriceInfo.getEnddate())&&d.after(roomPriceInfo.getStarttime())){
							BigDecimal price = roomPriceInfo.getRoomPrice();
							total = total.add(price.multiply(number));//总价加
							
							BigDecimal taxRate_ = price.multiply(number).multiply(taxRate);//税费
							BigDecimal serviceFeeRate_ = price.multiply(number).multiply(serviceFeeRate);//服务费
							//date--roomTypeId-->priceItemId--->detail
							//date=[{roomTypeId=[{priceItemId}]}]
							String roomTypeId =json.getString("roomTypeId");
							JSONArray roomTypeArray =  (JSONArray) dateJson.get(sdf.format(d));
							if(roomTypeArray==null){
								roomTypeArray = new JSONArray();
								//价格项detail
								JSONObject priceJson = new JSONObject();
								priceJson.put(""+id+"", id);
								priceJson.put("total", roomPriceInfo.getRoomPrice().multiply(number));
								priceJson.put("taxRate", taxRate_);
								priceJson.put("serviceFeeRate",serviceFeeRate_);
								roomTypeArray.add(priceJson);
								dateJson.put(sdf.format(d), roomTypeArray);
							}else{
								roomTypeArray =  (JSONArray) dateJson.get(sdf.format(d));
								//价格项detail
								JSONObject priceJson = new JSONObject();
								priceJson.put(""+id+"", id);
								priceJson.put("total", roomPriceInfo.getRoomPrice().multiply(number));
								priceJson.put("taxRate", taxRate_);
								priceJson.put("serviceFeeRate",serviceFeeRate_);
								
								roomTypeArray.add(priceJson);
								dateJson.put(sdf.format(d), roomTypeArray);
							}
						}else{
							paramJson.put("type", "error");
							paramJson.put("msg", "时间："+sdf.format(d)+",价格项："+roomPriceInfo.getPriceItem()+"无效");
							response.getWriter().print(paramJson);
							return;
						}
					}
				}
			}
			taxRateTotal = total.multiply(taxRate);
			serviceFeeRateTotal = total.multiply(serviceFeeRate);
			paramJson.put("type", "success");
			paramJson.put("total", total);
			paramJson.put("taxRateTotal", taxRateTotal);
			paramJson.put("serviceFeeRateTotal", serviceFeeRateTotal);
			paramJson.put("dateMap", dateJson.toJSONString());
			response.getWriter().print(paramJson);
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("login checkAddHotelRoute. " + e.toString());
        }

    }
    
    
}
