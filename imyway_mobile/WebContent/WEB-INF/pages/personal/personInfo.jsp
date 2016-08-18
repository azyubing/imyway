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
<link href="<%=basePath%>assets/css/personInfo.css" rel="stylesheet" type="text/css">
<link href="<%=basePath%>assets/css/contact.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=basePath%>assets/js/javascriptCheck.js"></script>
</head>
<body>
<!-- ===info main -->
<div id="contact_main" >
	<div id="main">
	<h2 class="main_title">编辑个人信息 <span style="font-size: 14px;">完善个人信息，立即开启您的精彩旅程。</span></h2>
		<div id="p_info">
		<form action="" method="post" enctype="multipart/form-data" >
			<div id="p_img">
				<img class="fl" alt=""  src="${user.photo!=null?user.photo:'../assets/img/personal/p_tmp.png'}">
				<div class="fl img_info">
					<div>我的头像</div>
					<div class="fileUpload btn btn-primary">
						<input type="text" id="upload_txt"  readonly="readonly"/>
					    <input type="file" class="upload" onchange="setImage(this)" name="uploadList" id="uploadBtn"/>
					    <span style="padding-left: 13px;">浏览</span>
					</div>
					<div class="ps"><span>*</span>&nbsp;目前仅支持JPG、GIF、PNG、BMP格式的图片，文件小于3M</div>
					<div><button type="button" id="upBtn" class="btn">上传头像</button></div>
				</div>
				<div class="clr"></div>
			</div>
		</form>
			<form action="" method="post" name="updateUserForm" id="updateUserForm">
				<input name="id" id="id" value="${user.id }" type="hidden">
				<input name="birthday" id="birthday" type="hidden">
				<input name="photo" id="photo" type="hidden">
				<input name="passportImg" id="passportImg" type="hidden">
			<table class="info_table">
				<colgroup>
					<col width="192px">
					<col width="440px">
				</colgroup>
				<tr>
					<td class="tr"><span class="red">&nbsp;</span>真实姓名</td>
					<td><input type="text" name="realName" value="${user.realName }" placeholder="请输入真实姓名" title="请输入真实姓名"></td>
				</tr>
				<c:if test="${empty user.openid }">
				<tr>
					<td  class="tr"><span class="red">*&nbsp;</span>用户名</td>
					<td><input type="text" name="username" value="${user.username }" readonly="readonly" style="background-color: #F2F2F2;"></td>
				</tr>
				</c:if>
				<tr>
					<td  class="tr"><span class="red">&nbsp;</span>常用邮箱</td>
					<td><input class="sm" type="email" name="email" id="email" value="${user.email }" style="width: 225px;" placeholder="首次输入或修改请验证邮箱" title="首次输入或修改请验证邮箱">
						<input type="text" name="checkEmalCode" maxlength="4" style="width: 70px;" placeholder="验证码" title="验证码">
					<button type="button" class="btn btn-green" onclick="sendCode('email')">验证邮箱</button></td>
				</tr>
				<tr>
					<td  class="tr"><span class="red">*&nbsp;</span>手机号码</td>
					<td><input class="sm" type="text" name="tel" id="tel" value="${user.tel }" style="width: 225px;" placeholder="首次输入或修改请验证手机" title="首次输入或请验证手机">
						<input type="text" name="checkTelCode" maxlength="4" style="width: 70px;" placeholder="验证码" title="验证码">
					<button type="button" class="btn btn-green" onclick="sendCode('tel')">验证手机</button></td>
				</tr>
				<!-- 
				<tr>
					<td  class="tr"><span class="red">*&nbsp;</span>密码</td>
					<td><input type="password"  value="${user.password }" readonly="readonly"></td>
				</tr>
				 -->
				<tr>
					<td  class="tr"><span class="red">&nbsp;</span>出生日期</td>
					<td>
					<div class="dropdown mr_10">
						  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
						   <font id="fontYear">1980</font>
						    <span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu" aria-labelledby="dropdownMenu1" id="year" style="height: 100px;overflow:auto;">
						  </ul>
					</div>
					<div class="dropdown">
						  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
						    <font id="fontMonth">1月</font>
						    <span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu" aria-labelledby="dropdownMenu2" style="height: 100px;overflow:auto;">
						    <li><a href="javascript:void(0)" onclick="getDay(1);">1月</a></li>
						    <li><a href="javascript:void(0)" onclick="getDay(2);">2月</a></li>
						    <li><a href="javascript:void(0)" onclick="getDay(3);">3月</a></li>
						    <li><a href="javascript:void(0)" onclick="getDay(4);">4月</a></li>
						    <li><a href="javascript:void(0)" onclick="getDay(5);">5月</a></li>
						    <li><a href="javascript:void(0)" onclick="getDay(6);">6月</a></li>
						    <li><a href="javascript:void(0)" onclick="getDay(7);">7月</a></li>
						    <li><a href="javascript:void(0)" onclick="getDay(8);">8月</a></li>
						    <li><a href="javascript:void(0)" onclick="getDay(9);">9月</a></li>
						    <li><a href="javascript:void(0)" onclick="getDay(10);">10月</a></li>
						    <li><a href="javascript:void(0)" onclick="getDay(11);">11月</a></li>
						    <li><a href="javascript:void(0)" onclick="getDay(12);">12月</a></li>
						  </ul>
						</div><!--
	              	 --><div class="dropdown last">
						  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
						    <font id="fontDay">1日</font>
						    <span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu" aria-labelledby="dropdownMenu3" id="day" style="height: 100px;overflow:auto;">
						  </ul>
						</div><!--
              	--></td>
				</tr>
				<tr>
					<td class="tr"><span class="red">&nbsp;</span>身份证号码</td>
					<td><input type="text" name="idCard" value="${user.idCard }" placeholder="请输入身份证号码" title="请输入身份证号码"></td>
				</tr>
				<tr>
					<td class="tr"><span class="red">&nbsp;</span>联系地址</td>
					<td><input type="text" name="address" value="${user.address }" placeholder="请输入联系地址" title="请输入身份证号码"></td>
				</tr>
				<tr>
					<td class="tr"><span class="red">&nbsp;</span>护照号码</td>
					<td><input type="text" name="passportNumber" value="${user.passportNumber }" placeholder="请输入护照号码" title="请输入护照号码"></td>
				</tr>
				<tr>
					<td class="tr"><span class="red">*&nbsp;</span>护照签发地</td>
					<td><!-- 
              		 --><div class="dropdown mr_10" style="margin-right:15px">
              		 <input type="text" name="countryName" style="width:134px" value="${user.countryName }" placeholder="国家" title="国家">
						 <%--  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
						      <font id="fontcountryId">${country.cityName==null ? '请选择' : country.cityName}</font>
						    <span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu" aria-labelledby="dropdownMenu1" id="countryId" child="provinceId">
						   <li><a href="javascript:void(0)" cityId="" onclick="ajaxRequestData(this)">请选择</a></li>
						  	<c:forEach items="${cityList }" var="city">
							    <li><a href="javascript:void(0)" cityId="${city.id }" onclick="ajaxRequestData(this)">${city.cityName }</a></li>
						  	</c:forEach>
						  </ul> --%>
						</div>
	              	  <div class="dropdown" style="margin-right:15px">
	              	 	 <input type="text" name="provinceName" style="width:134px" value="${user.provinceName }" placeholder="省份或直辖市" title="省份或直辖市">
						  <%-- <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
						    <font id="fontprovinceId">${province.cityName==null?'请选择':province.cityName}</font>
						    <span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu" aria-labelledby="dropdownMenu2" id="provinceId" child="cityId">
						  </ul>--%>
						</div>
	              	 <div class="dropdown last" >
	              	 <input type="text" name="cityName" style="width:134px" value="${user.cityName }" placeholder="城市" title="城市">
						 <%--  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
						   <font id="fontcityId">${city.cityName==null?'请选择':city.cityName}</font>
						    <span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu" aria-labelledby="dropdownMenu3"  id="cityId">
						  </ul> --%>
						</div><!--
              	--></td>
				</tr>
			</table>
			</form>
			<hr class="hr2">
			<button id="saveBtn" class="btn" onclick="submit();">保存</button>
		</div>
	</div>
