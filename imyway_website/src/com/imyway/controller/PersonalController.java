package com.imyway.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.imyway.common.utils.CommonUtils;
import com.imyway.common.utils.JSONProxy;
import com.imyway.common.utils.PageResult;
import com.imyway.model.BookCusInfo;
import com.imyway.model.City;
import com.imyway.model.Customer;
import com.imyway.model.CustomerVO;
import com.imyway.model.EntInfo;
import com.imyway.model.EntPriceInfo;
import com.imyway.model.HotelInfo;
import com.imyway.model.PackageInfo;
import com.imyway.model.PackagePriceInfo;
import com.imyway.model.ProductOrder;
import com.imyway.model.ProductOrderDetail;
import com.imyway.model.RoomPriceInfo;
import com.imyway.model.RouteOrder;
import com.imyway.model.TrafficCharteredPriceInfo;
import com.imyway.model.TrafficInfo;
import com.imyway.model.User;
import com.imyway.model.VillaDetailPriceInfo;
import com.imyway.model.VillaInfo;
import com.imyway.services.IBookCusInfoService;
import com.imyway.services.ICityService;
import com.imyway.services.ICollectionService;
import com.imyway.services.ICustomerService;
import com.imyway.services.IEntInfoService;
import com.imyway.services.IEntPriceInfoService;
import com.imyway.services.IHotelInfoService;
import com.imyway.services.IPackageInfoService;
import com.imyway.services.IPackagePriceInfoService;
import com.imyway.services.IProductOrderDetailService;
import com.imyway.services.IProductOrderService;
import com.imyway.services.IRoomPriceInfoService;
import com.imyway.services.IRouteOrderService;
import com.imyway.services.ITrafficCharteredPriceInfoService;
import com.imyway.services.ITrafficInfoService;
import com.imyway.services.IUserService;
import com.imyway.services.IVillaDetailPriceInfoService;
import com.imyway.services.IVillaInfoService;
import com.imyway.vo.ProductOrderVO;
import com.imyway.vo.RouteOrderVO;



/**
 * 
 * @author GM
 * 
 */
