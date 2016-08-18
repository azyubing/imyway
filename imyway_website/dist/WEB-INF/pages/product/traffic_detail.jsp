<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page language="java" import="java.util.Date" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath =
            request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
                    + path + "/";
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html>
<head>
<!-- page level -->
<link href="<%=basePath%>assets/css/traffic_detail.css" rel="stylesheet" type="text/css">
<!-- 
<script type="text/javascript" src="http://maps.google.cn/maps/api/js?sensor=false&language=zh-CN"></script> 
 -->
<script type="text/javascript" src="<%=basePath%>assets/js/javascriptCheck.js"></script>

</head>
<body>

<!-- ==center content -->
<div class="fl center_content">
	<div class="breadcrumbs"><i class="fa fa-chevron-left i_style"></i><a href="<%=basePath%>home.html">首页</a> &nbsp;<span>&gt;</span>&nbsp;&nbsp;<a href="<%=basePath%>product/product_list.html?ptype=3&fromFlag=0">交通</a>&nbsp; <span>&gt;</span>&nbsp;&nbsp;${country.cityName }-${city.cityName }</div>
	<div class="p_detail"  style="height: 85px;">
		<div style="padding-top: 22px;font-size: 24px;height: 80px;line-height: 30px;">${row.pname }</div>
	</div>
	<div class="p_tags">
		<div class="fl pl_20">
			<c:forEach items="${fn:split(row.tags,'|')}" var="val" >
			<a  class="btn btn-sm btn-success tag-btn" style="cursor: default;">${val}</a>
			</c:forEach>
			
		</div>
		<div class="fr p_0 tag_btn_group" >
			<!-- <a class="btn btn-sm btn-info" id="setBtn"  onclick="add();">放入行程单</a> -->
			<a href="javascript:void(0)" class="tag-item" id="inCollection"><img src="<%=basePath%>assets/img/hotel/star.png"></a>
			<%-- <a href="javascript:void(0)" class="tag-item"><img src="<%=basePath%>assets/img/hotel/chart.png"></a>
			<a href="javascript:void(0)" class="tag-item"><img src="<%=basePath%>assets/img/hotel/link.png"></a> --%>
		</div>
	</div>
	<div class="clr"></div>
	<!-- ==banner -->
	<c:set value="${ fn:split(row.size_img1, ',') }" var="images" />
	<div id="myCarousel" class="carousel slide">
		<!-- 轮播（Carousel）指标 -->
		<ol class="my-indicators carousel-indicators">
		   <c:forEach items="${images}" var="img_val" varStatus="status">
			   <li data-target="#myCarousel" data-slide-to="${status.index}"  <c:if test="${status.index == 0}">class="active" </c:if>></li>
			</c:forEach>
		</ol>  
		<!-- 轮播（Carousel）项目 -->
		<div class="carousel-inner">
		    <c:forEach items="${images}" var="img_val" varStatus="status">
				<div class="item <c:if test="${status.index == 0}">active </c:if>">
				   <img class="lazy-carousel" data-original="${img_val}" alt="" >
				</div>
			</c:forEach>
		</div>
		<!-- 轮播（Carousel）导航 -->
		<a class="slidesjs-navigation " href="#myCarousel" data-slide="prev"><img  src="<%=basePath%>assets/img/left_btn.png"  alt="上一页"></a>
		<a class="slidesjs-navigation slidesjs-next" href="#myCarousel" data-slide="next"><img  src="<%=basePath%>assets/img/right_btn.png"  alt="下一页"></a>
	</div>
	<div class="clr"></div>
	<!-- ==end banner -->
	<!-- ==sub nav -->
	<div class="sub_nav rel" >
		<a class="fl nav_item active" catid="1">行程说明</a>
		<a class="fl nav_item"  catid="2">价格&条款</a>
		<a class="fl nav_item"  catid="3">评价</a>
		<a class="fl nav_item last_item"  catid="4">注意事项</a>
	</div>
	<!-- ==End sub nav -->
	<!-- ==details -->
	<div class="cat"  catid="1">
		${row.pdesc }
	</div>
	<!-- <div class="distance cat" catid="1">
		<div class="distance-item1">
			<div style="position:absolute;">
				<p>起点</p>
				<span>长滩岛天堂花园度假村</span>
			</div>
		</div>
		<div class="distance-item2">
			<div style="position:absolute;">
				<p>终点</p>
				<span>长滩岛金凤凰酒店</span>
			</div>
		</div>
	</div>
	<div id="p_map"  class="cat traffic-map">
		<div class="p_content" id="map_canvas" style="width: 100%; height: 390px"></div>
		<div class="distance-item4">
			<div class="distance-item4-l">
				<span>20.8</span>
				<p>公里数</p>
			</div>
			<div class="distance-item4-r">
				<span>5</span>
				<p>预计耗时</p>
			</div>
		</div>
		<div class="distance-item3">
			<p>成都至雅安为川藏线唯一一段高速公路。泸定一段为二级路面，路况相对好。</p>
		</div>
	</div> -->
	<!-- 
	<div id="p_map"  class="cat traffic-map">
		<div class="p_content" id="map_canvas" style="width: 100%; height: 390px"></div>
	</div> 
	 -->
	<div class="price cat" catid="2">
		<div class="price-title">
			<p>价格&条款</p>
		</div>
		<div class="price-content">
		${row.price_desc }
			<!-- <div class="price-content1">
				<p>时段价格差说明</p>
			</div>
			<div class="price-content2">
				<span>标准价格</span><i>07:00-19:00</i>
			</div>
			<div class="price-content3">
				<span>额外加价</span><i>19:00-07:00</i>
			</div>
			<div class="price-info1">
				<span>价格包含：</span>
				<p>1、全天9小时车辆使用费，全程燃油费；</p>
				<p>2、中文导游费；</p>	
			</div>
			<div class="price-info2">
				<span>价格不含：</span>
				<p>1、停车费由游客另外负担，现场支付；</p>
				<p>2、景点门票；</p>
				<p>3、午餐、晚餐费用，游客个人消费及其他未提及费用；</p>
			</div>
			<div class="price-info3">
				<span>退赔标准：</span>
				<p>1、如因仙贝旅行无法提供服务而取消，可全额退款，不收取任何费用；</p>
				<p>2、如因客人个人原因取消服务，出行日期前15天收取10%手续费，出行日期前7-14天收取50%违约金，出行日期前7天之内不得退改；</p>
			</div> -->
		</div>
	</div>
	<div class="evaluation cat" catid="3">
		<div id="p_discuss"  class="cat">
			<div class="evaluation-title">
				<p>评价</p>
			</div>
			<div class="p_content" >
					 <div id="evaluationList" class="discuss_content">
						<c:forEach items="${evaluationList }" var="evaluation">
							<div class="d_detail">
								<div class="d_img fl"><img alt="" width="20px;" height="20px;"
									<c:if test="${empty evaluation.photo}">
										src="<%=basePath%>assets/tmp/hotel_tmp_img/man2.png"
									</c:if>
									<c:if test="${!empty evaluation.photo}">
										src="${evaluation.photo}"
									</c:if>
								></div>
								<div class="d_name fl">
									<c:if test="${empty evaluation.customerName}">
										匿名用户
									</c:if>
									<c:if test="${!empty evaluation.photo}">
										${evaluation.customerName}
									</c:if>
								</div>
								<div class="d_time fl"><fmt:formatDate value="${evaluation.ctdt}" type="both" pattern="yyyy-MM-dd"/></div>
								<div class="d_mark clr">${evaluation.content}</div>
							</div>
						</c:forEach>
					 </div>
					<div class="y_comm">您的评论：
					<c:if test="${empty loginUser.id}">
						<span>评论请先
							<a href="<%=basePath%>tologin.html">登录</a>，或
							<a href="<%=basePath%>toregister.html">注册</a>
						</span>
					</c:if>
					</div>
					<form action="" id="y_remark">
						<input type="hidden" value="${pid }" name="productId">
						<input type="hidden" value="${loginUser.username }" name="customerName">
						<input type="hidden" value="${loginUser.id }" name="userId">
						<input type="hidden" value="0" name="core">
						<textarea rows="2" cols="2" name="content"  ></textarea>
						<a id="subCommBtn" href="javascript:void(0)" onclick="addEvaluation('${pid}','${loginUser.id }');" class="btn btn-info">发表评论</a>
					</form>
				</div>
		</div>
	</div>
	<!-- ==end discuss  -->
	<div class="attention cat" catid="4">
		<div class="attention-title">
			<p>注意事项</p>
		</div>
		<div class="attention-content">
		${row.pnote }
			<!-- <p>1、如因仙贝旅行无法提供服务而取消，可全额退款，不收取任何费用；</p>
			<p>2、如因客人个人原因取消服务，出行日期前15天收取10%手续费，出行日期前7-14天收取50%违约金，出行日期前7天之内不得退改；</p> -->
		</div>
	</div>
