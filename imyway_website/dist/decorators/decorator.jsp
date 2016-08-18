<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
<!--[if IE 8]> <html lang="zh-CN" class="ie8"> <![endif]-->  
<!--[if IE 9]> <html lang="zh-CN" class="ie9"> <![endif]-->  
<!--[if !IE]><!--> <html lang="zh-CN"> <!--<![endif]--> 
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<c:import url="../keywords.jsp"></c:import>
<!-- Favicon -->
<link rel="shortcut icon" href="<%=basePath%>assets/img/favicon.png">
<!-- Bootstrap -->
<link href="<%=basePath%>assets/plugins/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="<%=basePath%>assets/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="<%=basePath%>assets/plugins/tooltipster/tooltipster.css" rel="stylesheet" type="text/css">

<!-- custom -->
<link href="<%=basePath%>assets/css/custom.css" rel="stylesheet" type="text/css">
<style type="text/css">
.foot_tooltip{color: #fff; margin-right: 0;cursor: pointer;}
</style>
<sitemesh:write property='head'/>
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
<style type="text/css">
.navbar-custom{padding: 0;position: relative;}

.navbar-nav-custom .nav-custom{margin-left: 112px;}
.sub-navbar .row .tags-nav{padding-left: 112px;}

.navbar-custom1 .nav-custom li {
    float: left;
    list-style: outside none none;
    border-right: 1px solid #e5e5e5;
}
.navbar-custom .nav-custom li {
    float: left;
    list-style: outside none none;
    border-right: 1px solid #e5e5e5;
}
.navbar-custom1 .nav-custom li a{background-color: transparent;color: #666;}
.navbar-custom .nav-custom li a{background-color: transparent;color: #666;}
.navbar-custom1 .nav-custom li a:hover {
    color: #529CFF;
    text-decoration: none;
    background-color: transparent;
}
.navbar-custom .nav-custom li a:hover {
    color: #529CFF;
    text-decoration: none;
    background-color: transparent;
}
</style>
</head>
<body class="global">
<%--
<div id="tipmask" style="width: 100%;height: 100%; background-color: #000; position: absolute; z-index: 1000000; ">
	<img src="<%=basePath%>assets/img/tip/tip_1.jpg" style="width: 1663px; margin: 0 auto;display: block;">
	<img src="<%=basePath%>assets/img/tip/search_tip.png" border="0" usemap="#searchTip" 
	style="position: absolute;top:50px;left: 1130px;"/>
	<map name="searchTip" id="searchTip">
	  <area shape="rect" coords="82,113,193,148" href ="javascript:alert(1);" />
	</map>

<img src="<%=basePath%>assets/img/tip/banner_tip.png" border="0" usemap="#bannerTip" 
	style="position: absolute;top:470px;left: 760px;"/>
	<map name="bannerTip" id="bannerTip">
	  <area shape="rect" coords="268,92,376,129" href ="javascript:alert(1);" />
	</map>
	
	<img src="<%=basePath%>assets/img/tip/diy_tip.png" border="0" usemap="#diyTip" 
	style="position: absolute;top:930px;left: 1030px;"/>
	<map name="diyTip" id="diyTip">
	  <area shape="rect" coords="89,145,195,179" href ="javascript:alert(1);" />
	</map>
</div>
 --%>


<div class="content" id="main_content">

<!--=== Header ===-->    
<div style="border-bottom: 1px solid #e5e5e5;width: 100%;position:relative; z-index: 9999;background-color: #fff;">

<div class="navbar-custom">
<a id="header_logo" href="<%=basePath%>home.html"></a>
<%--
   <div class="nav-brand">
      <a class=" no-padding" href="<%=basePath%>home.html"><img alt="logo" src="<%=basePath%>assets/img/nav_logo.png"> </a>
   </div>
 --%>
   <div class="navbar-nav-custom">
      <ul class="nav-custom" >
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
			    <img alt="" id="headPhoto" src="${empty loginUser.photo ? './assets/img/personal/p_tmp.png':loginUser.photo}" >
			    </a>
			    </div>
			    <div class="p_name">
			    	<p> <a href="<%=basePath%>personal/myorder.html?page=1&pageSize=10">
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
	   		<a class="searchicon" id="searchProduct" href="javascript:void(0);" onclick="searchProduct()"></a>
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
		$(".search-bar>form>a").removeClass("searchicon").addClass("searchicon-hover");
		$(".search-bar").animate({width:"260px"},400).css("background","#f6f6f6");
		$(this).animate({width:"75%"},500).css("background","#f6f6f6");;
	}).blur(function(){
		$(".search-bar>form>a").removeClass("searchicon-hover").addClass("searchicon");
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
	
	//setFooter();
});

function setFooter(){
	//set footer
	var contentHeight = $(".content").height();
	var wh = $(window).height();
	if(wh-contentHeight>0){
		var hscale = wh-98;
		$(".content").css("height",hscale+"px");
	}
}
</script>
<div class="sub-navbar">
	<div class="row">
		<div class="tags-nav col-md-5 col-lg-5 col-sm-5 col-xs-5">
			<a href="<%=basePath%>product/product_list.html?ptype=0&fromFlag=0">套餐</a>
			<a href="<%=basePath%>product/product_list.html?ptype=1&fromFlag=0">酒店</a>
			<a href="<%=basePath%>product/product_list.html?ptype=2&fromFlag=0">别墅</a>
			<a href="<%=basePath%>product/product_list.html?ptype=3&fromFlag=0">交通</a>
			<a href="<%=basePath%>product/product_list.html?ptype=4&fromFlag=0">娱乐</a>
			<!-- 
			<a href="javascript:void(0);">海底婚礼</a>
			<a href="javascript:void(0);">奢华住宿</a>
			<a href="javascript:void(0);">豪华接送</a>
			<a href="javascript:void(0);">摄影摄像</a>
			 
		 <a href="<%=basePath%>personal/contact.html">*个*</a>
         <a href="<%=basePath%>product/product_list.html">*交列*</a>
         <a href="<%=basePath%>product/traffic_detail.html?pid=P0000000000000000025">*交*</a>
         <a href="<%=basePath%>product/villa_detail.html">*别*</a>
         <a href="<%=basePath%>product/hotel_detail.html?pid=P0000000000000000001">*酒*</a>
         <a href="<%=basePath%>product/package_detail.html?pid=P0000000000000000005">*套*</a>
         -->
		</div>
		<div class="continent-nav col-md-7 col-lg-7 col-sm-7 col-xs-7" id="search_continent">
			<a href="javascript:void(0);">亚洲</a>
			<a href="javascript:void(0);" >欧洲</a>
			<a href="javascript:void(0);">大洋洲</a>
			<a href="javascript:void(0);">美洲</a>
			<a href="javascript:void(0);">非洲</a>
		</div>
		<script type="text/javascript">

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
							html = '<a href="home.html?cid='+rows[index].id+'#anchor_continent" class="anchor-continent" id="'+rows[index].id+'">'+rows[index].cityName+'</a>'+html;
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
				<div><img alt="微信订阅号" src="<%=basePath%>assets/img/wx_icon.png" class="rel">&nbsp;<div class="foot_tooltip"  
				style="margin-right: 0;" title="&lt;img src=&quot;<%=basePath%>assets/img/UI/subscribe.png&quot; /&gt; ">微信订阅号</div></div>
				<div>400-003-7525</div>
			</div>
			<div class=" footer-copyright fr" >Copyright © 2016 麦味旅行 All Rights Reserved</div>
		</div>
	</div>
</div>

<div class="clr"></div>
<!-- ===End footer -->
</body>
<script type='text/javascript'>
function setTip(){
	var bh = $(document).height();
	$("#tipmask").height(bh);
}

$(function() {
	$('.foot_tooltip').tooltipster({
		contentAsHTML: true
	});	
	<%--
	setTip();
	--%>
});
/*
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
    */
</script>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-70680149-1', 'auto');
  ga('send', 'pageview');
//UA-70680149-1
</script>
</html>
