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
    
    String weichatback = "http%3A%2F%2Fwww.imyway.cn%2Fimyway%2Fwchatlogin.html%3fnextUrl%3d";
    if(path == null || "".equals(path)){
    	weichatback = "http%3A%2F%2Fwww.imyway.cn%2Fwchatlogin.html%3fnextUrl%3d";
    }
%>
<!DOCTYPE html>
<html>
<head>
<!-- page level -->
<link href="<%=basePath%>assets/css/login.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=basePath%>assets/js/javascriptCheck.js"></script>
</head>
<body>
<!-- ===login main -->
<div id="login_main" style="background-image: url('<%=basePath%>assets/img/personal/login_bak.jpg');">
<form id="login" name="login" method="post">
	<div id="main" >
		<div class="title"><img alt="" src="<%=basePath%>assets/img/personal/login_t.jpg"></div>
		<div class="txt p"><img alt="" src="<%=basePath%>assets/img/personal/login_p.jpg"><input type="text" placeholder="用户名" id="username" name="username" title="用户名"></div>
		<div class="txt l"><img alt="" src="<%=basePath%>assets/img/personal/login_l.jpg"><input type="password" placeholder="密码" id="password" name="password" title="密码"></div>
		<div class="inf">
			<span class="fl">
				<a href="javascript:checkFun()"><img id="checkImg" src="<%=basePath%>assets/img/personal/check1.png" width="18" height="18"></a>
				&nbsp;记住我<input type="hidden" id="checkVal" value="0">
			</span>
			<a class="fr" href="#" onclick="openModal();">忘记密码？</a>
		</div>
		<div class="clr"></div>
		<div style="margin-top: 20px;"><button type="button" class="btn" id="loginBtn">立即登录</button></div>
		<div class="other"><span class="fl" style="height: 32px;line-height: 32px;">第三方帐号登录</span>
			<span class="fr">
				<a href="https://open.weixin.qq.com/connect/qrconnect?appid=wxa4a9620e264e143f&redirect_uri=<%=weichatback%>${nextUrlenCode}&response_type=code&scope=snsapi_login&state=STATE#wechat_redirect">
				<img alt="" src="<%=basePath%>assets/img/personal/wx_icon.png">
				</a>
			</span>
		</div>
		<div class="clr"></div>
	</div>
</form>
</div>
<!-- ===End login main -->


<!-- send mail model -->
<div class="modal fade bs-example-modal-sm" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-sm" style="margin-top: 100px;">
        <div class="modal-content">
            <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
               <h4>找回密码</h4>
           </div>
           <div class="modal-body">
      	   		<p class="p1" id="changeType"><a href="javascript:void(0)" onclick="changeType('email')">邮箱</a>&nbsp;&nbsp;&nbsp;<span></span>&nbsp;&nbsp;&nbsp;<span style="border:0px;">手机</span></p>
      	   		<div class="txt p">
      	   			<input	type="hidden" id="checkType" value="0">
      	   			<input	type="hidden" id="changeUsername" value="">
					<input type="text" name="tel" id="tel" placeholder="请输入手机号码" title="请输入手机号码">
					<input type="text" name="email" id="email" placeholder="请输入邮箱" title="请输入邮箱" style="display: none;">
				</div>
				<div class="txt yzm_content">
					<div class="txt p yzm fl"><input type="text" name="checkTelCode" id="checkTelCode" placeholder="验证码" title="验证码"></div>
					<div class="fr p"><input type="button" class="btn" id="yzmBtn" onclick="sendCode('tel')" value="发送验证码"></div>
				</div>
				<div class="clr"></div>
				<div><a href="javascript:void(0)"  class="btn" id="confirmBtn">提交</a></div>
           </div>
       </div>
   </div>
</div>
<!-- end send mail model -->

<!-- Page level JS -->
<script type="text/javascript">
<c:if test="${msg ne null}">
	alert('${msg}');
</c:if>

function openModal(){
	var username = $("#username").val();
	if(username == null || username == ''){
		alert("请输入要找回密码的用户名。");
		return false;
	}
	$("#myModal").modal('show');
}
function changeType(type){
	if(type=='email'){
		$("#changeType").empty().append('<span >邮箱&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="changeType(\'tel\')">手机</a>');		
		$("#tel").val('').hide();
		$("#email").show();
		$("#checkType").val(1);
		$("#yzmBtn").attr("onclick", "sendCode('email')");
		$("#checkTelCode").val('');
	}else if(type="tel"){
		$("#changeType").empty().append('<a href="javascript:void(0)" onclick="changeType(\'email\')">邮箱</a>&nbsp;&nbsp;&nbsp;<span></span>&nbsp;&nbsp;&nbsp;<span style="border:0px;">手机</span>');
		$("#email").val('').hide();
		$("#tel").show();
		$("#checkType").val(0);
		$("#yzmBtn").attr("onclick", "sendCode('tel')");
		$("#checkTelCode").val('');
	}else{
		return;
	}
}


var countdown = 60;
function settime() {
	if (countdown == 0) {
		$("#yzmBtn").removeAttr("disabled");
		$("#yzmBtn").val("免费获取验证码");
		countdown = 60;
		return;
	} else {
		$("#yzmBtn").attr("disabled", true);
		$("#yzmBtn").val("重新发送(" + countdown + ")");
		countdown--;
	}
	setTimeout(function() {
		settime();
	}, 1000)
}

