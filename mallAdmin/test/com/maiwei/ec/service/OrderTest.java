package com.maiwei.ec.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.maiwei.ec.model.BookCusInfo;
import com.maiwei.ec.model.ProductOrder;
import com.maiwei.ec.model.ProductOrderDetail;
import com.maiwei.ec.model.RouteOrder;
import com.maiwei.ec.service.base.BaseServiceTest;
import com.maiwei.ec.services.IBookCusInfoService;
import com.maiwei.ec.services.IProductOrderDetailService;
import com.maiwei.ec.services.IProductOrderService;
import com.maiwei.ec.services.IRouteOrderService;
import com.maiwei.ec.vo.ProductOrderVO;
import com.maiwei.ec.vo.RouteOrderVO;

public class OrderTest extends BaseServiceTest {
	@Autowired
	private IRouteOrderService routeOrderService;
	@Autowired
	private IProductOrderService productOrderService;
	@Autowired
	private IProductOrderDetailService iroductOrderDetailService;
	@Autowired
	private IBookCusInfoService bookCusInfoService;
	
	
	@Test
	public void saveOrder(){
		RouteOrderVO routeOrderVO = new RouteOrderVO();
		//行程单
		RouteOrder routeOrder = new RouteOrder();
		routeOrder.setCusNo("1");//客户编号
		routeOrder.setOrderNm("测试订单一");//订单名称
		routeOrder.setStatus("1");//订单状态 1:预定
		routeOrder.setStartdate(new Date());//行程开始日期
		routeOrder.setEnddate(new Date());//行程结束日期
		routeOrder.setAdultCnt(3);//成人数
		routeOrder.setChildCnt(2);//儿童数
		routeOrder.setAmount(6000.00);//总价
		routeOrder.setPrepay(3000.00);//预付款
		routeOrder.setEvaluateflg("0");//是否已评价   0是  1否
		routeOrder.setDelFlg("0");//有效FLG  0:有效
		routeOrder.setBillTime(new Date());//下单时间
		routeOrder.setPrepayTime(new Date());//预付款支付时间
		routeOrder.setAllpayTime(new Date());//尾款支付之间
		routeOrder.setCtuser("0");//创建人
		routeOrder.setCtdt(new Date()); //创建时间
		routeOrderVO.setRouteOrder(routeOrder);
		
		//产品订单
		List<ProductOrderVO> productOrderVOList = new ArrayList<ProductOrderVO>();
		ProductOrderVO productOrderVO = new ProductOrderVO();
		ProductOrder productOrder = new ProductOrder();
		productOrder.setPid("P0000000000000000001");//产品ID
		productOrder.setInday(new Date());//行程日期
		productOrder.setAttime("2015-09-30");//时间
		productOrder.setPtype("1");//产品类别
		productOrder.setPname("测试酒店1");
		productOrder.setPnameEn("testHotel");
		productOrder.setContinent("1");
		productOrder.setCountry("12");
		productOrder.setCity("13");
		productOrder.setSupplierNo("5");
		productOrder.setStartdate(new Date());
		productOrder.setEnddate(new Date());
		productOrder.setDelFlg("0");
		productOrder.setCtuser("0");
		productOrder.setCtdt(new Date());
		productOrderVO.setProductOrder(productOrder);
		
		//产品订单详情
		List<ProductOrderDetail> productOrderDetailList = new ArrayList<ProductOrderDetail>();
		ProductOrderDetail productOrderDetail = new ProductOrderDetail();
		productOrderDetail.setPriceItem("1");//价格项
		productOrderDetail.setPid(productOrder.getPid());
		productOrderDetail.setOrdercnt(3);
		productOrderDetail.setUnitPrice(2000.00);
		productOrderDetail.setUnitPrepay(1000.00);
		productOrderDetail.setPeoplecnt(3);
		productOrderDetail.setAmount(6000.00);//总计价格
		productOrderDetail.setPrepayAmount(3000.00);//预付总计额
		productOrderDetail.setCtdt(new Date());
		productOrderDetail.setCtuser("0");
		productOrderDetailList.add(productOrderDetail);
		
		ProductOrderDetail productOrderDetail1 = new ProductOrderDetail();
		productOrderDetail1.setPriceItem("2");//价格项
		productOrderDetail1.setPid(productOrder.getPid());
		productOrderDetail1.setOrdercnt(2);
		productOrderDetail1.setUnitPrice(0);
		productOrderDetail1.setUnitPrepay(0);
		productOrderDetail1.setPeoplecnt(2);
		productOrderDetail1.setAmount(0);//总计价格
		productOrderDetail1.setPrepayAmount(0);//预付总计额
		productOrderDetail1.setCtdt(new Date());
		productOrderDetail1.setCtuser("0");
		productOrderDetailList.add(productOrderDetail1);
		productOrderVO.setProductOrderDetailList(productOrderDetailList);
		
		//预定人信息
		List<BookCusInfo> bookCusInfoList = new ArrayList<BookCusInfo>();
		BookCusInfo bookCusInfo = new BookCusInfo();
		bookCusInfo.setCusNo("1");
		bookCusInfo.setCtuser("0");
		bookCusInfo.setCtdt(new Date());
		bookCusInfoList.add(bookCusInfo);
		
		BookCusInfo bookCusInfo1 = new BookCusInfo();
		bookCusInfo1.setCusNo("1");
		bookCusInfo1.setCtuser("0");
		bookCusInfo1.setCtdt(new Date());
		bookCusInfoList.add(bookCusInfo1);
		
		BookCusInfo bookCusInfo2 = new BookCusInfo();
		bookCusInfo2.setCusNo("1");
		bookCusInfo2.setCtuser("0");
		bookCusInfo2.setCtdt(new Date());
		bookCusInfoList.add(bookCusInfo2);
		
		BookCusInfo bookCusInfo3 = new BookCusInfo();
		bookCusInfo3.setCusNo("1");
		bookCusInfo3.setCtuser("0");
		bookCusInfo3.setCtdt(new Date());
		bookCusInfoList.add(bookCusInfo3);
		
		BookCusInfo bookCusInfo4 = new BookCusInfo();
		bookCusInfo4.setCusNo("1");
		bookCusInfo4.setCtuser("0");
		bookCusInfo4.setCtdt(new Date());
		bookCusInfoList.add(bookCusInfo4);
		productOrderVO.setBookCusInfoList(bookCusInfoList);
		
		productOrderVOList.add(productOrderVO);
		routeOrderVO.setProductOrderVOList(productOrderVOList);
		
		routeOrderService.saveRouteOrderVO(routeOrderVO);
		
	}
	
	
	
}