</div>
<!--=== End center content ===-->
<!--=== right content ===-->
<div class="right_content fr">
	<div class="r_top">
		<!-- <div class="traffic_info">
			<p><span class="ri">开始时间</span></p>
			<p class="traffic_date">
		    <span class="ri ri-btn1">
				<a href="javascript:void(0)"><i class="fa fa-caret-left"></i></a>2007-06-14<a href="javascript:void(0)"><i class="fa fa-caret-right"></i></a>
			</span>&nbsp;&nbsp;
			<span class="ri ri-btn2">
				13:00<a href="javascript:void(0)"><i class="fa fa-caret-down"></i></a>
			</span>
			</p>
			<p class="traffic_type">
		    <span class="bus">班车接送</span>
			 &nbsp;&nbsp;&nbsp;x&nbsp;&nbsp;&nbsp;<span class="ri ri-btn2">
				<span class="count">1</span><span class="btns"><a class="up" href="javascript:void(0)"><i class="fa fa-caret-up"></i></a>
				<a class="down" href="javascript:void(0)"><i class="fa fa-caret-down"></i></a></span>
			</span>&nbsp;<span class="person">人</span><!-- 
		</p>
			<p class="traffic_content">
		   <span class="car-img"><img src="../assets/img/traffic/car.jpg" width:100% ></span>&nbsp;&nbsp;
		   <span class="car-info"><span style="margin:0;padding:0;display:block;height:20px">实际乘坐40人</span><span>行李数：20寸×20个</span></span>
			</p>
		</div> -->
			<hr>
		<div class="traffic_info">
			<p style="margin-bottom:10px;width: 100px; display: inline-block;">
				<span class="">开始时间：</span>
				<%--
				<span><input class="sdate" id="childDate" value="<fmt:formatDate value="<%=new Date() %>" type="both" pattern="yyyy-MM-dd"/>" type="text" readonly="readonly"/></span>
				 --%>
				<div class="input-append date date-picker" style="cursor: pointer;height: 42px;width:140px;display: inline-block;">
						<input type="text" id="childDate" class="dateinput" readonly="readonly" style="padding-left:8px;text-align: left; width: 120px;border-right: 1px solid #e5e5e5;  " value="<fmt:formatDate value="<%=new Date()%>" type="both" pattern="yyyy-MM-dd"/>">
						<span class="add-on date_picker_btn rel" id="date_picker_btn3"  style="height: 12px;border: 0px;width: 15px; left:-28px;top:1px;margin-bottom: 18px;" ><i class="fa fa-calendar"></i></span>
				</div>
				<script type="text/javascript" src="<%=basePath%>assets/js/bootstrap-datepicker.min.js"></script>
					<script type="text/javascript">
					$('.date-picker').datepicker({
					    	format: 'yyyy-mm-dd',
					        autoclose: true,
					        todayHighlight: true,
					        language: 'cn', //en
					    });
					</script>
			</p>
			
			<p>
			<!-- <span class="ri ri-btn"><span>toyota FIT-实际乘坐4人</span>
			<a href="javascript:void(0)"><i class="fa fa-caret-down"></i></a></span> -->
			<select class="selecttime" id="starthour" onchange="selectPriceInfo();">
				<option value="09">09</option>
				<option value="10">10</option>
				<option value="11">11</option>
				<option value="12">12</option>
				<option value="13">13</option>
				<option value="14">14</option>
				<option value="15">15</option>
				<option value="16">16</option>
				<option value="17">17</option>
				<option value="18">18</option>
				<option value="19">19</option>
				<option value="20">20</option>
				<option value="21">21</option>
				<option value="22">22</option>
				<option value="23">23</option>
				<option value="00">00</option>
				<option value="01">01</option>
				<option value="02">02</option>
				<option value="03">03</option>
				<option value="04">04</option>
				<option value="05">05</option>
				<option value="06">06</option>
				<option value="07">07</option>
				<option value="08">08</option>
			</select>
			 &nbsp;时&nbsp;
			 <!-- <span class="ri ri-btn2"><span class="count">1</span><span class="btns"><a class="up" href="javascript:void(0)"><i class="fa fa-caret-up"></i></a><a class="down" href="javascript:void(0)"><i class="fa fa-caret-down"></i></a></span>
			 </span> -->
			 <select class="selecttime" id="startmin" onchange="selectPriceInfo();">
				<option value="00">00</option>
				<option value="05">05</option>
				<option value="10">10</option>
				<option value="15">15</option>
				<option value="20">20</option>
				<option value="25">25</option>
				<option value="30">30</option>
				<option value="35">35</option>
				<option value="40">40</option>
				<option value="45">45</option>
				<option value="50">50</option>
				<option value="55">55</option>
			</select>
			&nbsp;分&nbsp;
			</p>
			<!-- 
			<p><span class="ri">开始时间</span></p>
			<p class="traffic_date">
			<span><input class="ri ri-btn2" id="childDate" value="<fmt:formatDate value="<%=new Date() %>" type="date" pattern="yyyy-MM-dd"/>" type="text" readonly="readonly"/></span>
			<span><input class="ri ri-btn2" id="trafficTime" value="13:00" type="text" />
			 </span>
			</p>
			 -->

			<div id="carcontent" >
				<c:if test="${!empty rows }">
					<div class="delHelp" style="position: relative;border-top:1px solid #e5e5e5;margin-top: 20px">
					<img src="<%=basePath%>assets/img/colse.png" onclick="removeTraffic(this);" style="position:absolute;top:0;right:0"/>
					</div>
					<p class="car_style"></p>
					<div class="traffic_type">
						<p class="traffic_type">
							<!-- <span class="ri ri-btn"><span>toyota FIT-实际乘坐4人</span>
							<a href="javascript:void(0)"><i class="fa fa-caret-down"></i></a></span> -->
							<select onchange="changeTraffic(this)" class="select1">
							<c:set var="pprice" value="0"/>
							<c:forEach items="${rows }" var="r" varStatus="i" >
								<c:if test="${i.index==0}">
									<c:set var="pprice" value="${r.price}"/>
								</c:if>
								<option value="${i.index }">${r.carbrand }-(${r.hourCnt}小时)</option>
							</c:forEach>
							</select>
							 &nbsp;x&nbsp;
							 <!-- <span class="ri ri-btn2"><span class="count">1</span><span class="btns"><a class="up" href="javascript:void(0)"><i class="fa fa-caret-up"></i></a><a class="down" href="javascript:void(0)"><i class="fa fa-caret-down"></i></a></span>
							 </span> -->
							 <select onchange="changeTrafficprice(this)" class="select2">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
							</select>
							<span style="color:#ff0000;float:right;line-height:34px"><fmt:formatNumber value="${pprice}" type="currency" pattern="¥"/>(含税)</span>
						</p>
					</div>
					<p class="traffic_content">
				    <span class="car-img"><img id="carImg" src="${empty rows[0].carImg? '../assets/img/traffic/car.jpg': rows[0].carImg}" style="width:100%" ></span>
				    <span class="car-info"><span style="margin:0;padding:0;display:block;height:20px" id="trafficspan">${rows[0].carbrand }-实际乘坐${rows[0].maxpeople}人</span><span id="trafficluggage">${rows[0].luggage}</span></span>
					</p>
				</c:if>
			</div>
		</div>
		<hr>
		<p id="addNewTraffic" style="margin: 10px 0 10px;padding-left: 20px"><a href="javascript:void(0)" style="color: #69a8ff;font-size: 14px;" onclick="addNewTraffic(this)">+添加其他车型</a></p>
			
	</div>
	<div class="r_down">
		<div class="price_list">
			<c:if test="${! empty rows }">
				<div id="trafficpriceList">
					<p class="li"><span class="li_l">${rows[0].carbrand}</span><span class="li_r"><span class="sm_r"></span><fmt:formatNumber value="${rows[0].price -rows[0].price*row.tax_rate -  rows[0].price*row.service_fee_rate}" type="currency" pattern="¥.00"/></span></p>
				</div>
				<c:if test="${row.tax_rate!=null }">
					<p class="li"><span class="li_l">税费</span><span class="li_r"><span class="sm_r"></span> <span id="taxationPrice"><fmt:formatNumber value="${rows[0].price*row.tax_rate}" type="currency" pattern="¥.00"/></span></span></p>
				</c:if>
				<c:if test="${row.service_fee_rate!=null }">
					<p class="li"><span class="li_l">服务费</span><span class="li_r"><span class="sm_r"></span> <span id="servicePrice"><fmt:formatNumber value="${rows[0].price*row.service_fee_rate}" type="currency" pattern="¥.00"/></span></span></p>
				</c:if>
			</c:if>
			<c:if test="${empty rows}">
				<div id="trafficpriceList">
					<p class="li"><span class="li_l">车辆1</span><span class="li_r"><span class="sm_r"></span><fmt:formatNumber value="0" type="currency" pattern="¥.00"/></span></p>
				</div>
				<c:if test="${row.tax_rate!=null }">
					<p class="li"><span class="li_l">税费</span><span class="li_r"><span class="sm_r"></span> <span id="taxationPrice"><fmt:formatNumber value="0" type="currency" pattern="¥.00"/></span></span></p>
				</c:if>
				<c:if test="${row.service_fee_rate!=null }">
					<p class="li"><span class="li_l">服务费</span><span class="li_r"><span class="sm_r"></span> <span id="servicePrice"><fmt:formatNumber value="0" type="currency" pattern="¥.00"/></span></span></p>
				</c:if>
			</c:if>
		</div>
		<div class="price_total">
			<c:if test="${!empty rows}">
				<p class="li"><span class="li_l">总价</span><span class="li_r"><span class="sm_r"></span> <span id="total"><fmt:formatNumber value="${rows[0].price}" type="currency" pattern="¥"/></span> </span></p>
			</c:if>
			<c:if test="${empty rows}">
				<p class="li"><span class="li_l">总价</span><span class="li_r"><span class="sm_r"></span> <span id="total"><fmt:formatNumber value="0" type="currency" pattern="¥"/></span> </span></p>
			</c:if>
		</div>
		<p class="p_info">包车规则：按车型*数量 计费</p>
		<p class="p_btn"><a class="btn btn-info addroute" id="setCtripBtn" disabled="false">放入行程单</a></p>
	</div>
