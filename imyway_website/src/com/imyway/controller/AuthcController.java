package com.imyway.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.MessageFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

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
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.imyway.common.utils.CommonUtils;
import com.imyway.common.utils.JSONProxy;
import com.imyway.common.utils.mail.MailSender;
import com.imyway.model.City;
import com.imyway.model.EntRouteDetailInfo;
import com.imyway.model.RouteDetailInfo;
import com.imyway.model.User;
import com.imyway.services.ICityService;
import com.imyway.services.IDiscountInfoService;
import com.imyway.services.IEntRouteDetailInfoService;
import com.imyway.services.IEvaluationService;
import com.imyway.services.IMediaService;
import com.imyway.services.IPackageInfoService;
import com.imyway.services.IProductInfoService;
import com.imyway.services.IRouteDetailInfoService;
import com.imyway.services.IThemeProductService;
import com.imyway.services.IThemeService;
import com.imyway.services.IUserService;
import com.imyway.services.IVillaInfoService;
import com.imyway.sms.SmsClientSend;



/**
 * 
 * @author GM
 * 
 */
@Controller
public class AuthcController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(AuthcController.class);
    @Autowired private IDiscountInfoService discountInfoService;
    @Autowired private IVillaInfoService villaInfoService;
    @Autowired private IPackageInfoService packageInfoService;
    @Autowired private IThemeService themeService;
    @Autowired private IThemeProductService themeProductService;
    @Autowired private IMediaService mediaService;
    @Autowired private ICityService cityService;
    @Autowired private IRouteDetailInfoService routeDetailInfoService;
    @Autowired private IEntRouteDetailInfoService entRouteDetailInfoService;
    @Autowired private IEvaluationService evaluationService;
    @Autowired private IUserService userService;
    @Autowired private IProductInfoService productService;
    /**
     * 首页
     * 
     * @param response
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/home")
    public ModelAndView home(HttpServletResponse response, HttpServletRequest request,String continent,Long cid) {
        
        ModelAndView mav = new ModelAndView("home");
        
        try {
            
            
            Map<String,Object> param = new HashMap<>();
            //海外目的地统计
            Map parammap = new HashMap();
            parammap.put("country", 12);
            int outCount = productService.getOutCount(parammap);
            mav.addObject("outCount", outCount);
            //高端别墅统计
            int villaCount = villaInfoService.getVillaCount();
            mav.addObject("villaCount", villaCount); 
            //套餐统计
            int packageCount = packageInfoService.getPackageCount();        
            mav.addObject("packageCount", packageCount);           
          
            //4大主题
            List<Map<String,Object>> list = themeService.getAllListMapByIsHome();
            for(Map<String,Object> map : list){
                Map<String,Object> paramThemeproduct = new HashMap<>();
                paramThemeproduct.put("themeId", map.get("id"));
                List<Map<String,Object>> themeProduct = themeProductService.getThemeproductListMapBythemeId(paramThemeproduct);
                for (Map<String, Object> product : themeProduct) {
                	if(product.get("tags") != null){
	                	String tagsStr = (String) product.get("tags");
	                	String tags[] = tagsStr.split("\\|");
	                	product.put("tags", tags);
                	}
				}
                map.put("themeProduct", themeProduct);
            }
            mav.addObject("list", list);   
            
            //更多主题
            List<Map<String,Object>> isMorelist = themeService.getAllListMapByIsMore2();
//            List<Map<String,Object>> isMorelist = themeService.getAllListMapByIsMore();
            mav.addObject("isMorelist", isMorelist);   
            
            //麦视频
            List<Object> medialist = mediaService.getAllList();
            mav.addObject("medialist", medialist);   
            //视频统计
            mav.addObject("mediaCount", medialist.size());
            
            //热门城市
            Map<String,Object> cityparam = new HashMap<>();
            cityparam.put("parentId", "0");
            List<City> cityList = cityService.getCityList(cityparam);
            mav.addObject("cityList", cityList); 
            
            mav.addObject("now", new Date());
            
            mav.addObject("timeLong", System.currentTimeMillis());
            
            mav.addObject("continent", continent);
            
            request.setAttribute("cid", cid);
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
     * 跳转登录页面
     * @param response
     * @param request
     * @return ModelAndView
     * @throws UnsupportedEncodingException 
     */
    @RequestMapping(value = "/tologin")
    public ModelAndView tologin(HttpServletResponse response, HttpServletRequest request,String nextUrl) throws UnsupportedEncodingException {
    	if(StringUtils.isNotEmpty(nextUrl)){
    		request.setAttribute("nextUrlenCode", URLEncoder.encode(nextUrl, "utf-8"));
    		request.setAttribute("nowUrl", URLEncoder.encode(nextUrl, "utf-8"));
    		request.setAttribute("nextUrl", nextUrl);
    	}
        return new ModelAndView("login");
    }
   
    
    /**
     * 用户登录
     * 
     * @param loginName
     * @param pw
     * @param validateCode
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/login")
    public ModelAndView login(String loginName, String pw, String validateCode,
            HttpServletResponse response, HttpServletRequest request) {

        try {

            
        } catch (Exception e) {
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("login fail. " + e.toString());
        }
        return new ModelAndView("redirect:home.html");
    }
    

    /**
     * 跳转登录页面
     * @param response
     * @param request
     * @return ModelAndView
     * @throws UnsupportedEncodingException 
     */
    @RequestMapping(value = "/toregister")
    public ModelAndView toregister(HttpServletResponse response, HttpServletRequest request,String nextUrl) throws UnsupportedEncodingException {
    	if(StringUtils.isNotEmpty(nextUrl)){
    		request.setAttribute("nextUrlenCode", URLEncoder.encode(nextUrl, "utf-8"));
    		request.setAttribute("nowUrl", URLEncoder.encode(nextUrl, "utf-8"));
    		request.setAttribute("nextUrl", nextUrl);
    	}
        return new ModelAndView("register");
    }
    
    /**
     * 手机发送验证码
     * @param response
     * @param request
     */
    @RequestMapping(value = "/sendCodeByTel")
    public void sendCodeByTel(HttpServletResponse response, HttpServletRequest request,String tel) {
    	String code =String.valueOf(Math.random()*9000+1000).substring(0,4);
    	String sendMsg = CommonUtils.getMsgTemplateBykey("verif_code_phone");
    	SmsClientSend.sendSms(tel, MessageFormat.format(sendMsg, code));
    	request.getSession().setAttribute("checkCode", code);
    	request.getSession().setAttribute("currentTimeMillis", System.currentTimeMillis());
    }
    
    /**
     * 邮箱发送验证码
     * @param response
     * @param request
     */
    @RequestMapping(value = "/sendCodeByEmail")
    public void sendCodeByEmail(HttpServletResponse response, HttpServletRequest request,String email) {
    	
    	String code =String.valueOf(Math.random()*9000+1000).substring(0,4);
    	
    	try {
			MailSender.send_verifycode_mail(code, email);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		request.getSession().setAttribute("checkCode", code);
    	request.getSession().setAttribute("currentTimeMillis", System.currentTimeMillis());

    }
    
    /**
     * 邮箱发送验证码
     * @param response
     * @param request
     */
    @RequestMapping(value = "/sendUrl")
    public void sendUrl(HttpServletResponse response, HttpServletRequest request,String username,String password,String email) {
    	
    	try {
    		String path = request.getContextPath();  
			String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
			//MailSender.send_regist_mail("<a href='"+basePath+"user/activateUser.html?username="+username+"&password="+password+"'>激活</a>", email);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}

    }
    
    
    /**
     * 验证邮箱发送验证码
     * @param response
     * @param request
     */
    @RequestMapping(value = "/checkEmail")
    public void checkEmail(HttpServletResponse response, HttpServletRequest request,String email) {
    	String code =String.valueOf(Math.random()*9000+1000).substring(0,4);
    	
    	try {
			MailSender.send_verifycode_mail(code, email);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		request.getSession().setAttribute("checkEmail", code);
    }
    
    /**
     * 验证手机发送验证码
     * @param response
     * @param request
     */
    @RequestMapping(value = "/checkTel")
    public void checkTel(HttpServletResponse response, HttpServletRequest request,String tel) {
    	String code =String.valueOf(Math.random()*9000+1000).substring(0,4);
    	String sendMsg = CommonUtils.getMsgTemplateBykey("verif_code_phone");
    	SmsClientSend.sendSms(tel, MessageFormat.format(sendMsg, code));
    	request.getSession().setAttribute("checkTel", code);
    }
    
    /**
     * 跳转邮箱验证成功页面
     * @param response
     * @param request
     * @return ModelAndView
     */
    @RequestMapping(value = "/checkMailSuccess")
    public ModelAndView checkMailSuccess(HttpServletResponse response, HttpServletRequest request) {
        return new ModelAndView("/checkMailSuccess");
    }
    /**
     * 跳转邮箱验证失败页面
     * @param response
     * @param request
     * @return ModelAndView
     */
    @RequestMapping(value = "/checkMailError")
    public ModelAndView checkMailError(HttpServletResponse response, HttpServletRequest request) {
        return new ModelAndView("/checkMailError");
    }
    
    
    
    /**
     * 加入行程
     * 
     * @param response
     * @param request
     */
    @RequestMapping(value = "/addRouteStr")
    public void addRouteStr(HttpServletResponse response, HttpServletRequest request,String str,String type) {
    	try {
    		String routeJsonString = (String) request.getSession().getAttribute("routeJson");
    		JSONObject routeJson = null;
    		
    		if("traffic".equalsIgnoreCase(type)){
    			routeJson = trafficJson(routeJsonString,str,type);
    		}
    		else if("hotel".equalsIgnoreCase(type)){
    			routeJson = hotelJson(routeJsonString,str,type);
    		}
    		else if("package".equalsIgnoreCase(type)){
    			routeJson = packageJson(routeJsonString,str,type);
    		}
    		else if("ent".equalsIgnoreCase(type)){
    			routeJson = entJson(routeJsonString,str,type);
    		}
    		else if("villa".equalsIgnoreCase(type)){
    			routeJson = villaJson(routeJsonString,str,type);
    		}
    		
    		List<String> dateList = getDateKey(routeJson);
    		routeJson.put("dateList", dateList);
    		request.getSession().setAttribute("stardt",null);
    		request.getSession().setAttribute("addDate",null);
    		
    		request.getSession().setAttribute("routeJson",JSON.toJSONString(routeJson, JSONProxy.SYSTEM_FEATURE));
    		response.getWriter().print(JSON.toJSONString(routeJson, JSONProxy.SYSTEM_FEATURE));
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    }
    
    /**
     * 加入行程
     * 
     * @param response
     * @param request
     */
    @RequestMapping(value = "/addStartTime")
    public void addStartTime(HttpServletResponse response, HttpServletRequest request,String stardt) {
    	request.getSession().setAttribute("stardt",stardt);
    	try {
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    }
    
    /**
     * 加入行程
     * 
     * @param response
     * @param request
     */
    @RequestMapping(value = "/addDateTime")
    public void addDateTime(HttpServletResponse response, HttpServletRequest request,String stardt) {
    	request.getSession().setAttribute("addDate",stardt);
    	try {
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    }
    
    /**
     * 清除行程单
     * 
     * @param response
     * @param request
     */
    @RequestMapping(value = "/removeAllRouteStr")
    public void removeAllRouteStr(HttpServletResponse response, HttpServletRequest request,String str,String type) {
    	try {
    		request.getSession().setAttribute("routeJson",null);
    		request.getSession().setAttribute("stardt",null);
    		request.getSession().setAttribute("addDate",null);
    		
    		response.getWriter().print(JSON.toJSONString(null, JSONProxy.SYSTEM_FEATURE));
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    }
    
    /**
     * 移除行程
     * 
     * @param response
     * @param request
     */
    @RequestMapping(value = "/removeRouteStr")
    public void removeRouteStr(HttpServletResponse response, HttpServletRequest request,String date,String type,String timestamp) {
    	try {
			String routeJsonString = (String) request.getSession().getAttribute("routeJson");
			JSONObject routeJson = null;
			
			if("traffic".equalsIgnoreCase(type)){
				routeJson = removetrafficJson(routeJsonString,date,type,timestamp);
			}
			else if("hotel".equalsIgnoreCase(type)){
				routeJson = removehotelJson(routeJsonString,date,type,timestamp);
			}
			else if("package".equalsIgnoreCase(type)){
				routeJson = removepackageJson(routeJsonString,date,type,timestamp);
			}
			else if("ent".equalsIgnoreCase(type)){
				routeJson = removeentJson(routeJsonString,date,type,timestamp);
			}
			else if("villa".equalsIgnoreCase(type)){
				routeJson = removevillaJson(routeJsonString,date,type,timestamp);
			}
			
			List<String> dateList = getDateKey(routeJson);
			routeJson.put("dateList", dateList);
			
			request.getSession().setAttribute("routeJson",JSON.toJSONString(routeJson, JSONProxy.SYSTEM_FEATURE));
			response.getWriter().print(JSON.toJSONString(routeJson, JSONProxy.SYSTEM_FEATURE));
			System.out.println(routeJson);
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
    
    /**
     * 删除一个交通
     * @param routeJsonString
     * @param date
     * @param type
     * @param timestamp
     * @return
     */
    private JSONObject removetrafficJson(String routeJsonString, String date,
			String type, String timestamp) {
    	JSONObject routeJson = JSONObject.parseObject(routeJsonString);
    	JSONObject trafficJson = (JSONObject) routeJson.get(type);
    	JSONArray array = (JSONArray) trafficJson.get(date);
    	String total = (String) routeJson.get(type+"totalPrice");
    	int key = 0;
    	for(int i =0;i<array.size();i++){
    		JSONObject json = array.getJSONObject(i);
    		String timestamp_ = (String) json.get("timestamp");
    		String totalPrice = (String) json.get("totalPrice");
    		if(timestamp_.equalsIgnoreCase(timestamp)){
    			key=i;
    			Float newtotal = Float.parseFloat(total)-Float.parseFloat(totalPrice);
    			DecimalFormat decimalFormat=new DecimalFormat(".00");//构造方法的字符格式这里如果小数不足2位,会以0补足.
				String totalStr=decimalFormat.format(newtotal);//format 返回的是字符串
    			routeJson.put(type+"totalPrice",totalStr);
    			break;
    		}
    	}
    	array.remove(key);
    	if(array.size()==0){
    		trafficJson.put(date,null);
    	}
		return routeJson;
	}

    /**
     * 移除娱乐
     * @param routeJsonString
     * @param date
     * @param type
     * @param timestamp
     * @return
     */
	private JSONObject removeentJson(String routeJsonString, String date,
			String type, String timestamp) {
		JSONObject routeJson = JSONObject.parseObject(routeJsonString);
    	JSONObject trafficJson = (JSONObject) routeJson.get(type);
    	JSONArray array = (JSONArray) trafficJson.get(date);
    	String total = (String) routeJson.get(type+"totalPrice");
    	int key = 0;
    	for(int i =0;i<array.size();i++){
    		JSONObject json = array.getJSONObject(i);
    		String timestamp_ = (String) json.get("timestamp");
    		String totalPrice = (String) json.get("totalPrice");
    		if(timestamp_.equalsIgnoreCase(timestamp)){
    			key=i;
    			Float newtotal = Float.parseFloat(total)-Float.parseFloat(totalPrice);
    			DecimalFormat decimalFormat=new DecimalFormat(".00");//构造方法的字符格式这里如果小数不足2位,会以0补足.
				String totalStr=decimalFormat.format(newtotal);//format 返回的是字符串
    			routeJson.put(type+"totalPrice",totalStr);
    			break;
    		}
    	}
    	array.remove(key);
    	if(array.size()==0){
    		trafficJson.put(date,null);
    	}
		return routeJson;
	}

	/**
	 * 移除套餐
	 * @param routeJsonString
	 * @param date
	 * @param type
	 * @param timestamp
	 * @return
	 */
	private JSONObject removepackageJson(String routeJsonString, String date,
			String type, String timestamp) {
		JSONObject routeJson = JSONObject.parseObject(routeJsonString);
    	routeJson.put(type+"totalPrice",0.00);
    	routeJson.put(type,null);
		return routeJson;
	}

	/**
	 * 移除酒店
	 * @param routeJsonString
	 * @param date
	 * @param type
	 * @param timestamp
	 * @return
	 */
	private JSONObject removehotelJson(String routeJsonString, String date,
			String type, String timestamp) {
		JSONObject routeJson = JSONObject.parseObject(routeJsonString);
    	JSONObject trafficJson = (JSONObject) routeJson.get(type);
    	
    	JSONObject json = trafficJson.getJSONObject(date);
    	String total = routeJson.getString(type+"totalPrice");
    	String totalPrice = json.getString("totalPrice");
    	Float newtotal = Float.parseFloat(total)-Float.parseFloat(totalPrice);
		DecimalFormat decimalFormat=new DecimalFormat(".00");//构造方法的字符格式这里如果小数不足2位,会以0补足.
		String totalStr=decimalFormat.format(newtotal);//format 返回的是字符串
		routeJson.put(type+"totalPrice",totalStr);
		trafficJson.put(date,null);
		return routeJson;
	}

	@SuppressWarnings("rawtypes")
	private JSONObject removevillaJson(String routeJsonString, String date,
			String type, String timestamp) {
		JSONObject routeJson = JSONObject.parseObject(routeJsonString);
    	JSONObject trafficJson = (JSONObject) routeJson.get(type);
    	JSONObject json = (JSONObject) trafficJson.get(date);
    	String total = (String) routeJson.get(type+"totalPrice");
    	String totalPrice = (String) json.get("totalPrice");
    	
    	Float newtotal = Float.parseFloat(total)-Float.parseFloat(totalPrice);
		DecimalFormat decimalFormat=new DecimalFormat(".00");//构造方法的字符格式这里如果小数不足2位,会以0补足.
		String totalStr=decimalFormat.format(newtotal);//format 返回的是字符串
		routeJson.put(type+"totalPrice",totalStr);
		
		Iterator it =  trafficJson.keySet().iterator();
		List<String> dateList = new ArrayList<String>();
		while(it.hasNext()){
			String dateStr = (String) it.next();
			JSONObject json_ = (JSONObject) trafficJson.get(date);
			String timestamp_ = (String) json_.get("timestamp");
			if(timestamp_.equalsIgnoreCase(timestamp)){
				dateList.add(dateStr);
			}
		}
		for(String str : dateList){
			trafficJson.put(str, null);
		}
		
		return routeJson;
	}

	/**
     * 获取行程中所有的日期
     * @param routeJson
     * @return
     */
	@SuppressWarnings("rawtypes")
	private List<String> getDateKey(JSONObject routeJson) {
		List<String> dateList = new ArrayList<String>();
		try {
			
			JSONObject trafficJson = (JSONObject) routeJson.get("traffic");
			JSONObject hotelJson = (JSONObject) routeJson.get("hotel");
			JSONObject packageJson = (JSONObject) routeJson.get("package");
			JSONObject entJson = (JSONObject) routeJson.get("ent");
			JSONObject villaJson = (JSONObject) routeJson.get("villa");
			
			if (trafficJson != null) {
				Iterator it = trafficJson.keySet().iterator();
				while (it.hasNext()) {
					String date = it.next().toString();
					if(trafficJson.get(date)!=null){
						//去重复
						if(!dateList.contains(date)){
							dateList.add(date);
						}
					}
				}
			}
			if (hotelJson != null) {
				Iterator it = hotelJson.keySet().iterator();
				while (it.hasNext()) {
					String date = it.next().toString();
					if(hotelJson.get(date)!=null){
						//去重复
						if(!dateList.contains(date)){
							dateList.add(date);
						}
					}
				}
			}
			if (entJson != null) {
				Iterator it = entJson.keySet().iterator();
				while (it.hasNext()) {
					String date = it.next().toString();
					if(entJson.get(date)!=null){
						//去重复
						if(!dateList.contains(date)){
							dateList.add(date);
						}
					}
				}
			}
			if (villaJson != null) {
				Iterator it = villaJson.keySet().iterator();
				while (it.hasNext()) {
					String date = it.next().toString();
					if(villaJson.get(date)!=null){
						//去重复
						if(!dateList.contains(date)){
							dateList.add(date);
						}
					}
				}
			}
			if (packageJson != null) {
				Iterator it = packageJson.keySet().iterator();
				while (it.hasNext()) {
					String date = it.next().toString();
					if(packageJson.get(date)!=null){
						//去重复
						if(!dateList.contains(date)){
							dateList.add(date);
						}
					}
				}
			}
			dateList = sortListDesc(dateList);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return dateList;
	}
    
	/**
	 * 时间排序
	 * @param list
	 * @return
	 * @throws ParseException
	 */
	 public static List<String> sortListDesc(List<String> list) throws ParseException{
	        List<String> retStr=new ArrayList<String>();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        Map<Long,String> map = new TreeMap<Long,String>();
	        for(int i=0;i<list.size();i++){
	            String dateStr = list.get(i);
	            map.put(sdf.parse(dateStr).getTime(), dateStr);
	        }
	        Collection<String> coll=map.values();
	        retStr.addAll(coll);
//	        Collections.reverse(retStr);
	        Collections.sort(retStr);
	        return retStr;
	    }
	
    /**
     * 
     * 交通：{
     * 		date1：[{},{}]
     * 		date2：[{},{}]
     * }
     * 
     * @param sessionRouteStr
     * @param trafficStr
     * @param type
     * @return
     */
    private JSONObject trafficJson(String sessionRouteStr,String trafficStr,String type){
    	JSONObject json = JSONObject.parseObject(trafficStr);
    	String date = json.getString("date");//日期
    	JSONObject jsonRoute = null;
    	//无行程
    	if(sessionRouteStr==null){
    		JSONArray jsonArray = new JSONArray();
    		jsonArray.add(json);
    		
    		JSONObject jsonObject = new JSONObject();
    		jsonObject.put(date, jsonArray);
    		
    		jsonRoute = new JSONObject();
    		jsonRoute.put(type, jsonObject);
    		jsonRoute.put(type+"totalPrice",json.get("totalPrice"));
    	}else{//有行程
    		jsonRoute = JSONObject.parseObject(sessionRouteStr);
    		
    		JSONObject jsonObject =(JSONObject) jsonRoute.get(type);
    		if(jsonObject==null){//无交通
    			JSONArray jsonArray = new JSONArray();
    			jsonArray.add(json);
    			
    			jsonObject = new JSONObject();
    			jsonObject.put(date, jsonArray);
    			
    			jsonRoute.put(type, jsonObject);
    			jsonRoute.put(type+"totalPrice",json.get("totalPrice"));
    		}else{//有交通
    			JSONArray jsonArray = (JSONArray) jsonObject.get(date);
    			if(jsonArray==null){//无此日交通
    				jsonArray = new JSONArray();
    				jsonArray.add(json);
    				jsonObject.put(date, jsonArray);
    				Float total = Float.parseFloat((String) json.get("totalPrice"))+Float.parseFloat((String) jsonRoute.get(type+"totalPrice"));
    				DecimalFormat decimalFormat=new DecimalFormat(".00");//构造方法的字符格式这里如果小数不足2位,会以0补足.
    				String totalStr=decimalFormat.format(total);//format 返回的是字符串
    				jsonRoute.put(type+"totalPrice",totalStr);
    			}else{//有此日交通
    				jsonArray.add(json);
    				Float total = Float.parseFloat((String) json.get("totalPrice"))+Float.parseFloat((String) jsonRoute.get(type+"totalPrice"));
    				DecimalFormat decimalFormat=new DecimalFormat(".00");//构造方法的字符格式这里如果小数不足2位,会以0补足.
    				String totalStr=decimalFormat.format(total);//format 返回的是字符串
    				jsonRoute.put(type+"totalPrice",totalStr);
    			}
    		}
    	}
    	return jsonRoute;
    }
    
    /**
     * 酒店
     * 
     * 			酒店：{
     * 				date1:{}
     * 				date2:{}
     * 			}
     * 			
     * 
     * @param sessionRouteStr
     * @param trafficStr
     * @param type
     * @return
     */
    private JSONObject hotelJson(String sessionRouteStr,String hotelStr,String type){
    	JSONObject jsonRoute = null;
    	//无行程
    	if(sessionRouteStr==null){
    		jsonRoute = new JSONObject();
		}else{
			jsonRoute = JSONObject.parseObject(sessionRouteStr);
		}
    	JSONArray jsonArray = JSONArray.parseArray(hotelStr);
    	JSONObject typeJson =(JSONObject) jsonRoute.get(type);//酒店类型的json
    	//无酒店
    	if(typeJson==null){
    		typeJson = new JSONObject();
		}
    	String totalPriceStr = jsonRoute.getString(type+"totalPrice");
    	if(totalPriceStr==null){
    		totalPriceStr="0";
    	}
    	float totalPrice = Float.parseFloat(totalPriceStr);
    	for(int i=0;i<jsonArray.size();i++){
    		JSONObject jsonObject = jsonArray.getJSONObject(i);
    		String date = jsonObject.getString("date");////日期
    		JSONObject json = (JSONObject) typeJson.get(date);
    		//这天，行程中无酒店信息
    		if(json==null){
    			totalPrice = totalPrice+Float.parseFloat((String) jsonObject.get("totalPrice"));
    			
    			typeJson.put(date, jsonObject);
    			jsonRoute.put(type, typeJson);
    			jsonRoute.put(type+"totalPrice",totalPrice);
    		}else{
    			//这天，行程中有酒店信息
    			float oldTotal = Float.parseFloat(json.getString("totalPrice"));
    			totalPrice = totalPrice+Float.parseFloat((String) jsonObject.get("totalPrice"))-oldTotal;
    			typeJson.put(date, jsonObject);
    			jsonRoute.put(type, typeJson);
    			jsonRoute.put(type+"totalPrice",totalPrice);
    		}
    	}
    	return jsonRoute;
//    	String date = json.getString("date");//日期
//    	//无行程
//    	if(sessionRouteStr==null){
//    		
//    		JSONObject jsonObject = new JSONObject();
//    		jsonObject.put(date, json);
//    		
//    		jsonRoute = new JSONObject();
//    		jsonRoute.put(type, jsonObject);
//    		jsonRoute.put(type+"totalPrice",json.get("totalPrice"));
//    	}else{//有行程
//    		jsonRoute = JSONObject.parseObject(sessionRouteStr);
//    		JSONObject jsonObject =(JSONObject) jsonRoute.get(type);
//    		//无酒店
//    		if(jsonObject==null){
//    			jsonObject = new JSONObject();
//    			jsonObject.put(date, json);
//    			
//    			jsonRoute.put(type, jsonObject);
//    			jsonRoute.put(type+"totalPrice",json.get("totalPrice"));
//    		}else{//有酒店
//    			JSONObject j = (JSONObject) jsonObject.get(date);
//    			Float t = 0f;
//    			if(j!=null){
//    				t = Float.parseFloat((String) j.get("totalPrice"));
//    			}
//    			Float total = Float.parseFloat((String) json.get("totalPrice"))+Float.parseFloat((String) jsonRoute.get(type+"totalPrice"))-t;
//    			DecimalFormat decimalFormat=new DecimalFormat(".00");//构造方法的字符格式这里如果小数不足2位,会以0补足.
//				String totalStr=decimalFormat.format(total);//format 返回的是字符串
//				jsonObject.put(date, json);
//				jsonRoute.put(type+"totalPrice",totalStr);
//    		}
//    	}
//    	return jsonRoute;
    }
    /**
     * 套餐
     * 
     * 		套餐：{
     * 			date1:{
     * 				pid:
					pname:
					startDate:
					endDate:
					taxationPrice：
					servicePrice：
					total:
					packagePriceList:[
						{
							price:
							prepay:
							number:
							priceGroup:
							priceItem:
						}
					]
					packagePriceList
     * 			}
     * 			date2:{}
     * 		}
     * 
     * @param sessionRouteStr
     * @param hotelStr
     * @param type
     * @return
     */
	private JSONObject packageJson(String sessionRouteStr,String packageStr,String type) throws Exception{
    	JSONObject json = JSONObject.parseObject(packageStr);
    	JSONObject jsonRoute = JSONObject.parseObject(sessionRouteStr);
    	
    	String startDate = json.getString("startDate");
    	String endDate = json.getString("endDate");
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	Date d = sdf.parse(startDate);
    	Date e = sdf.parse(endDate);
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    	List<Date> dateList= CommonUtils.getDateArrays(d, e,Calendar.DAY_OF_YEAR); 
    	JSONObject jsonObject = new JSONObject();
    	for (int i=0;i<dateList.size();i++) {  
    		JSONObject json1 = JSONObject.parseObject(packageStr);
    		
    		Map<String,Object> param = new HashMap<>(5);
    		param.put("pid", json.get("pid"));
    		param.put("pday", i+1);
    		List<RouteDetailInfo> rows = routeDetailInfoService.selectAllListByParam(param);
    		json1.put("routeDetailInfoList", rows);
    		jsonObject.put(dateFormat.format(dateList.get(i)), json1);
    	}  
    	if(jsonRoute==null){
    		jsonRoute = new JSONObject();
    	}
    	jsonRoute.put(type, jsonObject);
    	jsonRoute.put(type+"totalPrice",json.get("totalPrice"));
    	
    	return jsonRoute;
    }
    
    /**
     *娱乐{
     * 		date1：[{},{}]
     * 		date2：[{},{}]
     * }
     * @param sessionRouteStr
     * @param entStr
     * @param type
     * @return
     * @throws Exception
     */
    private JSONObject entJson(String sessionRouteStr,String entStr,String type) throws Exception{
    	JSONObject json = JSONObject.parseObject(entStr);
    	String date = json.getString("date");//日期
    	JSONObject jsonRoute = null;
    	 Map<String,Object> param = new HashMap<>(4);
         param.put("pid", json.get("pid"));
         param.put("pday", 1);
         List<EntRouteDetailInfo> rows = entRouteDetailInfoService.selectAllListByParam(param);
         json.put("entRouteDetailInfoList", rows);
    	//无行程
    	if(sessionRouteStr==null){
    		JSONArray jsonArray = new JSONArray();
    		jsonArray.add(json);
    		
    		JSONObject jsonObject = new JSONObject();
    		jsonObject.put(date, jsonArray);
    		
    		jsonRoute = new JSONObject();
    		jsonRoute.put(type, jsonObject);
    		jsonRoute.put(type+"totalPrice",json.get("totalPrice"));
    	}else{//有行程
    		jsonRoute = JSONObject.parseObject(sessionRouteStr);
    		
    		JSONObject jsonObject =(JSONObject) jsonRoute.get(type);
    		if(jsonObject==null){//无娱乐
    			JSONArray jsonArray = new JSONArray();
    			jsonArray.add(json);
    			
    			jsonObject = new JSONObject();
    			jsonObject.put(date, jsonArray);
    			
    			jsonRoute.put(type, jsonObject);
    			jsonRoute.put(type+"totalPrice",json.get("totalPrice"));
    		}else{//有娱乐
    			JSONArray jsonArray = (JSONArray) jsonObject.get(date);
    			if(jsonArray==null){//无此日娱乐
    				jsonArray = new JSONArray();
    				jsonArray.add(json);
    				jsonObject.put(date, jsonArray);
    				Float total = Float.parseFloat((String) json.get("totalPrice"))+Float.parseFloat((String) jsonRoute.get(type+"totalPrice"));
    				DecimalFormat decimalFormat=new DecimalFormat(".00");//构造方法的字符格式这里如果小数不足2位,会以0补足.
    				String totalStr=decimalFormat.format(total);//format 返回的是字符串
    				jsonRoute.put(type+"totalPrice",totalStr);
    			}else{//有此日娱乐
    				jsonArray.add(json);
    				Float total = Float.parseFloat((String) json.get("totalPrice"))+Float.parseFloat((String) jsonRoute.get(type+"totalPrice"));
    				DecimalFormat decimalFormat=new DecimalFormat(".00");//构造方法的字符格式这里如果小数不足2位,会以0补足.
    				String totalStr=decimalFormat.format(total);//format 返回的是字符串
    				jsonRoute.put(type+"totalPrice",totalStr);
    			}
    		}
    	}
    	return jsonRoute;
    }
    
    /**
     /**
     * 别墅
     * 
     * 		别墅：{
     * 			date1:{
     * 				pid:
					pname:
					startDate:
					endDate:
					taxationPrice：
					servicePrice：
					total:
					villa_nm：
					valliPrice:
						{
							room_price:
							number:
							prepay:
							extrabed_price:
							extrabed_number:
						}
     * 			}
     * 			date2:{}
     * 		}
     * 
     * 
     * @param sessionRouteStr
     * @param packageStr
     * @param type
     * @return
     * @throws Exception
     */
	private JSONObject villaJson(String sessionRouteStr,String villaStr,String type) throws Exception{
    	JSONObject json = JSONObject.parseObject(villaStr);
    	JSONObject jsonRoute = JSONObject.parseObject(sessionRouteStr);
    	
    	String startDate = json.getString("startDate");
    	String endDate = json.getString("endDate");
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    	Date d = dateFormat.parse(startDate);
    	Date e = dateFormat.parse(endDate);
    	List<Date> dateList= CommonUtils.getDateArrays(d, e,Calendar.DAY_OF_YEAR);
    	//无行程
    	if(jsonRoute==null){
    		jsonRoute = new JSONObject();
    		JSONObject jsonObject = new JSONObject();
    		for (int i=0;i<dateList.size();i++) {  
    			if(i==dateList.size()-1){
    				JSONObject json1 = JSONObject.parseObject(villaStr);
    				json1.put("pname", "退房："+json1.getString("pname"));
    				json1.put("time", "10:00");
    				jsonObject.put(dateFormat.format(dateList.get(i)), json1);
    			}else{
    				JSONObject json1 = JSONObject.parseObject(villaStr);
    				jsonObject.put(dateFormat.format(dateList.get(i)), json1);
    			}
    		}  
    		jsonRoute.put(type+"totalPrice",json.get("totalPrice"));
    		jsonRoute.put(type, jsonObject);
    	}else{
    		JSONObject jsonObject = (JSONObject) jsonRoute.get(type);
    		//有别墅
    		if(jsonObject!=null){
    			//新增别墅入住时间段是在已有别墅时间段内,有就清楚所有
    			if(jsonObject.get(dateFormat.format(d))!=null||jsonObject.get(dateFormat.format(e))!=null){
    				jsonObject = new JSONObject();
    				jsonRoute.put(type+"totalPrice",json.get("totalPrice"));
    			}else{
    				Float total = Float.parseFloat((String) json.get("totalPrice"))+Float.parseFloat((String) jsonRoute.get(type+"totalPrice"));
    				DecimalFormat decimalFormat=new DecimalFormat(".00");//构造方法的字符格式这里如果小数不足2位,会以0补足.
    				String totalStr=decimalFormat.format(total);//format 返回的是字符串
    				jsonRoute.put(type+"totalPrice",totalStr);
    			}
    		}else{
    			jsonObject = new JSONObject();
    			jsonRoute.put(type+"totalPrice",json.get("totalPrice"));
    		}
    		for (int i=0;i<dateList.size();i++) { 
    			if(i==dateList.size()-1){
    				JSONObject json1 = JSONObject.parseObject(villaStr);
    				json1.put("pname", "退房："+json1.getString("pname"));
    				json1.put("time", "10:00");
    				jsonObject.put(dateFormat.format(dateList.get(i)), json1);
    			}else{
    				JSONObject json1 = JSONObject.parseObject(villaStr);
    				jsonObject.put(dateFormat.format(dateList.get(i)), json1);
    			}
    		}  
    		jsonRoute.put(type, jsonObject);
    	}
    	
    	return jsonRoute;
    }
    
	
	  /**
     * 验证邮箱发送验证码
     * @param response
     * @param request
     */
    @RequestMapping(value = "/checkEmailForPW")
    public void checkEmailForPW(HttpServletResponse response, HttpServletRequest request,String email,String username) {
    	try {
    		User user = userService.getUserByUserName(username);
    		String userEmail= user.getEmail();
    		String openid = user.getOpenid();
    		if(null == openid || "".equals(openid)){
    			if(null == userEmail || "".equals(userEmail)){
	    			response.getWriter().print("noEmail");
	    			return;
	    		}else if(!userEmail.equals(email)){
	    			response.getWriter().print("ne");
	    			return;
	    		}else if(userEmail.equals(email)){
	    			String code =String.valueOf(Math.random()*9000+1000).substring(0,4);
	    			MailSender.send_verifycode_mail1(code, email);
	    			request.getSession().setAttribute("checkEmailForPW", code);
	    			response.getWriter().print("success");
	    			return;
	    		}	
    		}else{
    			response.getWriter().print("hasId");
    			return;
    		}
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
    }
    
    /**
     * 验证手机发送验证码
     * @param response
     * @param request
     */
    @RequestMapping(value = "/checkTelForPW")
    public void checkTelForPW(HttpServletResponse response, HttpServletRequest request,String tel,String username) {
    	User user = userService.getUserByUserName(username);
    	try{
    		String userTel = user.getTel();
    		String openid = user.getOpenid();
    		if(null == openid || "".equals(openid)){
	    		if(null == userTel || "".equals(userTel)){
	    			response.getWriter().print("noTel");
	    			return;
	    		}else if(!userTel.equals(tel)){
	    			response.getWriter().print("ne");
	    			return;
	    		}else if(userTel.equals(tel)){
	    			String code =String.valueOf(Math.random()*9000+1000).substring(0,4);
	    			String sendMsg = CommonUtils.getMsgTemplateBykey("verif_code_phone");
	    			SmsClientSend.sendSms(tel, MessageFormat.format(sendMsg, code));
	    			request.getSession().setAttribute("checkCodeForPW", code);
	    			request.getSession().setAttribute("currentTime", System.currentTimeMillis());
	    			response.getWriter().print("success");
	    			return;
	    		}	
    		}else{
    			response.getWriter().print("hasId");
    			return;
    		}
    	}catch(Exception e){
    		logger.error(e.getMessage());
    	}
    }
    
    @RequestMapping(value = "/checkTelCodeForPw")
    public ModelAndView checkTelCodeForPw(HttpServletResponse response, HttpServletRequest request,String checkCode,String username) {
    	try{
    		String code = (String) request.getSession().getAttribute("checkCodeForPW");
    		long currentTimeMillis = (long) request.getSession().getAttribute("currentTime");
    		long now = System.currentTimeMillis();
    		if((currentTimeMillis+60*1000)>now){
    			if(code.equalsIgnoreCase(checkCode)){
    				return new ModelAndView("/modifyPW","username",username);
    			//	response.getWriter().print("ok");
    			}else{
    			//	response.getWriter().print("验证码错误");
    				return new ModelAndView("/login","msg","验证码错误");
    			}
    		}else{
    		//	response.getWriter().print("验证码过期");
    			return new ModelAndView("/login","msg","验证码过期");
    		}
    	}catch(Exception e){
    		logger.error(e.getMessage());
    	}
    	return new ModelAndView("/login","msg","验证错误");
    }
    
    @RequestMapping(value = "/checkEmailCodeForPw")
    public ModelAndView checkEmailCodeForPw(HttpServletResponse response, HttpServletRequest request,String checkCode,String username) {
    	try{
    		String code = (String) request.getSession().getAttribute("checkEmailForPW");
			if(code.equalsIgnoreCase(checkCode)){
				return new ModelAndView("/modifyPW","username",username);
			//	response.getWriter().print("ok");
			}else{
			//	response.getWriter().print("验证码错误");
				return new ModelAndView("/login","msg","验证码错误");
			}
    	}catch(Exception e){
    		logger.error(e.getMessage());
    	}
    	return new ModelAndView("/login","msg","验证错误");
    }
    
}
