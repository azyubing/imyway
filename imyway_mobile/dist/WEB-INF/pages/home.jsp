<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<link href="<%=basePath%>assets/plugins/videoJs/video-js.min.css" rel="stylesheet">
<link href="<%=basePath%>assets/plugins/scrollBar/jquery.mCustomScrollbar.min.css" rel="stylesheet">
<link href="<%=basePath%>assets/css/home.css" rel="stylesheet" type="text/css">
<style type="text/css">
.navbar-custom1{padding: 0;position: relative;}
#header_logo{width: 112px; height: 110px; display: block;position: absolute;top: 0px;left: 0px;border-right: 1px solid #e5e5e5;z-index: 10000;}
.navbar-nav-custom .nav-custom{margin-left: 112px;}
.sub-navbar1{z-index: 999;}
.sub-navbar1 .row .tags-nav{padding-left: 112px;}
</style>
</head>
<body>

<!-- target-data -->
<div id="target-data" class="abs" style="width: 300px;border: 1px solid #e5e5e5;padding: 10px; border-radius:4px; display: none;z-index: 9999;background-color: #fff;"></div>

<!-- ===video -->
<div id="banner">

<div class="abs" id="b_title">
	<div id="banner_title_1"  ></div>
	<div id="banner_title_2"  ></div>
</div>
<div id="b_search_tip">
	<div id="b_search_data"><table><tr><td>
				<p class="p1"><a href="javascript:void(0)">纽约</a></p>
				<p class="p2"><a href="javascript:void(0)">New York</a></p>
			</td></tr></table></div>
</div>
<%--
<video id="banner_video" class="video-js vjs-default-skin"
  autoplay loop muted preload="auto" mute="true" style="width: 100%;">
 <source src="http://139.196.38.172/myway/pages/oceans-clip.ogv" type='video/ogg' style="width: 100%;height: 100%;"/>
 <source src="http://139.196.38.172/myway/pages/oceans-clip.webm" type='video/webm' style="width: 100%;height: 100%;"/>
 <source src="http://139.196.38.172/myway/pages/oceans-clip.mp4" type='video/mp4' style="width: 100%;height: 100%;"/>
 <img id="tmp_img" src="<%=basePath%>assets/img/tmp.jpg" style="width: 100%;height: 100%;"/>
</video>
 --%>
 
<%--轮播区域 --%>
	<div id="banner_video" class="carousel slide" style="position: static;top: 0;"> 
		<!-- 轮播（Carousel）项目 -->
		<div class="carousel-inner">
			<div class="item active "><img id="tmp_img" class="lazy-carousel" data-original="<%=basePath%>assets/img/banner/1.jpg" style="width: 100%;"/></div>
			<div class="item  "><img id="tmp_img" class="lazy-carousel" data-original="<%=basePath%>assets/img/banner/2.jpg" style="width: 100%;"/></div>
			<div class="item  "><img id="tmp_img" class="lazy-carousel" data-original="<%=basePath%>assets/img/banner/3.jpg" style="width: 100%;"/></div>
			<div class="item  "><img id="tmp_img" class="lazy-carousel" data-original="<%=basePath%>assets/img/banner/4.jpg" style="width: 100%;"/></div>
			<div class="item  "><img id="tmp_img" class="lazy-carousel" data-original="<%=basePath%>assets/img/banner/5.jpg" style="width: 100%;"/></div>
			<div class="item  "><img id="tmp_img" class="lazy-carousel" data-original="<%=basePath%>assets/img/banner/6.jpg" style="width: 100%;"/></div>
			<div class="item  "><img id="tmp_img" class="lazy-carousel" data-original="<%=basePath%>assets/img/banner/7.jpg" style="width: 100%;"/></div>
			<div class="item  "><img id="tmp_img" class="lazy-carousel" data-original="<%=basePath%>assets/img/banner/8.jpg" style="width: 100%;"/></div>
			<div class="item  "><img id="tmp_img" class="lazy-carousel" data-original="<%=basePath%>assets/img/banner/9.jpg" style="width: 100%;"/></div>
			<div class="item  "><img id="tmp_img" class="lazy-carousel" data-original="<%=basePath%>assets/img/banner/10.jpg" style="width: 100%;"/></div>
	   </div>
	   <!-- 轮播（Carousel）导航 -->
	   <a class="slidesjs-navi opacity-hide rel fl left-btn" href="#banner_video" data-slide="prev"></a>
	   <a class="slidesjs-navi slidesjs-n opacity-hide rel fr right-btn" href="#banner_video" data-slide="next"></a>
	</div>
	<div class="clr"></div>
	<script type="text/javascript">
		<%--轮播区域 --%>
		function setBanner(){

			var navTop = -($("#banner_video>.carousel-inner").height()/2+25);
			//navTop+=118;
	    	$(".slidesjs-navi").css("top",navTop+"px");
		}
		
		$(function(){
			$('#banner_video').carousel({interval: 3000});
			//set next/pre hover 
			$(".carousel-inner,.slidesjs-navi,.my-indicators").hover(
				function(){
					$(".slidesjs-navi").removeClass("opacity-hide").addClass("opacity-harf-show");
				},
				function(){
					$(".slidesjs-navi").removeClass("opacity-harf-show").addClass("opacity-hide");
				}
			);
			
		});
		
		//轮播图懒加载
		function lazyContainer(searchNode){
			$(searchNode).find(".active").find("img.lazy-carousel").each(function(){
				
				 var imgSrc = $(this).attr("data-original");
		    	  if(imgSrc){
		    		  $(this).attr("src",imgSrc);
		    	  }
			});
		}
		$("#banner_video").bind("slid.bs.carousel",function(){
			lazyContainer(this);
		});
		lazyContainer("#banner_video");
	</script>
