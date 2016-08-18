package com.imyway.mobile.controller;

import java.io.IOException;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.fastjson.JSON;
import com.imyway.common.utils.CommonUtils;
import com.imyway.common.utils.JSONProxy;
import com.imyway.mobile.constants.Constants;
import com.imyway.mobile.utils.DBUtils;
import com.imyway.mobile.utils.Utils;
import com.imyway.model.Collection;
import com.imyway.model.User;
import com.imyway.services.ICollectionService;
import com.imyway.services.IRouteOrderService;
import com.imyway.services.IUserService;

@Controller
public class CustomerController {
	private static final Logger logger = LoggerFactory.getLogger(CustomerController.class);

	@Autowired
	private IUserService userService;

	@Autowired
	private IRouteOrderService routeOrderService;

	@Autowired
	private ICollectionService collectionService;

	/**
	 * login for username and mobile number
	 * 
	 * @param response
	 * @param request
	 * @param loginName
	 * @param pw
	 * @param validateCode
	 */
	@RequestMapping(value = "/mobile/login", method = RequestMethod.POST)
	public void login(HttpServletRequest request, HttpServletResponse response, String loginName, String password) {
		try {
			if (loginName != null && !loginName.equals("")) {
				Map<String, Object> resMap = new HashMap<String, Object>();
				resMap.put("username", loginName);
				resMap.put("password", CommonUtils.covertpw(password));
				User user = userService.login(resMap);
				response.addHeader("Access-Control-Allow-Origin", "*");
				if (user == null) {
					response.getWriter()
							.print(Utils.getReturnedData(Constants.FAILED, null, Constants.userNotExistOrWrongPwd));
				} else if (user.getStatus() == 0) {
					request.getSession().setAttribute(Constants.USER, user);
					response.getWriter().print(Utils.getReturnedData(Constants.SUCCESS, user, Constants.loginSuccess));
				} else if (user.getStatus() == 2) {
					response.getWriter().print(Utils.getReturnedData(Constants.FAILED, null, Constants.activateUser));
				}
			}
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
	}

	@RequestMapping(value = "/mobile/username", method = RequestMethod.POST)
	public void updateUserName(HttpServletRequest request, HttpServletResponse response, String loginName,
			String password, String validateCode) {
		response.addHeader("Access-Control-Allow-Origin", "*");
		User user = Utils.getUserInstance(request);
		try {
			if (loginName != null && !loginName.equals("")) {
				user.setUsername(loginName);
				userService.modifyUser(user);
				response.getWriter().print(Utils.getReturnedData(Constants.SUCCESS, user, Constants.updateSuccess));
			}
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (Exception e) {
			try {
				logger.error(e.getMessage(), e);
				response.getWriter().print(Utils.getReturnedData(Constants.FAILED, user, Constants.updateFailed));
			} catch (IOException e1) {
				logger.error(e.getMessage(), e);
			}
		}
	}

	@RequestMapping(value = "/mobile/cellPhoneNumber", method = RequestMethod.POST)
	public void updateCellPhoneNumber(HttpServletRequest request, HttpServletResponse response, String cellPhoneNumber,
			String validateCode) {
		User user = Utils.getUserInstance(request);
		try {
			if (cellPhoneNumber != null && !cellPhoneNumber.equals("")) {
				user.setCusTel(cellPhoneNumber);
				userService.modifyUser(user);
				response.addHeader("Access-Control-Allow-Origin", "*");
				response.getWriter().print(Utils.getReturnedData(Constants.SUCCESS, user, Constants.updateSuccess));
			} else {
				response.getWriter().print(Utils.getReturnedData(Constants.FAILED, user, Constants.ErrorPhoneNumber));
			}
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (Exception e) {
			try {
				logger.error(e.getMessage(), e);
				response.getWriter().print(Utils.getReturnedData(Constants.FAILED, user, Constants.updateFailed));
			} catch (IOException e1) {
				logger.error(e.getMessage(), e);
			}
		}
	}

	@RequestMapping(value = "/mobile/password", method = RequestMethod.POST)
	public void updatePassword(HttpServletRequest request, HttpServletResponse response, String password) {
		User user = Utils.getUserInstance(request);
		try {
			if (password != null && !password.equals("")) {
				user.setPassword(CommonUtils.covertpw(password));
				userService.modifyUser(user);
				response.addHeader("Access-Control-Allow-Origin", "*");
				response.getWriter().print(Utils.getReturnedData(Constants.SUCCESS, user, Constants.updateSuccess));
			} else {
				response.getWriter().print(Utils.getReturnedData(Constants.FAILED, user, Constants.ErrorPassword));
			}
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (Exception e) {
			try {
				logger.error(e.getMessage(), e);
				response.getWriter().print(Utils.getReturnedData(Constants.FAILED, user, Constants.updateFailed));
			} catch (IOException e1) {
				logger.error(e.getMessage(), e);
			}
		}
	}

	@RequestMapping(value = "/mobile/photo", method = RequestMethod.POST)
	public void updatePhoto(HttpServletRequest request, HttpServletResponse response, String photoUrl) {
		User user = Utils.getUserInstance(request);
		try {
			if (photoUrl != null && !photoUrl.equals("")) {
				user.setPhoto(photoUrl);
				userService.modifyUser(user);
				response.addHeader("Access-Control-Allow-Origin", "*");
				response.getWriter().print(Utils.getReturnedData(Constants.SUCCESS, user, Constants.updateSuccess));
			} else {
				response.getWriter().print(Utils.getReturnedData(Constants.FAILED, user, Constants.ErrorPhoto));
			}
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (Exception e) {
			try {
				logger.error(e.getMessage(), e);
				response.getWriter().print(Utils.getReturnedData(Constants.FAILED, user, Constants.updateFailed));
			} catch (IOException e1) {
				logger.error(e.getMessage(), e);
			}
		}
	}

	/**
	 * logout, now not be used
	 * 
	 * @param request
	 * @param response
	 * @param loginName
	 */
	@RequestMapping(value = "/mobile/logout")
	public void logout(HttpServletRequest request, HttpServletResponse response, String loginName) {
		try {
			if (loginName != null && !loginName.equals("")) {
				User user = Utils.getUserInstance(request);
				response.addHeader("Access-Control-Allow-Origin", "*");
				if (user.getCusName().equalsIgnoreCase(loginName)) {
					request.getSession().setAttribute(Constants.USER, null);
					response.getWriter().print("successfully logout!");
				} else {
					response.getWriter().print("please confirm you logged in!");
				}
			}
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
	}

	@RequestMapping(value = "/mobile/register")
	public void register(HttpServletResponse response, HttpServletRequest request, @ModelAttribute("user") User user,
			String checkCode) {
		Map<String, String> msg = new HashMap<String, String>();
		msg.put("code", "success");
		try {
			// 验证存在
			if (!userService.userNameExit(user.getUsername().trim())) {
				msg.put("code", "error");
				msg.put("errortype", "usernamedup");
				msg.put("msg", "用户名已存在，请更换用户名");
			}

			if (!StringUtils.isEmpty(user.getTel()) && !userService.telExit(user.getTel().trim())) {
				msg.put("code", "error");
				msg.put("errortype", "teldup");
				msg.put("msg", "该手机号以被注册，请更换手机号");
			}

			// if(!StringUtils.isEmpty(user.getEmail()) &&
			// !userService.emailExit(user.getEmail())){
			// msg.put("code", "error");
			// msg.put("errortype", "emaildup");
			// msg.put("msg", "该邮箱已被注册，请更换邮箱");
			// }

			if (!"success".equals(msg.get("code"))) {
				response.getWriter().print(JSON.toJSONString(msg, JSONProxy.SYSTEM_FEATURE));
				return;
			}
			String code = (String) request.getSession().getAttribute("checkCode");
			long currentTimeMillis = (long) request.getSession().getAttribute("currentTimeMillis");
			long now = System.currentTimeMillis();
			if ((currentTimeMillis + 60 * 1000) > now) {
				if (code.equalsIgnoreCase(checkCode)) {
					String md5password = CommonUtils.covertpw(user.getPassword());
					user.setPassword(md5password);
					user.setCtdt(new Date());
					userService.saveUser(user);
					Map<String, Object> resMap = new HashMap<String, Object>();
					resMap.put("username", user.getUsername());
					resMap.put("password", md5password);
					user = userService.login(resMap);
					request.getSession().setAttribute("loginUser", user);
				} else {
					msg.put("code", "error");
					msg.put("errortype", "codeerr");
					msg.put("msg", "验证码错误");
					// response.getWriter().print("验证码错误");
				}
			} else {
				msg.put("code", "error");
				msg.put("errortype", "codeexp");
				msg.put("msg", "验证码已过期，请重新获得验证码");
			}
			response.addHeader("Access-Control-Allow-Origin", "*");
			response.getWriter().print(JSON.toJSONString(msg, JSONProxy.SYSTEM_FEATURE));

			// if(!user.getEmail().isEmpty()){
			// String md5password = CommonUtils.covertpw(user.getPassword());
			// user.setPassword(md5password);
			// user.setCtdt(new Date());
			// user.setActivecode(UUID.randomUUID().toString());
			//
			// //发送验证邮箱邮件
			// String path = request.getContextPath();
			// String basePath =
			// request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
			// String url =
			// basePath+"user/activateUser.html?username="+user.getUsername()+"&code="+user.getActivecode();
			// MailSender.send_regist_mail(user.getUsername(),
			// url,user.getEmail());
			// userService.saveUser(user);
			// //response.getWriter().print("success");
			// }else{
			// String code = (String)
			// request.getSession().getAttribute("checkCode");
			// long currentTimeMillis = (long)
			// request.getSession().getAttribute("currentTimeMillis");
			// long now = System.currentTimeMillis();
			// if((currentTimeMillis+60*1000)>now){
			// if(code.equalsIgnoreCase(checkCode)){
			// String md5password = CommonUtils.covertpw(user.getPassword());
			// user.setPassword(md5password);
			// user.setCtdt(new Date());
			// userService.saveUser(user);
			// Map<String, Object> resMap = new HashMap<String, Object>();
			// resMap.put("username", user.getUsername());
			// resMap.put("password", md5password);
			// user = userService.login(resMap);
			// request.getSession().setAttribute("loginUser", user);
			// }else{
			// msg.put("code", "error");
			// msg.put("errortype", "codeerr");
			// msg.put("msg", "验证码错误");
			// //response.getWriter().print("验证码错误");
			// }
			// }else{
			// msg.put("code", "error");
			// msg.put("errortype", "codeexp");
			// msg.put("msg", "验证码已过期，请重新获得验证码");
			// //response.getWriter().print("验证码过期");
			// }
			// }
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			msg.put("code", "error");
			msg.put("errortype", "syserr");
			msg.put("msg", "系统繁忙，请稍后重试");
			try {
				response.getWriter().print(JSON.toJSONString(msg, JSONProxy.SYSTEM_FEATURE));
			} catch (IOException e1) {
				// the exception can be ignored
			}
		}
	}

	/**
	 * 我的收藏
	 * 
	 * @param request
	 * @param response
	 * @param ptype
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping(value = "mobile/myfavorites", method = RequestMethod.GET)
	public void getMyFavorites(HttpServletRequest request, HttpServletResponse response, String ptype,
			String destination, String orderby, int page, int pageSize) {
		response.addHeader("Access-Control-Allow-Origin", "*");
		try {
			User user = Utils.getUserInstance(request);
			Map<String, Object> param = new HashMap<>();
			if (null == user) {
				response.getWriter().print(Utils.getReturnedData(Constants.FAILED, null, Constants.ErrorUser));
				return;
			} else {
				param.put("userId", user.getId());
			}
			if (null != ptype && !"".equals(ptype)) {
				param.put("ptype", ptype);
			}
			param.put("offset", DBUtils.page(page, pageSize));
			param.put("limit", DBUtils.pageSize(page, pageSize));
			List<Map<String, Object>> myfavorites = collectionService.selectCollectionProductListByParam(param);
			int total = collectionService.getCount(param);
			Map<String, Object> ret = new HashMap<String, Object>();
			ret.put("total", total);
			ret.put("list", myfavorites);
			response.getWriter().print(Utils.getReturnedData(Constants.SUCCESS, ret, null));
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
	}

	/**
	 * 添加到收藏夹， 如果是套餐和娱乐，只传pid 如果是酒店，pid和staylvl=3 如果是交通，pid，startplace和endplace 如果是别墅，pid和roomcnt=5
	 * 
	 * @param request
	 * @param response
	 * @param pid
	 * @param staylvl
	 *            3
	 * @param startplace
	 * @param endplace
	 * @param roomcnt
	 *            5
	 */
	@RequestMapping(value = "mobile/myfavorites", method = RequestMethod.POST)
	public void addToMyFavorites(HttpServletRequest request, HttpServletResponse response, String pid, String staylvl,
			String startplace, String endplace, String roomcnt) {
		response.addHeader("Access-Control-Allow-Origin", "*");
		try {
			User user = Utils.getUserInstance(request);
			if (null == user) {
				response.getWriter().print(Utils.getReturnedData(Constants.FAILED, null, Constants.ErrorUser));
				return;
			}
			Collection favorite = new Collection();
			if (null != pid && !"".equals(pid)) {
				favorite.setPid(pid);
			}
			if (null != staylvl && !"".equals(staylvl)) {
				favorite.setStaylvl(3);
			}
			if (null != startplace && !"".equals(startplace)) {
				favorite.setStartplace(startplace);
			}
			if (null != endplace && !"".equals(endplace)) {
				favorite.setEndplace(endplace);
			}
			if (null != roomcnt && !"".equals(roomcnt)) {
				favorite.setRoomcnt(5);
			}
			favorite.setUserId(user.getId());
			favorite.setCtuser(user.getUsername());
			favorite.setCtdt(new Date());

			int isPid = collectionService.selectByPid(favorite);
			String resString = null;
			if (isPid > 0) {
				resString = "您已收藏过此产品";
				response.getWriter().print(Utils.getReturnedData(Constants.SUCCESS, null, resString));
				return;
			} else {
				if (collectionService.insert(favorite)) {
					resString = "保存成功";
					response.getWriter().print(Utils.getReturnedData(Constants.SUCCESS, null, resString));
					return;
				} else {
					resString = "保存失败";
					response.getWriter().print(Utils.getReturnedData(Constants.FAILED, null, resString));
					return;
				}
			}
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			try {
				response.getWriter().print(Utils.getReturnedData(Constants.FAILED, null, e.getMessage()));
			} catch (IOException e1) {

			}
		}
	}

	/**
	 * 添加到收藏夹， 如果是套餐和娱乐，只传pid 如果是酒店，pid和staylvl=3 如果是交通，pid，startplace和endplace 如果是别墅，pid和roomcnt=5
	 * 
	 * @param request
	 * @param response
	 * @param pid
	 * @param staylvl
	 *            3
	 * @param startplace
	 * @param endplace
	 * @param roomcnt
	 *            5
	 */
	@RequestMapping(value = "mobile/myfavorites", method = RequestMethod.DELETE)
	public void delMyFavorites(HttpServletRequest request, HttpServletResponse response, String pid, String staylvl,
			String startplace, String endplace, String roomcnt) {
		response.addHeader("Access-Control-Allow-Origin", "*");
		try {
			User user = Utils.getUserInstance(request);
			if (null == user) {
				response.getWriter().print(Utils.getReturnedData(Constants.FAILED, null, Constants.ErrorUser));
			}
			Collection favorite = new Collection();
			if (null != pid && !"".equals(pid)) {
				favorite.setPid(pid);
			}
			if (null != staylvl && !"".equals(staylvl)) {
				favorite.setStaylvl(3);
			}
			if (null != startplace && !"".equals(startplace)) {
				favorite.setStartplace(startplace);
			}
			if (null != endplace && !"".equals(endplace)) {
				favorite.setEndplace(endplace);
			}
			if (null != roomcnt && !"".equals(roomcnt)) {
				favorite.setRoomcnt(5);
			}
			String resString = "";
			if (collectionService.deleteByPrimaryKey(favorite)) {
				resString = "删除成功";
				response.getWriter().print(Utils.getReturnedData(Constants.SUCCESS, null, resString));
				return;
			} else {
				resString = "删除失败";
				response.getWriter().print(Utils.getReturnedData(Constants.FAILED, null, resString));
				return;
			}
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			try {
				response.getWriter().print(Utils.getReturnedData(Constants.FAILED, null, e.getMessage()));
			} catch (IOException e1) {

			}
		}
	}
}