</div>
<div class="clr"></div>
<!--=== End right content ===-->

<!-- Page level JS -->
<script type="text/javascript" src="<%=basePath%>assets/js/product_detail.js"></script>

<script type="text/javascript">
var ptraffic='';
var ptrafficprice='';
var rowsstr='';
function addNewTraffic(obj){
	//if(ptraffic==''){
	//	ptraffic =$(obj).parent().prev().html(); 
	//}
	if(ptrafficprice==''){
		ptrafficprice =$("#trafficpriceList").html(); 
	}

	$("#carcontent").append(ptraffic);
	$("#trafficpriceList").append(ptrafficprice);
	var l = $("#trafficpriceList").find("p").length;
	var firstBrand = rowsstr[0].carbrand;
	$("#trafficpriceList").find("p").eq(l-1).find(".li_l").html(firstBrand);
	
	var price = rowsstr[0].price;
	var taxationPrice = (price* parseFloat('${row.tax_rate}')).toFixed(2);
	var servicePrice = (price* parseFloat('${row.service_fee_rate}')).toFixed(2);
	
	var html = '<span class="sm_r">¥</span>'+(price-taxationPrice-servicePrice).toFixed(2);
	$("#trafficpriceList").find("p").eq(l-1).find(".li_r").html(html);
	countprice();
}

