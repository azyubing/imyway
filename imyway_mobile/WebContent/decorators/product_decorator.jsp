<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
    <%@ page language="java" import="java.util.Date" %>
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
<!--[if IE 8]> <html lang="zh-CN" class="ie8"> <![endif]-->  
<!--[if IE 9]> <html lang="zh-CN" class="ie9"> <![endif]-->  
<!--[if !IE]><!--> <html lang="zh-CN"> <!--<![endif]--> 
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width">
<c:import url="../keywords.jsp"></c:import>
<!-- Favicon -->
<link rel="shortcut icon" href="<%=basePath%>assets/img/favicon.png">
<!-- Bootstrap -->
<link href="<%=basePath%>assets/plugins/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="<%=basePath%>assets/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="<%=basePath%>assets/plugins/tooltipster/tooltipster.css" rel="stylesheet" type="text/css">

<!-- custom -->
<link href="<%=basePath%>assets/css/product_custom.css" rel="stylesheet" type="text/css">
<link href="<%=basePath%>assets/css/bootstrap-select.css" rel="stylesheet" type="text/css">
<link href="<%=basePath%>assets/css/jquery.shCircleLoader.css" rel="stylesheet" type="text/css"/>
<link href="<%=basePath%>assets/css/datepicker.css"  rel="stylesheet" type="text/css">
<link href='<%=basePath%>assets/fullcalender/fullcalendar.css' rel='stylesheet' />

<style type="text/css">
.dropdown-menu{max-height: 250px;
overflow-y: auto;
overflow-x: hidden;
}
</style>
<sitemesh:write property='head'/>