<%--轮播区域结束 --%>

</div>
<div id="banner-bar" class="abs"> 
	<div class="banner-searchbar">
		<span id="s_country"><font>国家</font><i class="fa fa-caret-down ml"></i></span>
		<input type="hidden" id="s_country_put" >
		<span id="s_city"><font>城市</font><i class="fa fa-caret-down ml "></i></span>
		<input type="hidden" id="s_city_put">
		<span id="s_theme"><font>主题</font><i  class="fa fa-caret-down ml"></i></span>
		<input type="hidden" id="s_theme_put">
		<span id="s_date" style="padding: 0;line-height: 40px;"><i  class="fa fa-caret-left date_style ml" ></i>&nbsp;&nbsp;&nbsp;&nbsp;<font style="width: 100px;"><fmt:formatDate value="${now}" type="date" pattern="yyyy年MM月"/></font><i  class="fa fa-caret-right date_style ml1"></i></span>
		<input type="hidden" id="s_date_put" value="<fmt:formatDate value="${now}" type="date" pattern="yyyy-MM"/>">
		<button class="btn banner-btn" id="searchBtn">开启我的旅程</button>
	</div>
</div>

<!-- ===End video -->
<div id="count_top" style="margin: 0px auto -10px;min-width: 1180px;max-width: 1600px; margin-top: -55px;">

<!-- ===counter-bar -->
<div class="counter-bar content" ">
 <div class="row">
 	<div class="col-md-3 col-sm-3 col-xs-3 counter-content"><div class="counter" catid="1">${outCount }</div><div>个海外目的地</div></div>
 	<div class="col-md-3 col-sm-3 col-xs-3 counter-content"><div class="counter" catid="3">${villaCount }</div><div>套高端别墅</div></div>
 	<div class="col-md-3 col-sm-3 col-xs-3 counter-content"><div class="counter" catid="4">${packageCount }</div><div>个专属定制行程</div></div>
 	<div class="col-md-3 col-sm-3 col-xs-3 counter-content last"><div class="counter" catid="2">${mediaCount }</div><div>个旅游视频分享</div></div>
 </div>
</div>
<!-- ===End counter-bar -->
<!-- ===theme -->
<c:forEach var="item" items="${list}" varStatus="statusIdx" >
	<div class="theme${statusIdx.index+1 } content">
	<div class="left-content">
		  <div class="slides" id="theme${statusIdx.index+1 }">
		  		<c:forEach var="themeProduct" items="${item.themeProduct}" varStatus="themeProductstatusIdx" begin="0" end="5">

		  			<a href="javascript:void(0);" onclick="toProductDetail('${themeProduct.pid}',${themeProduct.ptype})" ><img class="lazy" data-original="${themeProduct.size_img2 }" alt="${item.name}" style="width: 100%; height: 100%;"></a>
		  		</c:forEach>
		  </div>
	</div>
	<div class="right-content">
		<div class="theme-top top-bg" id="top${statusIdx.index+1 }" style="height: 200%;">
		   <div  class="rel theme-content">
			<div class="theme-name">${item.name }<c:if test="${statusIdx.first}"><a name="imyway_theme" class="rel" style="top:-60px;">&nbsp;</a></c:if></div>
			<div class="theme-en">${item.name_en }</div>
			<div class="theme-desc">${item.description }</div>
			<div ><button class="btn btn-primary theme-btn" onclick="gotoWeb(${item.id}, <c:if test="${item.name ne '别墅度假'}">0</c:if><c:if test="${item.name eq '别墅度假'}">1</c:if>)">DIY我的${item.name }</button></div>
		   </div>
		</div>
		<div class="theme-bottom" >
			<c:forEach var="themeProduct" items="${item.themeProduct}" varStatus="themeProductstatusIdx" >
				<div id="tp_${item.id}_${themeProductstatusIdx.index}" class="c_${item.id}" <c:if test="${not themeProductstatusIdx.first}"> style="display: none;" </c:if>>
					<div class="theme-title">
						<c:choose> 
					     <c:when test="${fn:length(themeProduct.pname) > 13}"> 
					      <c:out value="${fn:substring(themeProduct.pname, 0, 13)}..." /> 
					     </c:when> 
					     <c:otherwise> 
					      <c:out value="${themeProduct.pname}" /> 
					     </c:otherwise>
					    </c:choose>
					</div>
					<div class="title-desc">${themeProduct.countryName}&nbsp;${themeProduct.cityName}</div>
					<div class="theme-tag rel">
						<c:forEach items="${themeProduct.tags }" var="tag">
							<span><a href="javascript:void(0)">${tag}</a></span>
						</c:forEach>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
