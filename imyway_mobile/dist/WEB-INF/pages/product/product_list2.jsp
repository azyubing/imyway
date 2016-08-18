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
<link href="<%=basePath%>assets/css/package_list.css" rel="stylesheet" type="text/css">
<link href="<%=basePath%>assets/css/traffic_list.css" rel="stylesheet" type="text/css">
<link href="<%=basePath%>assets/css/hotel_list.css" rel="stylesheet" type="text/css">

<style type="text/css">
.tag_search_bar .search_top .circle_style{position: absolute;top: 1px;right: 1px;border: 2px solid #E50900;
    -moz-border-radius: 5px;      /* Gecko browsers */
    -webkit-border-radius: 5px;   /* Webkit browsers */
    border-radius:5px;            /* W3C syntax */
line-height: 8px;height: 12px;font-size: 12px;width: 27px;height: 13px;background-color: #E50900;color: #fff;}

</style>
</head>
<body>


<!-- ==center content -->
<div class="fl center_content">
<!-- ==search bar -->
<div class="search_bar">
	<div class="search_top">
		<!-- <a href="http://localhost:9090/imyway/product/product_list.html?ptype=1&themeId=23&countryId=12&cityId=13&endTime=2015-11&fromFlag=0">111</a> -->
		<input class="search-i" id="pname" value="${pname }" placeholder="模糊查询">
		<a id="searchBtn" class="btn" href="javascript:void(0)" onclick="searchBtn()">搜索</a>
		<a href="javascript:void(0)" class="btn" id="cleanBtn" onclick="cleanSearchBtn()">清空</a>
		<span class="top-label">超过&nbsp;<font class="blue b">800</font>&nbsp;个旅游服务项目</span>
	</div>
	<div class="search_top_right fr row">
		<div class="col-md-8 col-sm-8 col-xs-8 text_c">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;高级筛选条件</div>
		<div class="col-md-4 col-sm-4 col-xs-4 text_c">
			<a href="javascript:void(0)" id="expandMoreSearch"><img alt="" src="<%=basePath%>assets/img/traffic/a-up.png"></a>
		</div>
	</div>
	<div class="clr"></div>
	<!--adv search  -->
<div id="adv_search_list">
	<div class="list_item">
		<span>国家</span>&nbsp;&nbsp;&nbsp;
		<div class="dropdown">
		  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu9" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
		    <font>${countryCity.cityName }</font>
		    <input type="hidden" id="country" value="${countryCity.id }"/>
		    <span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu" id="countryMenu" aria-labelledby="dropdownMenu9">
		  	<li>
		  		<a href="javascript:void(0)" id="">请选择</a>
		  	</li>
	  	  	<c:forEach var="item" items="${country }" varStatus="statusIdx" >
				<li>
	  				<a href="javascript:void(0)" id="${item.id }">${item.cityName }</a>
				</li>
	  	  	</c:forEach>
		  </ul>
		</div>&nbsp;&nbsp;
		<span>地区/城市</span>&nbsp;&nbsp;&nbsp;
		<div class="dropdown">
		  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu8" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
		    <font>${cityCity.cityName }</font>
		   <input type="hidden" id="city" value="${cityCity.id }"/>
		    <span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu" id="cityselect" aria-labelledby="dropdownMenu8">
		  </ul>
		</div>&nbsp;&nbsp;
	    <span>选择日期</span>&nbsp;&nbsp;
		<div class="input-append date date-picker" style="cursor: pointer;height: 32px;display: inline-block;line-height: 30px;">
			<input type="text" id="endTime"  class="dateinput" value="${endTime }" readonly="readonly" style="width: 140px;">
			<span class="add-on date_picker_btn rel" style="height: 13px;border: 0px;width: 15px; left:-25px;top:0px;margin-bottom: 18px;" ><i class="fa fa-calendar"></i></span>
		</div>
	</div>
	<%--<div class="list_item">
	<!-- 
		<span>出行时间/入住</span>&nbsp;&nbsp;
	 -->
		<div class="input-append date " style="cursor: pointer;height: 30px;display: none;line-height: 28px;">
			<input type="text" id="startTime"  class="dateinput" readonly="readonly"><!-- 
			 --><span class="add-on date_picker_btn" ><i class="fa fa-calendar"></i></span>
		</div><!-- 
		<input id="startTime" type="text" class="date-picker" ><button class="btn date_picker_btn" >
	      <span class="fa fa-calendar"></span>
	    </button>
		 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 -->
	</div>--%>
	<script type="text/javascript">
		var UA = navigator.userAgent.toLowerCase();     
		if(UA.indexOf("chrome")>0){
			if(parseInt(UA.match(/chrome\/([\d.]+)/)[1]) <= 35){
				$("#btn_360").css("line-height","31px");
			}
		}
	</script>
	<div>&nbsp;</div>	
	<div class="list_item">
		<span>相关主题</span>&nbsp;&nbsp;&nbsp;
		
			<c:choose>
				<c:when test="${fn:length(themeId) >1 }">
					<c:forEach var="item" items="${theme }" varStatus="statusIdx" begin="0" end="7">
						<input type="checkbox" value="${item.id }" class="theme" />${item.name }&nbsp;&nbsp;&nbsp;
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach var="item" items="${theme }" varStatus="statusIdx" begin="0" end="7">
						<input type="checkbox" value="${item.id }" class="theme" <c:if test="${item.id == themeId }"> checked="checked"</c:if> />${item.name }&nbsp;&nbsp;&nbsp;
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<a id="themeConfirmBtn" class="btn" href="javascript:void(0)" onclick="searchBtn()"
				style=" background-color: #4795FF;
						display: inline-block;
						color: #FFF;
						border-radius: 0px;
						height: 30px;
						line-height: 30px;
						width: 55px;
						font-size: 12px;
						padding: 0px;
						margin-left: 10px;">确定</a>
			<div>&nbsp;</div>		
	</div>
	
<!-- 	<div class="list_item">
		<span>关键词</span>&nbsp;&nbsp;&nbsp;
		<input type="text" id="tags" style="width: 400px;">
	</div> -->
</div>
<!-- end adv search -->
</div>
<!-- ==End search bar -->
<input type="hidden" id="product_list" value="0"/>
<!-- ==tag search bar -->
<div class="tag_search_bar">
	<div class="search_top row tc" >
		<div class="col-md-8 col-sm-8 col-xs-8 text_l" id="tagSearchBtns" >
			<a href="javascript:void(0)"  onclick="toProductListPage('0')"><!-- 
				 --><span class="tc tag-btn rel <c:if test="${ptype==0 or ptype==null}"> active </c:if>" id="package_list"><font>套餐</font><span class="circle_style" id="packageCount">${packageCount}</span></span><!--  
			--></a><!-- 
		--><a href="javascript:void(0)" onclick="toProductListPage('1')"><!-- 
				 --><span class="jd tag-btn rel <c:if test="${ptype==1}"> active </c:if>" id="hotel_list"><font>酒店</font><span class="circle_style" id="hotelCount">${hotelCount}</span></span><!-- 
			 --></a><!--
			--><a href="javascript:void(0)" onclick="toProductListPage('2')"><!-- 
			 --><span class="bs tag-btn rel <c:if test="${ptype==2}"> active </c:if>" id="villa_list"><font>别墅</font><span class="circle_style" id="villaCount">${villaCount}</span></span><!-- 
			  --></a><!--
			--><a href="javascript:void(0)" onclick="toProductListPage('3')"><!-- 
			 --><span class="jt tag-btn rel <c:if test="${ptype==3}"> active </c:if>" id="traffic_list"><font>交通</font><span class="circle_style" id="trafficCount">${trafficCount}</span></span><!-- 
			  --></a><!--
			--><a href="javascript:void(0)" onclick="toProductListPage('4')"><!-- 
			 --><span class="yl tag-btn rel <c:if test="${ptype==4}"> active </c:if>" id="ent_list"><font>娱乐</font><span class="circle_style" id="entCount">${entCount}</span></span><!-- 
			  --></a><!--
		--></div>
		<div class="col-md-4 col-sm-4 col-xs-4 text_r">
			<a href="javascript:void(0)" onclick="orderByCnt()">销量</a>
			<span style="color: #f2f2f2;">|</span>
			<a href="javascript:void(0)" onclick="orderByPrice()">价格</a>
			<input type="hidden" id="orderCnt" />
			<input type="hidden" id="orderPrice" />
		</div>
	</div>
	<div class="clr"></div>
	<div class="search_bown " >
		<c:if test="${ptype == '0'}">
			<c:import url="./package_list2.jsp"></c:import>
		</c:if>
		<c:if test="${ptype == '1'}">
			<c:import url="./hotel_list2.jsp"></c:import>
		</c:if>
		<c:if test="${ptype == '2'}">
			<c:import url="./villa_list2.jsp"></c:import>
		</c:if>
		<c:if test="${ptype == '3'}">
			<c:import url="./traffic_list2.jsp"></c:import>
		</c:if>
		<c:if test="${ptype == '4'}">
			<c:import url="./ent_list2.jsp"></c:import>
		</c:if>
		<input type="hidden" id="ptype" value="${ptype}"/>
    </div>
</div>
<!-- ==End tag search bar -->
<div class="clr"></div>
<!-- img price -->
<div class="info_list" id="productListClass">
	<div class="row" id="objectLebel">
		<c:set var="detailUrl" value="package_detail.html"/>
		<c:if test="${ptype == '1'}">
		<c:set var="detailUrl" value="hotel_detail.html"/>
		</c:if>
		<c:if test="${ptype == '2'}">
		<c:set var="detailUrl" value="villa_detail.html"/>
		</c:if>
		<c:if test="${ptype == '3'}">
		<c:set var="detailUrl" value="traffic_detail.html"/>
		</c:if>
		<c:if test="${ptype == '4'}">
		<c:set var="detailUrl" value="ent_detail.html"/>
		</c:if>
	<c:forEach var="item" items="${plist}" varStatus="pIdx" >
		<a href="<%=basePath%>product/${detailUrl}?pid=${item.pid}">
		<div class="col col-md-4 col-sm-4 col-xs-4 col-lg-4">
			<div class="item">
				<div><img alt="" src="${item.size_img2}" class="p_img_style"></div>
				<div class="item_info bs">
					<p >${item.pname}</p>
					<p class="sp_info">${item.countryName}&nbsp;${item.cityName}</p>
					<div class="item_tag">
						<div class="fl tags">
						<c:forEach var="tag" items="${fn:split(item.tags, '|')}" >
							<span>${tag}</span>&nbsp;
						</c:forEach>
						</div>
						<div class="fr infos"><span>有效期：</span><span class="g"><fmt:formatDate value="${item.enddate}" pattern="yyyy-MM-dd"/></span></div>
						<div class="clr"></div>
					</div>
					<hr>
					<div class="item_price">
						<div class="fl price">价格：<span class="r"><fmt:formatNumber value="${item.start_price}" type="currency" pattern="¥"/></span>元起&nbsp;&nbsp;</div>
						<div class="clr"></div>
					</div>
				</div>
			</div>
		</div>
		</a>
		<c:if test="${pIdx.count%3 ==0 && pIdx.count>2}">
		<div class="">&nbsp;</div>
		</c:if>
	</c:forEach>
	</div>
</div>
<!-- end img price -->
</div>
<!--=== End center content ===-->
<div class="clr"></div>

<!-- Page level JS -->
<script type="text/javascript" src="<%=basePath%>assets/js/product_list.js"></script>

<script type="text/javascript">
function toProductListPage(type){
	
	var pname = $("#pname").val();
	var pcountry = $("#country").val();
	var pcity = $("#city").val();
	var pendTime = $("#endTime").val();
	var theme = $(".theme");
	var themeIds = new Array();
	var i = 0;
	$(theme).each(function(index){
		if(theme[index].checked){
			themeIds[i] = theme[index].value;
			i+=1;
		}
	});
	window.location.href='<%=basePath%>product/product_list.html?ptype='+type+'&fromFlag=1&pname='+pname+'&pcountry='+pcountry+'&pcity='+pcity+'&pendTime='+pendTime+'&pthemeIds='+themeIds.join(",");
}

var isExpend = false;
function initPage() {  
    try {  
        $window = $(window);  
        var resize = $window.jqElemResize();  
        $(resize).on("resize", function (size) {  
        	setTopHeight(); 

	       	 $(".p_img_style").css({
				 "width":$(".col").width()+"px",
				 "height":$(".col").width()/2+"px"
			 });
	       	 
        });  
    } catch (exp) {  
       // alert(exp.message);  
    }  
} 
/*页面卸载时*/  
$(window).unload(function () {  
    try {  
        $(window).jqElemResize("destroy");  
    } catch (exp) {  
      //  alert(exp.message);  
    }  
}); 

function cleanSearchBtn(){
	$("#startTime").val('');
	$("#endTime").val('');
	$("#tags").val('');
	$("#pname").val('');
	$(".theme:checkbox").attr("checked", false);
	
	$("#dropdownMenu9").find("font").text('');
	$("#dropdownMenu9").find("input").val('');
	
	$("#dropdownMenu8").find("font").text('');
	$("#dropdownMenu8").find("input").val('');
	
	
	seachObject();
}

function orderByCnt(){
	var cnt = $("#orderCnt").val();
	$("#orderPrice").val(null);
	if(cnt == null || cnt == ''){
		$("#orderCnt").val(1);
	}
	if(cnt == 1 ){
		$("#orderCnt").val(2);
	}
	
	if(cnt == 2 ){
		$("#orderCnt").val(1);
	}
	
	var ptype = $("#ptype").val();
	typeToList(ptype);
}

function orderByPrice(){
	var price = $("#orderPrice").val();
	$("#orderCnt").val(null);
	
	if(price == null || price == ''){
		$("#orderPrice").val(1);
	}
	if(price == 1 ){
		$("#orderPrice").val(2);
	}
	
	if(price == 2 ){
		$("#orderPrice").val(1);
	}
	
	var ptype = $("#ptype").val();
	typeToList(ptype);
}

function typeToList(ptype){
	seachObject();
}

//检索按钮,高级检索确定按钮
function searchBtn(){
	seachObject();
}

jQuery(document).ready(function() {
	initPage();
	
	$("#pname").val('${pname}');
	$("#country").val('${pcountry}');
	$("#endTime").val('${pendTime}');
	
	var t1 = $(".t1");
	var checkeddate = $.session.get('checkeddate');
	
	var countries = $("#countryMenu>li>a");
	$(t1).each(function(index){
		var t1date = $(t1[index]).attr('date');
		if(t1date == checkeddate){
			$("#endTime").val($(t1[index]).attr('date'));
			ischecked($(t1[index]));

			var leftcountry = $(t1[index]).attr('leftcountry');
			var countryId = $(countries[index]).attr('id');
			$(countries).each(function(index){
				var countryId = $(countries[index]).attr('id');
				if(countryId == leftcountry){
					var tid = $(countries).parent().parent().attr("aria-labelledby");
					$("#"+tid).find("font").text($(countries[index]).text());
					$("#"+tid).find("input").val(countryId);
				}
			});
		}
		
	});
	
	
	var themeIds = '${themeId}'.split(",");
	var theme = $(".theme");
	$(theme).each(function(index){
		for(var i = 0 ; i < themeIds.length ; i ++){
			if($(theme[index]).val() == themeIds[i]){
				$(theme[index]).attr("checked",'true');
			}
		}
	});

	var ptype = '${ptype}';
	//根据产品类别查询
	//typeToList(ptype);
	
	$("#orderPrice").val(null);
	$("#orderCnt").val(null);
	
	//获取选择的国家的城市
	getSelectCity($("#country").val(),$("#cityselect"));
	
	//回车键查询
	$("#pname").keypress(function(event){
		var key = event.which;
		if (key == 13) {
			searchBtn();
		}
		
		
	});
	
	//点击行程单日期,绑定日期,国家和城市到搜索的条件中
	$(".t1").click(function(){
		$("#endTime").val($(this).attr('date'));
		var leftcountry = $(this).attr('leftcountry');
		var countries = $("#countryMenu>li>a");
		$(countries).each(function(index){
			var countryId = $(countries[index]).attr('id');
			if(countryId == leftcountry){
				var tid = $(countries).parent().parent().attr("aria-labelledby");
				$("#"+tid).find("font").text($(countries[index]).text());
				$("#"+tid).find("input").val(countryId);
			}
		});
		searchBtn();
	});
	
	//set selecter
	$("#countryMenu>li>a").click(function(){
		var tid = $(this).parent().parent().attr("aria-labelledby");
		var countryId = $(this).attr('id');
		$("#"+tid).find("font").text($(this).text());
		$("#"+tid).find("input").val(countryId);

		var cityFrom = $("#cityselect");
		getSelectCity(countryId,cityFrom);
		
	});
	
	//set tag search btn
	$("#tagSearchBtns>.tag-btn").click(function(){
		$("#tagSearchBtns>.tag-btn").removeClass("active");
		$(this).addClass("active");
		$(".tag_search_bar>.search_top").removeClass().addClass('search_top').addClass('row');
		if($(this).hasClass("tc")){
			$(".tag_search_bar>.search_top").addClass('tc');
			return;
		}else if($(this).hasClass("jd")){
			$(".tag_search_bar>.search_top").addClass('jd');
			return;
		}else if($(this).hasClass("bs")){
			$(".tag_search_bar>.search_top").addClass('bs');
			return;
		}else if($(this).hasClass("jt")){
			$(".tag_search_bar>.search_top").addClass('jt');
			return;
		}else if($(this).hasClass("yl")){
			$(".tag_search_bar>.search_top").addClass('yl');
			return;
		}
	});


	$("#expandMoreSearch").click(function(){
		var img = $(this).find("img");
		if($("#adv_search_list").is(":hidden")){
			$("#adv_search_list").show();
			$(".search_top_right>.text_c").css("color","#4795ff");
			img.attr("src","<%=basePath%>assets/img/traffic/a-up.png");
		}else{
			$("#adv_search_list").hide();
			$(".search_top_right>.text_c").css("color","#666");
			img.attr("src","<%=basePath%>assets/img/traffic/a-down.png");
		}
	
	});
	showMoreSearch();
	setTopHeight();
	
	var country = $("#country").val();
	if(country != null && country != ''){
		var countries = $("#countryMenu>li>a");
		$(countries).each(function(index){
			var countryId = $(countries[index]).attr('id');
			if(countryId == country){
				var tid = $(countries).parent().parent().attr("aria-labelledby");
				$("#"+tid).find("font").text($(countries[index]).text());
				$("#"+tid).find("input").val(countryId);
			}
		});
	}
	
	var city = '${pcity}';
	$("#city").val(city);
	if(city != null && city != ''){
		var countries = $("#cityselect>li>a");
		$(countries).each(function(index){
			var cityId = $(countries[index]).attr('id');
			if(cityId == city){
				var tid = $(countries).parent().parent().attr("aria-labelledby");
				$("#"+tid).find("font").text($(countries[index]).text());
				$("#"+tid).find("input").val(cityId);
			}
		});
	}
	
});



</script>
<script type="text/javascript">

function seachObject(){

	//productCount(0);
	toProductListPage('${ptype}');
}

function getSelectCity(parentId,cityFrom){
	if(parentId == null || parentId == ''){
		cityFrom.empty();
		cityFrom.prev().find("font").text('');
		cityFrom.prev().find("input").val('');
		return;
	}
	
	$.ajax({
		type:"POST",
		url:"<%=basePath%>city/ajaxGetCityList.html",
		data:{'parentId': parentId},
		async: false,
		dataType: "html",
		success: function(json){
			var result =jQuery.parseJSON(json);
			var rows = result.rows;
			cityFrom.empty();

			if(rows.length < 1){
				cityFrom.prev().find("font").text('');
				cityFrom.prev().find("input").val('');
			}
			cityFrom.append(
					'<li><a href="javascript:void(0)" id="">请选择</a></li>'
			);
			$(rows).each(function(index){
				cityFrom.append(
						'<li><a href="javascript:void(0)" id="'+rows[index].id+'">'+rows[index].cityName+'</a></li>'
					);
				if(index == 0){
					cityFrom.prev().find("font").text('请选择');
					cityFrom.prev().find("input").val('');
				}
		  	});
			$(".dropdown-menu>li>a").click(function(){
				var tid = $(this).parent().parent().attr("aria-labelledby");
				var countryId = $(this).attr('id');
				$("#"+tid).find("font").text($(this).text());
				$("#"+tid).find("input").val(countryId);
			});
		}
	});
}

function showMoreSearch(){
	var img = $(this).find("img");
	$("#adv_search_list").show();
	$(".search_top_right>.text_c").css("color","#4795ff");
	img.attr("src","<%=basePath%>assets/img/traffic/a-up.png");
}
</script>
</body>
</html>