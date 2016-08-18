package com.imyway.mobile.controller;

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
import org.springframework.web.bind.annotation.RequestMethod;

import com.imyway.common.utils.CommonUtils;
import com.imyway.mobile.constants.Constants;
import com.imyway.mobile.utils.Utils;
import com.imyway.model.PackagePriceInfo;
import com.imyway.model.VillaDetailPriceInfo;
import com.imyway.services.IEntPriceInfoService;
import com.imyway.services.IPackagePriceInfoService;
import com.imyway.services.IRoomPriceInfoService;
import com.imyway.services.IVillaDetailPriceInfoService;

@Controller
public class PriceController {
	private static final Logger logger = LoggerFactory.getLogger(PriceController.class);
	@Autowired
	private IRoomPriceInfoService roomPriceInfoService;
	@Autowired
	private IPackagePriceInfoService packagePriceInfoService;
	@Autowired
	private IVillaDetailPriceInfoService villaDetailPriceInfoService;
	@Autowired
	private IEntPriceInfoService entPriceInfoService;

	/**
	 * 酒店价格日历
	 * 
	 * @param request
	 * @param response
	 * @param pid
	 * @param date
	 */
	@RequestMapping(value = "/mobile/hotelPriceCalendar", method = RequestMethod.GET)
	public void getHotelPriceCalendar(HttpServletRequest request, HttpServletResponse response, String pid,
			String date) {
		response.addHeader("Access-Control-Allow-Origin", "*");
		try {
			Map<String, Object> param = new HashMap<>(3);
			param.put("pid", pid);
			param.put("beginDate", CommonUtils.getMonthFirst(date, 0, 1));
			param.put("endDate", CommonUtils.getMonthEnd(date, 2));
			// 酒店价格日历
			List<PackagePriceInfo> prices = roomPriceInfoService.gethotelPriceCal(param);
			response.getWriter().print(Utils.getReturnedData(Constants.SUCCESS, prices, null));
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
	}

	/**
	 * 套餐价格日历
	 * 
	 * @param request
	 * @param response
	 * @param pid
	 * @param date
	 */
	@RequestMapping(value = "/mobile/packagePriceCalendar", method = RequestMethod.GET)
	public void getPackagePriceCalendar(HttpServletRequest request, HttpServletResponse response, String pid,
			String date) {
		response.addHeader("Access-Control-Allow-Origin", "*");
		try {
			Map<String, Object> param = new HashMap<>(3);
			param.put("pid", pid);
			param.put("beginDate", CommonUtils.getMonthFirst(date, 0, 1));
			param.put("endDate", CommonUtils.getMonthEnd(date, 2));
			// 套餐价格项
			List<PackagePriceInfo> prices = packagePriceInfoService.getPackagePriceCal(param);
			response.getWriter().print(Utils.getReturnedData(Constants.SUCCESS, prices, null));
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
	}

	/**
	 * 别墅价格日历
	 * 
	 * @param request
	 * @param response
	 * @param pid
	 * @param date
	 */
	@RequestMapping(value = "/mobile/villaPriceCalendar", method = RequestMethod.GET)
	public void getVillaPriceCalendar(HttpServletRequest request, HttpServletResponse response, String pid,
			String date) {
		response.addHeader("Access-Control-Allow-Origin", "*");
		try {
			Map<String, Object> param = new HashMap<>(3);
			param.put("pid", pid);
			param.put("beginDate", CommonUtils.getMonthFirst(date, 0, 1));
			param.put("endDate", CommonUtils.getMonthEnd(date, 2));
			// 别墅价格日历
			List<PackagePriceInfo> prices = villaDetailPriceInfoService.getVillaPriceCal(param);
			response.getWriter().print(Utils.getReturnedData(Constants.SUCCESS, prices, null));
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
	}

	/**
	 * 娱乐价格日历
	 * 
	 * @param request
	 * @param response
	 * @param pid
	 * @param date
	 */
	@RequestMapping(value = "/mobile/entertainmentPriceCalendar", method = RequestMethod.GET)
	public void getEntertainmentPriceCalendar(HttpServletRequest request, HttpServletResponse response, String pid,
			String date) {
		response.addHeader("Access-Control-Allow-Origin", "*");
		try {
			Map<String, Object> param = new HashMap<>(3);
			param.put("pid", pid);
			param.put("beginDate", CommonUtils.getMonthFirst(date, 0, 1));
			param.put("endDate", CommonUtils.getMonthEnd(date, 2));
			// 别墅价格日历
			List<PackagePriceInfo> prices = entPriceInfoService.getEntPriceCal(param);
			response.getWriter().print(Utils.getReturnedData(Constants.SUCCESS, prices, null));
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
	}

	@RequestMapping(value = "/mobile/villaPriceDetail", method = RequestMethod.GET)
	public void getVillaPriceDetail(HttpServletRequest request, HttpServletResponse response, String pid, String date) {
		response.addHeader("Access-Control-Allow-Origin", "*");
		try {
			Map<String, Object> param = new HashMap<>(3);
			param.put("pid", pid);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			//param.put("starttime", sdf.parse(date));
			List<VillaDetailPriceInfo> villaDetailPriceInfoList = villaDetailPriceInfoService.selectAllListByParam(param);
			List<VillaDetailPriceInfo> priceItems = villaDetailPriceInfoService.selectAllListByParam(param);
			response.getWriter().print(Utils.getReturnedData(Constants.SUCCESS, villaDetailPriceInfoList, null));
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
	}
}