<div class="clr"></div>

</c:forEach>


<!-- ===End theme -->
<!-- ===More theme -->
<div class="more_theme">

	<div class="more_theme_top" style="margin-top: 67px;">
		<h2 >更多主题旅行</h2>
		<p style="margin-top: 10px;margin-bottom: 35px;">国内顶尖的资深团队为您服务，相信我们为您提供最合适的旅游行程！</p>
	</div>
	<div class="row theme_imgs" >
		<c:forEach var="item" items="${isMorelist}" varStatus="statusIdx">
			<div class="col-md-3 col-sm-3 col-xs-3">
				<a href="javascript:void(0);" onclick="toProductDetail('${item.pid}', ${item.ptype})" >
					<img alt="" class="lazy"  data-original="${item.list_img}" style="width: 280px; height: 280px;">
				</a>
				<div class="t_detail">
					<a href="javascript:void(0);" onclick="toProductDetail('${item.pid}', ${item.ptype})" >${item.name }</a>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<div class="clr"></div>
<!-- ===End More theme -->
<!-- ===Target -->
<div class="target cat" catid="1" id="anchor_continent">
	<div class="row target-header" >
		<div class="col-md-4 col-sm-4 col-xs-4">
			<div class="t_hearder_left">
				<h2>探索世界</h2><label>麦味旅行覆盖100多个国家和地区</label>
			</div>
		</div>
		<div class="col-md-8 col-sm-8 col-xs-8">
			<div class="t_hearder_right">
				<a href="javascript:void(0);" class="selectCity active" id="0" >热门</a>
				<c:forEach var="item" items="${cityList}" varStatus="statusIdx" >
					<a href="javascript:void(0);" class="selectCity " id="${item.id }" >${item.cityName }</a>
				</c:forEach>
			</div>
		</div>
	</div>
	<div class="row target-content" >
		<div class="col-md-6 col-sm-6 col-xs-6">
			<div class="t_content_left rel" style="height: 390px;">
				<img alt="" class="lazy"  data-original="<%=basePath%>assets/img/map.png" id="map">
			</div>
	
		</div>
		<div class="col-md-6 col-sm-6 col-xs-6">
			<div class="t_content_right">
				<div class="content_top">				
				</div>
			</div>
		</div>
	</div>
</div>
<div class="clr"></div>
<!-- ===End Target -->

<!-- ===More vedio -->
<div class="more_vedio cat"  catid="2">
	<h2>麦视频<a name="imyway_vedio">&nbsp;</a></h2>
	<p>麦味旅行覆盖100多个国家和地区</p>
	<c:forEach var="item" items="${medialist}" varStatus="statusIdx" begin="0" end="7">
		<c:if test='${statusIdx.index%4+1 eq 1}'>
			<div class="row vedio_imgs" style="padding-top: 30px;padding-bottom: 20px;">
		</c:if>
			<div class="col-md-3 col-sm-3 col-xs-3">
				<a href="<%=basePath%>vedioDetail.html?vid=${item.id}"><img style="width: 270px;height: 135px;" class="lazy"  data-original="${item.img_path}"></a>
				<div class="t_detail ">
					<a href="<%=basePath%>vedioDetail.html?vid=${item.id}"><span>&nbsp;&nbsp;&nbsp;${item.name }</span></a>
					<span class="fr">${item.timelong}&nbsp;&nbsp;&nbsp;</span>
				</div>
			</div>
		<c:if test='${statusIdx.index%4+1 eq 4}'>
			</div>
		</c:if>
	</c:forEach>