<style type="text/css">
.fc-state-hover {background-color: #fff;}
.fc-state-hover.fc-state-down {background-color: #fff;box-shadow: none;}
.fc .fc-header-space { padding-left: 20px;}
#calContent .fc-header{position: relative; top: -5px;border-bottom: 1px solid #e5e5e5;height: 50px;}
#calContent .fc-content{margin-top: 15px;}
#calContent .fc-content table thead tr th{border: 1px solid #333;background-color: #333;color: #fff;
height: 30px;line-height: 30px;font-size: 12px;font-weight: lighter;}
.fc-grid .fc-day-number { float: left; padding: 0px 2px;}
.fc-grid .fc-day-number {float: left;padding: 10px 2px 0 10px; font-size: 12px;}
.fc-widget-content {border: 1px solid #e1e1e1;}
.fc-grid .fc-other-month {background-color: #f6f6f6;}
.fc-grid .fc-other-month .fc-day-number { color: #999;opacity: 1;}
.fc-header-title h2 { margin-top: 0px;white-space: nowrap;font-size: 16px;line-height: 45px;}
.fc { text-align: right;}
.fc-event {border: 0; background-color: transparent; color: #E45664;padding-right: 4px;}
.fc-event.sale-off{color: #ccc; font-size: 16px;}

.fc-event-inner {width: 100%;height: 50px;overflow: hidden;margin-top: -30px;margin-left: 10px;line-height: 75px;padding-right: 8px;position: relative;}
.off-icon .fc-event-inner {background-image: url("<%=basePath%>assets/img/UI/sale-icon.png");background-repeat: no-repeat;background-position: top right;}

#tip_content{position: absolute;width: 122px;background-color: #fff;box-shadow: 0px 0px 5px #e2e2e2;
left: -2px;border: 1px solid #e5e5e5; border-radius:5px;top:-71px;}
#tip_txt{color: #666; font-size: 12px; line-height: 12px; padding: 10px 10px 0;text-align: center;width: 120px}
#tip_icon{position: relative;left: -51px;top: 10px;}
</style>

<!--[if lt IE 9]>
  <script src="<%=basePath%>assets/js/html5shiv.js"></script>
  <script src="<%=basePath%>assets/js/respond.js"></script>
  <script src="<%=basePath%>assets/plugins/placeholder-IE-fixes.js"></script>
<![endif]-->

<!-- global -->
<script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>assets/js/jquery-migrate.min.js"></script>
<script type="text/javascript" src="<%=basePath%>assets/js/jqElemResize.js"></script>
<script type="text/javascript" src="<%=basePath%>assets/plugins/bootstrap/bootstrap.min.js"></script>
<!-- JS Implementing Plugins -->
<script type="text/javascript" src="<%=basePath%>assets/js/back-to-top.js"></script>
<script type="text/javascript" src="<%=basePath%>assets/js/smoothScroll.js"></script>
<script type="text/javascript" src="<%=basePath%>assets/plugins/tooltipster/jquery.tooltipster.min.js"></script>

<script type="text/javascript" src="<%=basePath%>assets/js/route.js"></script> 
<script type="text/javascript" src="<%=basePath%>assets/js/bootstrap-select.js"></script>
<link href="<%=basePath%>assets/css/datepicker.css"  rel="stylesheet" type="text/css">
<script src="<%=basePath%>assets/js/jquery.shCircleLoader-min.js" type="text/javascript"></script>
<style type="text/css">
.navbar-custom{padding: 0;position: relative;}
#header_logo{width: 112px; height: 110px; display: block;position: absolute;top: 0px;left: 0px;border-right: 1px solid #e5e5e5;}
.navbar-nav-custom .nav-custom{margin-left: 112px;}
.sub-navbar .row .tags-nav{padding-left: 112px;}


.navbar-custom .nav-custom li {
    float: left;
    list-style: outside none none;
    border-right: 1px solid #e5e5e5;
}
.navbar-custom .nav-custom li a{background-color: transparent;color: #666;}
.navbar-custom .nav-custom li a:hover {
    color: #529CFF;
    text-decoration: none;
    background-color: transparent;
}
</style>
</head>
<body class="global">

<div id="mask" style="width: 100%;height: 100%; background-color: #fff; filter:alpha(opacity=50);-moz-opacity:0.5;-khtml-opacity: 0.5;
	opacity: 0.5; position: absolute; z-index: 1497; display: none;">
</div>
<div id="shclDefault" style="width: 100px; height: 100px; display: none; position: absolute;top:48%;left: 48%; z-index: 1499; " ></div>
<!--calendar model -->
<div id="maskBak" style="background-color: #000; filter: alpha(opacity=0); opacity:0;position: absolute;top: 0px;left: 0px;display: none;"></div>
<div class="" id="calContent" style="position: absolute;top: 0px;left: 0px;width: 902px; padding:13px 20px 10px;filter: alpha(opacity=0); opacity:0;
 height: 2px;background-color: #fff;"></div>
<!-- end calendar model -->

<div class="content" id="main_content">

<!--=== Header ===-->    
<div style="border-bottom: 1px solid #e5e5e5;width: 100%;">
<div class="navbar-custom">
<a id="header_logo" href="<%=basePath%>home.html"><img alt="主题度假" src="<%=basePath%>assets/img/UI/logo_big.png"></a>
<%--
   <div class="nav-brand">
      <a class=" no-padding" href="<%=basePath%>home.html"><img alt="logo" src="<%=basePath%>assets/img/nav_logo.png"> </a>
   </div>
 --%>
   <div class="navbar-nav-custom">
      <ul class="nav-custom">
          <li><a href="<%=basePath%>home.html#imyway_theme">主题</a></li>
         <li><a href="<%=basePath%>myCustom.html">定制</a></li>
         <li><a href="<%=basePath%>home.html#imyway_vedio">麦视频</a></li>
      </ul>
   </div>

   <div class="login-bar <c:if test="${not empty loginUser}">logined </c:if>">
   	<c:choose>
   		<c:when test="${empty loginUser}">
   			<a class="login-btn" href="<%=basePath%>tologin.html?nextUrl=${nowUrl}">登录</a><a class="regist-btn" href="<%=basePath%>toregister.html?nextUrl=${nowUrl}">注册</a>
   		</c:when>
   		<c:otherwise>
	  		 <div class="p_img">
			    <div class="img_b">
			    <a href="<%=basePath%>personal/myorder.html?page=1&pageSize=10">
			    <img alt="" id="headPhoto" src="${empty loginUser.photo ? '../assets/img/personal/p_tmp.png':loginUser.photo}" >
			    </a>
			    </div>
			    <div class="p_name">
			    	<p><a href="<%=basePath%>personal/myorder.html?page=1&pageSize=10">
			    		<c:choose> 
					     <c:when test="${fn:length(loginUser.username) > 12}"> 
					      <c:out value="${fn:substring(loginUser.username, 0, 12)}..." /> 
					     </c:when> 
					     <c:otherwise> 
					      <c:out value="${loginUser.username}" /> 
					     </c:otherwise>
					    </c:choose>
					    </a>
			    	</p>
			    	<p><a href="<%=basePath%>/loginOut.html"><img alt=""  src="<%=basePath%>assets/img/personal/sign-out.png" ></a></p>
			    </div>
		    </div>
   		</c:otherwise>
   	</c:choose>
   </div>
   
   <div class="search-bar">
   		<form action="<%=basePath%>product/product_list.html" id="searchForm" name="searchForm" method="post">
	   		<a class="search-icon" id="searchProduct" href="javascript:void(0);"><img onclick="searchProduct()" src="<%=basePath%>assets/img/search_icon.png"/></a>
	   		<input type="text" name="pname"  class="search-content" placeholder="搜索您的行程"/>
	   		<input type="hidden" id="searchPtype" name="ptype"  value="${ptype }" />
	   		<input type="hidden" name="fromFlag"  value="1" />
	    </form>
	    <script type="text/javascript">

		    function searchProduct(){
		    	$("#searchPtype").val($("#ptype").val());
		    	$("#searchForm").submit();
		    }
	    </script>
   </div>
   <div class="clr"></div>
</div>
</div>
<script type="text/javascript">
$(function(){
	//set search bar style
	$(".search-bar>form>.search-content").focus(function(){
		$(".search-bar>form>.search-icon>img").attr("src","<%=basePath%>assets/img/search_icon_hover.png");
		$(".search-bar").animate({width:"260px"},400).css("background","#f6f6f6");
		$(this).animate({width:"75%"},500).css("background","#f6f6f6");;
	}).blur(function(){
		$(".search-bar>form>.search-icon>img").attr("src","<%=basePath%>assets/img/search_icon.png");
		$(".search-bar").animate({width:"200px"},400).css({"background":"#fff"});
		$(this).animate({width:"70%"},500).css("background","#fff");
	});
	
	// set go to top
	var mainobj=scrolltotop
	var iebrws=document.all
	mainobj.cssfixedsupport=!iebrws || iebrws && document.compatMode=="CSS1Compat" && window.XMLHttpRequest //not IE or IE7+ browsers in standards mode
	mainobj.$body=(window.opera)? (document.compatMode=="CSS1Compat"? $('html') : $('body')) : $('html,body')
	mainobj.$control=$('<div id="topcontrol">'+
			'<img src="<%=basePath%>assets/img/up.png" style="width:48px; height:48px" />'
			+'</div>')
		.css({position:mainobj.cssfixedsupport? 'fixed' : 'absolute', bottom:mainobj.controlattrs.offsety, right:'25px', opacity:0, cursor:'pointer'})
		.attr({title:'返回顶部'})
		.click(function(){mainobj.scrollup(); return false})
		.appendTo('body')
	if (document.all && !window.XMLHttpRequest && mainobj.$control.text()!='') //loose check for IE6 and below, plus whether control contains any text
		mainobj.$control.css({width:mainobj.$control.width()}) //IE6- seems to require an explicit width on a DIV containing text
	mainobj.togglecontrol()
	$('a[href="' + mainobj.anchorkeyword +'"]').click(function(){
		mainobj.scrollup()
		return false
	})
	$(window).bind('scroll resize', function(e){
		mainobj.togglecontrol()
	})
	
	
});

</script>
<div class="sub-navbar">
	<div class="row">
		<div class="tags-nav col-md-6 col-lg-6 col-sm-6 col-xs-6">
			<a href="javascript:void(0)" onclick="product_list('0')">套餐</a>
			<a href="javascript:void(0)" onclick="product_list('1')">酒店</a>
			<a href="javascript:void(0)" onclick="product_list('2')">别墅</a>
			<a href="javascript:void(0)" onclick="product_list('3')">交通</a>
			<a href="javascript:void(0)" onclick="product_list('4')">娱乐</a>
		</div>
		<div class="continent-nav col-md-6 col-lg-6 col-sm-6 col-xs-6" id="search_continent">
		</div>
		<script type="text/javascript">
			function product_list(obj){
				var url = '<%=basePath%>product/product_list.html?ptype='+obj+'&fromFlag=1';
/* 				var countryDetail = $("#countryDetail").val();
				var cityDetail = $("#cityDetail").val();
				
				if(countryDetail != null || countryDetail != ''){
					url += '&countryId='+countryDetail
				}
				if(cityDetail != null || cityDetail != ''){
					url += '&cityId='+cityDetail
				} */
				window.location.href=url;
			}
		
		
			$(function(){
				$.ajax({
					type:"POST",
					url:"<%=basePath%>city/ajaxGetCityList.html",
					data:{'parentId': 0},
					async:false, 
					dataType: "html",
					success: function(json){
						var result =jQuery.parseJSON(json);
						var rows = result.rows;
						var cityFrom = $("#search_continent");		
						cityFrom.empty();
						var html = '';
						$(rows).each(function(index){
							html = '<a href="<%=basePath%>home.html?continent='+rows[index].id+'#anchor_continent" class="anchor-continent" id="'+rows[index].id+'">'+rows[index].cityName+'</a>'+html;
					  	});
						cityFrom.append(html);
						
					}
				});
				
		    });
	    </script>
	</div>
</div>
<div class="clr"></div>
<!--=== End Header ===-->

<input type="hidden" value="${productType}" id="productType"/>
<input type="hidden" value="${pid}" id="pid"/>
<!-- ==left content -->
<div class="left_content fl">
<table id="order_table">
	<thead>
		<tr>
			<th class="th1"><a href="javascript:void(0)" id="expendBtn1"><img alt="" src="<%=basePath%>assets/img/UI/expend_l.png"></a></th>
			<th class="th2">
				<c:if test="${empty loginUser.id}">
					<div id="l_header_content" class="p_name fl" style="width: 100%;text-align: right;">
				    	<a href="<%=basePath%>toregister.html">快速注册</a>
			    	</div>
				</c:if>
				<c:if test="${not empty loginUser.id}">
					<div  id="l_header_content">
						<a href="<%=basePath%>personal/myorder.html?page=1&pageSize=10">
						<img class="p_img fl" alt="" src="${empty loginUser.photo ? '../assets/img/personal/p_tmp.png':loginUser.photo}">
						</a>
						<div class="p_name fl">
					    <p><a style="padding-right:0px" href="<%=basePath%>personal/myorder.html?page=1&pageSize=10">
					    <c:choose> 
					     <c:when test="${fn:length(loginUser.username) > 12}"> 
					      <c:out value="${fn:substring(loginUser.username, 0, 12)}..." /> 
					     </c:when> 
					     <c:otherwise> 
					      <c:out value="${loginUser.username}" /> 
					     </c:otherwise>
					    </c:choose>
					    </a>
					    </p>
					    	<p class="p2"><a href="<%=basePath%>/loginOut.html" id="signOutBtn"><img alt="" src="<%=basePath%>assets/img/UI/sign-out_1.png"></a></p>
				    	</div>
						<div class="fr p_r">
							<img class="in_line" alt="" src="<%=basePath%>assets/img/UI/line.png">
							<a href="#"><i class="fa fa-angle-down"></i></a>
						</div>
					</div>
				</c:if>
				<div class="clr"></div>
			</th>
		</tr>
	</thead>
	<tbody id="right_body">
		<%-- <tr>
			<td class="t1" id="testId1_date">
				<p class="t1_p1">28</p>
				<p class="t1_p2">Feb</p>
			</td>
			<td class="t2">
				<div class="t2_p1">
					<div class="fl">普吉</div>
					<div class="fr"><a href="#" class="angleDown" id="testId1"><i class="fa fa-angle-down"></i></a></div>
				</div>
				<div class="clr"></div>
				<div class="t2_p2">
					<div class="tag">
						<img alt="" src="<%=basePath%>assets/img/hotel/tc_icon.png">
						<span class="u_no">8</span>
					</div>
					<div class="tag">
						<img alt="" src="<%=basePath%>assets/img/hotel/jd_icon.png">
						<span class="u_no">2</span>
					</div>
					<div class="tag">
						<img alt="" src="<%=basePath%>assets/img/hotel/bs_icon.png">
						<span class="u_no">3</span>
					</div>
					<div class="tag">
						<img alt="" src="<%=basePath%>assets/img/hotel/jt_icon.png">
						<span class="u_no">1</span>
					</div>
					<div class="tag">
						<img alt="" src="<%=basePath%>assets/img/hotel/yl_icon.png">
						<span class="u_no">5</span>
					</div>
				</div>
			</td>
		</tr>
		<tr id="testId1_detail" class="data_detail">
			<td class="d1">
				<div class="top_line"></div>
				<p id="testId1_time_1">09:30</p>
				<div class="line_style"></div>
				<p id="testId1_time_2">11:30</p>
				<div class="line_style"></div>
				<p id="testId1_time_3">14:30</p>
				<div class="line_style"></div>
				<p id="testId1_time_4">18:30</p>
				<div class="line_style"></div>
				<p id="testId1_time_5">21:30</p>
				<div class="bottom_line"></div>
			</td>
			<td class="d2">
				<div class="d_content">
					<img class="arrowStyle" src="<%=basePath%>assets/img/UI/arrow_l_icon_1.png">
					<p><span class="fl">起点：普及机场</span><img class="fr iconStyle" data-type="tc" data-data="testId1_time_1" src="<%=basePath%>assets/img/UI/package_icon.png"></p>
					<div class="clr"></div>
					<p>终点：卡塔海滩酒店</p>
				</div>
				<div class="d_content">
					<img class="arrowStyle" src="<%=basePath%>assets/img/UI/arrow_l_icon_1.png">
					<p><span class="fl">浮潜</span><img class="fr iconStyle" data-type="bs" data-data="testId1_time_2" src="<%=basePath%>assets/img/UI/villa_icon.png"></p>
				</div>
				<div class="d_content">
					<img class="arrowStyle" src="<%=basePath%>assets/img/UI/arrow_l_icon_1.png">
					<p><span class="fl">起点：普及机场</span><img class="fr iconStyle" data-type="jt" data-data="testId1_time_3" src="<%=basePath%>assets/img/UI/traffic_icon.png"></p>
					<p>终点：卡塔海滩酒店</p>
				</div>
				<div class="d_content">
					<img class="arrowStyle" src="<%=basePath%>assets/img/UI/arrow_l_icon_1.png">
					<p><span class="fl">天皇秀</span><img class="fr iconStyle" data-type="yl" data-data="testId1_time_4" src="<%=basePath%>assets/img/UI/yl_icon.png"></p>
				</div>
				<div class="d_content">
					<img class="arrowStyle" src="<%=basePath%>assets/img/UI/arrow_l_icon_1.png">
					<p><span class="fl">住宿：City Hotel</span><img class="fr iconStyle" data-type="jd" data-data="testId1_time_5" src="<%=basePath%>assets/img/UI/hotel_icon.png"></p>
				</div>
			</td>
		</tr>
		
		
		<tr>
			<td class="t1" >
				<p class="t1_p1">28</p>
				<p class="t1_p2">Feb</p>
			</td>
			<td class="t2">
				<div class="t2_p1">
					<div class="fl">普吉</div>
					<div class="fr"><a href="#" class="angleDown" ><i class="fa fa-angle-down"></i></a></div>
				</div>
				<div class="clr"></div>
				<div class="t2_p2">
					<div class="tag">
						<img alt="" src="<%=basePath%>assets/img/hotel/tc_icon.png">
						<span class="u_no">8</span>
					</div>
				
				</div>
			</td>
		</tr>
	
		<tr>
			<td class="t1">
				<p class="t1_p1">28</p>
				<p class="t1_p2">Feb</p>
			</td>
			<td class="t2">
				<div class="t2_p1">
					<div class="fl">普吉</div>
					<div class="fr"><a href="#" class="angleDown" id=""><i class="fa fa-angle-down"></i></a></div>
				</div>
				<div class="clr"></div>
				<div class="t2_p2">
					<div class="tag">
						<img alt="" src="<%=basePath%>assets/img/hotel/tc_icon.png">
						<span class="u_no">8</span>
					</div>
					<div class="tag">
						<img alt="" src="<%=basePath%>assets/img/hotel/jd_icon.png">
						<span class="u_no">2</span>
					</div>
					
				</div>
			</td>
		</tr> 
		<tr>
			<td class="t1">
				<p class="t1_p1"><fmt:formatDate value="<%=new Date() %>" type="date" pattern="dd"/></p>
				<p class="t1_p2">Feb</p>
			</td>
			<td class="t2">
				<div class="t2_p1">
					<div class="fl">暂未添加任何行程</div>
					<div class="fr"><a href="#" class="angleDown" id=""><i class="fa fa-angle-down"></i></a></div>
				</div>
				<div class="clr"></div>
				<div class="t2_p2">
					<div class="fl new"><a href="#"><span class="plus">+</span>添加行程</a></div>
					<div class="fr"><img class="cal_icon" alt="" src="<%=basePath%>assets/img/UI/cal_icon.png"></div>
					<div class="clr"></div>
				</div>
			</td>
		</tr>--%>
	</tbody>
</table>

<c:if test="${empty loginUser.id}">
<!--
<div id="l_login_open">
	<div style="height:42px;width:240px;margin:20px 0 0 10px;">
		<input type="text" id="username" name="username" placeholder="用户名" style="width:220px;height:32px;padding:0 10px;border:1px solid #ddd;outline-color:#4795ff;" >
	</div>
	<div style="height:42px;width:240px;margin-left: 10px;">
		<input type="password" id="password" name="password" placeholder="密码" style="width:220px;height:32px;padding:0 10px;border:1px solid #ddd;outline-color:#4795ff;">
	</div>
	<div class="create_style" style="margin-left: 10px;height: 42px">
		<input type="button" onclick="login();" value="登录" style="width:220px;height:32px;border:none;background:#4795ff;color:#fff;outline:none;cursor:pointer" >
	</div>
	<div style="text-align:center;color:#666;font-size:12px;margin-top:10px">第三方账号登录</div>
	<div style="text-align:center;margin-top:10px;">
		<a href="https://open.weixin.qq.com/connect/qrconnect?appid=wxa4a9620e264e143f&redirect_uri=http%3A%2F%2Fwww.imyway.cn%2Fimyway%2Fwchatlogin.html&response_type=code&scope=snsapi_login&state=STATE#wechat_redirect">
			<img src="<%=basePath%>assets/img/bweixin.png" style="margin:0 5px">
		</a>
	</div>
</div>
<div  id="l_login_close" style="display: none;">
	<div><button type="button" onclick="window.location.href='<%=basePath%>toregister.html';" style="width: 42px;height: 32px;border: 1px solid #e3e3e3; background-color: #fff;font-size: 12px;margin-bottom: 10px;margin-left: 4px;">注册</button></div>
	<div><button type="button" onclick="window.location.href='<%=basePath%>tologin.html';" style="width: 42px;height: 32px;border: 1px solid #e3e3e3; background-color: #fff;font-size: 12px;margin-bottom: 10px;margin-left: 4px;">登录</button></div>
	<div><a href="https://open.weixin.qq.com/connect/qrconnect?appid=wxa4a9620e264e143f&redirect_uri=http%3A%2F%2Fwww.imyway.cn%2Fimyway%2Fwchatlogin.html&response_type=code&scope=snsapi_login&state=STATE#wechat_redirect" style="position: relative; left: 9px;"><img src="<%=basePath%>assets/img/swexin.png"></a></div>
</div>
-->
</c:if>

<div id="left_header_open" style="display: none;">

	<div class="input-append date date-picker" style="cursor: pointer;height: 42px;width:240px;margin:20px 0 0 10px;">
		<input type="text" id="startdate" placeholder="开始日期" class="dateinput" readonly="readonly">
		<span class="add-on date_picker_btn" id="date_picker_btn1" ><i class="fa fa-calendar"></i></span>
	</div>	

	<div class="create_style1" style="margin-left: 10px;height: 42px">
		<input type="button" value="开始行程安排" onclick="startSetRotue();" style="width:220px;height:32px;border:none;background:#4795ff;color:#fff;outline:none;cursor:pointer" >
	</div>
</div>
<!-- 
<div id="left_header_close" style="display: none;">
	<div><button type="button" onclick="alert('go to start')" style="width: 42px;height: 32px;border: 1px solid #e3e3e3; background-color: #fff;font-size: 12px;margin-bottom: 10px;margin-left: 4px;">开始</button></div>
	<div><button type="button" onclick="alert('go to end')" style="width: 42px;height: 32px;border: 1px solid #e3e3e3; background-color: #fff;font-size: 12px;margin-bottom: 10px;margin-left: 4px;">结束</button></div>
	<div style="background-color: #5498FB;width: 40px;height: 40px;text-align:center ;line-height: 40px;margin-left: 4px;margin-bottom: 10px;"><a href="javascript:void(0)" onclick="alert('booking')"><img src="<%=basePath%>assets/img/UI/book_icon.png"></a></div>
	<div style="border: 1px solid #e3e3e3;width: 43px;margin-left: 3px;"><img src="${empty loginUser.photo ? '../assets/tmp/man.jpg':loginUser.photo}" style="width:40px;height:40px;border:3px solid #fff" ></div>
</div>
 -->

<div id="price_style" style="display: none;">
当前价格（含税）：&nbsp;<span class="sm_r">¥</span>&nbsp;<span id="routeTotalPrice">0</span>
</div>
<div id="create_style" style="display: none;">
	<div id="add_style" onclick="addRoute();">添加一天行程</div>
	<a href="javascript:void(0)" id="createBtn" onclick="createRoute();" class="btn">生成行程单</a>
</div>
<div id="clear_btn" style="display: none;padding-top:10px">
	<a href="javascript:void(0);" id="clearRoteBtn" onclick="removeAllRoute();" class="btn">清空行程单</a>
</div>


</div>
<script type="text/javascript" src="<%=basePath%>assets/js/bootstrap-datepicker.min.js"></script>
<!--=== End left content ===-->
<script type="text/javascript">
function createRoute(){
	var str = '${routeJson}';
	var commonJson = routeJson;
	if((str!=null&&str!='')||(commonJson!=null&&commonJson!='')){
		window.location.href="<%=basePath%>personal/createRoute.html";
	}else{
		alert("暂未添加任何行程");
		return false;
	}
}



function getSrc(type){
	var src="";
	switch(type){
	case "traffic":
		src="<%=basePath%>assets/img/hotel/jt_icon.png";
	  break;
	case "package":
		src="<%=basePath%>assets/img/hotel/tc_icon.png";
	  break;
	case "ent":
		src="<%=basePath%>assets/img/hotel/yl_icon.png";
	  break;
	case "villa":
		src="<%=basePath%>assets/img/hotel/bs_icon.png";
	  break;
	case "hotel":
		src="<%=basePath%>assets/img/hotel/jd_icon.png";
	  break;
	default:
		src="";
	}
	return src;
}
function getSrcHover(type){
	var src="";
	switch(type){
	case "traffic":
		src="<%=basePath%>assets/img/UI/traffic_icon.png";
	  break;
	case "package":
		src="<%=basePath%>assets/img/UI/package_icon.png";
	  break;
	case "ent":
		src="<%=basePath%>assets/img/UI/yl_icon.png";
	  break;
	case "villa":
		src="<%=basePath%>assets/img/UI/villa_icon.png";
	  break;
	case "hotel":
		src="<%=basePath%>assets/img/UI/hotel_icon.png";
	  break;
	default:
		src="";
	}
	return src;
}



function builderRoute(data){
	if(data==null){
		$("#right_body").html('');
		$("#left_header_open").show();
		$("#price_style").hide();
		$("#create_style").hide();
		$("#clear_btn").hide();
		return;
	}
	var dateList = data.dateList;
	var html = '';
	for(var i=0;i<dateList.length;i++){
		var date = new Date(dateList[i]);
		date = date.format("yyyy-MM-dd");
		var m = date.toString().split("-")[1]+"月";
		var d = date.toString().split("-")[2];
		var addr = getAddr(data,dateList[i]);
		var leftCountry = getCountry(data,dateList[i]);
		
		//临时数据
		var typeHtml = getTypeHtml(data,dateList[i]);
		var contentHtml = routeSort(data,dateList[i],i);
		var html = html+'<tr>'
					+'<td class="t1 ischeckedClass" id="testId1_date" onclick="ischecked(this)" leftcountry="'+leftCountry+'" date="'+dateList[i]+'" timestamp="'+0+'">'
					+'<p class="t1_p1">'+d+'</p>'
					+'<p class="t1_p2">'+m+'</p>'
					+'</td>'
					+'<td class="t2">'
					+'<div class="t2_p1">'
					+'<div class="fl">'+addr
					+'</div>'
					+'<div class="fr"><a href="javascript:void(0);" class="angleDown" id="testId'+(i+1)+'" onclick="angleDown(this)"><i class="fa fa-angle-down"></i></a></div>'
					+'</div>'
					+'<div class="clr"></div>'
					+'<div class="clr"></div>'
					+'<div class="t2_p2">'+typeHtml+'</div></td></tr>'+contentHtml;
	}
	$("#right_body").html(html);
	gettotal(data);
	d_contenthover();

	if(html == ''){
		// 显示开始结束日期输入框
		$("#left_header_open").show();
		// 影藏价格，添加一天行程按钮 ，生成行程单按钮
		$("#price_style").hide();
		$("#create_style").hide();
		$("#clear_btn").hide();
	}else{
		// 显示开始结束日期输入框
		$("#left_header_open").hide();
		// 影藏价格，添加一天行程按钮 ，生成行程单按钮
		$("#price_style").show();
		$("#create_style").show();
		$("#clear_btn").show();
	}
}

/**
 * 计算总价
 */
function gettotal(data){
	var packagetotalPrice = data.packagetotalPrice;
	var hoteltotalPrice = data.hoteltotalPrice;
	var villatotalPrice = data.villatotalPrice;
	var traffictotalPrice = data.traffictotalPrice;
	var enttotalPrice = data.enttotalPrice;
	var total = 0;
	if(packagetotalPrice!=null&&packagetotalPrice!=''&&packagetotalPrice!='undefined'){
		total = total+parseFloat(packagetotalPrice);
	}
	if(hoteltotalPrice!=null&&hoteltotalPrice!=''&&hoteltotalPrice!='undefined'){
		total = total+parseFloat(hoteltotalPrice);
	}
	if(villatotalPrice!=null&&villatotalPrice!=''&&villatotalPrice!='undefined'){
		total = total+parseFloat(villatotalPrice);
	}
	if(traffictotalPrice!=null&&traffictotalPrice!=''&&traffictotalPrice!='undefined'){
		total = total+parseFloat(traffictotalPrice);
	}
	if(enttotalPrice!=null&&enttotalPrice!=''&&enttotalPrice!='undefined'){
		total = total+parseFloat(enttotalPrice);
	}
	$("#routeTotalPrice").html(total);
	
}
function routeSort(data,date,index){
	var dateList = data.dateList;
	var trafficJson = data.traffic;
	var hotelJson = data.hotel;
	var packageJson = data.package;
	var entJson = data.ent;
	var villaJson = data.villa;
	var array = new Array();
	if(packageJson!=null&&packageJson!=''&&packageJson!='undefined'){
		var package_json = packageJson[''+date+''];
		if(package_json!=null&&package_json!=''&&package_json!='undefined'){
			var list =  package_json.routeDetailInfoList;
			for(var i =0;i<list.length;i++){
				var o = list[i];
				o.pid=package_json.pid;
				o.pname=o.title;
				o.cityName=package_json.cityName;
				o.countryName=package_json.countryName;
				o.time=o.starttime;
				o.timestamp=package_json.timestamp;
				o.type="package";
				array.push(o);
			}
		}
		
	}
	if(trafficJson!=null&&trafficJson!=''&&trafficJson!='undefined'){
		var traffic_json = trafficJson[''+date+''];//数组
		if(traffic_json!=null&&traffic_json!=''&&traffic_json!='undefined'){
			for(var i =0;i<traffic_json.length;i++){
				array.push(traffic_json[i]);
			}
		}
	}
	//酒店，默认时间是23：59
	if(hotelJson!=null&&hotelJson!=''&&hotelJson!='undefined'){
		var hotel_json = hotelJson[''+date+''];
		if(hotel_json!=null&&hotel_json!=''&&hotel_json!='undefined'){
			array.push(hotel_json);
		}
	}
	//娱乐
	if(entJson!=null&&entJson!=''&&entJson!='undefined'){
		var ent_json = entJson[''+date+''];
		if(ent_json!=null&&ent_json!=''&&ent_json!='undefined'){
			for(var i =0;i<ent_json.length;i++){
				var pid = ent_json[i].pid;
				var pname = ent_json[i].pname;
				var cityName = ent_json[i].cityName;
				var countryName = ent_json[i].countryName;
				var list = ent_json[i].entRouteDetailInfoList;
				for(var j =0;j<list.length;j++){
					var o = list[j];
					o.pid=pid;
					o.pname=list[j].title;
					o.cityName=cityName;
					o.countryName=countryName;
					o.time=o.starttime;
					o.timestamp=ent_json[i].timestamp;
					o.type="ent";
					array.push(o);
				}
			}
		}
	}
	//别墅，默认时间是23：59
	if(villaJson!=null&&villaJson!=''&&villaJson!='undefined'){
		var villa_json = villaJson[''+date+''];//数组
		if(villa_json!=null&&villa_json!=''&&villa_json!='undefined'){
			var o = villa_json;
			array.push(o);
		}
	}
	
	//排序
	if(array.length>0){
		JsonSort(array,'time'); 
	}
	return timeHtml(array,index);
}

function timeHtml(array,index){
	var html ='<tr id="testId'+(parseInt(index)+1)+'_detail" class="data_detail"><td class="d1">';
	var timehtml = '';
	var contentHtml = '';
	for(var i=0;i<array.length;i++){
		var class_ = 'line_style';
		if(i==0){
			class_ = 'top_line';
		}
		timehtml=timehtml+'<div class="'+class_+'"></div><p id="testId1_time_'+(i+1)+'" timestamp="'+array[i].timestamp+'">'+array[i].time+'</p>';
		
		if(i==array.length-1){
			timehtml = timehtml+'<div class="bottom_line"></div>';
			
		}
	<%-- 交通--班车
	<div class="d_content">
		<img class="arrowStyle" src="<%=basePath%>assets/img/UI/arrow_l_icon_1.png">
		<p><span class="fl">起点：普及机场</span><img class="fr iconStyle" data-type="tc" data-data="testId1_time_1" src="<%=basePath%>assets/img/UI/package_icon.png"></p>
		<div class="clr"></div>
		<p>终点：卡塔海滩酒店</p>
	</div> --%>
	var src = getSrcHover(array[i].type);
	var pname = array[i].pname;
	if(pname.length>10){
		pname = pname.substring(0,9)+"...";
	}
	var commonSrc = "<%=basePath%>assets/img/UI/arrow_l_icon_1.png";
	contentHtml = contentHtml+'<div class="d_content" hover="d_contenthover(this)"><img class="arrowStyle" src="'+commonSrc+'">'
				+'<p><span class="fl" title="'+array[i].pname+'">'+pname + '</p>'
				+'<img class="fr iconStyle" data-type="'+array[i].type+'" data-data="testId1_time_'+(i+1)+'" src="'+src+'"></div>';
	}
	
	
	html = html + timehtml +'</td><td class="d2">'+contentHtml+'</td></tr>';
	return html;
}


//排序
function JsonSort(json,key){
    for(var j=1,jl=json.length;j < jl;j++){
        var temp = json[j];
            var val  = parseInt(temp[key].split(":")[0]+""+temp[key].split(":")[1]);
            i  = j-1;
        while(i >=0 && parseInt(json[i][key].split(":")[0]+""+json[i][key].split(":")[1])>val){
            json[i+1] = json[i];
            i = i-1;    
        }
        json[i+1] = temp;

    }
    return json;
}


function getTypeHtml(data,date){
	var dateList = data.dateList;
	var trafficJson = data.traffic;
	var hotelJson = data.hotel;
	var packageJson = data.package;
	var entJson = data.ent;
	var villaJson = data.villa;
	var html ='';
	if(packageJson!=null&&packageJson!=''&&packageJson!='undefined'){
		var json = packageJson[''+date+''];
		if(json!=null&&json!=''&&json!='undefined'){
			var src = getSrc("package");

			var list = json.routeDetailInfoList;
			if(list.length!=0){
				html = html +'<div class="tag" onclick="showDayRoute(this)">'
						+'<a href="javascript:void(0);" class="angleDown" onclick="angleDown(this)">'
						+'<img alt="" src="'+src+'">'
						+'<span class="u_no">'+list.length+'</span></a></div>';
			}
		}
	}
	if(hotelJson!=null&&hotelJson!=''&&hotelJson!='undefined'){
		var json = hotelJson[''+date+''];
		if(json!=null&&json!=''&&json!='undefined'){
			var src = getSrc("hotel");
			html = html +'<div class="tag" onclick="showDayRoute(this)">'
					+'<img alt="" src="'+src+'">'
					+'<span class="u_no">1</span></div>';
		}
	}
	if(villaJson!=null&&villaJson!=''&&villaJson!='undefined'){
		var json = villaJson[''+date+''];
		if(json!=null&&json!=''&&json!='undefined'){
			if(json!=null&&json!=''&&json!='undefined'){
				var src = getSrc("villa");
				html = html +'<div class="tag"  onclick="showDayRoute(this)">'
						+'<img alt="" src="'+src+'">'
						+'<span class="u_no">1</span></div>';
			}
		}
	}
	if(trafficJson!=null&&trafficJson!=''&&trafficJson!='undefined'){
		var json = trafficJson[''+date+''];
		if(json!=null&&json!=''&&json!='undefined'){
			var src = getSrc("traffic");
			html = html +'<div class="tag" onclick="showDayRoute(this)">'
					+'<img alt="" src="'+src+'">'
					+'<span class="u_no">'+json.length+'</span></div>';
		}
	}
	if(entJson!=null&&entJson!=''&&entJson!='undefined'){
		var json = entJson[''+date+''];
		if(json!=null&&json!=''&&json!='undefined'){
			var src = getSrc("ent");
			var n = 0;
			for(var j = 0;j<json.length;j++){
				var list = json[j].entRouteDetailInfoList;
				if(list.length!=0){
					n = n+list.length;
				}
			}
			if(n!=0){
				html = html +'<div class="tag" onclick="showDayRoute(this)">'
						+'<img alt="" src="'+src+'">'
						+'<span class="u_no">'+n+'</span></div>';
			}
		}
	}
	return html;
	
}


function getAddr(data,date){
	var packageJson = data.package;
	var trafficJson = data.traffic;
	var hotelJson = data.hotel;
	var entJson = data.ent;
	var villaJson = data.villa;
	var addr = ''; 
	//优先套餐
	if(packageJson!=null&&packageJson!=''&&packageJson!='undefined'){
		var json = packageJson[''+date+''];
		if(json!=null&&json!=''&&json!='undefined'){
			return json.cityName;
		}
	}
	if(villaJson!=null&&villaJson!=''&&villaJson!='undefined'){
		var json = villaJson[''+date+''];
		if(json!=null&&json!=''&&json!='undefined'){
			return json.cityName;
		}
	}
	if(hotelJson!=null&&hotelJson!=''&&hotelJson!='undefined'){
		var json = hotelJson[''+date+''];
		if(json!=null&&json!=''&&json!='undefined'){
			return json.cityName;
		}
	}
	if(entJson!=null&&entJson!=''&&entJson!='undefined'){
		var json = entJson[''+date+''];
		if(json!=null&&json!=''&&json!='undefined'){
			return json[0].cityName;
		}
	}
	if(trafficJson!=null&&trafficJson!=''&&trafficJson!='undefined'){
		var json = trafficJson[''+date+''];
		if(json!=null&&json!=''&&json!='undefined'){
			return json[0].cityName;
		}
	}
}

function getCountry(data,date){
	var packageJson = data.package;
	var trafficJson = data.traffic;
	var hotelJson = data.hotel;
	var entJson = data.ent;
	var villaJson = data.villa;
	var addr = ''; 
	//优先套餐
	if(packageJson!=null&&packageJson!=''&&packageJson!='undefined'){
		var json = packageJson[''+date+''];
		if(json!=null&&json!=''&&json!='undefined'){
			return json.leftCountry;
		}
	}
	if(villaJson!=null&&villaJson!=''&&villaJson!='undefined'){
		var json = villaJson[''+date+''];
		if(json!=null&&json!=''&&json!='undefined'){
			return json.leftCountry;
		}
	}
	if(hotelJson!=null&&hotelJson!=''&&hotelJson!='undefined'){
		var json = hotelJson[''+date+''];
		if(json!=null&&json!=''&&json!='undefined'){
			return json.leftCountry;
		}
	}
	if(entJson!=null&&entJson!=''&&entJson!='undefined'){
		var json = entJson[''+date+''];
		if(json!=null&&json!=''&&json!='undefined'){
			return json[0].leftCountry;
		}
	}
	if(trafficJson!=null&&trafficJson!=''&&trafficJson!='undefined'){
		var json = trafficJson[''+date+''];
		if(json!=null&&json!=''&&json!='undefined'){
			return json[0].leftCountry;
		}
	}
}



function ischecked(obj){
	$(".ischeckedClass").css({"background-image":"none","border-bottom":"1px solid #E5E5E5"});
	/* $(".ischeckedClass").find(".t1_p1").css("color","#666"); */
	
	$(obj).css({"background-image":"url('<%=basePath%>assets/img/UI/timeBak.png')","background-repeat":"no-repeat", "border-bottom":"0"});
	/* $(obj).find(".t1_p1").css("color","#fff"); */
	
	var date = $(obj).attr("date");
	$.session.set('checkeddate', date);
	getpriceItemDetail(date);
	$("#childDate").val(date);
}

//TODO 小黄同学 ，此处 暂时值调用你的intiRoute方法 设定左侧开始时间，回头你改一下让他能设定上开始和结束区间日期
function startSetRotue(){
	var stardt = $("#startdate").val();
	addStartTime(stardt);
	var date =new Date();
	var seperator1 = "-";
	var year  = date.getFullYear();
	var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = year + seperator1 + month + seperator1 + strDate;
	
	
	if(stardt == null || stardt.trim() == ""){
		alert("请输入行程开始时间");
		return;
	}
	
	var stardttimestamp = Date.parse(stardt);
	var currentdatetimestamp = Date.parse(currentdate);
	if(stardttimestamp <=  currentdatetimestamp){
		alert("开始时间必须大于当前日期");
		return;
	}

	// 隐藏开始结束日期输入框
	$("#left_header_open").hide();
	
	// 显示价格，添加一天行程按钮 ，生成行程单按钮
	$("#price_style").show();
	$("#create_style").show();
	$("#clear_btn").show();
	//$("#add_style").show();
	var myDate = new Date(stardt);
	myDate=myDate.valueOf();
    
    myDate=myDate -1 * 24 * 60 * 60 * 1000;
    dd = new Date(myDate);

    <c:if test="${productList == 'list'}">
    	seachObject();
    </c:if>
	intiRoute(dd);
}


function showDayRoute(obj){
	var obj = $(obj).parents("td").find(".angleDown");
	var icon = $(obj).find("i");
	if(icon.hasClass("fa-angle-down")){
		icon.removeClass("fa-angle-down");
		icon.addClass("fa-angle-up");
		$("#"+$(obj).attr("id")+"_date").css({"background-image":"url('<%=basePath%>assets/img/UI/timeBak.png')",
			"background-repeat":"no-repeat", "border-bottom":"0"});
		/* $("#"+$(obj).attr("id")+"_date>.t1_p1").css("color","#fff");
		$("#"+$(obj).attr("id")+"_date>.t1_p2").css("color","#fff"); */
		$("#"+$(obj).attr("id")+"_detail").show();
		
	}else{
		icon.removeClass("fa-angle-up");
		icon.addClass("fa-angle-down");		
		$("#"+$(obj).attr("id")+"_date").css({"background-image":"none",
			"border-bottom":"1px solid #E5E5E5"});
		/* $("#"+$(obj).attr("id")+"_date>.t1_p1").css("color","#666");
		$("#"+$(obj).attr("id")+"_date>.t1_p2").css("color","#999"); */
		$("#"+$(obj).attr("id")+"_detail").hide();
	}
}

var selectDateIndex = 1;
function intiRoute(date){
	firstflg = true; 
	var m='';
	var d='';
	var dd='';
	if(date==null){
		// 显示开始结束日期输入框
		$("#left_header_open").show();
		// 影藏价格，添加一天行程按钮 ，生成行程单按钮
		$("#price_style").hide();
		$("#create_style").hide();
		$("#clear_btn").hide();
		return;
	}else{
		var myDate = new Date(date);
		myDate=myDate.valueOf();
        
	    myDate=myDate +1 * 24 * 60 * 60 * 1000;
	    dd = new Date(myDate);
	
		$("#create_style").show();
		$("#clear_btn").show();
	}
	dd = dd.format("yyyy-MM-dd");
	m = dd.toString().split("-")[1]+"月";
	d = dd.toString().split("-")[2];
	
	
    var html ='<tr><td class="t1 ischeckedClass" onclick="ischecked(this)" date="'+dd+'">'
			  +'<p class="t1_p1">'+d+'</p>'
			  +'<p class="t1_p2">'+m+'</p>'
			  +'</td>'
			  +'<td class="t2">'
			  +'<div class="t2_p1">'
			  +'<div class="fl">暂未添加任何行程</div>'
			  +'<div class="fr"><a href="javascript:void(0);" class="angleDown" id=""><i class="fa fa-angle-down"></i></a></div>'
			  +'</div>'
			  +'<div class="clr"></div>'
			  +'<div class="t2_p2">'
			  +'<div class="fl new"><a href="javascript:void(0);"><span class="plus">+</span>添加行程</a></div>'
			  +'<div class="fr input-append date"  style="position: relative;">'
			 
			  +'<img  class="cal_icon" alt="" src="<%=basePath%>assets/img/UI/cal_icon.png">'
			 
			  +' <input  type="text" value="2012-06-15 14:45" readonly'
			  + ' id="selectDate_'+selectDateIndex+'" style="height: 20px; width: 20px;  position: absolute; z-index: 99999;top:10px; right:10px;cursor: pointer;filter:alpha(opacity=0);-moz-opacity:0;opacity:0;"  onclick="myShowDatePicker(this)">'
			  +'</div>'
			  +'<div class="clr"></div>'
			  +'</div></td></tr>'
			  <c:if test="${productList == 'list'}">
			  +'<script type="text/javascript">'
			  +'jQuery(document).ready(function() {'
			  +'  $(".t1").click(function(){'
			  +'		$("#endTime").val($(this).attr("date"));'
			  +'		setTimeout(function(){'
			  +'			seachObject();'
			  +'		},500);'
			  +'	});'
			  +'});'
			  +'<\/script>'
			  </c:if>
			  ;
	  selectDateIndex ++;
	  var str='';
	  if(routeJson==null||routeJson==''){
		  str = '${routeJson}';
	  }else{
	  	str = routeJson;
	  }
	if(str!=null&&str!=''){
		$("#right_body").append(html);
	}else{
		$("#right_body").html(html);
		$("#routeTotalPrice").html(0);
	}
	
	return dd;
}

var firstflg = true; 
function myShowDatePicker(obj){
//	if(firstflg){
	var dayNow = $(obj).parent().parent().parent().siblings().attr("date");
	var eleid = $(obj).attr("id") ;
	$("#"+eleid).datepicker({
		  format: "yyyy-mm-dd",
		  autoclose: true,
		  todayHighlight: true,
		  language: "cn", 
		  startDate:new Date(),
		  defaultDate: dayNow
	  }).on('changeDate', function(ev){
		 // console.log(ev);
		
		  if(ev.date != undefined){
			$(obj).parent().parent().parent().siblings().find(".t1_p1").text(ev.date.getDate());
	//	    $(".t1>.t1_p1").text(ev.date.getDate());
		    var month = ev.date.getMonth()+1;
		    //$(".t1>.t1_p2").text(month+"月");	
		    $(obj).parent().parent().parent().siblings().attr("date",ev.date.format("yyyy-MM-dd"))
		    $(obj).parent().parent().parent().siblings().find(".t1_p2").text(month+"月");
		    addDateTime(ev.date.format("yyyy-MM-dd"));	
		  }
		});
	
	  $('#'+eleid).datepicker('show');
//	  firstflg = false;
//	}
}

function addRoute(){
	var tr = $("#right_body").find("tr");
	if($(tr).html()!=null&&$(tr).html()!=''&&$(tr).html()!='undefined'&&$(tr).html()!=undefined){
		  var str='';
		  if(routeJson==null||routeJson==''){
			  str = '${routeJson}';
		  }else{
		  	str = routeJson;
		  }
		  var data ='';
		  if(typeof str=='string'){
			  data = eval("("+str+")");
		  }else{
			  data = str
		  }
		  var dateList= data.dateList;
		  var time = new Date(dateList[dateList.length-1]);
		var date = $(tr).eq(tr.length-1).find("td").eq(0).attr("date");
		
		if(date!=null&&date!=''&&date!='undefined'&&date!=undefined){
		}else{
			var date = $(tr).eq(tr.length-2).find("td").eq(0).attr("date");
			if(date==dateList[dateList.length-1]){
				var addDate = intiRoute(time);
				addDateTime(addDate);
			}
		}
	}else{
		var time = new Date();
		var addDate = intiRoute(time);
		addDateTime(addDate);
	}
	
}



function angleDown(obj){
	var icon = $(obj).find("i");
	if(icon.hasClass("fa-angle-down")){
		icon.removeClass("fa-angle-down");
		icon.addClass("fa-angle-up");
		$("#"+$(obj).attr("id")+"_date").css({"background-image":"url('<%=basePath%>assets/img/UI/timeBak.png')",
			"background-repeat":"no-repeat", "border-bottom":"0"});
		/* $("#"+$(obj).attr("id")+"_date>.t1_p1").css("color","#fff");
		$("#"+$(obj).attr("id")+"_date>.t1_p2").css("color","#fff"); */
		$("#"+$(obj).attr("id")+"_detail").show();
		
	}else{
		icon.removeClass("fa-angle-up");
		icon.addClass("fa-angle-down");		
		$("#"+$(obj).attr("id")+"_date").css({"background-image":"none",
			"border-bottom":"1px solid #E5E5E5"});
		/* $("#"+$(obj).attr("id")+"_date>.t1_p1").css("color","#666");
		$("#"+$(obj).attr("id")+"_date>.t1_p2").css("color","#999"); */
		$("#"+$(obj).attr("id")+"_detail").hide();
	}
}

function d_contenthover(){
	$(".d_content").hover(function(){
		$(this).css("border-color","#C9E7DB");
		$(this).find(".iconStyle").attr("src","<%=basePath%>assets/img/UI/close_icon.png").click(function(){
			var date = $(this).parents("tr").prev().find("td").eq(0).attr("date");
			var index = $(this).parents("div").index();
			var timestamp = $(this).parents("td").prev().find("p").eq(index).attr("timestamp");
			var type = $(this).data("type");
			if(type=='package'){
				var bool = window.confirm("确认删除吗？注意：删除套餐将会删除整个套餐");
				if(!bool){
					return false;
				}
			}else if(type=='villa'){
				var bool = window.confirm("确认删除吗？注意：删除该天别墅将会删除这个别墅所有所在日期");
				if(!bool){
					return false;
				}
			}
			removeRouteAttr(type,date,timestamp);
		});
		$("#"+$(this).find(".iconStyle").data("data")).css("color","#51BC90");

	},function(){
		var icon = $(this).find(".iconStyle");
		$(this).css("border-color","#eee");
		if(icon.data("type")=="package"){
			icon.attr("src","<%=basePath%>assets/img/UI/package_icon.png");
		}else if(icon.data("type")=="villa"){
			icon.attr("src","<%=basePath%>assets/img/UI/villa_icon.png");
		}else if(icon.data("type")=="ent"){
			icon.attr("src","<%=basePath%>assets/img/UI/yl_icon.png");
		}else if(icon.data("type")=="hotel"){
			icon.attr("src","<%=basePath%>assets/img/UI/hotel_icon.png");
		}else if(icon.data("type")=="traffic"){
			icon.attr("src","<%=basePath%>assets/img/UI/traffic_icon.png");
		}
		icon.unbind( "click" );
		/* $("#"+$(this).find(".iconStyle").data("data")).css("color","#666"); */
	});


}

//对Date的扩展，将 Date 转化为指定格式的String   
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
//例子：   
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423   
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18   
Date.prototype.format = function(fmt) { //author: meizz   
	var o = {
		"M+" : this.getMonth() + 1, //月份   
		"d+" : this.getDate(), //日   
		"h+" : this.getHours(), //小时   
		"m+" : this.getMinutes(), //分   
		"s+" : this.getSeconds(), //秒   
		"q+" : Math.floor((this.getMonth() + 3) / 3), //季度   
		"S" : this.getMilliseconds()
	//毫秒   
	};
	if (/(y+)/.test(fmt))
		fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(fmt))
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]): (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt;
}

$(function(){
	var str = '${routeJson}';
	if(str!=null&&str!=''){
		var data = eval("(" + '${routeJson}' + ")");
		builderRoute(data);
	}else{
		var stardt = '${stardt}';
		if(stardt!=null&&stardt!=''){
			stardt = new Date(stardt);
			
			var a = stardt.valueOf();
			a = a - 1 * 24 * 60 * 60 * 1000;
			stardt = new Date(a);;
			
		}else{
			stardt = null;
		}
		intiRoute(stardt);
	}
	
	if('${addDate}' != null){
		var addDate = '${addDate}';
		if(addDate!=null&&addDate!=''){
			addDate = new Date(addDate);
			
			var a = addDate.valueOf();
			a = a - 1 * 24 * 60 * 60 * 1000;
			addDate = new Date(a);;
			intiRoute(addDate);	
		}
	}
	var date = $(".t1").attr('date');
	if(date == 'undefined' || date==null || date==''){
		
	}else{
		getpriceItemDetail(date);
	}
	<%-- $(".angleDown").click(function(){
		var icon = $(this).find("i");
		if(icon.hasClass("fa-angle-down")){
			icon.removeClass("fa-angle-down");
			icon.addClass("fa-angle-up");
			alert($(this).attr("id"));
			$("#"+$(this).attr("id")+"_date").css({"background-image":"url('<%=basePath%>assets/img/UI/timeBak.png')",
				"background-repeat":"no-repeat", "border-bottom":"0"});
			$("#"+$(this).attr("id")+"_date>.t1_p1").css("color","#fff");
			$("#"+$(this).attr("id")+"_date>.t1_p2").css("color","#fff");
			$("#"+$(this).attr("id")+"_detail").show();
			
		}else{
			icon.removeClass("fa-angle-up");
			icon.addClass("fa-angle-down");		
			$("#"+$(this).attr("id")+"_date").css({"background-image":"none",
				"border-bottom":"1px solid #E5E5E5"});
			$("#"+$(this).attr("id")+"_date>.t1_p1").css("color","#666");
			$("#"+$(this).attr("id")+"_date>.t1_p2").css("color","#999");
			$("#"+$(this).attr("id")+"_detail").hide();
		}
	}); --%>
	
	<%-- $(".d_content").hover(function(){
		$(this).css("border-color","#C9E7DB");
		$(this).find(".iconStyle").attr("src","<%=basePath%>assets/img/UI/close_icon.png").click(function(){
			var date = $(this).parents("tr").prev().find("td").eq(0).attr("date");
			var index = $(this).parents("div").index();
			var timestamp = $(this).parents("td").prev().find("p").eq(index).attr("timestamp");
			var type = $(this).data("type");
			var date = $(this).parents("tr").prev().find("td").eq(0).attr("date");
			var index = $(this).parents("div").index();
			var timestamp = $(this).parents("td").prev().find("p").eq(index).attr("timestamp");
			var type = $(this).data("type");
			if(type=='package'){
				var bool = window.confirm("确认删除吗？注意：删除套餐将会删除整个套餐");
				if(!bool){
					return false;
				}
			}else if(type=='villa'){
				var bool = window.confirm("确认删除吗？注意：删除该天别墅将会删除这个别墅所有所在日期");
				if(!bool){
					return false;
				}
			}
			removeRouteAttr(type,date,timestamp);
		});
		$("#"+$(this).find(".iconStyle").data("data")).css("color","#51BC90");

	},function(){
		var icon = $(this).find(".iconStyle");
		$(this).css("border-color","#eee");
		if(icon.data("type")=="package"){
			icon.attr("src","<%=basePath%>assets/img/UI/package_icon.png");
		}else if(icon.data("type")=="villa"){
			icon.attr("src","<%=basePath%>assets/img/UI/villa_icon.png");
		}else if(icon.data("type")=="ent"){
			icon.attr("src","<%=basePath%>assets/img/UI/yl_icon.png");
		}else if(icon.data("type")=="hotel"){
			icon.attr("src","<%=basePath%>assets/img/UI/hotel_icon.png");
		}else if(icon.data("type")=="traffic"){
			icon.attr("src","<%=basePath%>assets/img/UI/traffic_icon.png");
		}
		icon.unbind( "click" );
		$("#"+$(this).find(".iconStyle").data("data")).css("color","#666");
	}); --%>
});

function shCircleLoaderLoading(){
   	$('#shclDefault').show();
   	$("#mask").show();
   	$('#shclDefault').shCircleLoader();
}
   
function shCircleLoaderDestroy(){
	$('#shclDefault').shCircleLoader('destroy');
	$('#shclDefault').hide();
	$("#mask").hide();
}
   
function login(){
	var username = $("#username").val().trim();
	var password = $("#password").val().trim();
	if(username == null || username == ""){
		alert("请填写用户名");
		return false;
	}
	if(password == null || password == ""){
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
        		location.reload();
        	}else{
        		alert(data);
        	}
        }    
    });
}
</script>
<sitemesh:write property='body'/>

</div>

<!-- ===footer -->
<div id="bottom_content" style="margin: 0 auto;min-width: 1180px;max-width: 1600px;">
	<div class="footer ">
		<div class="footer1">
			<div class=" footer-content fl" >
				<div><a href="<%=basePath%>aboutUs.html">关于我们</a></div>
				<div><a href="<%=basePath%>job.html">人才招聘</a></div>
				<div><a href="javascript:void(0);">隐私条款</a></div>
				<div><img alt="微博" src="<%=basePath%>assets/img/wb_icon.png" class="rel">&nbsp;<a href="javascript:void(0);">微博</a></div>
				<div><img alt="淘宝" src="<%=basePath%>assets/img/UI/tao.png" class="rel">&nbsp;<div class="foot_tooltip"  
				style="margin-right: 0;" title="&lt;img src=&quot;<%=basePath%>assets/img/UI/taobao_ew.png&quot; /&gt; ">淘宝</div></div>
				<div><img alt="微信" src="<%=basePath%>assets/img/wx_icon.png" class="rel">&nbsp;<div class="foot_tooltip"  
				style="margin-right: 0;" title="&lt;img src=&quot;<%=basePath%>assets/img/UI/taobao_ew.png&quot; /&gt; ">微信</div></div>
				<div><img alt="微信订阅号" src="<%=basePath%>assets/img/wx_icon.png" class="rel">&nbsp;<div class="foot_tooltip"  
				style="margin-right: 0;" title="&lt;img src=&quot;<%=basePath%>assets/img/UI/taobao_ew.png&quot; /&gt; ">微信订阅号</div></div>
				<div><img alt="微信服务号" src="<%=basePath%>assets/img/wx_icon.png" class="rel">&nbsp;<div class="foot_tooltip"  
				style="margin-right: 0;" title="&lt;img src=&quot;<%=basePath%>assets/img/UI/taobao_ew.png&quot; /&gt; ">微信服务号</div></div>
			</div>
			<div class=" footer-copyright fr" >Copyright © 2014 麦味旅行 All Rights Reserved</div>
		</div>
	</div>
</div>

<div class="clr"></div>
<!-- ===End footer -->
</body>
<script type="text/javascript" src="<%=basePath%>assets/js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript">
$(function() {
	var kt = getCookie("knowTip");
	if(kt !="y" ){
		setMaskTip();
	}
	
	$('.foot_tooltip').tooltipster({
		contentAsHTML: true
	});
});
function setTipStatus(){
	Setcookie("knowTip","y");
	$("#tipmask").remove();
}

function setMaskTip(){
	var html = '<div id="tipmask" style="width: 100%;height: 100%;  position: absolute; z-index: 1000000; ">'+
	'<img src="<%=basePath%>assets/img/tip/tip_2_1.jpg" usemap="#Tip21" style="width: 1663px; margin: 0 auto;display: block;">'+
	'<map name="Tip21" id="Tip21">'+
	  '<area shape="rect" coords="320,154,430,192"  onclick="setTipStatus()"/>'+
	  '<area shape="rect" coords="320,370,430,404"   onclick="setTipStatus()"/>'+
	  '<area shape="rect" coords="137,577,248,612"   onclick="setTipStatus()"/>'+
	  '<area shape="rect" coords="430,815,540,850"   onclick="setTipStatus()"/>'+
	'</map>'+
	'</div>';
	$("body").prepend(html);
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

$('.date-picker').datepicker({
    	format: 'yyyy-mm-dd',
        autoclose: true,
        todayHighlight: true,
        language: 'cn'//en,
    });


</script>

<script type='text/javascript'>
    (function(m, ei, q, i, a, j, s) {
        m[a] = m[a] || function() {
            (m[a].a = m[a].a || []).push(arguments)
        };
        j = ei.createElement(q),
            s = ei.getElementsByTagName(q)[0];
        j.async = true;
        j.src = i;
        s.parentNode.insertBefore(j, s)
    })(window, document, 'script', '//eco-api.meiqia.com/dist/meiqia.js', '_MEIQIA');
    _MEIQIA('entId', 1937);
</script>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-70680149-1', 'auto');
  ga('send', 'pageview');
//UA-70680149-1

//jquerySession
(function($){

    $.session = {

        _id: null,

        _cookieCache: undefined,

        _init: function()
        {
            if (!window.name) {
                window.name = Math.random();
            }
            this._id = window.name;
            this._initCache();

            // See if we've changed protcols

            var matches = (new RegExp(this._generatePrefix() + "=([^;]+);")).exec(document.cookie);
            if (matches && document.location.protocol !== matches[1]) {
               this._clearSession();
               for (var key in this._cookieCache) {
                   try {
                   window.sessionStorage.setItem(key, this._cookieCache[key]);
                   } catch (e) {};
               }
            }

            document.cookie = this._generatePrefix() + "=" + document.location.protocol + ';path=/;expires=' + (new Date((new Date).getTime() + 120000)).toUTCString();

        },

        _generatePrefix: function()
        {
            return '__session:' + this._id + ':';
        },

        _initCache: function()
        {
            var cookies = document.cookie.split(';');
            this._cookieCache = {};
            for (var i in cookies) {
                var kv = cookies[i].split('=');
                if ((new RegExp(this._generatePrefix() + '.+')).test(kv[0]) && kv[1]) {
                    this._cookieCache[kv[0].split(':', 3)[2]] = kv[1];
                }
            }
        },

        _setFallback: function(key, value, onceOnly)
        {
            var cookie = this._generatePrefix() + key + "=" + value + "; path=/";
            if (onceOnly) {
                cookie += "; expires=" + (new Date(Date.now() + 120000)).toUTCString();
            }
            document.cookie = cookie;
            this._cookieCache[key] = value;
            return this;
        },

        _getFallback: function(key)
        {
            if (!this._cookieCache) {
                this._initCache();
            }
            return this._cookieCache[key];
        },

        _clearFallback: function()
        {
            for (var i in this._cookieCache) {
                document.cookie = this._generatePrefix() + i + '=; path=/; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
            }
            this._cookieCache = {};
        },

        _deleteFallback: function(key)
        {
            document.cookie = this._generatePrefix() + key + '=; path=/; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
            delete this._cookieCache[key];
        },

        get: function(key)
        {
            return window.sessionStorage.getItem(key) || this._getFallback(key);
        },

        set: function(key, value, onceOnly)
        {
            try {
                window.sessionStorage.setItem(key, value);
            } catch (e) {}
            this._setFallback(key, value, onceOnly || false);
            return this;
        },
        
        'delete': function(key){
            return this.remove(key);
        },

        remove: function(key)
        {
            try {
            window.sessionStorage.removeItem(key);
            } catch (e) {};
            this._deleteFallback(key);
            return this;
        },

        _clearSession: function()
        {
          try {
                window.sessionStorage.clear();
            } catch (e) {
                for (var i in window.sessionStorage) {
                    window.sessionStorage.removeItem(i);
                }
            }
        },

        clear: function()
        {
            this._clearSession();
            this._clearFallback();
            return this;
        }

    };

    $.session._init();

})(jQuery);
</script>
</html>
