<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link href="<%=basePath%>assets/css/peerInfo.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=basePath%>assets/js/javascriptCheck.js"></script>
</head>
<body>
<!-- ===info main -->
<div id="contact_main" >
  <div id="main">
	<h2 id="title">填写旅客信息</h2>
	<div class="info_list">
	<table class="info_table dcl" id="${order.order_no }_table">
			<colgroup><col class="col1"><col class="col2"><col class="col3"><col class="col4"><col class="col5"></colgroup>
			<thead>
				<tr>
					<td class="pl_20" colspan="5"><span class="bold">${order.startCountryName }</span><span>${order.startCityName }&nbsp;-&nbsp;<span class="bold">${order.endCountryName }</span>${order.endCityName }</span></td>
					<td><span class="order_time">订单时间：<fmt:formatDate value="${order.ctdt}" type="both" pattern="yyyy-MM-dd"/></span><span class="order_id">订单编号：${order.order_no }</span></td>
				</tr>
			</thead>
			<tbody>
				<tr id="${order.order_no }_tr">
					<td class="pl_20 rel">
						<span class="order_date mr_2"><fmt:formatDate value="${order.startdate}" type="both" pattern="MM"/>&nbsp;/&nbsp;<fmt:formatDate value="${order.startdate}" type="both" pattern="dd"/></span>
							<span class="order_date"><fmt:formatDate value="${order.enddate}" type="both" pattern="MM"/>&nbsp;/&nbsp;<fmt:formatDate value="${order.enddate}" type="both" pattern="dd"/></span>
							<img class="arrow" src="<%=basePath%>assets/img/personal/arrow.png">
					</td>
					<td><span class="red"><fmt:formatNumber value="${order.amount }" type="currency" pattern="¥0.00"/></span></td>
					<td><c:if test="${order.status==1 }">
							¥0.00
						</c:if>
						<c:if test="${order.status==2||order.status==3 }">
							¥${order.amount -row.prepay}
						</c:if>
						<c:if test="${order.status==4||order.status==5 }">
							¥${order.amount}
						</c:if></td>
					<td><c:if test="${order.status==1 }">
								<fmt:formatNumber value="${order.amount }" type="currency" pattern="¥0.00"/>
							</c:if>
							<c:if test="${order.status==2||order.status==3 }">
								¥${order.amount -row.prepay}
							</c:if>
							<c:if test="${order.status==4||order.status==5 }">
								¥0
							</c:if></td>
					<td>
						<div class="stat">
						<span class="fl">
							<c:if test="${order.status==1 }">
									待付款
								</c:if>
								<c:if test="${order.status==2 }">
									待处理
								</c:if>
								<c:if test="${order.status==3 }">
									待付尾款
								</c:if>
								<c:if test="${order.status==4 }">
									待出行
								</c:if>
								<c:if test="${order.status==5 }">
									已完成
								</c:if>
								<c:if test="${row.status==8 }">
									支付中
								</c:if>
								<c:if test="${row.status==9 }">
									已退款
								</c:if>
						</span>
							<c:if test="${order.status==2 }">
								<span class="fr mr_53">
									${order.percent}
								</span>
							</c:if>
						</div>
						<div class="clr"></div>
						<c:if test="${order.status==2 }">
							<div class="stat_bar"><div class="bar" data-width="${fn:split(order.percent, '%')[0]  }">&nbsp;</div></div>
						</c:if>
					</td>
					<td>
						<div class="fl">
							<img class="ewm" src="<%=basePath%>assets/img/personal/ewm.png">&nbsp;&nbsp;联络客服
						</div>
						<div class="fr right_content"><a id="ABC1506_btn" href="javascript:void(0);" onclick="showSubList('${order.order_no }','dcl','${order.status}');"><img class="down_arrow" src="<%=basePath%>assets/img/personal/down_arrow.png"></a></div>
						<div class="clr"></div>
					</td>
				</tr>
				<tr id="${order.order_no }" class="sub_data" style="display: none;">
					
				</tr>
			</tbody>
		</table>
	</div>
	<!-- sub title -->
	<div id="sub_title">本次行程最大出行人数为 <span class="g">${order.adult_cnt }</span>人，请认真填写并核对以下信息</div>
	<!--end sub title -->
	<!-- main info -->
	<c:forEach items="${orderCusInfoList }" var="orderCusInfo" varStatus="index">
		<!-- 同行人 -->
		<c:if test="${orderCusInfo.type==0 }">
			<div class="main_info">
			<div class="lc fl">
			<div class="sub_title2">旅行伙伴</div>
				<div class="sub_title3">不负责旅途中的联系与沟通</div>
				<hr class="main_info_hr">
				<div class="p_list">
					<c:forEach items="${rows }" var="row" varStatus="i">
						<span><a href="javascript:void(0)" onclick="cusIsChecked(this)" index="${i.index }"><img alt="" 
						<c:if test="${row.id==orderCusInfo.cusNo }">
							src="http://www.imyway.cn:80/assets/img/UI/checked.png"
							ischecked="true"
						</c:if>
						<c:if test="${row.id!=orderCusInfo.cusNo }">
							src="http://www.imyway.cn:80/assets/img/UI/check.png"
						</c:if>
						
						></a>&nbsp;&nbsp;${row.realName }</span>
						<c:if test="${(i.index+1)/4==0 }">
						<br>
						</c:if>
					</c:forEach>
				</div>
			</div>
			<div class="rc fr">
				<div class="form_style">
				<form action="" method="post">
					<input type="hidden" name="id" value="${orderCusInfo.id }">
					<input type="hidden" name="orderNo" value="${order.order_no }">
					<input type="hidden" name="bookCusId" value="${orderCusInfo.bid  }">
					<input type="hidden" name="type" value="${orderCusInfo.type }">
		           	<input type="hidden" name="birthday">
		           	<input type="hidden" name="isUse" value="${orderCusInfo.isUse  }">
					<table>
						<colgroup><col><col><col></colgroup>
						<tr>
							<td class="inf">真实姓名&nbsp;<span class="import">*</span></td>
							<td class="inf">真实姓名拼音&nbsp;<span class="import">*</span></td>
							<td class="inf"></td>
						</tr>
						<tr>
							<td><input type="text" name="realName" value="${orderCusInfo.realName  }"></td>
							<td><input type="text" name="customerName" value="${orderCusInfo.customerName  }"></td>
							<td></td>
						</tr>
						<tr>
							<td class="inf">身份证号码&nbsp;<span class="import">*</span></td>
							<td class="inf" colspan="2">出生日期&nbsp;<span class="import">*</span></td>
						</tr>
						<tr>
							<td>
								<select name="cardType" class="select1">
										<option value="1" <c:if test="${orderCusInfo.cardType=='1' }">selected="selected"</c:if>>身份证</option>
										<option value="2" <c:if test="${orderCusInfo.cardType=='2' }">selected="selected"</c:if>>护照</option>
										<option value="3" <c:if test="${orderCusInfo.cardType=='3' }">selected="selected"</c:if>>军人证</option>
										<option value="4" <c:if test="${orderCusInfo.cardType=='4' }">selected="selected"</c:if>>回乡证</option>
										<option value="5" <c:if test="${orderCusInfo.cardType=='5' }">selected="selected"</c:if>>台胞证</option>
										<option value="6" <c:if test="${orderCusInfo.cardType=='6' }">selected="selected"</c:if>>港澳通行证</option>
										<option value="7" <c:if test="${orderCusInfo.cardType=='7' }">selected="selected"</c:if>>户口簿</option>
										<option value="8" <c:if test="${orderCusInfo.cardType=='8' }">selected="selected"</c:if>>出生证明</option>
										<option value="9" <c:if test="${orderCusInfo.cardType=='9' }">selected="selected"</c:if>>其他</option>
									</select> 
							</td>
							<td colspan="2"><div class="dropdown mr_10">
							  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
							    <font class="fontYear">${fn:substring(orderCusInfo.birthday,0,4)}</font>
							    <span class="caret"></span>
							  </button>
							  <ul class="dropdown-menu year" aria-labelledby="dropdownMenu1" style="height: 100px;overflow:auto;">
							    <li><a href="javascript:void(0)">1981</a></li>
							  </ul>
							</div><div class="dropdown">
							  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
							    <font class="fontMonth">${fn:substring(orderCusInfo.birthday,5,7)}月</font>
							    <span class="caret"></span>
							  </button>
							  <ul class="dropdown-menu" aria-labelledby="dropdownMenu2" style="height: 100px;overflow:auto;">
							     <li><a href="javascript:void(0)" onclick="getDay(1,this);">1月</a></li>
							    <li><a href="javascript:void(0)" onclick="getDay(2,this);">2月</a></li>
							    <li><a href="javascript:void(0)" onclick="getDay(3,this);">3月</a></li>
							    <li><a href="javascript:void(0)" onclick="getDay(4,this);">4月</a></li>
							    <li><a href="javascript:void(0)" onclick="getDay(5,this);">5月</a></li>
							    <li><a href="javascript:void(0)" onclick="getDay(6,this);">6月</a></li>
							    <li><a href="javascript:void(0)" onclick="getDay(7,this);">7月</a></li>
							    <li><a href="javascript:void(0)" onclick="getDay(8,this);">8月</a></li>
							    <li><a href="javascript:void(0)" onclick="getDay(9,this);">9月</a></li>
							    <li><a href="javascript:void(0)" onclick="getDay(10,this);">10月</a></li>
							    <li><a href="javascript:void(0)" onclick="getDay(11,this);">11月</a></li>
							    <li><a href="javascript:void(0)" onclick="getDay(12,this);">12月</a></li>
							  </ul>
							</div><div class="dropdown last">
							  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
							    <font class="fontDay">${fn:substring(orderCusInfo.birthday,8,10)}日</font>
							    <span class="caret"></span>
							  </button>
							  <ul class="dropdown-menu day" aria-labelledby="dropdownMenu3" style="height: 100px;overflow:auto;">
							    <li><a href="javascript:void(0)">1日</a></li>
							  </ul>
							</div></td>
						</tr>
						<tr>
							<td class="inf" colspan="3">护照号码&nbsp;<span class="import">*</span></td>
						</tr>
						<tr>
							<td  colspan="3"><input type="text" class="lg_txt" name="cardNumber" value="${orderCusInfo.cardNumber  }"></td>
						</tr>
					</table>
					</form>
					<hr>
					<div class="btn_group">
						<a href="javascript:void(0);" onclick="deleteCus(this);" class="btn save deletePeerInfo" id="">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0);" onclick="addCus(this);" class="btn save addPeerInfo" id="">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox"
						<c:if test="${orderCusInfo.isUse==0}"> checked="checked"</c:if>
						>&nbsp;
						
						<span>添加到常用联系人</span>
					</div>	
				</div>
			</div>
			<div class="clr"></div>
		</div>
		</c:if>
	</c:forEach>
	<c:if test="${order.adult_cnt>=1}">
		<c:forEach begin="${fn:length(orderCusInfoList) }" end="${order.adult_cnt-1 }"  varStatus="index">
			<div class="main_info">
				<div class="lc fl">
					<div class="sub_title2">同行伙伴</div>
					<div class="sub_title3">不负责旅途中的联系与沟通</div>
					
					<hr class="main_info_hr">
					<div class="p_list">
						<c:forEach items="${rows }" var="row" varStatus="i">
							<span><a href="javascript:void(0)" onclick="cusIsChecked(this)" index="${i.index }"><img alt="" src="<%=basePath%>assets/img/UI/check.png"></a>&nbsp;&nbsp;${row.realName }</span>
							<c:if test="${(i.index+1)/4==0 }">
							<br>
							</c:if>
						</c:forEach>
					</div>
				</div>
				<div class="rc fr">
					<div class="form_style">
					<form action="" method="post">
						<input type="hidden" name="id" value="0">
						<input type="hidden" name="orderNo" value="${order.order_no}">
						<input type="hidden" name="bookCusId" value="0">
						<input type="hidden" name="type" value="0">
			           	<input type="hidden" name="birthday">
			           	<input type="hidden" name="isUse" value="1">
						<table>
							<colgroup><col><col><col></colgroup>
							<tr>
								<td class="inf">真实姓名&nbsp;<span class="import">*</span></td>
								<td class="inf">真实姓名拼音&nbsp;<span class="import">*</span></td>
							</tr>
							<tr>
								<td><input type="text" name="realName" ></td>
								<td><input type="text" name="customerName" ></td>
							</tr>
							<tr>
								<td class="inf">证件类型&nbsp;<span class="import">*</span></td>
								<td class="inf" colspan="2">出生日期&nbsp;<span class="import">*</span></td>
							</tr>
							<tr>
								<td>
									<select name="cardType" class="select1">
										<option value="1">身份证</option>
										<option value="2">护照</option>
										<option value="3">军人证</option>
										<option value="4">回乡证</option>
										<option value="5">台胞证</option>
										<option value="6">港澳通行证</option>
										<option value="7">户口簿</option>
										<option value="8">出生证明</option>
										<option value="9">其他</option>
									</select> 
								</td>
								<td colspan="2"><div class="dropdown mr_10">
								  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
								    <font class="fontYear"></font>
								    <span class="caret"></span>
								  </button>
								  <ul class="dropdown-menu year" aria-labelledby="dropdownMenu1" style="height: 100px;overflow:auto;">
								    <li><a href="javascript:void(0)"></a></li>
								  </ul>
								</div><div class="dropdown">
								  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
								    <font class="fontMonth">1月</font>
								    <span class="caret"></span>
								  </button>
								  <ul class="dropdown-menu" aria-labelledby="dropdownMenu2" style="height: 100px;overflow:auto;">
								     <li><a href="javascript:void(0)" onclick="getDay(1,this);">1月</a></li>
								    <li><a href="javascript:void(0)" onclick="getDay(2,this);">2月</a></li>
								    <li><a href="javascript:void(0)" onclick="getDay(3,this);">3月</a></li>
								    <li><a href="javascript:void(0)" onclick="getDay(4,this);">4月</a></li>
								    <li><a href="javascript:void(0)" onclick="getDay(5,this);">5月</a></li>
								    <li><a href="javascript:void(0)" onclick="getDay(6,this);">6月</a></li>
								    <li><a href="javascript:void(0)" onclick="getDay(7,this);">7月</a></li>
								    <li><a href="javascript:void(0)" onclick="getDay(8,this);">8月</a></li>
								    <li><a href="javascript:void(0)" onclick="getDay(9,this);">9月</a></li>
								    <li><a href="javascript:void(0)" onclick="getDay(10,this);">10月</a></li>
								    <li><a href="javascript:void(0)" onclick="getDay(11,this);">11月</a></li>
								    <li><a href="javascript:void(0)" onclick="getDay(12,this);">12月</a></li>
								  </ul>
								</div><div class="dropdown last">
								  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
								    <font class="fontDay">1日</font>
								    <span class="caret"></span>
								  </button>
								  <ul class="dropdown-menu day" aria-labelledby="dropdownMenu3" style="height: 100px;overflow:auto;">
								    <li><a href="javascript:void(0)">1日</a></li>
								  </ul>
								</div></td>
							</tr>
							<tr>
								<td class="inf" colspan="3">证件号码&nbsp;<span class="import">*</span></td>
							</tr>
							<tr>
								<td  colspan="3"><input type="text" class="lg_txt" name="cardNumber"></td>
							</tr>
						</table>
						</form>
						<hr>
						<div class="btn_group">
							<a href="javascript:void(0);" onclick="deleteCus(this);"  class="btn save deletePeerInfo" id="">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0);" onclick="addCus(this);"  class="btn save addPeerInfo" id="">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="checkbox">&nbsp;
							
							<span>添加到常用联系人</span>
						</div>	
					</div>
				</div>
				<div class="clr"></div>
			</div>
		</c:forEach>
	
	</c:if>
  </div>
	<div style="margin-left: 45px;margin-bottom: 20px;">
	<span>本次行程最大出行人数为 <span class="peoplenum">${order.adult_cnt }</span>人，您填写了
							<span class="peoplenum" id="adCnt">${adultCount }</span>成人，
							<span class="peoplenum" id="chCnt">${childCount }</span>儿童(2-12周岁)，
							<span class="peoplenum" id="baCnt">${babyCount }</span>婴儿(0-2周岁)。
	</span>
	<!-- 
	<span id="cusAgeInfo">
	<c:if test="${adultCount>0 }">${adultCount }成人</c:if>
	<c:if test="${childCount>0 }">${childCount }儿童</c:if>
	<c:if test="${babyCount>0 }">${babyCount }婴儿</c:if>
	</span>
	<span>。</span>
	 -->
	</div>
  <a href="javascript:void(0);" class="btn save" style="padding-left: 45px;color: #529bff;" onclick="addOneCustomer();">+添加一位旅客</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <div style="height: 70px;margin-left: 50px">
  	<form action="" id="route">
  		<input type="hidden" name="orderNo" value="${order.order_no }">
  		<span style="color:#666666">联系人姓名</span><span style="color:#e00000">*</span>:
  		<input type="text" name="routeUsername" class="inputContact" style="width: 150px;" 
  		<c:if test="${empty order.routeUsername  }">
  			value="${loginUser.cusName }"
  		</c:if>
  		<c:if test="${!empty order.routeUsername }">
  			value="${order.routeUsername }"
  		</c:if>
  		>
  		<span style="color:#666666">联系手机</span><span style="color:#e00000">*</span>:
  		<input type="text" name="routeTel" class="inputContact" style="width: 150px;"
  		<c:if test="${empty order.routeTel  }">
  			value="${loginUser.cusTel }"
  		</c:if>
  		<c:if test="${!empty order.routeTel }">
  			value="${order.routeTel }"
  		</c:if>
  		 >
  		<span style="color:#666666">邮箱</span><span style="color:#e00000">*</span>:
  		<input type="text" name="routeEmail" class="inputContact" style="width:200px"
  		<c:if test="${empty order.routeEmail  }">
  			value="${loginUser.cusEmail }"
  		</c:if>
  		<c:if test="${!empty order.routeEmail }">
  			value="${order.routeEmail }"
  		</c:if>
  		 >
  		<a href="javascript:void(0);" class="savebtn" id="saveRouteUser">保存</a>
  	</form>
  </div>
  
  
  