<div class="clr"></div>
</div>
<!-- ===End vedio -->
<!-- ===partner -->
<div class="partner ">
	<div class=" partner_imgs" >
		<div ><a href="http://www.australia.com" target="_blank"><img alt="" class="lazy"  data-original="<%=basePath%>assets/img/tourist/AUS.png"></a></div>
		<div ><a href="http://www.welcome2japan.cn" target="_blank"><img alt="" class="lazy"  data-original="<%=basePath%>assets/img/tourist/JAPAN.png"></a></div>
		<div ><a href="http://www.visitkorea.or.kr/intro.html" target="_blank"><img alt="" class="lazy"  data-original="<%=basePath%>assets/img/tourist/KOREA.png"></a></div>
		<div ><a href="http://www.newzealand.com" target="_blank"><img alt="" class="lazy"  data-original="<%=basePath%>assets/img/tourist/NEWZEALAND.png"></a></div>
		<div ><a href="http://www.amazingthailand.org.cn" target="_blank"><img alt="" class="lazy"  data-original="<%=basePath%>assets/img/tourist/TAI.png"></a></div>
		<div class="last"><a href="http://www.indonesia.travel/" target="_blank"><img alt="" class="lazy"  data-original="<%=basePath%>assets/img/tourist/YINDU.png"></a></div>
	</div>
</div>
<div class="clr"></div>
<!-- ===End partner -->

</div>
<!-- Page level JS -->
<script type="text/javascript" src="<%=basePath%>assets/plugins/counter/waypoints.min.js"></script>
<script type="text/javascript" src="<%=basePath%>assets/plugins/counter/jquery.counterup.min.js"></script>
<script type="text/javascript" src="<%=basePath%>assets/plugins/slidesJS/jquery.slides.min.js"></script>
<script type="text/javascript" src="<%=basePath%>assets/js/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="<%=basePath%>assets/js/home.js"></script>
<script type="text/javascript" src="<%=basePath%>assets/plugins/videoJs/video.js"></script>
<script type="text/javascript" src="<%=basePath%>assets/plugins/scrollBar/jquery.mCustomScrollbar.min.js"></script>


<script type="text/javascript">
videojs.options.flash.swf = "<%=basePath%>assets/tmp/video-js.swf";
var videoH = 1080;
var videoW = 1920;
var hasVideo = !!(document.createElement('video').canPlayType);
var cityParentId = 1;

function setVideo(){
	if(!hasVideo){
		return;
	}
	var addtin = 0;
	addtin += document.body.scrollHeight - document.body.offsetHeight;
	if($(document).width() < 1920){
		$('#banner_video').height(videoH/videoW*($(document).width() + addtin));
	}else{
		$('#banner_video').height(videoH);
	}

	var topTitle = ($('#banner_video').height() + 110)/3;
	var topSearch = ($('#banner_video').height() + 110)-100;
	
	$("#b_title").css("top",(topTitle-130)+"px");
	$("#banner-bar").css("top",(topSearch-220) + "px");
	<%--轮播区域 --%>
	var bannerVideoHeight = $("#banner_video").height();
	bannerVideoHeight -= 230;
	$("#banner_video,#tmp_img").css({"height": bannerVideoHeight+"px"});
	<%--轮播区域 --%>
	setBanner();
}

<%--轮播区域 --%>
var resizFlg=false;

function initPage() {  
    try {  
        $window = $(window);  
        var resize = $window.jqElemResize();  
        $(resize).on("resize", function (size) {  
        	
        	setThemeTopHeight(); 
        	setVideo();
        	<%--轮播区域 --%>
        	setBanner();
        
        });  
    } catch (exp) {  
        alert(exp.message);  
    }  
} 
/*页面卸载时*/  
$(window).unload(function () {  
    try {  
        $(window).jqElemResize("destroy");  
    } catch (exp) {  
        alert(exp.message);  
    }  
}); 

