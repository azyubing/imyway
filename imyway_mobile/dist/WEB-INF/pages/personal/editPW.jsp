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
<link href="<%=basePath%>assets/css/editPW.css" rel="stylesheet" type="text/css">

</head>
<body>
<!-- === main -->
<div id="login_main" style="background-image: url('<%=basePath%>assets/img/personal/login_bak.jpg');">
<form id="login" method="post" >
	<div id="main" >
		<div class="e_title">修改密码</div>
		<div class="inf">原密码</div>
		<div class="txt"><input type="password" placeholder="请输入原密码" id="oldpw" name="oldpw" title="密码"></div>
		<div class="inf" style="margin-top: 20px;">设置密码</div>
		<div class="txt"><input type="password" placeholder="请输入密码" id="newpw" name="newpw" title="密码"></div>
		<div class="inf" style="margin-top: 20px;">确认密码</div>
		<div class="txt"><input type="password" placeholder="请再次输入密码" id="confirmpw" name="confirmpw" title="再次输入密码"></div>
		<div class="clr"></div>
		<div style="margin-top: 30px;"><button type="button" class="btn" id="confirmBtn">确认修改</button></div>
		<div class="clr"></div>
	</div>
</form>
</div>
<!-- ===End main -->

<!-- Page level JS -->
<script type="text/javascript" src="<%=basePath%>assets/js/javascriptCheck.js"></script>
<script type="text/javascript">
$(function(){
	$(".tags-nav").find("a").removeClass("active");
	$(".tags-nav").find("a").eq(4).addClass("active");
	$("#confirmBtn").click(function(){
		var newpw = $("#newpw").val().trim();
		var confirmpw = $("#confirmpw").val().trim();
		var oldpw = $("#oldpw").val().trim();
		if(isNull(oldpw)){
			alert("请输入原密码");
			return false;
		}
		if(isNull(newpw)){
			alert("请输入密码");
			return false;
		}
		if(isNull(confirmpw)){
			alert("请填写确认密码");
			return false;
		}
		if(newpw != confirmpw){
			alert("两次密码不一致，请重新填写");
			return false;
		}
		$.ajax({
	        type:'post',        
	        url:'<%=basePath%>personal/updatePW.html',    
	        data:{"newpw":newpw,"oldpw":oldpw},    
	        async:true,    
	        dataType:'text',    
	        success:function(data){
	        	if(data == '' || data == null){
	        		alert('操作失败，请稍后重试');
	        	}else{
		        	alert(data);
		        	$("#oldpw").val('');
		        	$("#newpw").val('');
		        	 $("#confirmpw").val('');
	        	}
	        }    
	    });
	})
});


</script>

</body>
</html>