</div>
<script type="text/javascript">

function addOneCustomer(){
	var max = parseInt('${order.adult_cnt}');
	var html = '<div class="main_info">'+model+'</div>';
	var n = $(".main_info").length;
	if(max>n){
		$("#main").append(html);
	}else{
		alert("本次行程最大出行人数为"+max+"人");
	}
}



//获取数据
function ajaxRequestData(obj) {
	var parentId = $(obj).attr("cityId");
	var selectId = $(obj).parent().parent().attr("child");
	var font = $(obj).parent().parent().prev().find("font");
	var name = $(obj).parent().parent().attr("name")
	$(obj).parents("form").find("input[name='"+name+"']").val(parentId);
	$(font).html($(obj).html());
	if(parentId==null||parentId==''){
		return false;
	}
	$.ajax({
		type : "post",
		url : "<%=basePath%>city/ajaxGetCityList.html",
		data : {
			"parentId" : parentId
		},
		cache : false,
		dataType : 'json',
		beforeSend : function() {
		},
		success : function(data) {
			changeSelect(data,obj);
		}
	});
}

//改变下拉框
function changeSelect(data,obj){
	var json = data.rows;
	var html ='<li><a href="javascript:void(0)" cityId="" onclick="ajaxRequestData(this)">请选择</a></li>';
	for(var i = 0;i<json.length;i++){
		var selected='';
		html = html+'<li><a href="javascript:void(0)" cityId="'+json[i].id+'" onclick="ajaxRequestData(this)">'+json[i].cityName+'</a></li>';
	}
	var child = $(obj).parents("ul").attr("child");
	$(obj).parents("form").find("."+child).html(html);
}


