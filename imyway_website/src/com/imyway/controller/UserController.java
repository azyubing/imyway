package com.imyway.controller;

import java.io.IOException;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.imyway.common.utils.CommonUtils;
import com.imyway.common.utils.JSONProxy;
import com.imyway.common.utils.WeiChatUtil;
import com.imyway.common.utils.mail.MailSender;
import com.imyway.model.User;
import com.imyway.services.IUserService;

@Controller
public class UserController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private IUserService userService;
	
	 /**
     * 微信登录callback
     * @param response
     * @param request
     * @return ModelAndView
     */
    @RequestMapping(value = "/wchatlogin")
    public ModelAndView wchatlogin(HttpServletResponse response, HttpServletRequest request,String code,String state,String nextUrl) {
    	
    	if(StringUtils.isEmpty(code)){
    		return new ModelAndView("redirect:login.html");
    	}
    	
    	WeiChatUtil wchat = new WeiChatUtil();
    	//wei_appid=wxa4a9620e264e143f
    	//wei_appsecret=d4624c36b6795d1d99dcf0547af5443d
    	Map<String,Object> seMap = wchat.getOauth2Info(CommonUtils.getInterfaceConfigBykey("wei_appid"), CommonUtils.getInterfaceConfigBykey("wei_appsecret"), code);
    	
    	if(seMap.get("access_token") == null || seMap.get("openid") == null){
    		return new ModelAndView("redirect:login.html");
    	}
    	
    	String openid = (String)seMap.get("openid");
    	
    	request.getSession().removeAttribute("loginUser");
    	//String openid = "oTrrpwnC5qmkYsjiJOGGo7-WpP4s";
    	// 如果以用微信登陆过，则直接用openid登录
    	User user = userService.weixinLogin(openid);
    	if(user != null){
    		if(StringUtils.isEmpty(user.getTel())){
    			
    			request.setAttribute("weiid", openid);
    			request.setAttribute("nextUrl", nextUrl);
    			return new ModelAndView("inputTel");
    		}
    		user.setUsername(user.getWeiname());
    		request.getSession().setAttribute("loginUser", user);
    		if(StringUtils.isNotEmpty(nextUrl)){
    			return new ModelAndView("redirect:"+nextUrl);
    		}
    		
    		return new ModelAndView("redirect:home.html");
    	}
    	
    	
    	//如果没有登陆过，获取微信接口用户信息
    	Map<String,Object> userMap = wchat.getUserInfo((String)seMap.get("access_token"), openid);
    	
    	user = new User();
    	user.setUsername(openid);
    	user.setPassword(CommonUtils.covertpw(UUID.randomUUID().toString()));//设定默认密码
    	user.setStatus(0);
    	user.setOpenid(openid);
    	user.setUnionid((String)userMap.get("unionid"));
    	user.setPhoto(wchat.saveToFile((String)userMap.get("headimgurl")));
    	user.setWeiname((String)userMap.get("nickname"));
    	
    	userService.saveUser(user);
    	
    	user = userService.weixinLogin(openid);
    	user.setUsername(user.getWeiname());
    	
    	if(StringUtils.isNotEmpty(nextUrl)){
    		request.setAttribute("nextUrl", nextUrl);
    	}
    	request.setAttribute("weiid", openid);
        return new ModelAndView("inputTel");
    }
    
    /**
     * 修改用户
     * @param response
     * @param request
     * @param user
     * @throws IOException 
     */
    @RequestMapping(value = "/setphone")
    public void setphone(HttpServletResponse response, HttpServletRequest request,String phone,String vcode,String weiid) throws IOException{
    	
    	String msg = null;
    	try {
    		if(StringUtils.isEmpty(phone)){
    			msg = "请填写手机号码！";
    			response.getWriter().print(msg);
    			return;
    		}
    		
    		if(StringUtils.isEmpty(weiid)){
    			msg = "系统繁忙,请稍后再试！";
    			response.getWriter().print(msg);
    			return;
    		}
    		
    		
    		User user = userService.weixinLogin(weiid);
    		
    		if(user == null){
    			msg = "系统繁忙,请稍后再试！";
    			response.getWriter().print(msg);
    			return;
    		}
    		
    		if(StringUtils.isEmpty(vcode)){
    			msg = "请获取并填写手机验证码！";
    			response.getWriter().print(msg);
    			return;
    		}
    		
    		long currentTimeMillis = (long) request.getSession().getAttribute("currentTimeMillis");
    		long now = System.currentTimeMillis();
    		if((currentTimeMillis+60*1000)<=now){
				msg =  "验证码已过期，请重新获得验证码";
				response.getWriter().print(msg);
    			return;
    		}
    		
    		
    		
    	    if(!vcode.equals((String) request.getSession().getAttribute("checkCode"))){
    			msg = "手机验证码不正确，请输入正确的验证码！";
    			response.getWriter().print(msg);
    			return;
    		}

    		user.setTel(phone);
    		user.setUpdt(new Date());
    		userService.modifyUser(user);
    		user = userService.getUserById(user.getId());
    		user.setUsername(user.getWeiname());
    		request.getSession().removeAttribute("loginUser");
    		request.getSession().setAttribute("loginUser", user);
    		msg = "";
		} catch (IOException e) {
			e.printStackTrace();
			logger.info("personal/updateUser fail. " + e.toString());
			msg = "系统繁忙，请稍后再试！";
		}
    	response.getWriter().print(msg);
    }
    
    
    
	/**
     * 注册
     * 
     * @param response
     * @param request
     * @return
	 * @throws IOException 
     */
    @RequestMapping(value = "/user/register")
    public void register(HttpServletResponse response, HttpServletRequest request,@ModelAttribute("user") User user,String checkCode) throws IOException {
    	Map<String,String> msg = new HashMap<String,String>();
    	msg.put("code", "success");
        try {
        	
        	//验证存在
        	if(!userService.userNameExit(user.getUsername().trim())){
        		msg.put("code", "error");
        		msg.put("errortype", "usernamedup");
        		msg.put("msg", "用户名已存在，请更换用户名");
        	}
        	
        	if(!StringUtils.isEmpty(user.getTel()) && !userService.telExit(user.getTel().trim())){
        		msg.put("code", "error");
        		msg.put("errortype", "teldup");
        		msg.put("msg", "该手机号以被注册，请更换手机号");
        	}
        	
        	if(!StringUtils.isEmpty(user.getEmail()) && !userService.emailExit(user.getEmail())){
        		msg.put("code", "error");
        		msg.put("errortype", "emaildup");
        		msg.put("msg", "该邮箱已被注册，请更换邮箱");
        	}
        	
        	if(!"success".equals(msg.get("code"))){
        		response.getWriter().print(JSON.toJSONString(msg, JSONProxy.SYSTEM_FEATURE));
        		return;
        	}
        	
        	
        	if(!user.getEmail().isEmpty()){
        		String md5password = CommonUtils.covertpw(user.getPassword());
    			user.setPassword(md5password);
    			user.setCtdt(new Date());
    			user.setActivecode(UUID.randomUUID().toString());

    			//发送验证邮箱邮件
    			String path = request.getContextPath();  
    			String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
    			String url = basePath+"user/activateUser.html?username="+user.getUsername()+"&code="+user.getActivecode();
    			MailSender.send_regist_mail(user.getUsername(), url,user.getEmail());
    			userService.saveUser(user);
    			//response.getWriter().print("success");
        	}else{
        		String code = (String) request.getSession().getAttribute("checkCode");
        		long currentTimeMillis = (long) request.getSession().getAttribute("currentTimeMillis");
        		long now = System.currentTimeMillis();
        		if((currentTimeMillis+60*1000)>now){
        			if(code.equalsIgnoreCase(checkCode)){
        				String md5password = CommonUtils.covertpw(user.getPassword());
        				user.setPassword(md5password);
        				user.setCtdt(new Date());
        				userService.saveUser(user);
        				Map<String, Object> resMap = new HashMap<String, Object>();
        	    		resMap.put("username", user.getUsername());
        	    		resMap.put("password", md5password);
        	    		user = userService.login(resMap);
        	    		request.getSession().setAttribute("loginUser", user);
        			}else{
        				msg.put("code", "error");
        				msg.put("errortype", "codeerr");
        				msg.put("msg", "验证码错误");
        				//response.getWriter().print("验证码错误");
        			}
        		}else{
        			msg.put("code", "error");
    				msg.put("errortype", "codeexp");
    				msg.put("msg", "验证码已过期，请重新获得验证码");
        			//response.getWriter().print("验证码过期");
        		}
        	}
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("register fail. " + e.toString());
            msg.put("code", "error");
    		msg.put("errortype", "syserr");
    		msg.put("msg", "系统繁忙，请稍后重试");
        }
        response.getWriter().print(JSON.toJSONString(msg, JSONProxy.SYSTEM_FEATURE));
    }
    
    /**
     * 登入
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/user/login")
    public void login(HttpServletResponse response, HttpServletRequest request,String username,String password) {
    	try {
    		Map<String, Object> resMap = new HashMap<String, Object>();
    		resMap.put("username", username);
    		resMap.put("password", CommonUtils.covertpw(password));
    		User user = userService.login(resMap);
    		if(user==null){
    			response.getWriter().print("用户不存在或用户名密码错误");
    		}else if(user.getStatus()==0){
    			request.getSession().setAttribute("loginUser", user);
    		}else if(user.getStatus()==2){
    			response.getWriter().print("请先激活该用户");
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    		if (null != e.getMessage()) {
    			System.out.println(e.toString());
    		}
    		logger.info("userNameExit fail. " + e.toString());
    	}
    }
    
    /**
     * 注销
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/loginOut")
    public ModelAndView loginOut(HttpServletResponse response, HttpServletRequest request) {
    	try {
			Enumeration em = request.getSession().getAttributeNames();
			while (em.hasMoreElements()) {
				request.getSession().removeAttribute(em.nextElement().toString());
			}
		} catch (Exception e) {
			if (null != e.getMessage()) {
				System.out.println(e.toString());
			}
			logger.info("login fail. " + e.toString());
		}
		return new ModelAndView("redirect:/tologin.html");
    }
    
    
    
    /**
     * 激活
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/user/activateUser")
    public ModelAndView activateUser(HttpServletResponse response, HttpServletRequest request,String username,String code) {
        try {
        	Map<String, Object> resMap = new HashMap<String, Object>();
    		resMap.put("username", username);
    		resMap.put("activecode", code);
    		boolean bool = userService.activateUser(resMap);
    		response.setHeader("Content-type", "text/html;charset=UTF-8"); 
    		response.setCharacterEncoding("UTF-8"); 
    		String path = request.getContextPath();  
			String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
			String url = basePath+"tologin.html";
			String vrifysts = "ok";
    		if(!bool){
    			url = basePath+"toregister.html";
    			vrifysts = "ng";
    		}
			request.setAttribute("gourl", url);
			request.setAttribute("vrifysts", vrifysts);
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("register fail. " + e.toString());
        }
        return new ModelAndView("verifymail");
    }
    
    
    /**
     * 验证用户名是否唯一
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/user/userNameExit")
    public void userNameExit(HttpServletResponse response, HttpServletRequest request,String username) {
    	try {
    		boolean bool =userService.userNameExit(username);
    		response.getWriter().print(bool+"");
    	} catch (Exception e) {
    		e.printStackTrace();
    		if (null != e.getMessage()) {
    			System.out.println(e.toString());
    		}
    		logger.info("userNameExit fail. " + e.toString());
    	}
    }
    /**
     * 验证手机是否唯一
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/user/telExit")
    public void telExit(HttpServletResponse response, HttpServletRequest request,String tel) {
    	try {
    		boolean bool =userService.telExit(tel);
    		response.getWriter().print(bool+"");
    	} catch (Exception e) {
    		e.printStackTrace();
    		if (null != e.getMessage()) {
    			System.out.println(e.toString());
    		}
    		logger.info("telExit fail. " + e.toString());
    	}
    }
    /**
     * 验证邮箱是否唯一
     * 
     * @param response
     * @param request
     * @return
     */
    @RequestMapping(value = "/user/emailExit")
    public void emailExit(HttpServletResponse response, HttpServletRequest request,String email) {
        try {
			boolean bool =userService.emailExit(email);
			response.getWriter().print(bool+"");
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("emailExit fail. " + e.toString());
        }
    }
    
}