</div>
<!-- ===End info main -->

<!-- Page level JS -->
<script type="text/javascript">
$(function(){
	$(".tags-nav").find("a").removeClass("active");
	$(".tags-nav").find("a").eq(3).addClass("active");
	$("#uploadBtn").change(function(){
		$("#upload_txt").val($(this).val());
	});
	$("#uploadBtn_2").change(function(){
		$("#upload_txt_2").val($(this).val());
	});
	
	setYearHtml();
	getDay(1);
	var birthday = '${user.birthday}';
	if(birthday!=null&&birthday!=''){
		
		var time = new Date(birthday);
		
		$("#fontYear").html(time.getFullYear());
		$("#fontMonth").html((time.getMonth()+1)+"月");
		$("#fontDay").html(time.getDate()+"日");
	}
	
	
	// 头像上传
	$("#upBtn").click(function(){
		var form = $(this).parents("form");
		var imgpath = $(form).find("input[name='uploadList']");
		if(isNull(imgpath.val())){
			alert("请选择图片");
			return;
		}
		
		$(form).ajaxSubmit({
			url : "<%=basePath%>img/uploadFileList.html",
            type:'POST',
            dataType:'json',
            success: function(json){
            	$("#photo").val(json);
            	$.ajax({
            		type : "post",
            		url : "<%=basePath%>personal/updateUserPhoto.html",
            		data : {"id":'${user.id}',"photo":$("#photo").val()},
            		cache : false,
            		dataType : 'json',
            		beforeSend : function() {
            		},
            		success : function(data) {
            			alert("头像上传成功");
            			location.reload();
            		}
            	});
            } 
        });
	});
	// 护照上传
	$("#upBtn1").click(function(){
		var form = $(this).parents("form");
		var imgpath = $(form).find("input[name='uploadList']");
		if(isNull(imgpath.val())){
			alert("请选择图片");
			return;
		}
		
		$(form).ajaxSubmit({
			url : "<%=basePath%>img/uploadFileList.html",
            type:'POST',
            dataType:'json',
            success: function(json){
            	$("#passportImg").val(json);
            } 
        });
	});
	
});