function getNowYear(){
	var myDate = new Date();
	var year = myDate.getYear();
}

function setYearHtml(){
	var myDate = new Date();
	var year = myDate.getFullYear();
	var html = '';
	for(var i=parseInt(year);i>1920;i--){
		html = html+'<li><a href="javascript:void(0)" onclick="year(this)">'+i+'</a></li>';
	}
	var fontYear = $(".fontYear");
	for(var i=0;i<fontYear.length;i++){
		if($(fontYear).eq(i).html().trim()==''){
			$(fontYear).eq(i).html(year);
		}
	}
	$(".year").html(html);
}

 function getDay(month,obj){
	 var year = '';
	 if(obj==null){
		 year = $(".fontYear").html().substring(0,4);
	 }else{
		 year = $(obj).parents("td").find(".fontYear").html().substring(0,4);
	 }
	 var d = DayNumOfMonth(year, month);
	 var html = '';
	for(var i=1;i<=parseInt(d);i++){
		html = html+'<li><a href="javascript:void(0)" onclick="day(this)">'+i+'日</a></li>';
	}
	if(obj==null){
		if($(".fontMonth").html().trim()==''){
			$(".fontMonth").html(month+"月");
		}
		$(".fontMonth").html(month+"月");
		$(".day").html(html);
	}else{
		if($(obj).parents("td").find(".fontMonth").html().trim()==''){
			$(obj).parents("td").find(".fontMonth").html(month+"月");
		}
		$(obj).parents("td").find(".fontMonth").html(month+"月");
		$(obj).parents("td").find(".day").html(html);
	}
 }
 
 function year(obj){
	 var d = $(obj).html();
	 $(obj).parents("td").find(".fontYear").html(d);
	var month =  $(obj).parents("td").find(".fontMonth").html().split("月")[0];
	getDay(month,obj);
	 
 }
 function day(obj){
	 var d = $(obj).html();
	 $(".fontDay").html(d);
 }
