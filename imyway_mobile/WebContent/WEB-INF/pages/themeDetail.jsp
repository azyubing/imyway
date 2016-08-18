<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
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
<link href="<%=basePath%>assets/css/themeDetail.css" rel="stylesheet" type="text/css">

</head>
<body>
<div class="row" id="banner">
	<div class="col-xs-9 col-sm-9 col-md-9 col-lg-9 col col_l" >
		<!-- ==banner -->
		<div id="myCarousel" class="carousel slide">
		   <!-- 轮播（Carousel）项目 -->
			<div class="carousel-inner">
				<c:forEach var="items" items="${themeList[0].themeProductList }" varStatus="statusIdx">
					<div class="item <c:if test="${statusIdx.index == 0 }">active</c:if>">
						<%-- <c:choose>
							<c:when test="${items.list_img == null or items.list_img == '' }">
								<img alt="" src="<%=basePath%>assets/tmp/1.png">
							</c:when>
							<c:otherwise><img alt="" src="${items.list_img }" width="940px" height="470px"></c:otherwise>
						</c:choose> --%>
						<img alt="" src="<%=basePath%>assets/tmp/${statusIdx.index+1}.png">
					</div>
				</c:forEach>
<%-- 				<div class="item active">
				   <img src="<%=basePath%>assets/tmp/1.png" alt="" >
				</div>
				<div class="item">
				   <img src="<%=basePath%>assets/tmp/2.png" alt="">
				</div>
				<div class="item">
				   <img src="<%=basePath%>assets/tmp/3.png" alt="">
				</div> --%>
			</div>
		   <!-- 轮播（Carousel）导航 -->
		   <a class="slidesjs-navigation left-btn" href="#myCarousel" data-slide="prev"></a>
		   <a class="slidesjs-navigation slidesjs-next right-btn" href="#myCarousel" data-slide="next"></a>
		</div>
		<div class="clr"></div>
		<!-- ==end banner -->
		<c:forEach var="items" items="${themeList[0].themeProductList }" varStatus="statusIdx">
			<div class="l_bottom" <c:if test="${statusIdx.index > 0 }"> style="display: none;"</c:if>>
				<c:set value="${ fn:split(items.tags, '|') }" var="tags" />
				<c:forEach var="tag" items="${tags }">
					<span class="tag">${tag }</span>
				</c:forEach>
			</div>
		</c:forEach>
	</div>
	<c:forEach var="items" items="${themeList[0].themeProductList }" varStatus="statusIdx">
		<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col col_r" <c:if test="${statusIdx.index > 0 }"> style="display: none;"</c:if>>
			<div class="title">${items.pname }</div>
			<div class="sub_title">${items.pname_en }</div>
			<div class="desc">${items.pdesc }</div>
			<c:choose>
				<c:when test="${items.ptype == 0 }">
					<div class="detail"><a href="http://localhost:9090/imyway/product/package_detail.html?pid=${items.pid }" id="detailBtn">查看详细</a></div>
				</c:when>
				<c:when test="${items.ptype == 1 }">
					<div class="detail"><a href="http://localhost:9090/imyway/product/hotel_detail.html?pid=${items.pid }" id="detailBtn">查看详细</a></div>
				</c:when>
				<c:when test="${items.ptype == 2 }">
					<div class="detail"><a href="http://localhost:9090/imyway/product/villa_detail.html?pid=${items.pid }" id="detailBtn">查看详细</a></div>
				</c:when>
				<c:when test="${items.ptype == 3 }">
					<div class="detail"><a href="http://localhost:9090/imyway/product/traffic_detail.html?pid=${items.pid }" id="detailBtn">查看详细</a></div>
				</c:when>
				<c:when test="${items.ptype == 4 }">
					<div class="detail"><a href="http://localhost:9090/imyway/product/ent_detail.html?pid=${items.pid }" id="detailBtn">查看详细</a></div>
				</c:when>
			</c:choose>
		</div>
	</c:forEach>
	