function removeTraffic(obj){
	var index =  $("#carcontent").find(".delHelp").index($(obj).parent());
	$("#trafficpriceList").find("p").eq(index).remove();
	$(obj).parent().next(".car_style").remove();
	$(obj).parent().next(".traffic_type").remove();
	$(obj).parent().next(".traffic_content").remove();
	$(obj).parent().remove();
	
	countprice();
}

function changeTraffic(obj){
	var i= $(obj).val();
	$(obj).next().next().html("¥"+rowsstr[i].price+"(含税)");
	$(obj).parent().parent().next().find("#trafficspan").html(rowsstr[i].carbrand+"-实际乘坐"+rowsstr[i].maxpeople+"人");
	$(obj).parent().parent().next().find("#trafficluggage").html(rowsstr[i].luggage);
	
	if(rowsstr[i].carImg != null && rowsstr[i].carImg != ""){
		$(obj).parent().parent().next().find("#carImg").attr('src',rowsstr[i].carImg); 
	}else{
		$(obj).parent().parent().next().find("#carImg").attr('src',"../assets/img/traffic/car.jpg"); 
	}

	//$("#trafficspan").html(rowsstr[i].carbrand+"-实际乘坐"+rowsstr[i].maxpeople+"人");
	//$("#trafficluggage").html(rowsstr[i].luggage);
	
	//第几种车
	var index = $("#traffic_type").find("p").index($(obj).parent());
	var number = $(obj).next().val();
	var price = number * parseFloat(rowsstr[i].price);
	var taxationPrice = (price* parseFloat('${row.tax_rate}')).toFixed(2);
	var servicePrice = (price* parseFloat('${row.service_fee_rate}')).toFixed(2);
	
	var carprice = (price - taxationPrice - servicePrice).toFixed(2);
	
	var html = '<span class="sm_r">¥</span>'+carprice;
	$("#trafficpriceList").find("p").eq(index).find(".li_l").html(rowsstr[i].carbrand);
	$("#trafficpriceList").find("p").eq(index).find(".li_r").html(html);
	countprice();
}