function DayNumOfMonth(Year, Month) {
	var d = new Date(Year, Month, 0);
	return d.getDate();
}


function setImage(obj){
	var path = URL.createObjectURL(obj.files[0]);
	$(obj).parents("tr").next().find("img").attr("src",path);
	$(obj).parent().parent().parent().parent().find("img").attr("width","444");
	$(obj).parent().parent().parent().parent().find("img").attr("height","312");
}

var ischeckedArray = new Array();

function cusIsChecked(obj){
	var index = $(obj).attr("index");
	var old = $(obj).parents(".p_list").find("img");
	var oldIndex='';
	for(var i=0;i<old.length;i++){
		if($(old).eq(i).attr("ischecked")=="true"){
			oldIndex = $(old).eq(i).parent().attr("index")
		}
	}
	$(obj).parents(".p_list").find("img").attr("ischecked",false);
	var ischecked = $(obj).find("img").eq(0).attr("ischecked");
	if(ischecked=="true"){
		return;
	}
	if(ischeckedArray.contains(index) ){
		alert("该旅客信息已存在，不能重复添加");
		return;
	}
	$(obj).find("img").attr("ischecked",true);
	var rowsStr = eval("("+'${rowsStr}'+")");
	var form_style = $(obj).parents(".main_info").find(".form_style");
	rowsStr = rowsStr[index];
	var birthday = rowsStr.birthday;
	var customerName = rowsStr.customerName;
	var id = rowsStr.id;
	var cardType = rowsStr.cardType;
	var cardNumber = rowsStr.cardNumber;
	var realName = rowsStr.realName;
	var isUse = rowsStr.isUse;
	
	var form1 = $(form_style).find("form").eq(0);
	var form2 = $(form_style).find("form").eq(1);
	
	$(form1).find("input[name='realName']").val(realName);
	$(form1).find("input[name='customerName']").val(customerName);
	$(form1).find("input[name='cardNumber']").val(cardNumber);
	$(form1).find("select[name='cardType']").val(cardType);
	$(form1).find("input[name='id']").val(id);
	$(form1).find("input[name='isUse']").val(isUse);
	$(form_style).find(".btn_group").find("input").attr("checked",true);
	
	var date = new Date(birthday);
	var year = date.getFullYear();
	var month = date.getMonth();
	var day = date.getDate();
	$(form1).find(".fontYear").html(year);
	$(form1).find(".fontMonth").html(month+"月");
	$(form1).find(".fontDay").html(day+"日");
	
	var d = new Date(year+'-'+month+'-'+day);
	$(form1).find("input[name='birthday']").val(d);
	
	
	ischeckedArray.splice($.inArray(oldIndex,ischeckedArray),1);
	ischeckedArray.push(index);
	$(obj).parents(".p_list").find("img").attr("src","http://www.imyway.cn:80/assets/img/UI/check.png");
	$(obj).find("img").attr("src","http://www.imyway.cn:80/assets/img/UI/checked.png");
	
}

