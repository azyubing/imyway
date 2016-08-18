package com.imyway.mobile.controller;

import java.io.IOException;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestMethod;

import com.imyway.mobile.constants.Constants;
import com.imyway.mobile.utils.DBUtils;
import com.imyway.mobile.utils.Utils;
import com.imyway.model.City;
import com.imyway.model.Evaluation;
import com.imyway.model.Option;
import com.imyway.model.Theme;
import com.imyway.model.User;
import com.imyway.services.ICityService;
import com.imyway.services.ICollectionService;
import com.imyway.services.IEvaluationService;
import com.imyway.services.IProductInfoService;
import com.imyway.services.IRecommendProductService;
import com.imyway.services.IRouteDayInfoService;
import com.imyway.services.IThemeService;
import com.imyway.services.IUserService;
import com.imyway.services.impl.ThemeProductImpl;

@Controller
public class ProductController {
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);

	@Autowired
	private IThemeService themeService;
	@Autowired
	private IRecommendProductService recommendProductService;
	@Autowired
	private IProductInfoService productInfoService;
	@Autowired
	private ICityService cityService;
	@Autowired
	private IRouteDayInfoService routedayService;
	@Autowired
	private IEvaluationService evaluationService;
	@Autowired
	private IUserService userService;

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/mobile/themes", method = RequestMethod.GET)
	public void getAllThemes(HttpServletRequest request, HttpServletResponse response) {
		try {
			List themelist = themeService.getAllListMap(new HashMap());
			response.addHeader("Access-Control-Allow-Origin", "*");
			response.getWriter().print(Utils.getReturnedData(Constants.SUCCESS, themelist, null));
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
	}

	@RequestMapping(value = "/mobile/recommendThemeProducts", method = RequestMethod.GET)
	public void getRecommendedThemeProducts(HttpServletRequest request, HttpServletResponse response) {
		List<Map<String, Object>> products = recommendProductService.getRecommendProduct(new HashMap<String, String>());
		try {
			response.addHeader("Access-Control-Allow-Origin", "*");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(Utils.getReturnedData(Constants.SUCCESS, products, null));
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
	}

	@RequestMapping(value = "/mobile/hotSingleServices", method = RequestMethod.GET)
	public void getHotServices(HttpServletRequest request, HttpServletResponse response, int page, int pageSize) {
		try {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("page", DBUtils.page(page, pageSize));
			params.put("pageSize", DBUtils.pageSize(page, pageSize));
			List<Map<String, Object>> services = productInfoService.queryProductsByParam(params);
			response.addHeader("Access-Control-Allow-Origin", "*");
			response.getWriter().print(Utils.getReturnedData(Constants.SUCCESS, services, null));
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
	}

	/**
	 * get product search options
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/mobile/productSearchOptions", method = RequestMethod.GET)
	public void getProductSearchOptions(HttpServletRequest request, HttpServletResponse response) {
		try {
			Map<String, Object> returnObj = new HashMap<String, Object>();
			// theme
			List<Map<String, Object>> themelist = themeService.getAllListMap(new HashMap<Object, Object>());
			List<Option> themeOptions = new ArrayList<Option>();
			themeOptions.add(new Option(Constants.AllTheme, "全部主题"));
			for (Object t : themelist) {
				if (t instanceof Theme) {
					Theme theme = (Theme) t;
					themeOptions.add(new Option(String.valueOf(theme.getId()), theme.getName()));
				}
			}
			returnObj.put("themeOptions", themeOptions);
			// 目的地
			List<Option> destOptions = new ArrayList<Option>();
			destOptions.add(new Option(Constants.HotDesintations, "热门目的地"));
			destOptions.add(new Option(Constants.AllDestinations, "全部目的地"));
			Map<String, Object> params = new HashMap<>();
			params.put("isHot", "1");
			params.put("parentId", "1");
			List<City> cities = cityService.getCityListByIsHot(params);
			for (City city : cities) {
				destOptions.add(new Option(city.getCityCode(), city.getCityName()));
			}
			returnObj.put("destinationOptions", destOptions);
			List<Option> serviceOptions = new ArrayList<Option>();// 单项服务，目前没有专门的表保存这些数据，所以这里是写死的
			serviceOptions.add(new Option(Constants.HotServices, "热门单项"));
			serviceOptions.add(new Option(Constants.AllServices, "全部单项"));
			serviceOptions.add(new Option("0", "套餐"));
			serviceOptions.add(new Option("1", "酒店"));
			serviceOptions.add(new Option("2", "娱乐"));
			serviceOptions.add(new Option("3", "别墅"));
			serviceOptions.add(new Option("4", "交通"));
			returnObj.put("serviceOptions", serviceOptions);
			// 排序
			List<Option> orderbyOptions = new ArrayList<Option>();
			orderbyOptions.add(new Option(Constants.Default, "默认排序"));
			orderbyOptions.add(new Option(Constants.TopSales, "销量最高"));
			orderbyOptions.add(new Option(Constants.TopAttention, "收藏最多"));
			orderbyOptions.add(new Option(Constants.PriceDesc, "价格高"));
			orderbyOptions.add(new Option(Constants.PriceAsc, "价格低"));
			returnObj.put("orderbyOptions", orderbyOptions);

			response.addHeader("Access-Control-Allow-Origin", "*");
			response.getWriter().print(Utils.getReturnedData(Constants.SUCCESS, returnObj, null));
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
	}

	/**
	 * get detail information of products
	 * 
	 * @param request
	 * @param response
	 * @param pid
	 */
	@RequestMapping(value = "/mobile/productDetail", method = RequestMethod.GET)
	public void getProductDetail(HttpServletRequest request, HttpServletResponse response, String pid) {
		try {
			Map<String, Object> params = new HashMap<String, Object>();
			if (null != pid && !"".equals(pid)) {
				params.put("pid", pid);
			}
			User user = Utils.getUserInstance(request);
			if (null != user) {
				params.put("userid", user.getId());
			}
			List<Map<String, Object>> products = productInfoService.selectProductInfoListByParam(params);
			response.addHeader("Access-Control-Allow-Origin", "*");
			response.getWriter().write(Utils.getReturnedData(Constants.SUCCESS, products, null));
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
	}

	/**
	 * 获取日程安排信息
	 * 
	 * @param request
	 * @param response
	 * @param pid
	 */
	@RequestMapping(value = "/mobile/productRouteInfo", method = RequestMethod.GET)
	public void getProductRouteInfo(HttpServletRequest request, HttpServletResponse response, String pid) {
		try {
			Map<String, Object> params = new HashMap<String, Object>();
			if (null != pid && !"".equals(pid)) {
				params.put("pid", pid);
			}
			List<?> products = routedayService.selectAllListByParam(params);
			response.addHeader("Access-Control-Allow-Origin", "*");
			response.getWriter().write(Utils.getReturnedData(Constants.SUCCESS, products, null));
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
	}

	@RequestMapping(value = "/mobile/products", method = RequestMethod.GET)
	public void getProducts(HttpServletRequest request, HttpServletResponse response, String destination,
			String service, String orderby, int page, int pageSize) {
		try {
			Map<String, Object> params = new HashMap<String, Object>();
			if (destination != null && !"".equals(destination)) {
				if (destination.equals(Constants.HotDesintations)) {
					Map<String, Object> p = new HashMap<String, Object>();
					p.put("isHot", "1");
					p.put("parentId", "1");
					List<City> cities = cityService.getCityListByIsHot(p);
					String[] c = new String[cities.size()];
					int pos = 0;
					for (City city : cities) {
						c[pos] = String.valueOf(city.getId());
						pos++;
					}
					params.put("cities", c);
				} else if (destination.equals(Constants.AllDestinations)) {
					// nothing need to do
				} else {
					params.put("city", destination);
				}
			}

			if (service != null && !"".equals(service)) {
				if (service.equals(Constants.AllServices)) {
					// nothing need to do
				} else if (service.equals(Constants.HotServices)) {
					// nothing need to do
				} else {
					params.put("ptype", service);
				}
			}

			if (orderby != null && !"".equals(orderby)) {
				if (orderby.equals(Constants.Default)) {
					params.put("orderby", "p.pid");
				} else if (orderby.equals(Constants.TopSales)) {
					// can not support this time
				} else if (orderby.equals(Constants.TopAttention)) {
					params.put("orderby", "marked DESC");
				} else if (orderby.equals(Constants.PriceDesc)) {
					params.put("orderby", "p.start_price DESC");
				} else if (orderby.equals(Constants.PriceAsc)) {
					params.put("orderby", "p.start_price ASC");
				}
			}
			params.put("page", DBUtils.page(page, pageSize));
			params.put("pageSize", DBUtils.pageSize(page, pageSize));
			List<Map<String, Object>> products = recommendProductService.searchProducts(params);
			response.addHeader("Access-Control-Allow-Origin", "*");
			response.getWriter().print(Utils.getReturnedData(Constants.SUCCESS, products, null));
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
	}

	/**
	 * 旅游产品评价
	 * 
	 * @param request
	 * @param response
	 * @param ptype
	 * @param page
	 * @param pageSize
	 * @param active
	 */
	@RequestMapping(value = "/mobile/productComments", method = RequestMethod.GET)
	public void getProductComments(HttpServletRequest request, HttpServletResponse response, String pid, int page, int pageSize) {
		try {
			Map<String, Object> ret = new HashMap<String, Object>();
			int count = evaluationService.getEvaluationCountByPid(pid);
			ret.put("total", count);
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("pid", pid);
			params.put("page", DBUtils.page(page, pageSize));
			params.put("pageSize", DBUtils.pageSize(page, pageSize));			
			List<Evaluation> comments = evaluationService.getEvaluationListByPid(params);
			ret.put("list", comments);
			response.addHeader("Access-Control-Allow-Origin", "*");
			response.getWriter().write(Utils.getReturnedData(Constants.SUCCESS, ret, null));
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
	}

	@RequestMapping(value = "/mobile/productComments", method = RequestMethod.POST)
	public void addProductComments(HttpServletRequest request, HttpServletResponse response, String pid,
			String comments) {
		response.addHeader("Access-Control-Allow-Origin", "*");
		try {
			Map<String, Object> param = new HashMap<>();
			User user = Utils.getUserInstance(request);
			param.put("userId", user.getId());
			param.put("pid", pid);
			if (userService.getIsCanEvaluation(param)) {
				Evaluation evaluation = new Evaluation();
				evaluation.setProductId(pid);
				evaluation.setCtdt(new Date());
				evaluation.setCore(0);
				evaluation.setUserId(user.getIdCard());
				evaluation.setCustomerName(user.getUsername());
				evaluationService.insert(evaluation);
				response.getWriter().write(Utils.getReturnedData(Constants.SUCCESS, evaluation, null));
			} else {
				response.getWriter().write(Utils.getReturnedData(Constants.FAILED, null, Constants.ErrorComment));
			}
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
	}
}