function changeTrafficprice(obj){
	var number = $(obj).val();
	//第几种车
	var index = $("#traffic_type").find("p").index($(obj).parent());
	var i = $(obj).prev().val();
	var price = number * parseFloat(rowsstr[i].price);
	
	var taxationPrice = (price* parseFloat('${row.tax_rate}')).toFixed(2);
	var servicePrice = (price* parseFloat('${row.service_fee_rate}')).toFixed(2);
	
	var carprice = (price - taxationPrice - servicePrice).toFixed(2);
	var html = '<span class="sm_r">¥</span>'+carprice;
	$("#trafficpriceList").find("p").eq(index).find(".li_r").html(html);
	countprice();
	
}

function countprice(){
	var pList = $(".traffic_type").find("p");
	var total=0;
	for(var i=0;i<pList.length;i++){
		var p = pList[i];
		var typeIndex = $(p).find("select").eq(0).val();
		var number = $(p).find("select").eq(1).val();
		total=total+ number * parseFloat(rowsstr[typeIndex].price);
	}
	var taxationPrice = (total* parseFloat('${row.tax_rate}')).toFixed(2);
	var servicePrice = (total* parseFloat('${row.service_fee_rate}')).toFixed(2);
	//total = (parseFloat(total) + parseFloat(taxationPrice)+parseFloat(servicePrice)).toFixed(3);
	
	$("#taxationPrice").html(taxationPrice);
	$("#servicePrice").html(servicePrice);
	$("#total").html(total);
	var html = '<span class="sm_r">¥</span>'+total;
	$(".price_total").find("p").eq(0).find(".li_r").html(html);
}


