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
			<c:if test="${vrifysts == 'ok' }">
			<div class="fl l_c"><img src="<%=basePath%>assets/img/UI/success.png"></div>
			<div class="fr r_c">
				<p class="pmail">邮箱激活成功!</p>
			</div>
			<div class="clr"></div>
			</c:if>
			<c:if test="${vrifysts != 'ok' }">
			<div class="fl l_c"><img src="<%=basePath%>assets/img/UI/error.png"></div>
			<div class="fr r_c">
				<p class="pmail">邮箱激活失败!</p>
			</div>
			<div class="clr"></div>
			</c:if>
		</div>
		<div class="down_content">
			<c:if test="${vrifysts == 'ok' }">
			<p class="p3">请点击&nbsp;<a class="order" href="${gourl}">登录</a>,开始您的麦味之旅。</p>
			</c:if>
			<c:if test="${vrifysts != 'ok' }">
			<p class="p3">请点击&nbsp;<a class="order" href="${gourl}">再次注册</a>，重新注册您的账户。</p>
			</c:if>
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