function getcity(parentId,flg){
	if(flg){
		$.ajax({
			type:"POST",
			url:"<%=basePath%>city/ajaxGetCityListAll.html",
			async:false, 
			dataType: "html",
			success: function(json){
				var result =jQuery.parseJSON(json);
				var rows = result.rows;
				var cityFrom = $("#b_search_data");		
				cityFrom.empty();
				var html = '<table>';
				$(rows).each(function(index){
					if(index%5==0){
						html += '<tr>';
					}
						html +=
							'<td>'+
							'	<p class="p1"><a href="javascript:void(0)" onclick="cityselect('+rows[index].id+',\''+rows[index].cityName+'\')"  >'+rows[index].cityName+'</a></p>'+
							'	<p class="p2"><a href="javascript:void(0)">'+rows[index].cityNameEn+'</a></p>'+
							'</td>';
					if(index%5==4){
						html += '</tr>';
					}
	
			  	});
				html += '</table>';
				cityFrom.append(html);
			}
		});
	}else{	
		$.ajax({
			type:"POST",
			url:"<%=basePath%>city/ajaxGetCityList.html",
			data:{'parentId': parentId},
			async:false, 
			dataType: "html",
			success: function(json){
				var result =jQuery.parseJSON(json);
				var rows = result.rows;
				var cityFrom = $("#b_search_data");		
				cityFrom.empty();
				var html = '<table>';
				$(rows).each(function(index){
					if(index%5==0){
						html += '<tr>';
					}
						html +=
							'<td>'+
							'	<p class="p1"><a href="javascript:void(0)" onclick="cityselect('+rows[index].id+',\''+rows[index].cityName+'\')"  >'+rows[index].cityName+'</a></p>'+
							'	<p class="p2"><a href="javascript:void(0)">'+rows[index].cityNameEn+'</a></p>'+
							'</td>';
					if(index%5==4){
						html += '</tr>';
					}
	
			  	});
				html += '</table>';
				cityFrom.append(html);
			}
		});
	}
}

function getDateList(){
	var	nowDate = new Date(${timeLong});
	 var month=nowDate.getMonth()+1;
	 var year=nowDate.getFullYear(); 
	var rows = new Array();
	var nextYearFlg= false;
	for(var i=0;i<12;i++){
		if(month>12){
			month = 1;
			nextYearFlg = true;
		}
		if(nextYearFlg){
			year += 1;
			nextYearFlg = false;
		}
		rows[i] = {dateFull : year+"年"+ (month<10?"0"+month:month) +"月",
					dateShort: year +"-"+ (month<10?"0"+month:month)};
		
		month++;
	}
	
	var cityFrom = $("#b_search_data");		
	cityFrom.empty();
	var html = '<table>';
	$(rows).each(function(index){
		if(index%5==0){
			html += '<tr>';
		}
			html +=
				'<td>'+
				'	<p class="p1"><a href="javascript:void(0)" onclick="cityselect( \''+rows[index].dateShort+'\' ,\''+rows[index].dateFull+'\')"  >'+rows[index].dateFull+'</a></p>'+
				'</td>';
		if(index%5==4){
			html += '</tr>';
		}

  	});
	html += '</table>';
	cityFrom.append(html);
}

function getTheme(){
	$.ajax({
		type:"POST",
		url:"<%=basePath%>themeList.html",
		data:{},
		async:false, 
		dataType: "html",
		success: function(json){
			var result =jQuery.parseJSON(json);
			var rows = result;
			var cityFrom = $("#b_search_data");		
			cityFrom.empty();
			var html = '<table>';
			$(rows).each(function(index){
				if(index%5==0){
					html += '<tr>';
				}
					html +=
						'<td>'+
						'	<p class="p1"><a href="javascript:void(0)" onclick="cityselect('+rows[index].id+',\''+rows[index].name+'\')"  >'+rows[index].name+'</a></p>'+
						'	<p class="p2"><a href="javascript:void(0)">'+rows[index].name_en+'</a></p>'+
						'</td>';
				if(index%5==4){
					html += '</tr>';
				}

		  	});
			html += '</table>';
			cityFrom.append(html);
		}
	});
}

function cityselect(cid,cname){
	var iHtml ='<i class="fa fa-caret-up ml" style="color: rgb(83, 155, 255);"></i>';
	var searchTipClass = $("#b_search_tip").attr("class");
	
	if(cid != $("#s_country_put").val()){
		if(searchTipClass == "s_country"){
			$("#s_city_put").val('')
			$("#s_city").find('font').text('城市');
		}
	}
	
	if($("#s_country_put").val() == '' || $("#s_country_put").val() == null){
		getcity(cid,true);
		cityParentId = cid;
	}

	$("#"+searchTipClass+"_put").val(cid);
	$("#"+searchTipClass).children('font').empty().text(cname);

	//hide search data list
	$("#banner-bar>.banner-searchbar>span>.fa-caret-up").removeClass("fa-caret-up").addClass("fa-caret-down")
	.css("color","#ccc").parent().removeClass("active");
	<%--轮播区域 --%>
	$("#b_search_tip").animate({top:($("#banner_video").height()+70)+'px',opacity:0}).removeClass();
} 