function initCheckedArray(){
	var p_list = $(".p_list");
	for(var i =0;i<p_list.length;i++){
		var a = $(p_list).eq(i).find("a");
		for(var j=0;j<a.length;j++){
			var ischecked = $(a).eq(j).find("img").eq(0).attr("ischecked");
			if(ischecked=="true"){
				ischeckedArray.push($(a).eq(j).attr("index"));
			}
		}
	}
}



Array.prototype.contains = function(item){
    return RegExp(item).test(this);
};
var arr = [];
for (var i = 10; i < 15; i++) {
    arr.push(i);
}




function showSubList(eleid,className,status){
	var borderColor = '#4FC384';
	if(className == 'dfk'){
		borderColor = '#E1586C';
	}else if(className == 'ywc'){
		borderColor = '#ccc';
	}else if(className == 'dcx'){
		borderColor = '#F3AE49';
	}
	if($("#"+eleid).is(":hidden")){
		$("#"+eleid).show();
		$("#"+eleid+"_tr").css({"background-color":"#f6f6f6"});
		$("#"+eleid+"_tr>td>.order_date").css("background-color","#fff");
		$("#"+eleid+"_tr>td>.right_content").css("background-color","#fff");
		$("#"+eleid+"_table").attr("style","");
		$("#"+eleid+"_table").css("border","1px solid "+borderColor);
		shCircleLoaderLoading();
		$.ajax({
			type: "GET",	
			url: "<%=request.getContextPath()%>/personal/myorderlist.html",
			data: {orderNo: eleid,status: status },
			async: false,
			dataType: "html",
			success: function(htmlData){
				$("#"+eleid).empty().html(htmlData);
				shCircleLoaderDestroy();
			},
			error: function (msg) {
				alert("error");   
				shCircleLoaderDestroy();
	        }
		});
	}else{
		$("#"+eleid).hide();
		$("#"+eleid+"_tr").css({"background-color":"transparent"});
		$("#"+eleid+"_table").css("border-left","0");
		$("#"+eleid+"_table").css("border-bottom","0");
		$("#"+eleid+"_table").css("border-right","0");
		$("#"+eleid).empty();
	}
}