function add(){
	if(isNull($("#childDate").val())){
		alert("请输入开始时间");
		return false;
	}
	
	var productEndtime = new Date('${row.enddate }');
	var endtime = productEndtime.format('yyyy-MM-dd');
	var starttime = $("#childDate").val().trim()
	var n = getDateDiff(starttime, endtime) ;
	if(n<0){
		alert("产品无效，无法就加入行程单");
		return false;
	}
	
	//var time = $("#trafficTime").val().trim();
	var time = $("#starthour").val().trim() + ":" + $("#startmin").val().trim()
	if(isNull(time)){
		alert("请输入开始时间");
		return false;
	}
	if(time.indexOf(":")<0||time.length!=5){
		alert("请输入有效开始时间，如：13:00");
		return false;
	}
	var hour = time.split(":")[0];
	var m = time.split(":")[1];
	if(hour.length!=2||m.length!=2){
		alert("请输入有效开始时间，如：13:00");
		return false;
	}
	if(!isNumber(hour)||!isNumber(m)){
		alert("请输入有效开始时间，如：13:00");
		return false;
	}
	if(hour>24||m>59){
		alert("请输入有效开始时间，如：13:00");
		return false;
	}
	
	buliderObject();	
}

function buliderObject(){
	var pList = $(".traffic_type").find("p");
	var trafficCharteredPriceList = '{';
	var str = '{';
	var total=0;
	for(var i=0;i<pList.length;i++){
		var trafficCharteredPrice={};
		var p = pList[i];
		var typeIndex = $(p).find("select").eq(0).val();
		var number = $(p).find("select").eq(1).val();
		
		var carbrand = rowsstr[typeIndex].carbrand;
		var luggage = rowsstr[typeIndex].luggage;
		var price = rowsstr[typeIndex].price;
		var prepay = rowsstr[typeIndex].prepay;
		var id = rowsstr[typeIndex].id;
		
		total=total+ number * parseFloat(price);
		
		var s = '"carbrand":'+'"'+carbrand+'",'
				+'"luggage":'+'"'+luggage+'",'
				+'"price":'+'"'+price+'",'
				+'"id":'+'"'+id+'",'
				+'"prepay":'+'"'+prepay+'",'
				+'"number":'+'"'+number+'"'
		
		str = str+s+"},{"
	}
	str = str.substring(0,str.length-2);
	//var time = $("#trafficTime").val().trim();
	var time = $("#starthour").val().trim() + ":" + $("#startmin").val().trim()
	var date = $("#childDate").val().trim();
	var taxationPrice = (total* parseFloat('${row.tax_rate}')).toFixed(3);
	var servicePrice = (total* parseFloat('${row.service_fee_rate}')).toFixed(3);
	var timestamp = Date.parse(new Date());
	
	var enddate = new Date('${row.enddate}');
	var nowDate = new Date(date);
	if(enddate<nowDate){
		alert("在日期："+date+",该交通无效 ");
		return false;
	}
	
	var s = '{"time":'+'"'+time+'",'
			+'"date":'+'"'+date+'",'
			+'"timestamp":'+'"'+timestamp+'",'
			+'"startDate":'+'"'+nowDate.format('yyyy-MM-dd')+'",'
			+'"endDate":'+'"'+nowDate.format('yyyy-MM-dd')+'",'
			+'"pid":'+'"'+'${row.pid}'+'",'
			+'"leftCountry":'+'"'+'${country.id}'+'",'
			+'"pname":'+'"'+'${row.pname}'+'",'
			+'"startplace":'+'"'+'${row.startplace}'+'",'
			+'"endplace":'+'"'+'${row.endplace}'+'",'
			+'"serviceFeeRate":'+'"'+'${row.service_fee_rate}'+'",'
			+'"countryName":'+'"'+'${country.cityName }'+'",'
			+'"cityName":'+'"'+'${city.cityName }'+'",'
			+'"taxRate":'+'"'+'${row.tax_rate}'+'",'
			+'"servicePrice":'+'"'+servicePrice+'",'
			+'"taxPrice":'+'"'+taxationPrice+'",'
			+'"totalPrice":'+'"'+total+'",'
			+'"type":'+'"traffic",'
			+'"trafficCharteredPriceList":'+'['+str+']}';
	appendTrafficJson(s,rowsstr,'traffic');
}