function sendCode(type){
	var username = $("#username").val();
	if(type=='email'){
		url = "<%=basePath%>checkEmailForPW.html";
		var email = $("#email").val();
		if(!isEmail(email)){
			alert("请输入有效邮箱");
			return false;
		}
		data = {"email":email,"username":username};
	}else if(type=='tel'){
		url = "<%=basePath%>checkTelForPW.html";
		var tel = $("#tel").val();
		if(!checkMobile(tel)){
			alert("请输入有效手机号码");
			return false;
		}
		data = {"tel":tel,"username":username};
	}
	
	$.ajax({    
        type:'post', 
        url:url,    
        data:data,
        async:false,
        cache:false,    
        dataType:'text',    
        success:function(data){
        	if(type=='tel'){	
        		if(data=='noTel'){
            		alert("没有绑定电话，请选择邮件方式");
            		$("#tel").val('');
            		return false;
            	}else if(data=='ne'){
            		alert("绑定的电话与输入的不符，请重新输入");
            		$("#tel").val('');
            		return false;
            	}else if(data=='hasId'){
            		$("#tel").val('');
            		alert("第三方登陆，无法修改密码");
            		return false;
            	}else if(data=='success'){
            		var username = $("#username").val();
            		$("#changeUsername").val(username);
            	//	alert("验证码已发送");
            		settime();
            		return true;
            	}
        	}else if(type=='email'){
        		if(data=='noEmail'){
            		alert("没有绑定邮件，请选择电话方式");
            		$("#email").val('');
            		return false;
            	}else if(data=='ne'){
            		alert("绑定的邮件与输入的不符，请重新输入");
            		$("#email").val('');
            		return false;
            	}else if(data=='hasId'){
            		$("#email").val('');
            		alert("第三方登陆，无法修改密码");
            		return false;
            	}else if(data=='success'){
            		var username = $("#username").val();
            		$("#changeUsername").val(username);
            		alert("验证码已发送,请登录邮箱查看。");
            		return true;
            	}
        	}else{
        		return false;
        	}
        }    
    });
	
}

$(function(){
	var username = getCookie("imyway-username");
	var password = getCookie("imyway-password");
	if(username!=null&&password!=null){
		$("#username").val(username);
		$("#password").val(password);
		var checkImg = $("#checkImg");
		checkImg.attr("src","<%=basePath%>assets/img/personal/login_check.jpg");
		$("#checkVal").val(1);
	}

	$(document).keydown(function(event){ 
		if(event.keyCode==13){ 
			login();
		} 
	});
	
	$("#confirmBtn").click(function(){
		var checkType = $("#checkType").val();
		var checkTelCode = $("#checkTelCode").val();
		var username = $("#changeUsername").val();
		var url= "<%=basePath%>checkTelCodeForPw.html?checkCode="+checkTelCode+"&username="+username;
		if(checkType == 1){
			url= "<%=basePath%>checkEmailCodeForPw.html?checkCode="+checkTelCode+"&username="+username;
		}
		window.location.href=url;
	});
});


function checkFun(){
	var checkImg = $("#checkImg");
	var checkVal = $("#checkVal").val();
	if(checkVal==1){
		checkImg.attr("src","<%=basePath%>assets/img/personal/check1.png");
		$("#checkVal").val(0);
	}else{
		checkImg.attr("src","<%=basePath%>assets/img/personal/login_check.jpg");
		$("#checkVal").val(1);
	}
}

$("#loginBtn").click(function(){
	login();
})

function login(){
	var username = $("#username").val().trim();
	var password = $("#password").val().trim();
	if(isNull(username)){
		alert("请填写用户名");
		return false;
	}
	if(isNull(password)){
		alert("请填写密码");
		return false;
	}
	$.ajax({
        type:'post',        
        url:'<%=basePath%>user/login.html',    
        data:{"username":username,"password":password},    
        async:true,    
        dataType:'text',    
        success:function(data){
        	if(data==''){
        		var checkVal = $("#checkVal").val();
        		if(checkVal==1){
        			Setcookie("imyway-username", username);
        			Setcookie("imyway-password", password);
        		}else{
        			delCookie("imyway-username");
        			delCookie("imyway-password");
        		}
        		<c:if test="${not empty nextUrl}">
        		window.location.href="${nextUrl}";
	        	</c:if>
	        	<c:if test="${empty nextUrl}">
	        	window.location.href="<%=basePath%>home.html"
	        	</c:if>
	        	
        	}else{
        		alert(data);
        	}
        }    
    });
}

/**
 * 写入cookie
 */
function Setcookie(name, value) {
	//设置名称为name,值为value的Cookie
	var expdate = new Date(); //初始化时间
	expdate.setTime(expdate.getTime() + 365*24*60 * 60 * 1000); //15天过期时间
	document.cookie = name + "=" + value + ";expires="+ expdate.toGMTString() + ";path=/";
	//即document.cookie= name+"="+value+";path=/";   时间可以不要，但路径(path)必须要填写，因为JS的默认路径是当前页，如果不填，此cookie只在当前页面生效！~
}
	
/**
 * 读取cookies
 */
function getCookie(name) {
	var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
	if (arr = document.cookie.match(reg))
		return unescape(arr[2]);
	else
		return null;
}

/**
 * 删除cookies 
 */
function delCookie(name) {
	var exp = new Date();
	exp.setTime(exp.getTime() - 10000);
	var cval = getCookie(name);
	if (cval!=null){
		document.cookie = name + "=" + cval + ";expires="+ exp.toGMTString() + ";path=/";
	}
}
</script>

</body>
</html>