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
			<div class="fl l_c"><img src="<%=basePath%>assets/img/UI/error.png"></div>
			<div class="fr r_c">
				<p class="p1">麦味旅行提醒您！</p>
				<p class="p2">邮箱激活失败</p>
			</div>
			<div class="clr"></div>
		</div>
		<div class="down_content">
			<p class="p3">请检查邮箱是否正确，重新发送验证邮件。</p>
			<br>
			<p class="p5"><button type="button" class="btn btn-info" id="orderBtn">返回上一步</button></p>
		</div>
	</div>
</div>
<!-- ===End main -->

<!-- Page level JS -->

<script type="text/javascript">
$(function(){

});
</script>

</body>
</html>