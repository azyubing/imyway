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
<link href="<%=basePath%>assets/css/datepicker.css"  rel="stylesheet" type="text/css">
<style type="text/css">
#about_main{min-width: 1180px;max-width: 1600px;background-color: #f6f6f6;margin-bottom: -28px;height: 579px;text-align: center;}
#about_main .content{width: 880px;height: 497px;margin: 0 auto;position: relative;top:-535px;text-align:center; }
#about_main .content .inputs{position: absolute;   top: 127px; left: 186px;z-index: 9}
#about_main .content .inputs .input{ background-color: #D0DCE9; width: 230px;position:relative;top:1px;left:-4px;z-index:9;top:3px\9\0;
 height: 40px; line-height: 40px;  border: none;padding-left: 10px;margin-bottom: 10px;}
 @-moz-document url-prefix(){#about_main .content .inputs .input{top: 2px;}  /* firefox only */ } 
 
 #about_main .content .inputs .input.input-sm1{width: 86px;}
 #about_main .content .inputs .input.input-sm2{width: 86px;}
 #about_main .content .inputs img{z-index: 10;position: relative;}
 #about_main .content .comfrimBtn{background-color: #529BFF;width: 360px; height: 50px;border-radius: 0;position: absolute;
  bottom: 108px;
  left: 185px; }
  
</style>
</head>
<body>
<!-- === main -->
<div id="about_main" >
	<img src="<%=basePath%>assets/img/UI/dz_bak.jpg" style="width: 100%;height: 579px;">
	<div class="content">
		<img src="<%=basePath%>assets/img/UI/dz_main.png" style="width: 880px;height: 497px;">
		<button type="button" class="btn btn-primary comfrimBtn" id="comfrimBtn" style="border: 0">提交</button>
		<div class="inputs">
			<div><img src="<%=basePath%>assets/img/UI/lab1.png"><input class="input" name="targetCity" id="targetCity" type="text"></div>
			<div><img src="<%=basePath%>assets/img/UI/lab2.png"><input class="input date-picker" name="goDate" id="goDate" type="text"></div>
			<div><img src="<%=basePath%>assets/img/UI/lab3.png"><input class="input" name="contract" id="contract" type="text"></div>
			<div>
				<img src="<%=basePath%>assets/img/UI/lab4.png"><input class="input input-sm1" name="days" id="days" type="text">
				<img src="<%=basePath%>assets/img/UI/lab5.png"><input class="input input-sm2" name="personCount" id="personCount" type="text">
			</div>
		</div>
	</div>
	
</div>

   <div id="alertmsg" style="background-color:#FBFBFB; width:360px;height:168px;position: absolute;top:300px;left: 300px;border: 1px solid #d0d0d0;text-align: center;z-index: 999;display: none;">
   	<div style="color: #529BFF;font-size: 16px;font-weight: bold;margin: 15px auto 15px auto;">提交成功！</div><img src="<%=basePath%>assets/img/close.jpg" style="position: absolute; top: 10px; right: 10px;cursor: pointer;" onclick="closeAlert()">
   	<div style="color: #333;font-size: 12px;line-height: 22px;">小主，您的定制需求已下达成功，<br>贴心的小麦会马上与您联系，请小主耐心等候哦<sup>~</sup></div>
   	<div style="color: #529BFF; font-size: 12px; border: 1px solid #529BFF;width: 100px;height: 32px;line-height: 30px;margin: 25px auto 0px auto;cursor: pointer;"  onclick="closeAlert()">确&nbsp;&nbsp;定</div>
   </div>
<!-- ===End  main -->

<!-- Page level JS -->
<script type="text/javascript" src="<%=basePath%>assets/js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript" src="<%=basePath%>assets/js/javascriptCheck.js"></script>
<script type="text/javascript">
function closeAlert(){
	$("#alertmsg").hide();
	window.location.href = "./home.html";
}
function openAlert(){
	var ww = $(window).width();
	var left = ww/2-180;
	$("#alertmsg").css({"left": left+"px"});
	$("#alertmsg").show();
}
$(function() {
	var UA = navigator.userAgent.toLowerCase();     
	if(UA.indexOf("chrome")>0){
		if(parseInt(UA.match(/chrome\/([\d.]+)/)[1]) <= 35){
			$("#about_main>.content>.inputs>div>.input").css("top","2px");
		}
	}
	$('.date-picker').datepicker({
    	format: 'yyyy-mm-dd',
        autoclose: true,
        todayHighlight: true,
        startDate: new Date(),
        language: 'cn'//en,
    });

	$("#comfrimBtn").click(function(){
		var tc = $("#targetCity").val(),
		gd = $("#goDate").val(),ct=$("#contract").val(),
		days=$("#days").val(),pc=$("#personCount").val();
		
		if(tc ==null || $.trim(tc)== ''){
			alert("请输入目的地");
			return false;
		}
		/*
		if(gd ==null || $.trim(gd)== ''){
			alert("请选择出行日期");
			return false;
		}*/
		if(ct ==null || $.trim(ct)== ''){
			alert("请输入联系方式");
			return false;
		}else{
			if(!checkMobile(ct)){
				alert("请输入正确的联系方式");
				return false;
			}
		}
		
		/*
		if(days ==null || $.trim(days)== ''){
			alert("请输入天数");
			return false;
		}
		if(pc ==null || $.trim(pc)== ''){
			alert("请输入人数");
			return false;
		}*/
		if(days !=null && $.trim(days) != '' ){
			if(isNaN(days)){
				alert("请输入正确的天数，天数只能为数字");
				return false;
			}else if(days <= 0){
				alert("请输入正确的天数");
				return false;
			} 
		}
		
		
		if(pc !=null && $.trim(pc) != ''){
			if(isNaN(pc)){
				alert("请输入正确的人数，人数只能为数字");
				return false;
			}else if(pc <= 0){
				alert("请输入正确的人数");
				return false;
			}
		}
		
		
		$.ajax({
			type:"POST",
			url:"<%=basePath%>sendRequestMail.html",
			data:{'targetCity': tc,
					'goDate': gd,	
					'contract': ct,	
					'days': days,	
					'personCount': pc
			},
			async:false, 
			dataType: "html",
			success: function(json){
				if(json=="Y"){
				//	alert("已将您的需求发送给麦味，我们的客服会尽快联系您。你还可以查看已有的套餐，祝您愉快！");
					openAlert();
				}else if(json=="N"){
					alert("系统繁忙，请稍后重试");
				}
			}
		});
		
	});
});


</script>

</body>
</html>