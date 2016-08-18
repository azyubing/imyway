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
<link href="<%=basePath%>assets/css/myorder.css" rel="stylesheet" type="text/css">

</head>
<body>
<!-- ===info main -->
<div id="contact_main" >
  <div id="main">
	<div class="title_nav">
		<a href="javascript:void(0);" class="active" onclick="window.location.href='<%=basePath%>personal/myorder.html?page=1&pageSize=10'">全部订单</a>
		<a href="javascript:void(0);" onclick="window.location.href='<%=basePath%>personal/myorder.html?status=1&page=1&pageSize=10'">待付款订单</a>
		<a href="javascript:void(0);" onclick="window.location.href='<%=basePath%>personal/myorder.html?status=2&page=1&pageSize=10'">待处理订单</a>
		<a href="javascript:void(0);" onclick="window.location.href='<%=basePath%>personal/myorder.html?status=4&page=1&pageSize=10'">待出行订单</a>
		<a href="javascript:void(0);" onclick="window.location.href='<%=basePath%>personal/myorder.html?status=5&page=1&pageSize=10'">已完成订单</a>
	</div>
	<div class="info_list">
		<table class="h_table">
			<colgroup><col class="col1"><col class="col2"><col class="col3"><col class="col4"><col class="col5"></colgroup>
			<tr>
				<td class="pl_20">行程日期</td>
				<td>订单金额</td>
				<td>已付款</td>
				<td>待付款</td>
				<td>状态</td>
				<td>&nbsp;</td>
			</tr>
		</table>

		<!--info list table -->
		<c:forEach items="${pageResult.pageResultList }" var="row" >
			<table class="info_table 
			<c:choose>
				<c:when test="${row.status==1 }">dfk</c:when>
				<c:when test="${row.status==2 }">dcl</c:when>
				<c:when test="${row.status==4 }">dcx</c:when>
				<c:when test="${row.status==5 }">ywc</c:when>
				<c:when test="${row.status==6 }">'dfk'</c:when>
				<c:when test="${row.status==8 }">'dfk'</c:when>
				<c:when test="${row.status==9 }">'ywc'</c:when>
				<c:otherwise>dcl</c:otherwise>
			</c:choose>
			" id="${row.order_no }_table">
				<colgroup><col class="col1"><col class="col2"><col class="col3"><col class="col4"><col class="col5"></colgroup>
				<thead>
					<tr>
						<td class="pl_20" colspan="5"><span class="bold">${row.startCountryName }</span><span>${row.startCityName }&nbsp;-&nbsp;<span class="bold">${row.endCountryName }</span>${row.endCityName }</span></td>
						<td><span class="order_time">订单时间：<fmt:formatDate value="${row.ctdt}" type="both" pattern="yyyy-MM-dd"/></span><span class="order_id">订单编号：${row.order_no }</span></td>
					</tr>
				</thead>
				<tbody>
					<tr id="${row.order_no }_tr">
						<td class="pl_20 rel">
							<span class="order_date mr_2"><fmt:formatDate value="${row.startdate}" type="both" pattern="MM"/>&nbsp;/&nbsp;<fmt:formatDate value="${row.startdate}" type="both" pattern="dd"/></span>
							<span class="order_date"><fmt:formatDate value="${row.enddate}" type="both" pattern="MM"/>&nbsp;/&nbsp;<fmt:formatDate value="${row.enddate}" type="both" pattern="dd"/></span>
							<img class="arrow" src="<%=basePath%>assets/img/personal/arrow.png">
						</td>
						<td><span class="red"><fmt:formatNumber value="${row.amount }" type="currency" pattern="¥0.00"/></span></td>
						<td>
						<c:if test="${row.status==1 }">
							¥0.00
						</c:if>
						<c:if test="${row.status==2||row.status==3 }">
							<fmt:formatNumber value="${row.amount }" type="currency" pattern="¥0.00"/>
						</c:if>
						<c:if test="${row.status==4||row.status==5 }">
							<fmt:formatNumber value="${row.amount }" type="currency" pattern="¥0.00"/>
						</c:if>
						</td>
						<td>
							<c:if test="${row.status==1 }">
								<fmt:formatNumber value="${row.amount }" type="currency" pattern="¥0.00"/>
							</c:if>
							<c:if test="${row.status==2||row.status==3 }">
								¥0.00
							</c:if>
							<c:if test="${row.status==4||row.status==5 }">
								¥0.00
							</c:if>
						</td>
						<td>
							<div class="stat">
								<span class="fl">
								<c:if test="${row.status==1 }">
									待付款
								</c:if>
								<c:if test="${row.status==2 }">
									待处理
								</c:if>
								<c:if test="${row.status==3 }">
									待付尾款
								</c:if>
								<c:if test="${row.status==4 }">
									待出行
								</c:if>
								<c:if test="${row.status==5 }">
									已完成
								</c:if>
								<c:if test="${row.status==6 }">
									出行中
								</c:if>
								<c:if test="${row.status==8 }">
									支付中
								</c:if>
								<c:if test="${row.status==9 }">
									已退款
								</c:if>
								</span>
								<c:if test="${row.status==2 }">
									<span class="fr mr_53">
										${row.percent}
									</span>
								</c:if>
							</div>
							<div class="clr"></div>  
							<c:if test="${row.status==2 }">
								<c:if test="${empty row.percent}">
									<div class="stat_bar"><div class="bar" data-width="0">&nbsp;</div></div>
								</c:if>
								<c:if test="${not empty row.percent}">
									<div class="stat_bar"><div class="bar" data-width="${fn:split(row.percent, '%')[0]  }">&nbsp;</div></div>
								</c:if>
							</c:if>
						</td>
						<td>
							<div class="fl">
								<!-- 
								<img class="ewm" src="<%=basePath%>assets/img/personal/ewm.png">&nbsp;&nbsp;联络客服
								 -->
								<c:if test="${row.status==1 }">
									<a class="btn btn_style" href="<%=basePath%>personal/peerInfo.html?orderNo=${row.order_no}" style="border: 1px solid #e5e5e5;background-color: #fff;color: #666;"><img alt="" src="<%=basePath%>assets/img/personal/group_icon2.png">&nbsp;&nbsp;&nbsp;填写同行人信息&nbsp;&nbsp;</a>
									<c:if test="${row.routeUsername!=null }">
									<button class="btn btn_style_1 ml_0" onclick="goPay('${row.order_no}')" >结算</button>
									</c:if>
									<button class="btn btn_style_1 ml_0" onclick="deleteOrder('${row.order_no}')" >删除</button>
								</c:if>
								<c:if test="${row.status==5}">
									<!-- <button class="btn btn_style ml_0">评价</button> -->	
								</c:if>
							</div>
							<div class="fr right_content"><a href="javascript:void(0);"  onclick="showSubList('${row.order_no}',
							<c:choose>
								<c:when test="${row.status==1 }">'dfk'</c:when>
								<c:when test="${row.status==2 }">'dcl'</c:when>
								<c:when test="${row.status==4 }">'dcx'</c:when>
								<c:when test="${row.status==5 }">'ywc'</c:when>
								<c:when test="${row.status==6 }">'dfk'</c:when>
								<c:when test="${row.status==8 }">'dfk'</c:when>
								<c:when test="${row.status==9 }">'ywc'</c:when>
								<c:otherwise>'dcl'</c:otherwise>
							</c:choose>,
							'${row.status}');"><img id="${row.order_no}_arrow_img" class="down_arrow" src="<%=basePath%>assets/img/personal/down_arrow.png"></a></div>
							<div class="clr"></div>
						</td>
					</tr>
					<tr id="${row.order_no}" class="sub_data" style="display: none;">
						
					</tr>
				</tbody>
			</table>
		</c:forEach>	
	</div>
	<div id="pagination">
		<ul>
			<c:if test="${pageResult.currPage>1 }">
				<li class="l_arrow"><a href="<%=basePath%>personal/myorder.html?pageSize=10&status=${status}&page=${pageResult.currPage-1 }"><img alt="" src="<%=basePath%>assets/img/personal/la.png"></a></li>
			</c:if>
			
			<c:if test="${pageResult.pageCount<7 && pageResult.currPage<7 && pageResult.pageCount>0 }" >
				<c:forEach end="${pageResult.pageCount }" var="page" begin="1" >
					<li class="l_arrow"><a href="<%=basePath%>personal/myorder.html?pageSize=10&status=${status}&page=${page}"
						<c:if test="${pageResult.currPage==page }">
							class="active"
						</c:if>
					>${page}</a>
					</li>
				</c:forEach>
			</c:if>
			
			<c:if test="${pageResult.pageCount>=7 && pageResult.currPage>=7}" >
				<li>...</li>
				<li class="l_arrow"><a href="<%=basePath%>personal/myorder.html?pageSize=10&status=${status}&page=${pageResult.currPage-2}"></a></li>
				<li class="l_arrow"><a href="<%=basePath%>personal/myorder.html?pageSize=10&status=${status}&page=${pageResult.currPage-1}"></a></li>
				<li class="l_arrow"><a href="<%=basePath%>personal/myorder.html?pageSize=10&status=${status}&page=${pageResult.currPage}" class="active"></a></li>
				<c:if test="${pageResult.pageCount!=pageResult.currPage }">
					<c:if test="${pageResult.pageCount<=pageResult.currPage+2 && pageResult.pageCount>pageResult.currPage}">
						<c:forEach begin="${pageResult.currPage+1 }" end="${pageResult.pageCount }" var="page">
							<li class="l_arrow"><a href="<%=basePath%>personal/myorder.html?pageSize=10&status=${status}&page=${page}"></a></li>
						</c:forEach>
					</c:if>
					
					<c:if test="${pageResult.pageCount>pageResult.currPage+2 }">
						<li class="l_arrow"><a href="<%=basePath%>personal/myorder.html?pageSize=10&status=${status}&page=${pageResult.currPage+1}"></a></li>
						<li class="l_arrow"><a href="<%=basePath%>personal/myorder.html?pageSize=10&status=${status}&page=${pageResult.currPage+2}"></a></li>
						<li>...</li>
					</c:if>
				</c:if>
			</c:if>
			<c:if test="${pageResult.pageCount >pageResult.currPage }">
				<li class="l_arrow"><a href="<%=basePath%>personal/myorder.html?pageSize=10&status=${status}&page=${pageResult.currPage+1 }"><img alt="" src="<%=basePath%>assets/img/personal/ra.png"></a></li>
			</c:if>
		</ul>
	</div>
	<div class="clr"></div>
  </div>
