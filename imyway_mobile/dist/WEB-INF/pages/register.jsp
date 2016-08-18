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
<link href="<%=basePath%>assets/css/register.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=basePath%>assets/js/javascriptCheck.js"></script>
</head>
<body>
<!-- ===login main -->
<div id="login_main" style="background-image: url('<%=basePath%>assets/img/personal/login_bak.jpg');">
<input type="hidden" id="type" value="tel">
<form method="post" name="register" id="register" >
	<input type="hidden" id="status" name="status" value="0" >
	<div id="main" >
		<div class="title"><img alt="" src="<%=basePath%>assets/img/personal/register_t.png"></div>
		<div class="t mt_30">用户名</div>
		<div class="txt p"><input type="text" name="username" onblur="userNameExit(this)" placeholder="字母、数字等、用户名唯一、长度6-18位" title="字母、数字等、用户名唯一、长度6-18位"></div>
		<div class="t mt_10" id="changetype1"><a class="a1" href="javascript:void(0);" >手机</a>&nbsp;&nbsp;&nbsp;<span style="color: #999;">|</span>&nbsp;&nbsp;&nbsp;<a class="a2" href="javascript:changeType(this,'email');">邮箱</a></div>
		<div class="txt p">
			<input type="text" name="tel" id="tel" placeholder="请输入手机号码" onblur="telExit(this)" title="请输入手机号码">
			<input type="text" name="email" id="email" placeholder="请输入邮箱" onblur="emailExit(this)" title="请输入邮箱" style="display: none;">
		</div>
		<div class="txt yzm_content">
			<div class="txt p yzm fl"><input type="text" name="checkCode" placeholder="验证码" title="验证码"></div>
			<div class="fr p"><input class="btn" type="button" id="yzmBtn" onclick="sendCode(this)" value="发送验证码"></div>
		</div>
		<div class="clr"></div>
		<div class="t mt_10">密码</div>
		<div class="txt p"><input type="password" name="password" placeholder="请输入不少于6位密码" title="请输入不少于6位密码"></div>
		<div class="t mt_10">再次输入密码</div>
		<div class="txt p"><input type="password" id="password2"  placeholder="请输入不少于6位密码" title="请输入不少于6位密码"></div>
		<div class="inf">
			<span class="fl mt_20">
				<a href="javascript:checkFun()"><img id="checkImg" src="<%=basePath%>assets/img/personal/check1.png" width="18" height="18"></a>
				&nbsp;同意并接受《服务条款》<input type="hidden" name="agree" id="checkVal" value="0">
			</span>
		</div>
		<div class="clr"></div>
		<div style="margin-top: 20px;"><button type="button" class="btn" id="loginBtn" onclick="login()" disabled="disabled">立即注册</button></div>
		<div class="other"><span class="fl" style="height: 32px;line-height: 32px;">第三方帐号注册</span>
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
   <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
           </div>
           <div class="modal-body">
      	   		<p class="p1">感谢你使用麦味旅行</p>
      	   		<p class="p1">我们发送了一封邮件到你的邮箱</p>
      	   		<p id="email_address"></p>
      	   		<p class="p3">请及时查看</p>
      	   		<p><button type="button" class="btn toMail" url="" id="gourl" onclick="goemail(this);">前往邮箱</button></p>
      	   		<p><a href="<%=basePath%>home.html" class="bakHome">回到网站首页</a></p>
           </div>
       </div>
   </div>
</div>
<!-- end send mail model -->

<!-- Page level JS -->
<script type="text/javascript">
function openMailSend(email){
	if(email!=''){
		$("#email_address").text(email); 
	}
	$("#myModal").modal('show');
	var h = email.split("@")[1];
	var hh = h.split(".")[0];
	$("#gourl").attr("url",hh);
}

function goemail(obj){
	var url =$(obj).attr("url");
	window.open("http://www.mail."+url+".com");
}



document.onkeydown=function(e){
	var keycode=document.all?event.keyCode:e.which;
	if(keycode==13){
		login();
	}
}
	
	
	
function checkFun(){
	var checkImg = $("#checkImg");
	var checkVal = $("#checkVal").val();

	checkVal=='1'?checkVal='0':checkVal='1';
	if(checkVal=='1'){
		checkImg.attr("src","<%=basePath%>assets/img/personal/login_check.jpg");
		$("#checkVal").val('1');
		$("#loginBtn").attr("disabled",false);
	}else{
		checkImg.attr("src","<%=basePath%>assets/img/personal/check1.png");
		$("#checkVal").val('0');
		$("#loginBtn").attr("disabled",true);
	}
}

