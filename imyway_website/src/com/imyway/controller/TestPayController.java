package com.imyway.controller;

import java.io.BufferedReader;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.imyway.common.utils.CommonUtils;
import com.imyway.common.utils.JSONProxy;
import com.imyway.model.RouteOrder;
import com.imyway.services.IRouteOrderService;
import com.pingplusplus.Pingpp;
import com.pingplusplus.exception.ChannelException;
import com.pingplusplus.exception.PingppException;
import com.pingplusplus.model.Charge;
import com.pingplusplus.model.Event;
import com.pingplusplus.model.Webhooks;



/**
 * 
 * @author GM
 * 
 */
@Controller
public class TestPayController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(TestPayController.class);
    @Autowired
	private IRouteOrderService routeOrderService;
    
    @RequestMapping(value = "/testpay")
    public ModelAndView testpay(HttpServletResponse response, HttpServletRequest request) {
        try {

        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("login fail. " + e.toString());
        }
        return new ModelAndView("testpay");
    }
    
    /**
     * ping++ 支付后回调
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/paynotify")
    public void paynotify(HttpServletResponse response, HttpServletRequest request,@RequestBody String code) {
        try {
        	request.setCharacterEncoding("UTF8");
            //获取头部所有信息
            Enumeration headerNames = request.getHeaderNames();
            while (headerNames.hasMoreElements()) {
                String key = (String) headerNames.nextElement();
                String value = request.getHeader(key);
                System.out.println(key+" "+value);
            }
            // 获得 http body 内容
            BufferedReader reader = request.getReader();
            StringBuffer buffer = new StringBuffer();
            String string;
            while ((string = reader.readLine()) != null) {
                buffer.append(string);
            }
            reader.close();
            
            
            // 解析异步通知数据
            Event event = Webhooks.eventParse(buffer.toString());
            logger.info(buffer.toString());
            logger.info("callback ping++:"+event.getType()+":"+event.getId());
            if ("charge.succeeded".equals(event.getType())) {
            	String ping_orderid = event.getId();
            	Map<String,Object> param = new HashMap<String, Object>();
            	param.put("ping_orderid", ping_orderid);
            	routeOrderService.updateRoutePaySuccess(param);
                response.setStatus(200);
            } else if ("refund.succeeded".equals(event.getType())) {
            	String ping_orderid = event.getId();
            	Map<String,Object> param = new HashMap<String, Object>();
            	param.put("ping_orderid", ping_orderid);
            	routeOrderService.updateRouteRefundSuccess(param);
                response.setStatus(200);
            } else {
                response.setStatus(500);
            }
        	
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("login fail. " + e.toString());
        }
    }
    
    /**
     * 请求支付
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/requestpay")
    public void requestpay(HttpServletResponse response, HttpServletRequest request,@RequestBody String code) {
        try {
        	
        	JSONObject jsonObject = JSONObject.parseObject(code);  
        	String channel = (String)jsonObject.get("channel");
        	String amountstr = (String)jsonObject.get("amount");
            String orderNo = (String)jsonObject.get("orderNo");
        	
            Map<String,Object> param = new HashMap<>();
        	param.put("orderNo", orderNo);
        	RouteOrder routeOrder = routeOrderService.getMyPayRouteOrderByOrderNo(param);
            Long amountDecimal = new Double(routeOrder.getAmount() * 100).longValue();
        	String amountDecimalStr = amountDecimal.toString() ;
            if(amountDecimalStr.equals(amountstr)){
            	Pingpp.apiKey = CommonUtils.getInterfaceConfigBykey("pingpp_apikey");
            	Charge charge = null;
                Map<String, Object> chargeMap = new HashMap<String, Object>();
                chargeMap.put("amount", Long.parseLong(amountstr));
                chargeMap.put("currency", "cny");
                chargeMap.put("subject", routeOrder.getOrderNm());
                DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd"); 
                String body = "行程日期："+fmt.format(routeOrder.getStartdate())+"~"+fmt.format(routeOrder.getEnddate());
                chargeMap.put("body", body);
                chargeMap.put("order_no", orderNo);
                chargeMap.put("channel", channel);
                chargeMap.put("client_ip", "127.0.0.1");
                Map<String, String> app = new HashMap<String, String>();
                app.put("id",CommonUtils.getInterfaceConfigBykey("pingpp_appid"));
                chargeMap.put("app", app);
                
                if("alipay_pc_direct".equals(channel)){
                	Map<String,String> extraMap = new HashMap<String, String>();
                	extraMap.put("success_url", CommonUtils.getInterfaceConfigBykey("pingpp_success_url")+orderNo);
                	chargeMap.put("extra", extraMap);
                }else if("wx_pub_qr".equals(channel)){
                	Map<String,String> extraMap = new HashMap<String, String>();
                	extraMap.put("product_id", orderNo); 
                	//extraMap.put("notify_url", CommonUtils.getInterfaceConfigBykey("pingpp_success_url"));
                	chargeMap.put("extra", extraMap);
                }
                try {
                    //发起交易请求
                    charge = Charge.create(chargeMap);
                    logger.info(charge.toString());
                    
                    //保存ping++ 生成的支付单号
                    Map<String,Object> param2 = new HashMap<String, Object>();
                	param2.put("ping_orderid", charge.getId());
                	param2.put("orderno", orderNo);
                	
                    routeOrderService.updateRouteStartPay(param2);
                    if("wx_pub_qr".equals(channel)){
                    	Map<String,Object> qr = charge.getCredential();
                    	qr.put("id", charge.getId());
                    	response.getWriter().print(JSON.toJSONString(qr, JSONProxy.SYSTEM_FEATURE));
                    	return;
                    }
                    
                    
                    response.getWriter().print(charge.toString());
                } catch (ChannelException e){
                	if(e.getMessage().indexOf("charge_order_no_used") != -1){
                		response.getWriter().print("charge_order_no_used");
                	}
                 
                }catch (PingppException e) {
                    e.printStackTrace();
                }
            }else{
            	response.getWriter().print("error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("login fail. " + e.toString());
        }
    }
    
    /**
     * 生成二维码图片并直接以流的形式输出到页面
     * @param code_url
     * @param response
     */
    @RequestMapping("qr_code")
    @ResponseBody
    public void getQRCode(HttpServletResponse response, HttpServletRequest request, String code_url){
    	CommonUtils.encodeQrcode(code_url, response);
    }
    
    /**
     * 请求支付
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/checkpay")
    public void checkpay(HttpServletResponse response, HttpServletRequest request,String id) {
        try {
            
        	Pingpp.apiKey = CommonUtils.getInterfaceConfigBykey("pingpp_apikey");

        	Charge charge = Charge.retrieve(id);
        	
        	if(charge.getPaid()){
        		String ping_orderid = charge.getId();
            	Map<String,Object> param = new HashMap<String, Object>();
            	param.put("ping_orderid", ping_orderid);
            	routeOrderService.updateRoutePaySuccess(param);
        	}
        	
        	response.getWriter().print(charge.getPaid()?"true":"false");
        	 
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("login fail. " + e.toString());
        }
    }
    
    /**
     * 支付成功页面
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/paystatus")
    public ModelAndView paysuccess(HttpServletResponse response, HttpServletRequest request,String id) {
        try {
        	Map<String,Object> param1 = new HashMap<>();
        	param1.put("orderNo", id);
        	RouteOrder routeOrder = routeOrderService.getRouteOrder(param1);

        	request.setAttribute("orderNo", id);
        	request.setAttribute("amount", routeOrder.getAmount());
        	request.setAttribute("paysts", "ok");
        	
        	if("2".equals(routeOrder.getStatus())){
        		 return new ModelAndView("/personal/paysuccess");
        	}
        	
        	Pingpp.apiKey = CommonUtils.getInterfaceConfigBykey("pingpp_apikey");
        	
        	if(StringUtils.isEmpty(routeOrder.getPingOrderNo())){
        		throw new Exception("success but no ping_orderno");
        	}

        	Charge charge = Charge.retrieve(routeOrder.getPingOrderNo());
        	
        	if(charge.getPaid()){
        		String ping_orderid = charge.getId();
            	Map<String,Object> param = new HashMap<String, Object>();
            	param.put("ping_orderid", ping_orderid);
            	routeOrderService.updateRoutePaySuccess(param);
        	}else{
        		Map<String,Object> param = new HashMap<String, Object>();
            	param.put("ping_orderid", charge.getId());
            	routeOrderService.updateRoutePaying(param);
        		request.setAttribute("paysts", "ng");
        	}
        	
        	return new ModelAndView("/personal/paysuccess");
        	
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("paysuccess fail. " + e.toString());
        }
        return new ModelAndView("/personal/paysuccess");
    }
  
}