</div>
<!-- ===End info main -->

<!-- Page level JS -->
<script type="text/javascript">
function goPay(orderid){
	window.location.href="<%=basePath%>personal/mypay.html?orderNo=" + orderid;
}
function deleteOrder(orderid){
	$.ajax({
		type: "post",	
		url: "<%=basePath%>personal/deleteOrder.html",
		data: {orderNo: orderid },
		async: false,
		dataType: "text",
		success: function(data){
			if(data=="success"){
				window.location.href='<%=basePath%>personal/myorder.html?pageSize=10&status=${status}&page=1';
			}
		},
		error: function (msg) {
			alert("error");   
			shCircleLoaderDestroy();
        }
	});
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
		$("#"+eleid+"_tr>td>div>.btn_style>img").attr("src","<%=basePath%>assets/img/personal/group_icon1.png");
		$("#"+eleid+"_tr>td>div>.btn_style").css({"background-color":"#f6f6f6","color":"#529BFF","border":"0"});
		$("#"+eleid+"_tr>td>div>.btn_style_1").css({"background-color":"#f6f6f6","color":"#529BFF","border":"0"});
		$("#"+eleid+"_table").attr("style","");
		$("#"+eleid+"_table").css("border","1px solid "+borderColor);
		$("#"+eleid+"_arrow_img").attr("src","<%=basePath%>assets/img/personal/up_arrow.png")
		shCircleLoaderLoading();
		$.ajax({
			type: "GET",	
			url: "<%=request.getContextPath()%>/personal/myorderlist.html",
			data: {orderNo: eleid ,status: status },
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
		$("#"+eleid+"_tr>td>div>.btn_style>img").attr("src","<%=basePath%>assets/img/personal/group_icon2.png");
		$("#"+eleid+"_arrow_img").attr("src","<%=basePath%>assets/img/personal/down_arrow.png")
		$("#"+eleid+"_tr>td>div>.btn_style").css({"background-color":"#fff","color":"#666","border":"1px solid #e5e5e5"});
		$("#"+eleid+"_tr>td>div>.btn_style_1").css({"background-color":"#529BFF","color":"#fff","border":"0"});
		$("#"+eleid).empty();
	}
}

$(function(){
	$(".tags-nav").find("a").removeClass("active");
	$(".tags-nav").find("a").eq(0).addClass("active");
	$(".title_nav").find("a").removeClass("active");
	var status = '${status}';
	if(status==null||status==''){
		$(".title_nav").find("a").eq(0).addClass("active");
	}else if(status==1){
		$(".title_nav").find("a").eq(1).addClass("active");
	}else if(status==2){
		$(".title_nav").find("a").eq(2).addClass("active");
	}else if(status==4){
		$(".title_nav").find("a").eq(3).addClass("active");
	}else if(status==5){
		$(".title_nav").find("a").eq(4).addClass("active");
	}
	
	$(".bar").each(function(){
		$(this).css("width",$(this).data("width")+"px");
	  });
	
	/*
	if($(".info_table>tbody>tr>td>.stat_bar>.bar")){
		var bar = $(".info_table>tbody>tr>td>.stat_bar>.bar");
		alert(bar.lenght);
		bar.css("width",bar.data("width")+"px");
	}
	*/
	
});
</script>

</body>
</html>