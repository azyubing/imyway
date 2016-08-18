<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<link href="<%=basePath%>assets/css/paysuccess.css" rel="stylesheet" type="text/css">

</head>
<body>
<!-- === main -->
<div id="main" >
	<div id="main_content" >
		<div class="up_content">
			<div class="fl l_c"><img src="<%=basePath%>assets/img/UI/success.png"></div>
			<div class="fr r_c">
				<p class="p1">麦味旅行提醒您！</p>
				<c:if test="${ paysts == 'ok'}">
				<p class="p2">订单支付成功</p>
				</c:if>
				<c:if test="${ paysts == 'ng'}">
				<p class="p2">订单支付状态确认中</p>
				</c:if>
			</div>
			<div class="clr"></div>
		</div>
		<div class="down_content">
			<p class="p3">您的订单号为：<span class="order">${orderNo}</span>&nbsp;&nbsp;&nbsp;&nbsp;您本次的交易金额是：<span class="red">¥ ${amount}</span></p>
			<p class="p4">请到我的订单中查看订单状态</p>
			<p class="p5"><button type="button" class="btn btn-info" id="orderBtn">查看订单状态</button></p>
		</div>
	</div>
</div>
<!-- ===End main -->

<!-- Page level JS -->

<script type="text/javascript">
$(function(){
	$("#orderBtn").click(function(){
		var url = '<%=basePath%>personal/myorder.html?page=1&pageSize=10';
		window.location.href=url;
	});
});
</script>

</body>
</html>