@Controller
public class PersonalController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(PersonalController.class);

    @Autowired
    private ICityService cityService;
    @Autowired
    private ICustomerService customerService;
    @Autowired
    private IUserService userService;
    @Autowired
	private IRouteOrderService routeOrderService;
	@Autowired
	private IProductOrderService productOrderService;
	@Autowired
	private IProductOrderDetailService iroductOrderDetailService;
	@Autowired
	private ITrafficInfoService trafficInfoService;
    @Autowired private IHotelInfoService hotelInfoService;
    @Autowired private IPackageInfoService packageInfoService;
    @Autowired private IEntInfoService entInfoService;
    @Autowired private IVillaInfoService villaInfoService;
    @Autowired private IPackagePriceInfoService packagePriceInfoService;
    @Autowired private IRoomPriceInfoService roomPriceInfoService;
    @Autowired private IVillaDetailPriceInfoService villaDetailPriceInfoService;
    @Autowired private ICollectionService collectionService;
    @Autowired private ITrafficCharteredPriceInfoService trafficCharteredPriceInfoService;
    @Autowired private IEntPriceInfoService entPriceInfoService;
    @Autowired private IBookCusInfoService bookCusInfoService;
    
    
    /**
     * 跳转常用联系人列表页面
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/personal/contact")
    public ModelAndView hotelDetail(HttpServletResponse response, HttpServletRequest request) {
        try {
        	Map<String,Object> param = new HashMap<>(1);
        	param.put("parentId", 0);
        	List<City> cityList = cityService.getCityList(param);
        	request.setAttribute("cityList", cityList);
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("login fail. " + e.toString());
        }
        return new ModelAndView("/personal/contact");
    }
    
    /**
     * 联系人列表
     * @param response
     * @param request
     * @param offset
     * @param limit
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/personal/customerAdminSearchList")
    public void customerAdminSearchList(HttpServletResponse response, HttpServletRequest request,Integer offset, Integer limit) {
        try {
        	String name = request.getParameter("customerName");
        	Map map = new HashMap();
			map.put("offset", offset);
        	map.put("limit", limit);
        	map.put("userId", getAdminId(request));
        	map.put("customerName", name);

            List<Map<String,Object>> rows = customerService.getAllListMap(map);
            long count = customerService.getCount(map);
            Map<String, Object> reslutMap = new HashMap<>();
            reslutMap.put("rows", rows);
            reslutMap.put("total", count);
            response.getWriter().print(JSON.toJSONString(reslutMap, JSONProxy.SYSTEM_FEATURE));
        } catch (Exception e) {
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("login fail. " + e.toString());
        }
    }
    
    /**
     * 新增联系人
     * @param response
     * @param request
     * @param menul
     * @return
     */
    @RequestMapping(value = "/personal/saveOrUpdateCustomer")
    public void saveOrUpdateCustomer(HttpServletResponse response, HttpServletRequest request,String menu,@ModelAttribute("customer") Customer customer) {
        try {
        	if(customer.getId()==0){
        		customer.setUserId(getAdminId(request));
        		customer.setCtuser(getAdminId(request)+"");
        		customer.setCtdt(new Date());
        		customerService.insert(customer);
        		response.getWriter().print("success");
        	}else{
        		customer.setUpdt(new Date());
            	customer.setUpuser(getAdminId(request)+"");
            	customer.setUserId(getAdminId(request));
            	customerService.updateObject(customer);
            	response.getWriter().print("success");
        	}
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("saveOrUpdateCustomer fail. " + e.toString());
        }
    }
    
    
    /**
     * 删除联系人
     * @param response
     * @param request
     * @param menu
     * @return
     */
    @RequestMapping(value = "/personal/deleteCustomer")
    public void deleteCustomer(HttpServletResponse response, HttpServletRequest request,int id) {
    	try {
//    		Customer c =  (Customer) customerService.getOneByPrimaryKey(id);
    		customerService.deleteByPrimaryKey(id);
    		response.getWriter().print("success");
    	} catch (Exception e) {
    		e.printStackTrace();
    		if (null != e.getMessage()) {
    			System.out.println(e.toString());
    		}
    		logger.info("deleteCustomer fail. " + e.toString());
    	}
    }
    
    /**
     * 获取一个联系人
     * @param response
     * @param request
     * @param menu
     * @return
     */
    @RequestMapping(value = "/personal/getCustomerById")
    public void getCustomerById(HttpServletResponse response, HttpServletRequest request,int id) {
        try {
        	Customer customer = (Customer) customerService.getOneByPrimaryKey(id);
//        	City country = cityService.getCity(customer.getCountryId());
//        	City province = cityService.getCity(customer.getProvinceId());
//        	City city = cityService.getCity(customer.getCityId());
        	 Map<String, Object> reslutMap = new HashMap<>();
//        	 reslutMap.put("country", country);
//        	 reslutMap.put("province", province);
//        	 reslutMap.put("city", city);
        	 reslutMap.put("customer", customer);
        	
        	 response.getWriter().print(JSON.toJSONString(reslutMap, JSONProxy.SYSTEM_FEATURE));
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("getCustomerById fail. " + e.toString());
        }
    }
    
    /**
     * 删除删除联系人
     * @param response
     * @param request
     * @param menu
     * @return
     */
    @RequestMapping(value = "/personal/deleteBucthCustomer")
    public void deleteBucthCustomer(HttpServletResponse response, HttpServletRequest request,String ids) {
        try {
        	String[] str = ids.split(",");
        	customerService.deleteBucthCustomer(str);
        	response.getWriter().print("success");
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("deleteCustomer fail. " + e.toString());
        }
    }
    
    
    
    
    
    /**
     * 跳转个人信息页面
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/personal/personInfo")
    public ModelAndView personInfo(HttpServletResponse response, HttpServletRequest request) {
    	try {
    		Map<String,Object> param = new HashMap<>(1);
        	param.put("parentId", 0);
        	
        	User user = userService.getUserById(getAdminId(request));
        	request.setAttribute("user", user);
    	} catch (Exception e) {
    		e.printStackTrace();
    		if (null != e.getMessage()) {
    			System.out.println(e.toString());
    		}
    		logger.info("personInfo fail. " + e.toString());
    	}
    	return new ModelAndView("/personal/personInfo");
    }
    
    /**
     * 修改用户头像
     * @param response
     * @param request
     * @param user
     * @throws IOException 
     */
    @RequestMapping(value = "/personal/updateUserPhoto")
    public void updateUserPhoto(HttpServletResponse response, HttpServletRequest request,String id,String photo) throws IOException{
    	try {
    		Map<String,Object> param = new HashMap<>(1);
    		param.put("id", id);
        	param.put("photo", photo);
    		userService.updateUserPhoto(param);
    		
    		request.getSession().removeAttribute("loginUser");
    		request.getSession().setAttribute("loginUser", userService.getUserById(Integer.parseInt(id)));
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("personal/updateUserPhoto fail. " + e.toString());
		}
    }
    
    
    /**
     * 修改用户
     * @param response
     * @param request
     * @param user
     * @throws IOException 
     */
    @RequestMapping(value = "/personal/updateUser")
    public void updateUser(HttpServletResponse response, HttpServletRequest request,@ModelAttribute("user") User user,String checkTelCode,String checkEmalCode) throws IOException{
    	
    	String msg = null;
    	try {
    		
    		User userold = userService.getUserById(user.getId());
    		
    		//邮箱有修改，验证码check
    		if(StringUtils.isNotEmpty(user.getEmail()) && !user.getEmail().equals(userold.getEmail())){
    			if(StringUtils.isEmpty(checkEmalCode)){
    				msg = "请获取并填写邮箱验证码！";
    			}else if(!checkEmalCode.equals((String) request.getSession().getAttribute("checkEmail"))){
    				msg = "邮箱验证码不正确，请输入正确的验证码！";
    			}
    		}
    		
    		//电话有修改，验证码check
    		if(StringUtils.isNotEmpty(user.getTel()) && !user.getTel().equals(userold.getTel())){
    			if(StringUtils.isEmpty(checkTelCode)){
    				msg = "请获取并填写手机验证码！";
    			}else if(!checkTelCode.equals((String) request.getSession().getAttribute("checkTel"))){
    				msg = "手机验证码不正确，请输入正确的验证码！";
    			}
    		}
    		
    		if(msg != null){
    			response.getWriter().print(msg);
    			return;
    		}
    		
    		user.setUpdt(new Date());
    		userService.modifyUser(user);
    		user = userService.getUserById(user.getId());
    		request.getSession().removeAttribute("loginUser");
    		request.getSession().setAttribute("loginUser", user);
    		msg = "修改成功";
		} catch (IOException e) {
			e.printStackTrace();
			logger.info("personal/updateUser fail. " + e.toString());
			msg = "系统繁忙，请稍后再试！";
		}
    	response.getWriter().print(msg);
    }
    
    
    
    
    
    /**
     * 删除删除联系人
     * @param response
     * @param request
     * @param menu
     * @return
     */
    @RequestMapping(value = "/personal/isCanEvaluation")
    public void isCanEvaluation(HttpServletResponse response, HttpServletRequest request,String userId,String pid) {
        try {
        	 Map<String,Object> param = new HashMap<>();
             param.put("userId", userId);
             param.put("pid", pid);
        	boolean bool = userService.getIsCanEvaluation(param);
        	
        	response.getWriter().print(bool+"");
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("deleteCustomer fail. " + e.toString());
        }
    }
    
    
    
    
    
    /**
     * 跳转个人收藏页面
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/personal/collection")
    public ModelAndView collection(HttpServletResponse response, HttpServletRequest request,
    		String ptype,int page,int pageSize,int active) {
        ModelAndView mav = new ModelAndView("/personal/collection");
        try {
            
            User user = (User) request.getSession().getAttribute("loginUser");
            Map<String,Object> param = new HashMap<>();
            param.put("userId", user==null?89:user.getId());
            param.put("ptype", ptype);
            PageResult<Map<String, Object>> pageResult = new PageResult<Map<String,Object>>(pageSize, page);
            param.put("offset", pageResult.getOffset());
    		param.put("limit", pageResult.getPageSize());
            List<Map<String,Object>> list = collectionService.selectCollectionProductListByParam(param);
            int total = collectionService.getCount(param);
            int pageSizes = total/10;
            if(total%10 > 0 ){
            	pageSizes +=1;
            }
            mav.addObject("list",list);
            mav.addObject("pageSizes",pageSizes);
            mav.addObject("ptype",ptype);
            mav.addObject("active",active);
            mav.addObject("la",active == 1 ? 1 : (active-1));
            mav.addObject("ra",active == pageSizes ? pageSizes : active+1);
            
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
     * 生成行程单
     * @param response
     * @param request
     * @return ModelAndView
     */
    @SuppressWarnings("unchecked")
	@RequestMapping(value = "/personal/createRoute")
    public ModelAndView createRoute(HttpServletResponse response, HttpServletRequest request) {
    	try {
			//获取行程json
    		String routeJsonStr = (String) request.getSession().getAttribute("routeJson");
			String orderNo = (String) request.getSession().getAttribute("orderNo");
			JSONObject jsonObject = JSONObject.parseObject(routeJsonStr);
			List<String> dateList = (List<String>) jsonObject.get("dateList");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			Double total = 0.00;//总价
			Double prepaytotal = 0.00;//总预付价格
			String ctuser = getAdminId(request)+"";
			
			RouteOrderVO routeOrderVO = new RouteOrderVO();
			//行程单
			RouteOrder routeOrder = new RouteOrder();
			if(orderNo!=null&&!orderNo.isEmpty()){
				routeOrderService.deleteRoute(orderNo);
				routeOrder.setOrderNo(orderNo);
			}
			
			routeOrder.setCusNo(ctuser);//客户编号
			routeOrder.setStatus("1");//订单状态 1:预定
			//行程开始时间
			Date startDate = sdf.parse(dateList.get(0));
			//行程结束时间
			Date endDate = sdf.parse(dateList.get(dateList.size()-1));
			routeOrder.setStartdate(startDate);//行程开始日期
			routeOrder.setEnddate(endDate);//行程结束日期
			routeOrder.setAdultCnt(0);//成人数
			routeOrder.setChildCnt(0);//儿童数
			routeOrder.setAmount(total);//总价
			routeOrder.setPrepay(prepaytotal);//预付款
			routeOrder.setEvaluateflg("0");//是否已评价   0是  1否
			routeOrder.setDelFlg("0");//有效FLG  0:有效
			routeOrder.setBillTime(new Date());//下单时间
			routeOrder.setCtuser(getAdminId(request)+"");//创建人
			routeOrder.setCtdt(new Date()); //创建时间
			routeOrder.setRouteJson(routeJsonStr);
			routeOrderVO.setRouteOrder(routeOrder);
			List<ProductOrderVO> productOrderVOList = new ArrayList<ProductOrderVO> ();
			routeOrderVO.setProductOrderVOList(productOrderVOList);
			//套餐
			getRouteOrderVOPackage(request,routeJsonStr,routeOrderVO);
			//别墅
			getRouteOrderVOVilla(request,routeJsonStr,routeOrderVO);
			//酒店
			getRouteOrderVOHotel(request,routeJsonStr,routeOrderVO);
			//娱乐
			getRouteOrderVOEnt(request,routeJsonStr,routeOrderVO);
			//交通
			getRouteOrderVOTraffci(request,routeJsonStr,routeOrderVO);
			
			String routeOrderName = getRouteOrderName(routeJsonStr);
			routeOrder.setOrderNm(routeOrderName);//订单名称
			routeOrder.setOldAmount(routeOrder.getAmount());
			routeOrderService.saveRouteOrderVO(routeOrderVO);
			request.getSession().setAttribute("routeJson",null);
			request.getSession().setAttribute("orderNo",null);
			request.getSession().setAttribute("addDate",null);
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	return new ModelAndView("redirect:/personal/myorder.html?page=1&pageSize=10");
    }
    
    @SuppressWarnings("unchecked")
	private String getRouteOrderName(String routeJsonStr){
    	JSONObject jsonObject = JSONObject.parseObject(routeJsonStr);
    	List<String> dateList = (List<String>) jsonObject.get("dateList");
    	//第一天
    	String date = dateList.get(0);
    	//套餐
    	JSONObject packageJson = (JSONObject) jsonObject.get("package");
    	if(packageJson!=null){
    		JSONObject p = packageJson.getJSONObject(date);
    		if(p!=null){
    			return p.getString("pname");
    		}
    	}
    	//别墅
    	JSONObject villaJson = (JSONObject) jsonObject.get("villa");
    	if(villaJson!=null){
    		JSONObject v = villaJson.getJSONObject(date);
    		if(v!=null){
    			return v.getString("pname");
    		}
    	}
    	//酒店
    	JSONObject hotelJson = (JSONObject) jsonObject.get("hotel");
    	if(hotelJson!=null){
    		JSONObject h = hotelJson.getJSONObject(date);
    		if(h!=null){
    			return h.getString("pname");
    		}
    	}
    	//娱乐
    	JSONObject entJson = (JSONObject) jsonObject.get("ent");
    	if(entJson!=null){
    		JSONArray jsonArray = entJson.getJSONArray(date);
    		if(jsonArray!=null&&jsonArray.size()!=0){
    			return ((JSONObject) jsonArray.get(0)).getString("pname");
    		}
    	}
    	//交通
		JSONObject trafficJson = (JSONObject) jsonObject.get("traffic");
		if(trafficJson!=null){
			JSONArray jsonArray = trafficJson.getJSONArray(date);
    		if(jsonArray!=null&&jsonArray.size()!=0){
    			return ((JSONObject) jsonArray.get(0)).getString("pname");
    		}
		}
    	
    	return null;
    }
    
    /**
     * 跳转我的订单页面
     * @param response
     * @param request
     * @return ModelAndView
     */
	@RequestMapping(value = "/personal/myorder")
    public ModelAndView toMyorder(HttpServletResponse response, HttpServletRequest request,String status,int page,int pageSize) {
		ModelAndView mav = new ModelAndView("/personal/myorder");
		try {
			Map<String,Object> param = new HashMap<>();
			param.put("status", status);
			param.put("cusNo", getAdminId(request));
			PageResult<Map<String, Object>> pageResult = new PageResult<Map<String,Object>>(pageSize, page);
			pageResult.setT(param);
			pageResult = routeOrderService.getMyorderPage(pageResult);
			mav.addObject("pageResult", pageResult);
			mav.addObject("rows", pageResult.getPageResultList());
			mav.addObject("status", status);
		} catch (Exception e) {
			e.printStackTrace();
		}
        return mav;
    }
    
    /**
     * 别墅
     * @param request
     * @param routeJsonStr
     * @param routeOrderVO
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    private void getRouteOrderVOVilla(HttpServletRequest request,String routeJsonStr,RouteOrderVO routeOrderVO) throws Exception{
    		//获取行程json
    		JSONObject jsonObject = JSONObject.parseObject(routeJsonStr);
    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    		
    		Double total = routeOrderVO.getRouteOrder().getAmount();//总价
    		Double prepaytotal = routeOrderVO.getRouteOrder().getPrepay();//总预付价格
    		String ctuser = getAdminId(request)+"";
    		
    		List<ProductOrderVO> productOrderVOList =  routeOrderVO.getProductOrderVOList();
    		int peopleMax = 0;
    		//别墅
    		JSONObject villaJson = (JSONObject) jsonObject.get("villa");
    		
    		if(villaJson!=null){
    			Iterator it_villa = villaJson.keySet().iterator();
        		List<String> timestampList = new ArrayList<String>();
        		List<String> dateList = new ArrayList<String>();
        		//筛选预定的别墅
    			while(it_villa.hasNext()){
    				String date = it_villa.next().toString();
    				JSONObject villaJsonObject = villaJson.getJSONObject(date);
    				String timestamp = villaJsonObject.getString("timestamp");
    				if(!timestampList.contains(timestamp)){
    					dateList.add(date);
    					timestampList.add(timestamp);
    				}
    			}
    			if(!dateList.isEmpty()){
    				for(String date:dateList){
    					JSONObject villaJsonObject = villaJson.getJSONObject(date);
    					String startDate = villaJsonObject.getString("startDate");
    					String endDate = villaJsonObject.getString("endDate");
						ProductOrderVO productOrderVO = new ProductOrderVO();
						ProductOrder productOrder = new ProductOrder();
						//产品pid
						String pid = villaJsonObject.getString("pid");
						Map<String,Object> param = new HashMap<>(3);
						param.put("pid", pid);
						
						//别墅属性
						VillaInfo row = villaInfoService.selectVillaInfoByParam(param);
						if(row.getUpdt()==null){
							row.setUpdt(row.getCtdt());
						}
						BeanUtils.copyProperties(productOrder, row);
						
						productOrder.setInday(sdf.parse(date));//行程日期
						productOrder.setDelFlg("0");
						productOrder.setCtdt(new Date());
						productOrder.setStartdate(sdf.parse(startDate));
						productOrder.setEnddate(sdf.parse(endDate));
						productOrder.setAttime(villaJsonObject.getString("time"));
						productOrder.setCtuser(ctuser);
						productOrder.setAttime(villaJsonObject.getString("time"));
						productOrder.setConfirmStatus("1");//默认是1，未确认
						productOrderVO.setProductOrder(productOrder);
						
						long n = CommonUtils.daysBetween(startDate, endDate)-1;
						
						//产品订单详情
						List<ProductOrderDetail> productOrderDetailList = new ArrayList<ProductOrderDetail>();
						//别墅价格项
						JSONArray valliPriceList = villaJsonObject.getJSONArray("valliPriceList");
						for(int i=0;i<valliPriceList.size();i++){
							JSONObject valliPrice = valliPriceList.getJSONObject(i);
							
							int number = valliPrice.getIntValue("number");//预定数量
							int id = valliPrice.getIntValue("id");//预定数量
							int extrabed_number = 0;//加床数量
							if(valliPrice.getString("extrabed_number")!=null){
								extrabed_number = valliPrice.getIntValue("extrabed_number");
							}
							VillaDetailPriceInfo villaDetailPriceInfo = villaDetailPriceInfoService.selectVillaDetailPriceInfoById(id);
							BigDecimal prepay = villaDetailPriceInfo.getPrepay();//预定预付价格
							BigDecimal roomPrice = villaDetailPriceInfo.getRoomPrice();//预定价格
							BigDecimal addPrice = villaDetailPriceInfo.getAddPrice();//预定加床价格
							if(addPrice == null){
								addPrice = new BigDecimal(0);
							}
							
							Double amout =0.00;
							Double prepayAmount =0.00;
							amout = n*(number*Double.parseDouble(roomPrice.toString())+extrabed_number*Double.parseDouble(addPrice.toString()));
							prepayAmount = n*(Double.parseDouble(prepay.toString())*number);
							total = total+amout;
							prepaytotal = prepaytotal+prepayAmount;
							
							ProductOrderDetail productOrderDetail = new ProductOrderDetail();
							productOrderDetail.setPriceItem(number+"卧室");//价格项
							productOrderDetail.setPriceItemId(id);
							productOrderDetail.setPid(productOrder.getPid());//产品id
							productOrderDetail.setOrdercnt(number);//预定数量
							productOrderDetail.setUnitPrice(Double.parseDouble(roomPrice.toString()));//预定价格
							productOrderDetail.setUnitPrepay(Double.parseDouble(prepay.toString()));//预定预付价格
							productOrderDetail.setPeoplecnt(villaDetailPriceInfo.getPeopleCnt()*number);//预定总人数
							
							productOrderDetail.setAmount(amout);//总计价格
							productOrderDetail.setPrepayAmount(prepayAmount);//预付总计额
							productOrderDetail.setCtdt(new Date());
							productOrderDetail.setCtuser(ctuser);
							productOrderDetailList.add(productOrderDetail);
							
							peopleMax = peopleMax+(villaDetailPriceInfo.getPeopleCnt()*number);
						}
						productOrderVO.setProductOrderDetailList(productOrderDetailList);
						productOrderVOList.add(productOrderVO);
    				}
    				routeOrderVO.setProductOrderVOList(productOrderVOList);
    			}
    		}
    		if(routeOrderVO.getRouteOrder().getAdultCnt()==0){
    			routeOrderVO.getRouteOrder().setAdultCnt(peopleMax);
    		}
    		routeOrderVO.getRouteOrder().setAmount(total);
    		routeOrderVO.getRouteOrder().setPrepay(prepaytotal);
    }
    /**
     * 娱乐
     * @param request
     * @param routeJsonStr
     * @param routeOrderVO
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    private void getRouteOrderVOEnt(HttpServletRequest request,String routeJsonStr,RouteOrderVO routeOrderVO) throws Exception{
			//获取行程json
			JSONObject jsonObject = JSONObject.parseObject(routeJsonStr);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			Double total = routeOrderVO.getRouteOrder().getAmount();//总价
			Double prepaytotal = routeOrderVO.getRouteOrder().getPrepay();//总预付价格
			String ctuser = getAdminId(request)+"";
			
			List<ProductOrderVO> productOrderVOList =  routeOrderVO.getProductOrderVOList();
			int peopleMax=0;
			//娱乐
			JSONObject entJson = (JSONObject) jsonObject.get("ent");
			if(entJson!=null){
				Iterator it_ent = entJson.keySet().iterator();
				while(it_ent.hasNext()){
					//产品订单
					String date = it_ent.next().toString();
					//第几天
					JSONArray entJSONArray = (JSONArray) entJson.get(date);
					if(entJSONArray!=null && !entJSONArray.isEmpty()){
						for(int j=0;j<entJSONArray.size();j++){
							ProductOrderVO productOrderVO = new ProductOrderVO();
							ProductOrder productOrder = new ProductOrder();
							JSONObject entJson_ = entJSONArray.getJSONObject(j);
							//产品pid
							String pid = entJson_.getString("pid");
							String startDate = entJson_.getString("startDate");
							String endDate = entJson_.getString("endDate");
							Map<String,Object> param = new HashMap<>(3);
							param.put("pid", pid);
							
							//娱乐属性
							EntInfo row = entInfoService.selectEntInfoByParam(param);
							if(row.getUpdt()==null){
								row.setUpdt(row.getCtdt());
							}
							BeanUtils.copyProperties(productOrder, row);
							
							productOrder.setInday(sdf.parse(date));//行程日期
							productOrder.setStartdate(sdf.parse(startDate));
							productOrder.setEnddate(sdf.parse(endDate));
							productOrder.setDelFlg("0");
							productOrder.setCtdt(new Date());
							productOrder.setStartdate(sdf.parse(date));
							productOrder.setAttime(entJson_.getString("time"));
							productOrder.setCtuser(ctuser);
							productOrder.setAttime(entJson_.getString("time"));
							productOrder.setConfirmStatus("1");//默认是1，未确认
							productOrderVO.setProductOrder(productOrder);
							
							//产品订单详情
							List<ProductOrderDetail> productOrderDetailList = new ArrayList<ProductOrderDetail>();
							//娱乐价格项
							JSONArray entPriceList = entJson_.getJSONArray("entPriceList");
							for(int k=0;k<entPriceList.size();k++){
								JSONObject entPrice = entPriceList.getJSONObject(k);
								//价格项id
								int id = entPrice.getIntValue("id");
								int number = entPrice.getIntValue("number");//预定数
								
								EntPriceInfo entPriceInfo = entPriceInfoService.selectEntPriceInfoById(id);		
								//价格项
								String priceItem = entPriceInfo.getPriceItem();
								BigDecimal price = entPriceInfo.getPrice();//预定价格
								BigDecimal prepay = entPriceInfo.getPrepay();//预定预付价格
								
								ProductOrderDetail productOrderDetail = new ProductOrderDetail();
								
								productOrderDetail.setPriceItem(priceItem);//价格项
								productOrderDetail.setPriceItemId(id);
								productOrderDetail.setPid(productOrder.getPid());//产品id
								productOrderDetail.setOrdercnt(number);//预定数量
								productOrderDetail.setUnitPrice(Double.parseDouble(price.toString()));//预定价格
								productOrderDetail.setUnitPrepay(Double.parseDouble(prepay.toString()));//预定预付价格
								productOrderDetail.setPeoplecnt(number*entPriceInfo.getPeopleCnt());//预定人数
								
								Double amout = Double.parseDouble(price.toString())*number;
								Double prepayAmount = Double.parseDouble(prepay.toString())*number;
								total = total+amout;
								prepaytotal = prepaytotal+prepayAmount;
								
								productOrderDetail.setAmount(amout);//总计价格
								productOrderDetail.setPrepayAmount(prepayAmount);//预付总计额
								productOrderDetail.setCtdt(new Date());
								productOrderDetail.setCtuser(ctuser);
								productOrderDetailList.add(productOrderDetail);
								
								productOrderVO.setProductOrderDetailList(productOrderDetailList);
								//总人数
								peopleMax = peopleMax+entPriceInfo.getPeopleCnt()*number;
							}
							
							productOrderVOList.add(productOrderVO);
						}
						routeOrderVO.setProductOrderVOList(productOrderVOList);
					}
				}
			}
			if(routeOrderVO.getRouteOrder().getAdultCnt()==0){
    			routeOrderVO.getRouteOrder().setAdultCnt(peopleMax);
    		}
			routeOrderVO.getRouteOrder().setAmount(total);
			routeOrderVO.getRouteOrder().setPrepay(prepaytotal);
    }
    /**
     * 套餐
     * @param request
     * @param routeJsonStr
     * @param routeOrderVO
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    private void getRouteOrderVOPackage(HttpServletRequest request,String routeJsonStr,RouteOrderVO routeOrderVO) throws Exception{
    		//获取行程json
    		JSONObject jsonObject = JSONObject.parseObject(routeJsonStr);
    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    		
    		//总价
    		Double total = routeOrderVO.getRouteOrder().getAmount();
    		//总预付价格
    		Double prepaytotal = routeOrderVO.getRouteOrder().getPrepay();
    		//登入用户
    		String ctuser = getAdminId(request)+"";
    		//订单产品集合
    		List<ProductOrderVO> productOrderVOList = routeOrderVO.getProductOrderVOList();
    		
    		//套餐
    		JSONObject packageJson = (JSONObject) jsonObject.get("package");
    		int peopleMax = 0;
    		if(packageJson!=null){
    			Iterator it_package = packageJson.keySet().iterator();
    			while(it_package.hasNext()){
    				//产品订单
    				ProductOrderVO productOrderVO = new ProductOrderVO();
    				ProductOrder productOrder = new ProductOrder();
    				String date = it_package.next().toString();
    				//第几天
    				JSONObject packageJsonObject = (JSONObject) packageJson.get(date);
    				if(packageJsonObject!=null){
    					//产品pid
    					String pid = packageJsonObject.getString("pid");
    					String startDate = packageJsonObject.getString("startDate");
    					String endDate = packageJsonObject.getString("endDate");
    					Map<String,Object> param = new HashMap<>(3);
    					param.put("pid", pid);
    					
    					//套餐属性
    					PackageInfo row = packageInfoService.selectPackageInfoByParam(param);
    					if(row.getUpdt()==null){
							row.setUpdt(row.getCtdt());
						}
    					BeanUtils.copyProperties(productOrder, row);
    					
    					productOrder.setInday(sdf.parse(date));//行程日期
    					productOrder.setStartdate(sdf.parse(startDate));
    					productOrder.setEnddate(sdf.parse(endDate));
    					productOrder.setDelFlg("0");
    					productOrder.setCtdt(new Date());
    					productOrder.setCtuser(ctuser);
    					productOrder.setConfirmStatus("1");//默认是1，未确认
    					productOrderVO.setProductOrder(productOrder);
    					
    					//产品订单详情
    					List<ProductOrderDetail> productOrderDetailList = new ArrayList<ProductOrderDetail>();
    					//套餐价格项
    					JSONArray packagePriceList = (JSONArray) packageJsonObject.get("packagePriceList");
    					for(int i =0;i<packagePriceList.size();i++){
    						JSONObject json = packagePriceList.getJSONObject(i);
    						int id = json.getIntValue("id");
    						int number = json.getIntValue("number");//预定数
    						// 价格项详细信息
        					PackagePriceInfo packagePriceInfo = packagePriceInfoService.selectPackagePriceInfoById(id);
        					String priceItem = packagePriceInfo.getPriceItem();//预定价格项
        					BigDecimal price = packagePriceInfo.getPrice();//预定价格
        					BigDecimal prepay = packagePriceInfo.getPrepay();//预定预付价格
    						
    						ProductOrderDetail productOrderDetail = new ProductOrderDetail();
    						productOrderDetail.setPriceItem(priceItem);//价格项
    						productOrderDetail.setPriceItemId(id);
    						productOrderDetail.setPid(productOrder.getPid());//产品id
    						productOrderDetail.setOrdercnt(number);//预定数
    						productOrderDetail.setUnitPrice(Double.parseDouble(price.toString()));//预定价格
    						productOrderDetail.setUnitPrepay(Double.parseDouble(price.toString()));//预定预付价格
    						productOrderDetail.setPeoplecnt(packagePriceInfo.getPeopleCnt()*number);//预定人数
    						
    						Double amout = Double.parseDouble(price.toString())*number;
    						Double prepayAmount = Double.parseDouble(prepay.toString())*number;
    						total = total+amout;
    						prepaytotal = prepaytotal+prepayAmount;
    						
    						productOrderDetail.setAmount(amout);//总计价格
    						productOrderDetail.setPrepayAmount(prepayAmount);//预付总计额
    						productOrderDetail.setCtdt(new Date());
    						productOrderDetail.setCtuser(ctuser);
    						productOrderDetail.setOrdercnt(Integer.parseInt(json.getString("number")));
    						productOrderDetailList.add(productOrderDetail);
    						
    						//总人数
        					peopleMax = peopleMax+packagePriceInfo.getPeopleCnt()*number;
    						
    					}
    					productOrderVO.setProductOrderDetailList(productOrderDetailList);
    					productOrderVOList.add(productOrderVO);
    					routeOrderVO.setProductOrderVOList(productOrderVOList);
    				}
    				break;
    			}
    			
    		}
    		if(routeOrderVO.getRouteOrder().getAdultCnt()==0){
    			routeOrderVO.getRouteOrder().setAdultCnt(peopleMax);
    		}
    		routeOrderVO.getRouteOrder().setAmount(total);
    		routeOrderVO.getRouteOrder().setPrepay(prepaytotal);
    }
    /**
     * 酒店
     * @param request
     * @param routeJsonStr
     * @param routeOrderVO
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    private void getRouteOrderVOHotel(HttpServletRequest request,String routeJsonStr,RouteOrderVO routeOrderVO) throws Exception{
    		//获取行程json
    		JSONObject jsonObject = JSONObject.parseObject(routeJsonStr);
    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    		
    		Double total = routeOrderVO.getRouteOrder().getAmount();//总价
    		Double prepaytotal = routeOrderVO.getRouteOrder().getPrepay();//总预付价格
    		String ctuser = getAdminId(request)+"";
    		
    		List<ProductOrderVO> productOrderVOList = routeOrderVO.getProductOrderVOList();
    		
    		int peopleMax = 0;
    		//酒店
    		JSONObject hotelJson = (JSONObject) jsonObject.get("hotel");
    		if(hotelJson!=null){
    			Iterator it_hotel = hotelJson.keySet().iterator();
    			while(it_hotel.hasNext()){
    				//产品订单
    				ProductOrderVO productOrderVO = new ProductOrderVO();
    				ProductOrder productOrder = new ProductOrder();
    				String date = it_hotel.next().toString();
    				
    				JSONObject hotelJsonObject = (JSONObject) hotelJson.get(date);
    				if(hotelJsonObject!=null){
    					//产品pid
    					String pid = hotelJsonObject.getString("pid");
    					String startDate = hotelJsonObject.getString("startDate");
    					String endDate = hotelJsonObject.getString("endDate");
    					Map<String,Object> param = new HashMap<>(3);
    					param.put("pid", pid);
    					
    					//酒店属性
    					HotelInfo row = hotelInfoService.selectHotelInfoByParam(param);
    					if(row.getUpdt()==null){
							row.setUpdt(row.getCtdt());
						}
    					BeanUtils.copyProperties(productOrder, row);
    					
    					productOrder.setInday(sdf.parse(date));//行程日期
    					productOrder.setStartdate(sdf.parse(startDate));
    					productOrder.setEnddate(sdf.parse(endDate));
    					productOrder.setDelFlg("0");
    					productOrder.setCtdt(new Date());
    					productOrder.setStartdate(sdf.parse(date));
    					productOrder.setCtuser(ctuser);
    					productOrder.setAttime(hotelJsonObject.getString("time"));
    					productOrder.setConfirmStatus("1");//默认是1，未确认
    					productOrderVO.setProductOrder(productOrder);
    					
    					//产品订单详情
    					List<ProductOrderDetail> productOrderDetailList = new ArrayList<ProductOrderDetail>();
    					//房间类型集合
    					JSONArray roomtypeList = (JSONArray) hotelJsonObject.get("roomtypeList");
    					for(int i =0;i<roomtypeList.size();i++){
    						//房间类型 json
    						JSONObject json = roomtypeList.getJSONObject(i);
    						//房型预定价格集合
    						JSONArray roomTypePriceList = (JSONArray) json.get("roomTypePriceList");
    						for(int k =0;k<roomTypePriceList.size();k++){
    							JSONObject j = roomTypePriceList.getJSONObject(k);
    							int number = Integer.parseInt(j.getString("number"));//预定数量
    							if(number>0){
    								//价格项id
    								int id = Integer.parseInt(j.getString("id"));
    								//价格项详情
    								RoomPriceInfo roomPriceInfo = roomPriceInfoService.selectRoomPriceInfoById(id);
    								String priceItem = roomPriceInfo.getPriceItem();//价格项
    								BigDecimal roomPrice = roomPriceInfo.getRoomPrice();//预定价格
    								BigDecimal prepay = roomPriceInfo.getPrepay();//预定预付价格
    								
    								ProductOrderDetail productOrderDetail = new ProductOrderDetail();
    								productOrderDetail.setPriceItem(priceItem);//价格项
    								productOrderDetail.setPriceItemId(id);
    								productOrderDetail.setPid(productOrder.getPid());//产品id
    								productOrderDetail.setOrdercnt(number);//预定数量
    								productOrderDetail.setUnitPrice(Double.parseDouble(roomPrice.toString()));//预定价格
    								productOrderDetail.setUnitPrepay(Double.parseDouble(prepay.toString()));//预定预付价格
    								productOrderDetail.setPeoplecnt(roomPriceInfo.getPeopleCnt()*number);//预定人数
    								
    								Double amout = Double.parseDouble(roomPrice.toString())*number;
    								Double prepayAmount = Double.parseDouble(prepay.toString())*number;
    								total = total+amout;
    								prepaytotal = prepaytotal+prepayAmount;
    								
    								productOrderDetail.setAmount(amout);//总计价格
    								productOrderDetail.setPrepayAmount(prepayAmount);//预付总计额
    								productOrderDetail.setCtdt(new Date());
    								productOrderDetail.setCtuser(ctuser);
    								productOrderDetailList.add(productOrderDetail);
    								
    								//总人数
    								peopleMax = peopleMax+roomPriceInfo.getPeopleCnt()*number;
    							}
    						}
    					}
    					productOrderVO.setProductOrderDetailList(productOrderDetailList);
    					productOrderVOList.add(productOrderVO);
    					routeOrderVO.setProductOrderVOList(productOrderVOList);
    				}
    			}
    			
    		}
    		if(routeOrderVO.getRouteOrder().getAdultCnt()==0){
    			routeOrderVO.getRouteOrder().setAdultCnt(peopleMax);
    		}
    		routeOrderVO.getRouteOrder().setAmount(total);
    		routeOrderVO.getRouteOrder().setPrepay(prepaytotal);
    }
    /**
     * 交通
     * @param request
     * @param routeJsonStr
     * @param routeOrderVO
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
	private void getRouteOrderVOTraffci(HttpServletRequest request,String routeJsonStr,RouteOrderVO routeOrderVO) throws Exception{
			//获取行程json
			JSONObject jsonObject = JSONObject.parseObject(routeJsonStr);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			Double total = routeOrderVO.getRouteOrder().getAmount();//总价
			Double prepaytotal = routeOrderVO.getRouteOrder().getPrepay();//总预付价格
			String ctuser = getAdminId(request)+"";
			
			List<ProductOrderVO> productOrderVOList =  routeOrderVO.getProductOrderVOList();
			int peopleMax=0;
			
			//交通
			JSONObject trafficJson = (JSONObject) jsonObject.get("traffic");
			if(trafficJson!=null){
				Iterator it_traffic = trafficJson.keySet().iterator();
				while(it_traffic.hasNext()){
					//产品订单
					String date = it_traffic.next().toString();
					//第几天
					JSONArray trafficJSONArray = (JSONArray) trafficJson.get(date);
					if(trafficJSONArray != null && !trafficJSONArray.isEmpty()){
						for(int j=0;j<trafficJSONArray.size();j++){
							ProductOrderVO productOrderVO = new ProductOrderVO();
							ProductOrder productOrder = new ProductOrder();
							JSONObject trafficJson_ = trafficJSONArray.getJSONObject(j);
							//产品pid
							String pid = trafficJson_.getString("pid");
							String startDate = trafficJson_.getString("startDate");
							String endDate = trafficJson_.getString("endDate");
							Map<String,Object> param = new HashMap<>(3);
							param.put("pid", pid);
							
							//交通属性
							TrafficInfo row = trafficInfoService.selectTrafficInfoByParam(param);
							if(row.getUpdt()==null){
								row.setUpdt(row.getCtdt());
							}
							BeanUtils.copyProperties(productOrder, row);
							
							productOrder.setInday(sdf.parse(date));//行程日期
							productOrder.setDelFlg("0");
							productOrder.setCtdt(new Date());
							productOrder.setStartdate(sdf.parse(date));
							productOrder.setAttime(trafficJson_.getString("time"));
							productOrder.setCtuser(ctuser);
							productOrder.setStartdate(sdf.parse(startDate));
							productOrder.setEnddate(sdf.parse(endDate));
							productOrder.setConfirmStatus("1");//默认是1，未确认
							productOrderVO.setProductOrder(productOrder);
							
							//产品订单详情
							List<ProductOrderDetail> productOrderDetailList = new ArrayList<ProductOrderDetail>();
							//包车
							JSONArray trafficCharteredPriceList = (JSONArray) trafficJson_.get("trafficCharteredPriceList");
							for(int i =0;i<trafficCharteredPriceList.size();i++){
								JSONObject json = trafficCharteredPriceList.getJSONObject(i);
								//价格项id
								int id = Integer.parseInt(json.getString("id"));//价格项id
								
								//价格项详情
								TrafficCharteredPriceInfo info = trafficCharteredPriceInfoService.selectTrafficCharteredPriceInfoById(id);
								
								BigDecimal price = info.getPrice();//价格项价格
								BigDecimal prepay =info.getPrepay();//价格项预付价格
								String carbrand = json.getString("carbrand");//价格项
								int maxpeople = info.getMaxpeople();
								int number = Integer.parseInt(json.getString("number"));//预定数量
								
								// 订单产品详细
								ProductOrderDetail productOrderDetail = new ProductOrderDetail();
								productOrderDetail.setPriceItem(carbrand);//价格项
								productOrderDetail.setPid(productOrder.getPid());//产品id
								productOrderDetail.setPriceItemId(id);
								productOrderDetail.setOrdercnt(number);//预定数
								productOrderDetail.setUnitPrice(Double.parseDouble(price.toString()));//预定价格
								productOrderDetail.setUnitPrepay(Double.parseDouble(prepay.toString()));//预定预付价
								productOrderDetail.setPeoplecnt(maxpeople*number);//预定人数
								
								Double amout = Double.parseDouble(price.toString())*number;
								Double prepayAmount = Double.parseDouble(prepay.toString())*number;
								total = total+amout;
								prepaytotal = prepaytotal+prepayAmount;
								
								productOrderDetail.setAmount(amout);//总计价格
								productOrderDetail.setPrepayAmount(prepayAmount);//预付总计额
								productOrderDetail.setCtdt(new Date());
								productOrderDetail.setCtuser(ctuser);
								productOrderDetailList.add(productOrderDetail);
								
								//总人数
								peopleMax = peopleMax+maxpeople*number;
							}
							productOrderVO.setProductOrderDetailList(productOrderDetailList);
							productOrderVOList.add(productOrderVO);
						}
						routeOrderVO.setProductOrderVOList(productOrderVOList);
					}
				}
			}
			if(routeOrderVO.getRouteOrder().getAdultCnt()==0){
    			routeOrderVO.getRouteOrder().setAdultCnt(peopleMax);
    		}
			routeOrderVO.getRouteOrder().setAmount(total);
			routeOrderVO.getRouteOrder().setPrepay(prepaytotal);
    }
    
    
    
    
    
    /**
     * 跳转填写同行人信息页面
     * @param response
     * @param request
     * @return ModelAndView
     */
    @RequestMapping(value = "/personal/peerInfo")
    public ModelAndView peerInfo(HttpServletResponse response, HttpServletRequest request,String orderNo) {
    	//用户常用联系人
    	ModelAndView mav = new ModelAndView("/personal/peerInfo");
    	Map<String,Object> param = new HashMap<>(1);
    	param.put("userId", getAdminId(request));
    	List<Map<String, Object>>  rows = customerService.getAllListMap(param);
    	
    	// 订单信息
    	Map<String,Object> param_ = new HashMap<>();
    	param_.put("cusNo", getAdminId(request));
    	param_.put("orderNo", orderNo);
		List<Map<String,Object>> rows_ = routeOrderService.getMyorder(param_);
		
		//订单联系人
        List<Map<String,Object>> orderCusInfoList = productOrderService.getOrderCusInfo(orderNo);
        
        int babyCount = bookCusInfoService.getBabyCount(orderNo);
        int childCount = bookCusInfoService.getChildCount(orderNo);
        int adultCount  =bookCusInfoService.getAdultCount(orderNo);
		
        mav.addObject("orderCusInfoList",orderCusInfoList);
        mav.addObject("rowsStr",JSON.toJSONString(rows));
    	mav.addObject("order", rows_.get(0));
    	mav.addObject("rows", rows);
    	mav.addObject("babyCount", babyCount);
    	mav.addObject("childCount", childCount);
    	mav.addObject("adultCount", adultCount);
        return mav;
    }
    
    /**
     * 同行人信息
     * @param response
     * @param request
     * @return ModelAndView
     */
    @RequestMapping(value = "/personal/cusAgeInfo")
    public void cusAgeInfo(HttpServletResponse response, HttpServletRequest request,String orderNo) {
    	try {
    		int babyCount = bookCusInfoService.getBabyCount(orderNo);
            int childCount = bookCusInfoService.getChildCount(orderNo);
            int adultCount  =bookCusInfoService.getAdultCount(orderNo);
            Map<String,Object> map = new HashMap<>();
            map.put("babyCount", babyCount);
            map.put("childCount", childCount);
            map.put("adultCount", adultCount);
            response.getWriter().print(JSON.toJSONString(map, JSONProxy.SYSTEM_FEATURE));
    	} catch (Exception e) {
    		logger.info("cusAgeInfo fail. " + e.toString());
    	}
    }
    
    
    /**
     * 添加同行人
     * @param response
     * @param request
     * @return ModelAndView
     */
    @RequestMapping(value = "/personal/addPeerInfo")
    public void addPeerInfo(HttpServletResponse response, HttpServletRequest request,@ModelAttribute("customerVO") CustomerVO customerVO) {
    	try {
    		Customer customer = new Customer();
    		customer.setId(customerVO.getId());
    		customer.setCustomerName(customerVO.getCustomerName());
    		customer.setRealName(customerVO.getRealName());
    		customer.setBirthday(customerVO.getBirthday());
    		customer.setIsUse(customerVO.getIsUse());
    		customer.setEmail(customerVO.getEmail());
    		customer.setCardNumber(customerVO.getCardNumber());
    		customer.setCardType(customerVO.getCardType());
    		
    		//添加用户联系人
    		if (customer.getId() == 0) {
    			customer.setUserId(getAdminId(request));
    			customer.setCtuser(getAdminId(request) + "");
    			customer.setCtdt(new Date());
    			customerService.insert(customer);
    			customerVO.setId(customer.getId());
    		} else {
    			customer.setUpdt(new Date());
    			customer.setUpuser(getAdminId(request) + "");
    			customer.setUserId(getAdminId(request));
    			customerService.updateObject(customer);
    		}
    		//同行人id
    		if(customerVO.getBookCusId()==0){
    			// 添加到订单同行人
    			BookCusInfo bookCusInfo = new BookCusInfo();
    			bookCusInfo.setCtdt(new Date());
    			bookCusInfo.setCtuser(getAdminId(request)+"");
    			bookCusInfo.setCusNo(customer.getId()+"");
    			bookCusInfo.setOrderNo(customerVO.getOrderNo());
    			bookCusInfo.setType(customerVO.getType());
    			bookCusInfo.setImgPath(customer.getPassportImg());
    			bookCusInfoService.saveBookCusInfo(bookCusInfo);
    			customerVO.setBookCusId(bookCusInfo.getId());
    		}else{
    			//修改同行人
    			BookCusInfo bookCusInfo = new BookCusInfo();
    			bookCusInfo.setId(customerVO.getBookCusId());
    			bookCusInfo.setCusNo(customer.getId()+"");
    			bookCusInfo.setImgPath(customer.getPassportImg());
    			bookCusInfo.setUpdt(new Date());
    			bookCusInfo.setUpuser(getAdminId(request)+"");
    			bookCusInfo.setOrderNo(customerVO.getOrderNo());
    			bookCusInfo.setType(customerVO.getType());
    			bookCusInfoService.updateBookCusInfo(bookCusInfo);
    		}
    		response.getWriter().print(JSON.toJSONString(customerVO, JSONProxy.SYSTEM_FEATURE));
    	} catch (Exception e) {
    		logger.info("addPeerInfo fail. " + e.toString());
    	}
    }
    /**
     * 删除同行人
     * @param response
     * @param request
     * @return ModelAndView
     */
    @RequestMapping(value = "/personal/deletePeerInfo")
    public void deletePeerInfo(HttpServletResponse response, HttpServletRequest request,int cusNo,String orderNo) {
    	try {
    		Map<String,Object> param = new HashMap<>();
    		param.put("cusNo", cusNo);
    		param.put("orderNo", orderNo);
    		bookCusInfoService.deleteBookCusInfoByParams(param);
    	} catch (Exception e) {
    		logger.info("deletePeerInfo fail. " + e.toString());
    	}
    }
    /**
     * 添加订单联系人
     * @param response
     * @param request
     * @return ModelAndView
     */
    @RequestMapping(value = "/personal/addRouteUser")
    public void addRouteUser(HttpServletResponse response, HttpServletRequest request,String orderNo,String routeUsername,String routeTel,String routeEmail) {
		try {
			Map<String,Object> param = new HashMap<>();
    		param.put("orderNo", orderNo);
    		param.put("routeUsername", routeUsername);
    		param.put("routeTel", routeTel);
    		param.put("routeEmail", routeEmail);
    		User user = (User) request.getSession().getAttribute("loginUser");
    		user.setCusEmail(routeEmail);
    		user.setCusName(routeUsername);
    		user.setCusTel(routeTel);
			routeOrderService.updateRouteUser(param);
			userService.modifyUser(user);
			request.getSession().setAttribute("loginUser",user);
		} catch (Exception e) {
			 logger.info("addRouteUser fail. " + e.toString());
		}
    }
    
    
    /**
     * 订单行程单列表
     * @param response
     * @param request
     * @return ModelAndView
     */
    @RequestMapping(value = "/personal/myorderlist")
    public ModelAndView myorderlist(HttpServletResponse response, HttpServletRequest request,String orderNo,String status) {
    	
    	ModelAndView mav = new ModelAndView("/personal/myorder_list");
    	
    	Map<String,Object> param = new HashMap<>();
    	param.put("orderNo", orderNo);
    	RouteOrder routeOrder = routeOrderService.getRouteOrder(param);
    	List<Map<String,Object>> resList = routeOrderService.getMyPayDetailByOrderNo(param);
    	mav.addObject("resList", resList);
    	mav.addObject("status", status);
    	mav.addObject("routeOrder", routeOrder);
        return mav;
    }
    /**
     * 跳转行程单结算页面
     * @param response
     * @param request
     * @return ModelAndView
     */
    @RequestMapping(value = "/personal/mypay")
    public ModelAndView mypay(HttpServletResponse response, HttpServletRequest request,String orderNo) {
    	
    	ModelAndView mav = new ModelAndView("/personal/mypay");
    	
    	Map<String,Object> param = new HashMap<>();
    	param.put("orderNo", orderNo);
    	RouteOrder routeOrder = routeOrderService.getMyPayRouteOrderByOrderNo(param);
    	
    	List<Map<String,Object>> resList = routeOrderService.getMyPayDetailByOrderNo(param);
    	List<Date> dateArrays = CommonUtils.getDateArrays(routeOrder.getStartdate(), routeOrder.getEnddate(), Calendar.DATE);
    	
    	mav.addObject("resList", resList);
    	mav.addObject("routeOrder", routeOrder);
    	mav.addObject("dateArrays", dateArrays);
    	
        return mav;
    }

	/**
	 * 删除订单
	 * 
	 * @param response
	 * @param request
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/personal/deleteOrder")
	public void deleteOrder(HttpServletResponse response,
			HttpServletRequest request, String orderNo) {
		try {
			routeOrderService.deleteRoute(orderNo);
			response.getWriter().print("success");
		} catch (Exception e) {
			if (null != e.getMessage()) {
				System.out.println(e.toString());
			}
			logger.info("deleteOrder fail. " + e.toString());
		}
	}
    
    /**
     * 跳转订单修改删除页面
     * @param response
     * @param request
     * @return ModelAndView
     */
    @RequestMapping(value = "/personal/updateAndDeleteOrder")
    public ModelAndView updateAndDeleteOrder(HttpServletResponse response, HttpServletRequest request,String orderNo) {
        
        Map<String,Object> param = new HashMap<>();
        param.put("orderNo", orderNo);
        RouteOrder routeOrder = routeOrderService.getMyPayRouteOrderByOrderNo(param);
        request.getSession().setAttribute("routeJson", routeOrder.getRouteJson());
        request.getSession().setAttribute("orderNo", routeOrder.getOrderNo());
        
        return new ModelAndView("redirect:/product/product_list.html");
    }
    
    
    
    /**
     * 跳转密码修改页面
     * @param response
     * @param request
     * @return ModelAndView
     */
    @RequestMapping(value = "/personal/editPW")
    public ModelAndView editPW(HttpServletResponse response, HttpServletRequest request) {
    	return new ModelAndView("/personal/editPW");
    }

    
    /**
     * 密码修改
     * @param response
     * @param request
     * @return ModelAndView
     */
    @RequestMapping(value = "/personal/updatePW")
    public void updatePW(String newpw,HttpServletResponse response, HttpServletRequest request,String oldpw) {
    	try {
    		String newMD5password = CommonUtils.covertpw(newpw);
    		HttpSession session= request.getSession(true);
    		User user = new User();
    		if(session.getAttribute("loginUser") != null){
    			user = (User)session.getAttribute("loginUser");
    			if(oldpw ==null || !user.getPassword().equals(CommonUtils.covertpw(oldpw))){
    				response.getWriter().print("原密码不正确，请重新再试！"); 
    			}else{
    				user.setPassword(newMD5password);
    				int bakInt = userService.updatePW(user);
    				if(bakInt ==1){
    					response.getWriter().print("操作成功！");    			    				
    				}else{
    					response.getWriter().print("操作失败！");    			    				
    				}	
    			}	
    		}else{
    			response.getWriter().print("操作失败！");    			
    		}
		} catch (IOException e) {
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
	        logger.info("updatePW fail. " + e.toString());
		}
    }
    
    @RequestMapping(value = "/personal/updatePW2")
    public void updatePW2(String newpw,HttpServletResponse response, HttpServletRequest request,String username) {
    	try {
    		String newMD5password = CommonUtils.covertpw(newpw);
    		User user = new User();
			user.setPassword(newMD5password);
			user.setUsername(username);
			int bakInt = userService.updatePW2(user);
			if(bakInt ==1){
				response.getWriter().print("操作成功！");    			    				
			}else{
				response.getWriter().print("操作失败！");    			    				
			}	

		} catch (IOException e) {
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
	        logger.info("updatePW fail. " + e.toString());
		}
    }
}