function changeType(obj,type){
	if(type=='email'){
		var html = "<a class='a2' href='javascript:changeType(this,"+'"tel"'+");' >手机</a>&nbsp;&nbsp;&nbsp;<span style='color: #999;'>|</span>&nbsp;&nbsp;&nbsp;<a class='a1' href='javascript:void(0);'>邮箱</a>";
		$("#changetype1").html(html);
		$("#tel").val('').hide();
		$("#email").show();
		$("#status").val(2);
		$(".yzm_content").hide();
		
	}else if(type=='tel'){
		var html = "<a class='a1' href='javascript:void(0);' >手机</a>&nbsp;&nbsp;&nbsp;<span style='color: #999;'>|</span>&nbsp;&nbsp;&nbsp;<a class='a2' href='javascript:changeType(this,"+'"email"'+");'>邮箱</a>";
		$("#changetype1").html(html);
		$("#email").val('').hide();
		$("#tel").show();
		$("#status").val(0);
		$(".yzm_content").show();
	}
	$("#type").val(type);
}

var countdown = 60;
function settime(obj) {
	if (countdown == 0) {
		$(obj).removeAttr("disabled");
		$(obj).val("免费获取验证码");
		countdown = 60;
		return;
	} else {
		$(obj).attr("disabled", true);
		$(obj).val("重新发送(" + countdown + ")");
		countdown--;
	}
	setTimeout(function() {
		settime(obj);
	}, 1000)
}

function sendCode(obj){
	var tel = $("#tel").val();
	if(!checkMobile(tel)){
		alert("请输入有效手机号码");
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
}


function login(){
	var username = $("#register").find("input[name='username']").val().trim();
	var password = $("#register").find("input[name='password']").val();
	var password2 = $("#password2").val();
	if (username == null || username == ''|| username.length<6||username.length>18) {
		alert("请填写长度大于6小于18的用户名");
		$("#register").find("input[name='username']").focus();
		return false;
	}
	if (password == null || password == '' || password.length < 6) {
		alert("请填写长度大于6密码");
		$("#register").find("input[name='password']").focus();
		return false;
	}
	if(password!=password2){
		alert("2次密码不一致");
		return false;
	}
	$("#loginBtn").attr("disabled",true);
	$.ajax({
        type:'post',        
        url:'<%=basePath%>user/register.html',    
        data:$("#register").serialize(),    
        async:true,    
        dataType:'json',    
        success:function(data){
        	if(data.code=='success'){
        		if($("#email").val() == null || $("#email").val() == ""){
        			window.location.href="<%=basePath%>personal/personInfo.html";
        			return;
        		}
        		openMailSend($("#email").val(),'register');
        	}else{
        		alert(data.msg);
        	}
        	$("#loginBtn").attr("disabled",false);
        }
    });
	
}


function userNameExit(obj){
	var username = $(obj).val().trim();
	if(username==null||username==''){
		return fasle;
	}
	$.ajax({
        type:'post',        
        url:'<%=basePath%>user/userNameExit.html',    
        data:{"username":username},    
        async:true,    
        dataType:'text',    
        success:function(data){
        	if(data!='true'){
        		alert(username+"该用户名已存在，请修改其他用户名！");
        		return false;
        	}
        }
    });
}
function telExit(obj){
	var tel = $(obj).val().trim();
	if(tel==null||tel==''){
		return false;
	}
	$.ajax({
        type:'post',        
        url:'<%=basePath%>user/telExit.html',    
        data:{"tel":tel},    
        async:true,    
        dataType:'text',    
        success:function(data){
        	if(data!='true'){
        		alert(tel+"该手机已被注册，请更换手机");
        		return false;
        	}
        }
    });
}
function emailExit(obj){
	var email = $(obj).val().trim();
	if(email==null||email==''){
		return email;
	}
	$.ajax({
        type:'post',        
        url:'<%=basePath%>user/emailExit.html',    
        data:{"email":email},    
        async:true,    
        dataType:'text',    
        success:function(data){
        	if(data!='true'){
        		alert(email+"该邮箱已被注册，请更换邮箱");
        		return false;
        	}
        }
    });
}
</script>

</body>
</html>