//获取有效价格项
function selectPriceInfo(){
	var starthour=$("#starthour").val();
	var startmin=$("#startmin").val();
	var time=starthour+":"+startmin;
	$.ajax({    
        type:'post',        
        url:'<%=basePath%>/product/traffic_priceItemDetail.html',    
        data:{"pid":'${pid}',"time":time},
        cache:false,    
        dataType:'json',    
        success:function(data){
        	setTrafficHtml(data);
        }    
    });
}

function priceItemDetail(data,date){
	$("#childDate").val(date);
}
function setTrafficHtml(data){
	var html='';
	if(data!=null&&data.length>0){
		html='<div class="delHelp" style="position: relative;border-top:1px solid #e5e5e5;margin-top: 20px">'
				+'<img src="<%=basePath%>assets/img/colse.png" onclick="removeTraffic(this);" style="position:absolute;top:0;right:0"/>'
				+'</div>'
				+'<p class="car_style"></p>'
				+'<div class="traffic_type">'
				+'<p class="traffic_type">'
				+'<select onchange="changeTraffic(this)" class="select1">';
		var pprice = data[0].price;
		var optionHtml='';
		for(var i=0;i<data.length;i++){
			var json = data[i]
			optionHtml = optionHtml+'<option value="'+i+'">'+json.carbrand +'-('+json.hourCnt+'小时)</option>'
		}
		var carImg = data[0].carImg;
		var carbrand = data[0].carbrand;
		var maxpeople = data[0].maxpeople;
		var luggage = data[0].luggage;
		if(carImg==null||carImg==''){
			carImg='../assets/img/traffic/car.jpg';
		}
		html = html+optionHtml+'</select>&nbsp;x&nbsp;'
				+'<select onchange="changeTrafficprice(this)" class="select2">'
				+'<option value="1">1</option>'
				+'<option value="2">2</option>'
				+'<option value="3">3</option>'
				+'<option value="4">4</option>'
				+'<option value="5">5</option>'
				+'</select>'
				+'<span style="color:#ff0000;float:right;line-height:34px">¥'+pprice+'(含税)</span>'
				+'</p>'
				+'</div>'
				+'<p class="traffic_content">'
				+'<span class="car-img"><img id="carImg" src="'+carImg+'" style="width:100%" ></span>'
				+'<span class="car-info"><span style="margin:0;padding:0;display:block;height:20px" id="trafficspan">'+carbrand+'-实际乘坐'+maxpeople+'人</span><span id="trafficluggage">'+luggage+'</span></span>'
				+'</p>';
		var taxationPrice = (pprice* parseFloat('${row.tax_rate}')).toFixed(2);
		var servicePrice = (pprice* parseFloat('${row.service_fee_rate}')).toFixed(2);
		var p = pprice-taxationPrice-servicePrice;
		var trafficpriceListHtml = '<p class="li"><span class="li_l">'+data[0].carbrand+'</span><span class="li_r"><span class="sm_r"></span>¥'+p+'</span></p>';
		$("#trafficpriceList").html(trafficpriceListHtml);
	 	allowAdd();
	}else{
		notAllowAdd();
	}
	rowsstr = data;
	$("#carcontent").html(html);
	
	countprice();
	ptraffic = $("#carcontent").html();

}



/**
 * 可以加入行程单
 */
function allowAdd(){
	if(typeof($(".addroute").attr("disabled"))=="undefined"){
	}else{
		$(".addroute").bind("click",function(){
			add();
		});
		$(".addroute").removeAttr("disabled");
	}
}
/**
 * 步可以加入行程单
 */
function notAllowAdd(){
	$(".addroute").unbind("click")
	$(".addroute").attr("disabled",true);
}







//对Date的扩展，将 Date 转化为指定格式的String   
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
//例子：   
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423   
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18   
Date.prototype.format = function(fmt) { //author: meizz   
	var o = {
		"M+" : this.getMonth() + 1, //月份   
		"d+" : this.getDate(), //日   
		"h+" : this.getHours(), //小时   
		"m+" : this.getMinutes(), //分   
		"s+" : this.getSeconds(), //秒   
		"q+" : Math.floor((this.getMonth() + 3) / 3), //季度   
		"S" : this.getMilliseconds()
	//毫秒   
	};
	if (/(y+)/.test(fmt))
		fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(fmt))
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]): (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt;
}