function cusAgeInfo(){
	$.ajax({
		type : "post",
		url : "<%=basePath%>personal/cusAgeInfo.html",
		data : {"orderNo":'${order.order_no }'},
		cache : false,
		dataType : 'json',
		beforeSend : function() {
		},
		success : function(data) {
			var adultCount = data.adultCount;
			var childCount = data.childCount;
			var babyCount = data.babyCount;
			/*
			var html = '';
			if(adultCount>=0){
				html = html+adultCount+'成人';
			}
			if(childCount>0){
				html = html+childCount+'儿童';
			}
			if(babyCount>0){
				html = html+babyCount+'婴儿';
			}
			$("#cusAgeInfo").html(html);
			*/
			
			$("#adCnt").html(adultCount);
			$("#chCnt").html(childCount);
			$("#baCnt").html(babyCount);
		}
	});
}

//保存
function addCus(obj){
	var form = $(obj).parent().parent().find("form").eq(0);
	var yearStr = $(form).find(".fontYear").html();
	var monthStr = $(form).find(".fontMonth").html();
	var dayStr = $(form).find(".fontDay").html();
	var month = monthStr.split("月")[0];
	var day = dayStr.split("日")[0];
	var d = new Date(yearStr,month-1,day);
	$(form).find("input[name='birthday']").val(d);
	
	var realName = $(form).find("input[name='realName']").val().trim();
	var customerName = $(form).find("input[name='customerName']").val().trim();
	var cardNumber = $(form).find("input[name='cardNumber']").val().trim();
	
	if($(obj).parent().find("input").attr("checked")){
	 	$(form).find("input[name='isUse']").val(0);
	}else{
	 	$(form).find("input[name='isUse']").val(1);
	}
	
	if(isNull(realName)){
		alert("请填写真实姓名");
		return false;
	}
	if(isNull(customerName)){
		alert("请填写真实姓名拼音");
		return false;
	}
	if(isNull(cardNumber)){
		alert("请填证件号码 ");
		return false;
	}
	
	$.ajax({
		type : "post",
		url : "<%=basePath%>personal/addPeerInfo.html",
		data : $(form).serialize(),
		cache : false,
		dataType : 'json',
		beforeSend : function() {
		},
		success : function(data) {
			$(form).find("input[name='id']").val(data.id);
			$(form).find("input[name='bookCusId']").val(data.bookCusId);
			cusAgeInfo();
			alert("旅客信息添加成功");
		}
	});
};
// 删除
function deleteCus(obj){
	
	var form = $(obj).parent().parent().find("form").eq(0);
	var id = $(form).find("input[name='id']").val();
	if(id==null || id==0){
		$(obj).parents(".main_info").remove();
		return false;
	}
	$.ajax({
		type : "post",
		url : "<%=basePath%>personal/deletePeerInfo.html",
		data : {"cusNo":id,"orderNo":'${order.order_no }'},
		cache : false,
		dataType : 'json',
		beforeSend : function() {
		},
		success : function(data) {
			$(obj).parents(".main_info").remove();
			cusAgeInfo();
		}
	});
}

