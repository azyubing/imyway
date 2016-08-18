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
<meta name="Keywords" content="麦味,旅行,别墅,套餐" />
<meta name="Description" content="麦味,旅行,别墅,套餐" />
<meta name="robots" content="index, follow" />
<meta name="googlebot" content="index, follow" />

<title>麦味旅行-全球主题旅行</title>
<!-- Favicon -->
<link rel="shortcut icon" href="<%=basePath%>assets/img/favicon.png">
<!-- Bootstrap -->
<link href="<%=basePath%>assets/plugins/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="<%=basePath%>assets/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="<%=basePath%>assets/plugins/tooltipster/tooltipster.css" rel="stylesheet" type="text/css">
<link href="<%=basePath%>assets/css/jquery.shCircleLoader.css" rel="stylesheet" type="text/css"/>

<!-- custom -->
<link href="<%=basePath%>assets/css/personal_custom.css" rel="stylesheet" type="text/css">
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
<script type="text/javascript" src="<%=basePath%>assets/js/jquery.form.js"></script>
<script type="text/javascript" src="<%=basePath%>assets/plugins/tooltipster/jquery.tooltipster.min.js"></script>
<script src="<%=basePath%>assets/js/jquery.shCircleLoader-min.js" type="text/javascript"></script>
<style type="text/css">
.navbar-custom{padding: 0;position: relative;}
#header_logo{width: 112px; height: 110px; display: block;position: absolute;top: 0px;left: 0px;border-right: 1px solid #e5e5e5;}
.navbar-nav-custom .nav-custom{margin-left: 112px;}
.sub-navbar .row .tags-nav{padding-left: 115px;}

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
   
   <div class="login-bar">
   <%--
   		<a class="login-btn" href="<%=basePath%>tologin.html">登录</a><a class="regist-btn" href="<%=basePath%>toregister.html">注册</a>
    --%>
	    <div class="p_img">
		    <div class="img_b"><img alt="" id="headPhoto" src="${empty loginUser.photo ? '../assets/img/personal/p_tmp.png':loginUser.photo}" ></div>
		    <div class="p_name">
		    	<p>
		    		<c:choose> 
				     <c:when test="${fn:length(loginUser.username) > 12}"> 
				      <c:out value="${fn:substring(loginUser.username, 0, 12)}..." /> 
				     </c:when> 
				     <c:otherwise> 
				      <c:out value="${loginUser.username}" /> 
				     </c:otherwise>
				    </c:choose>
		    	</p>
		    	<p><a href="<%=basePath%>/loginOut.html"><img alt=""  src="<%=basePath%>assets/img/personal/sign-out.png" ></a></p>
		    </div>
	    </div>
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
			'<img src="<%=basePath%>assets/img/up.png" style="width:51px; height:42px" />'
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
</script>
<div class="sub-navbar">
	<div class="row" id="personal_nav">
	
		<div class="tags-nav col-md-7 col-lg-7 col-sm-7 col-xs-7">
			<a href="<%=basePath%>personal/myorder.html?page=1&pageSize=10">我的订单</a>
			<a href="<%=basePath%>personal/collection.html?page=1&pageSize=8&active=1">我的收藏</a>
			<a href="<%=basePath%>personal/contact.html">常用旅客信息</a>
			<a href="<%=basePath%>personal/personInfo.html">个人信息</a>
			<a href="<%=basePath%>personal/editPW.html">修改密码</a>
		</div>
		<div class="continent-nav col-md-5 col-lg-5 col-sm-5 col-xs-5"></div>
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
<script src="http://www.sobot.com/chat/pc/pc.min.js?sysNum=e1ef7a09cc364db2b1a5619b6f421365" id="zhichiload" ></script>
</body>
<script type='text/javascript'>
$(function() {
	$('.foot_tooltip').tooltipster({
		contentAsHTML: true
	});
});

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
</script>
</html>