var isExpend = false;

/*
//起点
var start = {lat: 31.0937077, lng: 121.2158436};
//途经点
var waypts = [{location:{lat: 31.1637077, lng: 120.4858436}},{location:{lat: 31.3937077, lng: 120.4158436}}];
//终点
var end = {lat: 31.834158, lng: 119.619869};

var centLat = (start.lat + end.lat)/2;
var centLng = (start.lng + end.lng)/2;

var myLatlng = new google.maps.LatLng(centLat, centLng);
var mapOptions = {
	zoom: 10,
	center: myLatlng,
	mapTypeId: google.maps.MapTypeId.ROADMAP,
	 scaleControl: true,    //比例尺  
     mapTypeControl: false      
};

function initializeMap() {
  var directionsService = new google.maps.DirectionsService;
  var directionsDisplay = new google.maps.DirectionsRenderer;
  var map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
  directionsDisplay.setMap(map);
  calculateAndDisplayRoute(directionsService, directionsDisplay);
}

function calculateAndDisplayRoute(directionsService, directionsDisplay) {
  directionsService.route({
    origin: start,
    destination: end,
    waypoints: waypts,
    optimizeWaypoints: true,
    travelMode: google.maps.TravelMode.DRIVING
  }, function(response, status) {
    if (status === google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(response);
    } else {
      window.alert('Google地图无法加载！');
    }
  });
}
*/

function initPage() {  
    try {  
        $window = $(window);  
        var resize = $window.jqElemResize();  
        $(resize).on("resize", function (size) {  
        	setTopHeight(); 
        	//initializeMap();
        });  
    } catch (exp) {  
        alert(exp.message);  
    }  
} 
/*页面卸载时*/  
$(window).unload(function () {  
    try {  
        $(window).jqElemResize("destroy");  
    } catch (exp) {  
        alert(exp.message);  
    }  
}); 
	
jQuery(document).ready(function() {
	
	selectPriceInfo();
	initPage();
	setTopHeight();
	$('#myCarousel').carousel({interval: 5000});
	
	//set next/pre hover 
	$(".carousel-inner,.slidesjs-navigation,.my-indicators").hover(
		function(){
			$(".slidesjs-navigation").removeClass("opacity-hide").addClass("opacity-harf-show");
		},
		function(){
			$(".slidesjs-navigation").removeClass("opacity-harf-show").addClass("opacity-hide");
		}
	);
	//sub_nav
	$(".sub_nav>.nav_item").click(function(){
		var obj = this;
		setCatTop(obj);
		setTimeout(function(){
			setCatTop(obj);
		},50);
	});
	function setCatTop(obj){
		if(!$(obj).hasClass("active")){
			$(".sub_nav>.nav_item").removeClass("active");
			$(obj).addClass("active");			
		}
		var catid=$(obj).attr("catid");
		var top=$(".cat[catid='"+catid+"']").offset().top;
		$(window).scrollTop(top-50);
	}

	//set map
	//initializeMap();

	//set check
	$("#rf>a").click(function(){
		if($(this).children().eq(0).hasClass("checked")){
			$(this).children().eq(0).attr("src","<%=basePath%>assets/img/hotel/check1.png").removeClass("checked");
		}else{
			$(this).children().eq(0).attr("src","<%=basePath%>assets/img/hotel/check2.png").addClass("checked");
		}
	});
	var snavTop = $('.sub_nav').offset().top;
	$('.sub_nav').setScroll({
	  startTop:snavTop
	});
	
	
	var t1 = $(".t1");
	var checkeddate = $.session.get('checkeddate');
	$(t1).each(function(index){
		var t1date = $(t1[index]).attr('date');
		if(t1date == checkeddate){
			$("#endTime").val($(t1[index]).attr('date'));
			ischecked($(t1[index]));
		}
	});
	
});
</script>
<!-- jianghuiqing javascript start -->
<script type="text/javascript">
//加入收藏夹
$("#inCollection").click(function(){
	setTimeout(function(){
		$.ajax({
			type: "GET",	
			url: "<%=basePath%>collection/ajaxAddCollection.html",
			data: {'pid':'${pid}','startplace':'${row.startplace}','endplace':'${row.endplace}'	},
			dataType: "html",
			success: function(htmlData){
				var objectList =jQuery.parseJSON(htmlData);
				alert(objectList);
			}
		});
	},500);
});
</script>
<!-- jianghuiqing javascript end -->
</body>
</html>