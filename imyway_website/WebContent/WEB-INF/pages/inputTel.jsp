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
<link href="<%=basePath%>assets/css/inputtel.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=basePath%>assets/js/javascriptCheck.js"></script>

</head>
<body>
<!-- === main -->
<div id="login_main" style="background-image: url('<%=basePath%>assets/img/personal/login_bak.jpg');">
<form id="login" method="post" >
	<div id="main" style="width:431px;position:relative;" >
		<div class="title"><img alt="" src="<%=basePath%>assets/img/phoneyz.png"></div>
		<div style="position:absolute;top:245px;width: 431px;color:red;" id="msg"></div>
		<div class="txt p" style="margin-bottom:8px"><input type="text" placeholder="请输入手机号" id="phone" name="phone" title="请输入手机号" style="padding-left:20px;"></div>
		<div class="txt l">
			<input type="text" placeholder="验证码" id="vcode" name="vcode" title="验证码" style="padding-left:20px">
			<input class="getbtn" type="button" value="获取验证码" onclick="sendCode(this)">
		</div>
		
		<div class="clr"></div>
		<div style="margin-top: 36px;"><button type="button" class="btn" id="loginBtn" onclick="settel()">确 认</button></div>
		
		<div class="clr"></div>
	</div>
	<input type="hidden" value="${weiid}" id="weiid"/>
</form>
</div>
<!-- ===End main -->

<!-- Page level JS -->
<script type="text/javascript" src="<%=basePath%>assets/js/javascriptCheck.js"></script>
<script type="text/javascript">

function settel(){
	$("#msg").html("");
	var phone = $("#phone").val().trim();
	var vcode = $("#vcode").val().trim();
	
	if(!checkMobile(phone)){
		$("#msg").html("请输入有效手机号码");
		return false;
	}
	if(isNull(vcode)||vcode.length != 4){
		$("#msg").html("请输入正确的验证码");
		return false;
	}
	$("#loginBtn").attr("disabled", true);
	$("#loginBtn").addClass("disableBtn");
	var weiid = $("#weiid").val();
	$.ajax({
        type:'post',        
        url:'<%=basePath%>/setphone.html',    
        data:{"weiid":weiid,"phone":phone,"vcode":vcode},    
        async:true,    
        dataType:'text',    
        success:function(data){
        	if(data != null && data != ""){
        		$("#msg").html(data);
        	}else{
	        	alert("手机号码设定成功！");
	        	<c:if test="${not empty nextUrl}">
        		window.location.href="${nextUrl}";
	        	</c:if>
	        	<c:if test="${empty nextUrl}">
	        	window.location.href="<%=basePath%>home.html"
	        	</c:if>
        	}
        	$("#loginBtn").removeAttr("disabled");
    		$("#loginBtn").removeClass("disableBtn");
        }    
    });
}
function sendCode(obj){
	$("#msg").html("");
	var tel = $("#phone").val();
	if(!checkMobile(tel)){
		$("#msg").html("请输入有效手机号码");
		return false;
	}
	$.ajax({    
        type:'post', 
        url:"<%=basePath%>sendCodeByTel.html",    
        data:{"tel":tel},    
        cache:false,    
        dataType:'text',    
        success:function(data){
        	settime(obj);
        }    
    });
	$("#vcode").val("");
}

var countdown = 60;
function settime(obj) {
	if (countdown == 0) {
		$(obj).removeAttr("disabled");
		$(obj).removeClass("disableBtn");
		$(obj).val("获取验证码");
		countdown = 60;
		return;
	} else {
		$(obj).attr("disabled", true);
		$(obj).addClass("disableBtn");
		$(obj).val("重新发送(" + countdown + ")");
		countdown--;
	}
	setTimeout(function() {
		settime(obj);
	}, 1000)
}

document.onkeydown=function(e){
	var keycode=document.all?event.keyCode:e.which;
	if(keycode==13){
		settel();
	}
}
</script>

</body>
</html>