var model='';
$(function(){
	setYearHtml();
	getDay(1,null);
	model = $(".main_info:last").html();
	initCheckedArray();
	
	// 订单联系人
	$("#saveRouteUser").click(function(){
		var routeUsername = $("#route").find("input[name='routeUsername']").val().trim();
		var routeTel = $("#route").find("input[name='routeTel']").val().trim();
		var routeEmail = $("#route").find("input[name='routeEmail']").val().trim();
		if(isNull(routeUsername)){
			alert("请填写联系人姓名");
			return false;
		}
		if(isNull(routeTel)){
			alert("请填写联系电话");
			return false;
		}
		if(!checkMobile(routeTel)){
			alert("请填写正确的联系电话");
			return false;
		}
		if(isNull(routeEmail)){
			alert("请填写邮箱");
			return false;
		}
		$.ajax({
			type : "post",
			url : "<%=basePath%>personal/addRouteUser.html",
			data : $("#route").serialize(),
			cache : false,
			dataType : 'json',
			beforeSend : function() {
			},
			success : function(data) {
				window.location.href="<%=basePath%>personal/myorder.html?page=1&pageSize=10";
			}
		});
	});
	
	
	$(".tags-nav").find("a").removeClass("active");
	$(".tags-nav").find("a").eq(0).addClass("active");
	
	if($(".info_table>tbody>tr>td>.stat_bar>.bar")){
		var bar = $(".info_table>tbody>tr>td>.stat_bar>.bar");
		bar.css("width",bar.data("width")+"px");
	}
});

</script>

</body>
</html>