function getCityList(parentId){
	$(".selectCity").removeClass('active');
	var selectCity = $(".selectCity");
	$(selectCity).each(function(index){
		if($(selectCity[index]).attr('id') == parentId ){
			$(selectCity[index]).addClass('active');
		}
	});
	
	getSelectCity(parentId);
}

jQuery(document).ready(function() {
	<c:if test="${cid ne null}">
		getCityList(${cid});
	</c:if>
	initCounter();
	initSlides("slides");
	initPage();
	
	setThemeTopHeight();
	
	getDestinationAdminSearchList();
	
	//装饰器product_decorator,点击州
	var continent = '${continent}';
	if(continent != null && continent !=''){
		$(".selectCity").removeClass('active');
		var parentId = continent;
		var selectCity = $(".selectCity");
		$(selectCity).each(function(index){
			if($(selectCity[index]).attr('id') == parentId ){
				$(selectCity[index]).addClass('active');
			}
		});
		getSelectCity(parentId);
	}else{
		getHotCityList();
		
	}
	
	//装饰器decorator,点击州
	$(".anchor-continent").click(function(){
		$(".selectCity").removeClass('active');
		var parentId = $(this).attr('id');
		var selectCity = $(".selectCity");
		$(selectCity).each(function(index){
			if($(selectCity[index]).attr('id') == parentId ){
				$(selectCity[index]).addClass('active');
			}
		});
		
		getSelectCity(parentId);
	});
	
	//获取点击的州的国家
	$(".selectCity").click(function(){
		selectCityRemoveClass();
		$(this).addClass('active');
		var parentId = $(this).attr('id');
		getSelectCity(parentId);
	});
	<%--轮播区域 --%>
	setVideo();
	<%--轮播区域 --%>
	$("#b_search_tip").css("top",($("#banner_video").height()+70)+'px');
	
	
	//set scroll bar
//	$("#b_search_data").mCustomScrollbar();
	
	//获得亚洲国家
	getcity(1,true);
	
	
	//set banner search tooltip
	$("#banner-bar>.banner-searchbar>span").click(function(){
			var selectId = $(this).attr("id");
			if(selectId ==  "s_city"){
				if($("#s_country_put").val()==''){
					alert("请先选择国家");
					return false;
				}else{
					getcity($("#s_country_put").val(),false);
					cityParentId = $("#s_country_put").val();
				}
			}else if(selectId == "s_country"){
				if(cityParentId !=1 ){
					getcity(1,true);
					cityParentId = 1;
				}
			}else if(selectId == "s_theme"){
				getTheme();
				cityParentId = 0;
			}else if(selectId == "s_date"){
				getDateList();
				cityParentId = 0;
			}
			

			if($(this).hasClass("active")){
				$("#banner-bar>.banner-searchbar>span>.fa-caret-up").removeClass("fa-caret-up").addClass("fa-caret-down")
				.css("color","#ccc").parent().removeClass("active");
				<%--轮播区域 --%>
				$("#b_search_tip").animate({top:($("#banner_video").height()+70)+'px',opacity:0}).css("z-index","1").removeClass();
				
			}else{
				$("#banner-bar>.banner-searchbar>span>.fa-caret-up").removeClass("fa-caret-up").addClass("fa-caret-down")
				.css("color","#ccc").parent().removeClass("active");
				$(this).addClass("active").children('i').removeClass("fa-caret-down").addClass("fa-caret-up").css("color","#539BFF");
				var vh = $("#banner_video").height();
				<%--轮播区域 --%>
				$("#b_search_tip").animate({top:(vh-228)+'px',opacity:0.90}).css("z-index","1000").removeClass().addClass($(this).attr("id"));
				$("#b_search_data").mCustomScrollbar("scrollTo","top");
			}	
		
	});
	
	
	
	//改变banner分页样式
	<c:forEach var="item" items="${list}" varStatus="statusIdx" >
		var items = $(".theme${statusIdx.index+1 } > .left-content>.slides>.slidesjs-pagination>.slidesjs-pagination-item>a");
		for(var i =0 ; i<items.length; i++){
			var btnImgHtml = '';
			<c:forEach var="themeProduct" items="${item.themeProduct}" varStatus="themeProductstatusIdx" begin="0" end="5">
				if(i == ${themeProductstatusIdx.index} ){
					btnImgHtml = '<img class="lazy"  data-original="${themeProduct.size_img2 }" style="width:104px;height:56px; border: 4px solid #fff;" alt="'+i+'">';
				}
  			</c:forEach>
			$(items[i]).attr("data-tpid","${item.id}_"+i).attr("data-themeid","${item.id}").empty().html(btnImgHtml);
		}
	</c:forEach>
	
	//set next/pre hover 
	$(".slidesjs-container,.slidesjs-navigation").hover(
		function(){
			var parentId = $(this).parent().attr("id");
			$("#"+parentId+"_pre,#"+parentId+"_next").removeClass("opacity-hide").addClass("opacity-harf-show");
		},
		function(){
			var parentId = $(this).parent().attr("id");
			$("#"+parentId+"_pre,#"+parentId+"_next").removeClass("opacity-harf-show").addClass("opacity-hide");
		}
	);


	//search btn click
	$("#searchBtn").click(function(){	
		var url = '<%=basePath%>product/product_list.html?ptype=0&themeId='+$("#s_theme_put").val()+
				'&countryId='+$("#s_country_put").val()+'&cityId='+$("#s_city_put").val()+'&endTime='+$("#s_date_put").val()+'&fromFlag=0';
		window.location.href = url;
	});
	
	$(".counter-content>.counter").click(function(){
		var catid=$(this).attr("catid");
		if(catid == 1 || catid == 2){
			var top=$(".cat[catid='"+catid+"']").offset().top;
			$(window).scrollTop(top);			
		}else if(catid ==  3){
			//villa
			window.location.href = '<%=basePath%>product/product_list.html?ptype=2&fromFlag=0';
		}else if(catid == 4){
			window.location.href = '<%=basePath%>product/product_list.html?ptype=0&fromFlag=0';
		}
	});
	
});