function submit(){
	var yearStr = $("#fontYear").html();
	var monthStr = $("#fontMonth").html();
	var dayStr = $("#fontDay").html();
	
	var month = monthStr.split("月")[0];
	var day = dayStr.split("日")[0];
	var d = new Date(yearStr,month-1,day);
	var id = $("#updateUserForm").find("input[name='id']").val();
	$("#updateUserForm").find("input[name='birthday']").val(d);
	var realName = $("#updateUserForm").find("input[name='realName']").val().trim();
	var tel = $("#updateUserForm").find("input[name='tel']").val().trim();
	var idCard = $("#updateUserForm").find("input[name='idCard']").val().trim();
	var passportNumber = $("#updateUserForm").find("input[name='passportNumber']").val().trim();
	var countryName = $("#updateUserForm").find("input[name='countryName']").val().trim();
	var provinceName = $("#updateUserForm").find("input[name='provinceName']").val().trim();
	var cityName = $("#updateUserForm").find("input[name='cityName']").val().trim();
	
	/*
	if(isNull(realName)){
		alert("请填写真实姓名");
		return false;
	}
	if(isNull(tel)){
		alert("请填写手机号码");
		return false;
	}
	if(!checkMobile(tel)){
		alert("请填写正确的手机号码");
		return false;
	}
	if(isNull(idCard)){
		alert("请填写身份证号码");
		return false;
	}
	var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;  
    if(reg.test(idCard) === false) {  
       alert("身份证输入不合法");  
       return  false;  
    }  
	if(isNull(passportNumber)){
		alert("请填写护照号码 ");
		return false;
	}
	if(isNull(countryName)||isNull(provinceName)||isNull(cityName)){
		alert("请填写护照签发地 ");
		return false;
	}
	*/
	if(!isNull(tel) && !checkMobile(tel)){
		alert("请填写正确的手机号码");
		return false;
	}
	
	var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;  
    if(!isNull(idCard) && reg.test(idCard) === false) {  
       alert("身份证输入不合法");  
       return  false;  
    }  
	$.ajax({
		type : "post",
		url : "<%=basePath%>personal/updateUser.html",
		data : $("#updateUserForm").serialize(),
		cache : false,
		dataType : 'text',
		beforeSend : function() {
		},
		success : function(data) {
			var photo = $("#updateUserForm").find("input[name='photo']").val();
			$("#headPhoto").attr("src",photo);
			alert("修改成功");
			window.location.href='<%=basePath%>home.html';
		}
	});
}