</div>
<div class="clr"></div>
<!-- theme item -->
<c:forEach var="items" items="${themeList }" varStatus="statusIdx" begin="1" end="${fn:length(themeList) }">
	<c:set value="${items.themeProductList }" var="themeProductList" />
	<c:set value="${items.themeProductCityList }" var="themeProductCityList" />
	<c:set value="${ fn:split(themeProductList[0].tags, '|') }" var="tags" />
	<div class="theme">
		<div class="theme_content">
			<img src="<%=basePath%>assets/img/UI/theme_bak_1.jpg">
			<div class="row">
				<div class="col-xs-8 col-sm-8 col-md-8 col-lg-8">
					<span class="t_title">${items.name }</span>
					<c:forEach var="themeProductCity" items="${themeProductCityList }" varStatus="statusIdx">
						<a class="t_tab" href="#">${themeProductCity.cityName }</a>
					</c:forEach>
					<div class="l_img"><img src="<%=basePath%>assets/tmp/theme.jpg" ></div>
					<div class="l_desc">
						<div class="fl">
							<div class="p1">${themeProductList[0].pname }</div>
							<div class="p2">
								<c:forEach var="tag" items="${tags }">
									<span class="tag">${tag }</span>
								</c:forEach>
							</div>
						</div>
						<div class="fr"><span><f:formatNumber value="${themeProductList[0].start_price }" type="currency" pattern="¥.00"/></span>&nbsp;/人</div>
						<div class="clr"></div>
					</div>
				</div>
				<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
					<div class="t_title_r" ><a href="#">更多${items.name }主题</a></div>
					<c:forEach var="themeProduct" items="${themeProductList }" varStatus="statusIdx" begin="1" end="2">
						<div class="r_img"><img src="<%=basePath%>assets/tmp/theme.jpg" ></div>
						<div class="r_desc">
							<div class="fl">
								<div class="p1">${themeProduct.pname }</div>
							</div>
							<div class="fr"><span><f:formatNumber value="${themeProduct.start_price }" type="currency" pattern="¥.00"/></span>&nbsp;/人&nbsp;&nbsp;</div>
							<div class="clr"></div>
						</div>
					</c:forEach>
				</div>
			</div>
			
			<div class="row row2">
				<c:forEach var="themeProduct" items="${themeProductList }" varStatus="statusIdx" begin="3" end="${fn:length(themeProductList) }">
					<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col" style="text-align: left;">
						<img src="<%=basePath%>assets/tmp/theme.jpg" ><div class="title">
							<p>${themeProduct.pname }</p>
							<p class="red"><f:formatNumber value="${themeProduct.start_price }" type="currency" pattern="¥.00"/>&nbsp;/人</p>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</c:forEach>
<!-- end theme item -->

<div class="bottom_content">
	<button type="button" class="btn btn-info" id="diyBTN">DIY我的婚礼</button>
</div>

<!-- Page level JS -->

<script type="text/javascript">
function initPage() {  
    try {  
        $window = $(window);  
        var resize = $window.jqElemResize();  
        $(resize).on("resize", function (size) {  
        	setTopHeight(); 
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

function setTopHeight(){
	var scaleHeight = $("#banner>.col_l").height();
	$("#banner>.col_r").css("height",scaleHeight+"px");
	//set navigation
	$(".slidesjs-navigation").addClass("opacity-hide");
	var navTop = -($("#myCarousel>.carousel-inner").height()/2+25);
	$(".slidesjs-navigation").css("top",navTop+"px");
}
	
jQuery(document).ready(function() {
	initPage();
	$('#myCarousel').carousel({interval: false});
	
	//set next/pre hover 
	$(".carousel-inner,.slidesjs-navigation,.my-indicators").hover(
		function(){
			$(".slidesjs-navigation").removeClass("opacity-hide").addClass("opacity-harf-show");
		},
		function(){
			$(".slidesjs-navigation").removeClass("opacity-harf-show").addClass("opacity-hide");
		}
	);
	setTopHeight(); 

});
</script>

</body>
</html>