function getSelectCity(parentId){
	if(parentId != 0){
		$.ajax({
			type:"POST",
			url:"<%=basePath%>city/ajaxGetCityList.html",
			data:{'parentId': parentId},
			dataType: "html",
			success: function(json){
				var result =jQuery.parseJSON(json);
				var rows = result.rows;
				var cityFrom = $(".content_top");
				cityFrom.empty();
				$(rows).each(function(index){
					
					if(index%6==0 && index >5){
						cityFrom.append('<div class="br">&nbsp;</div>');
					}
					cityFrom.append(
							'<a href="javascript:void(0);"  onclick="gotolist('+rows[index].id+')" >'+rows[index].cityName+'</a>&nbsp;'
						);
	
			  	});
				
			}
		});
	}else{
		$.ajax({
			type:"POST",
			url:"<%=basePath%>city/ajaxGetHotCityList.html",
			dataType: "html",
			success: function(json){
				var result =jQuery.parseJSON(json);
				var rows = result;
				var cityFrom = $(".content_top");
				cityFrom.empty();
				$(rows).each(function(index){
					
					if(index%6==0 && index >5){
						cityFrom.append('<div class="br">&nbsp;</div>');
					}
					cityFrom.append(
							'<a href="javascript:void(0);"  onclick="gotolist('+rows[index].id+')" >'+rows[index].cityName+'</a>&nbsp;'
						);

			  	});
				
			}
		});
	}
	
}

function getHotCityList(){
	$.ajax({
		type:"POST",
		url:"<%=basePath%>city/ajaxGetHotCityList.html",
		dataType: "html",
		success: function(json){
			var result =jQuery.parseJSON(json);
			var rows = result;
			var cityFrom = $(".content_top");
			cityFrom.empty();
			$(rows).each(function(index){
				
				if(index%6==0 && index >5){
					cityFrom.append('<div class="br">&nbsp;</div>');
				}
				cityFrom.append(
						'<a href="javascript:void(0);"  onclick="gotolist('+rows[index].id+')" >'+rows[index].cityName+'</a>&nbsp;'
					);

		  	});
			
		}
	});
}

//目的地
function getDestinationAdminSearchList(){
	$.ajax({
		type:"POST",
		url:"<%=basePath%>destination/destinationAdminSearchList.html",
		data:{},
		dataType: "html",
		success: function(json){
			var result =jQuery.parseJSON(json);
			var rows = result;

			var cityFrom = $(".t_content_left");
			cityFrom.empty();
			$(rows).each(function(index){
				var topval = (rows[index].map_lat/1-480) ;
				var leftval = (rows[index].map_lng/1);
				cityFrom.append(
						'<img class="c abs" id="c'+index+'" data-desid="'+rows[index].id+'" data-countryid="'+rows[index].countryId+'" data-cname="'+rows[index].countryName+'" style="left:'+leftval+'px;top:'+topval+'px;display:block ; z-index:9;"  src="<%=basePath%>assets/img/c1.png" >'
				);
		  	});
			cityFrom.append('<img alt="" src="<%=basePath%>assets/img/map.png" id="map">');
			//set map
			$(".target>.target-content>div>.t_content_left>.c").hover(
				function(event){
					var lisize = setMapContent($(this));
					var ccs=	$('.target>.target-content>div>.t_content_left>.c');
					for(var i=0;i<ccs.length;i++){
						if($(ccs[i]).hasClass('cc')){
							$(ccs[i]).attr('src','<%=basePath%>assets/img/c1.png');	
						}		
					}
					$(this).attr('src','<%=basePath%>assets/img/c2.png').addClass("cc");
					var scale = lisize*75 +45;
					var t = event.pageY-scale;
					var l = event.pageX;
					$("#target-data").css({'top':(t+10)+'px','left':l+'px'}).fadeIn(300);
				
				},function(){
					$("#target-data").mouseleave(function(){
						var ccs=	$('.target>.target-content>div>.t_content_left>.c');
							for(var i=0;i<ccs.length;i++){
								if($(ccs[i]).hasClass('cc')){
									$(ccs[i]).attr('src','<%=basePath%>assets/img/c1.png');	
								}		
							}
						$("#target-data").hide();
					});
				});
		

		}
	});
}