//获取数据
function ajaxRequestData(obj) {
	var parentId = $(obj).attr("cityId");
	var selectId = $(obj).parent().parent().attr("child");
	var font = $(obj).parent().parent().prev().find("font");
	var name = $(obj).parent().parent().attr("id")
	$("#updateUserForm").find("input[name='"+name+"']").val(parentId);
	$("#updateUserForm").find("input[name='"+selectId+"']").val('');
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
			changeSelect(data,$(obj).parent().parent().parent().next(),obj);
		}
	});
}

//改变下拉框
function changeSelect(data,div,obj){
	var json = data.rows;
	var html ='<li><a href="javascript:void(0)" cityId="" onclick="ajaxRequestData(this)">请选择</a></li>';
	for(var i = 0;i<json.length;i++){
		var selected='';
		html = html+'<li><a href="javascript:void(0)" cityId="'+json[i].id+'" onclick="ajaxRequestData(this)">'+json[i].cityName+'</a></li>';
	}
	$(div).find("font").html('请选择');
	$(div).find("ul").html(html);
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
	$("#fontYear").html(year);
	$("#year").html(html);
}

 function getDay(month){
	 var year = $("#fontYear").html().substring(0,4);
	 var d = DayNumOfMonth(year, month);
	 var html = '';
	for(var i=1;i<=parseInt(d);i++){
		html = html+'<li><a href="javascript:void(0)" onclick="day(this)">'+i+'日</a></li>';
	}
	$("#fontMonth").html(month+"月");
	$("#day").html(html);
 }
 
 function year(obj){
	 var d = $(obj).html();
	 $("#fontYear").html(d);
	var month =  $("#fontMonth").html().split("月")[0];
	getDay(month);
	 
 }
 function day(obj){
	 var d = $(obj).html();
	 $("#fontDay").html(d);
 }
function DayNumOfMonth(Year, Month) {
	var d = new Date(Year, Month, 0);
	return d.getDate();
}

function setImage(obj){
	var path = URL.createObjectURL(obj.files[0]);
	$(obj).parent().parent().parent().find("img").attr("src",path);
}
function setproImage(obj){
	var path = URL.createObjectURL(obj.files[0]);
	$(obj).parent().parent().parent().parent().find("img").attr("src",path);
	$(obj).parent().parent().parent().parent().find("img").attr("width","432");
	$(obj).parent().parent().parent().parent().find("img").attr("height","302");
}

function sendCode(type){
	if(type=='email'){
		url = "<%=basePath%>checkEmail.html";
		var email = $("#email").val();
		if(!isEmail(email)){
			alert("请输入有效邮箱");
			return false;
		}
		data = {"email":email};
	}else if(type=='tel'){
		url = "<%=basePath%>checkTel.html";
		var tel = $("#tel").val();
		if(!checkMobile(tel)){
			alert("请输入有效手机号码");
			return false;
		}
		data = {"tel":tel};
	}
	$.ajax({    
        type:'post', 
        url:url,    
        data:data,    
        cache:false,    
        dataType:'text',    
        success:function(data){
        	alert("验证码已发送");
        }    
    });
}

</script>

</body>
</html>