function selectCityRemoveClass(){
	$(".selectCity").removeClass('active');
}

function setMapContent(jqObj){
	var desId = jqObj.data("desid");
	var descityname = jqObj.data("cname");
	var countryid = jqObj.data("countryid");
	var listSize = 0;
	$.ajax({
		type:"POST",
		url:"<%=basePath%>destination/destinationDetail.html",
		data:{'desId': desId},
		async:false, 
		dataType: "html",
		success: function(json){
			var rows =jQuery.parseJSON(json);
			var htmlStr = '';
			$(rows).each(function(index){
				var productname  = rows[index].pname ; 
				if(productname.length > 11){
					productname = productname.substring(0,11) + "...";
				}
				htmlStr += '<div style="border-bottom: 1px solid #e5e5e5;padding-bottom: 10px;">'
				+'<img title="'+rows[index].pname+'" src="'+rows[index].list_img+'" style="display: inline-block;width:80px;height:60px;">'
				+'<p  style="display: inline-block;font-size: 12px;color: #333;width: 190px;padding-left: 15px;text-align: left;position:relative ;top:-10px;">'
				+'<a onclick="toProductDetail(\''+rows[index].pid+'\','+rows[index].ptype+')" href="javascript:void(0)" title="'+rows[index].pname+'" style="color: #333;">'
				+productname+'</a></p>'
				+'<p class="fr" style="display: inline-block;font-size: 12px;color: #8f9c9a;margin-top:-15px;'
				+'width: 190px;padding-left: 10px;text-align: left;">'+rows[index].startdate+' - '+rows[index].enddate+'</p>'
				+'</div><div class="clr"></div>';
				listSize ++;
			});
			htmlStr += '<div style="color: #529bff ;text-align: center;height:30px; padding-top: 10px;"><p><a id="target-more" href="javascript:void(0)" onclick="gotolist('+countryid+')" style="color: #529bff ;">查看更多'+descityname+'推荐行程</a></p></div>';
			$("#target-data").empty().append(htmlStr);
		}
	});
	return listSize;
}

function gotoWeb(themeId,flg){
	var url = '<%=basePath%>product/product_list.html?ptype=0&themeId='+themeId+'&fromFlag=0';
	if(flg == 1){
		url = '<%=basePath%>product/product_list.html?ptype=2&themeId='+themeId+'&fromFlag=0';
	}
	window.location.href = url;
}

function toProductDetail(pid, ptype){
	var url = "";
	if(ptype == 0){
		url ='<%=basePath%>product/package_detail.html?pid='+ pid;
	}else if(ptype == 1){
		url ='<%=basePath%>product/hotel_detail.html?pid='+ pid;
	}else if(ptype == 2){
		url ='<%=basePath%>product/villa_detail.html?pid='+ pid;
	}else if(ptype == 3){
		url ='<%=basePath%>product/traffic_detail.html?pid='+ pid;
	}else if(ptype == 4){
		url ='<%=basePath%>product/ent_detail.html?pid='+ pid;
	}
	window.location.href = url;
}
function gotolist(countryid){
	var url = '<%=basePath%>product/product_list.html?ptype=0&countryId='+countryid+'&fromFlag=0';
	window.location.href = url;
}

</script>
<script type="text/javascript" charset="utf-8">
//页面加载完成后的图片懒加载
$(function() {
      $("img.lazy").lazyload({
    	  event : "sporty"
    	  //effect : "fadeIn"
      });
});

$(window).bind("load", function() {
	    var timeout = setTimeout(function() {
	        $("img.lazy").trigger("sporty")
	    }, 10);
});

</script>

</body>
</html>