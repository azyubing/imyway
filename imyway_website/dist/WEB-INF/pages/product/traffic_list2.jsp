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
<%-- 		<div class="dropdown mr_10" style="margin-left: 15px;">
		  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
		    <font>起点</font>
		    <input type="hidden" id="startplace"/>
		    <span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu" id="startplaceMenu" aria-labelledby="dropdownMenu1">
		  	<c:forEach var="item" items="${startplace }" varStatus="statusIdx" >
		  		<li><a href="javascript:void(0)" id="${item.startplace }">${item.startplace }</a></li>
		  	</c:forEach>
		  </ul>
		</div><!-- 
	 --><div class="dropdown mr_10">
		  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
		    <font>终点</font>
		    <input type="hidden" id="endplace"/>
		    <span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu" id="endplaceMenu" aria-labelledby="dropdownMenu2">
		    <c:forEach var="item" items="${endplace }" varStatus="statusIdx" >
		  		<li><a href="javascript:void(0)" id="${item.endplace }">${item.endplace }</a></li>
		  	</c:forEach>
		  </ul>
		</div> --%><!-- 
	 --><div class="dropdown bottom-btns mr_10" style="margin-left: 10px;">
		  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
		    <font>用车等级</font>
		    <input type="hidden" id="carlvl"/>
		    <span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu" id="carlvlMenu" aria-labelledby="dropdownMenu3">
		  	<li><a href="javascript:void(0)" id="">请选择</a></li>
		  	<li><a href="javascript:void(0)" id="0">豪华</a></li>
		  	<li><a href="javascript:void(0)" id="1">舒适</a></li>
	  		<li><a href="javascript:void(0)" id="2">普通</a></li>
		    <%-- <c:forEach var="item" items="${carlvl }" varStatus="statusIdx" >
		  		<li>
		  			<a href="javascript:void(0)" id="${item.carlvl }">
					<c:if test="${item.carlvl == 0 }">豪华</c:if>
					<c:if test="${item.carlvl == 1 }">舒适</c:if>
					<c:if test="${item.carlvl == 2 }">普通</c:if>
					</a>
				</li>
		  	</c:forEach> --%>
		  </ul>
		</div><!-- 
	 --><!-- <div class="dropdown bottom-btns mr_10">
		  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu4" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
		    <font>用车类型</font>
		    <span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu" aria-labelledby="dropdownMenu4">
		    <li><a href="javascript:void(0)">租车</a></li>
		  </ul>
		</div> --><!--
	 --><div class="dropdown bottom-btns mr_10">
		  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu5" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
		    <font>车型</font>
		    <input type="hidden" id="cartype"/>
		    <span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu" id="cartypeMenu" aria-labelledby="dropdownMenu5">
		  	<li><a href="javascript:void(0)" id="">请选择</a></li>
		  	<li><a href="javascript:void(0)" id="0">4人以下</a></li>
		  	<li><a href="javascript:void(0)" id="1">5-7人坐</a></li>
	  		<li><a href="javascript:void(0)" id="3">7-20人坐</a></li>
	  		<li><a href="javascript:void(0)" id="4">20人以上</a></li>
<%-- 		    <c:forEach var="item" items="${cartype }" varStatus="statusIdx" >
		  		<li>
		  			<a href="javascript:void(0)" id="${item.cartype }">
		  				<c:if test="${item.cartype == 0 }">4人以下</c:if>
		  				<c:if test="${item.cartype == 1 }">5-7人坐</c:if>
		  				<c:if test="${item.cartype == 3 }">7-20人坐</c:if>
		  				<c:if test="${item.cartype == 4 }">20人以上</c:if>
		  			</a>
		  		</li>
		  	</c:forEach> --%>
		  </ul>
		</div><!-- 
    --><!-- <div class="dropdown bottom-btns">
		  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu6" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
		    <font>交通方式</font>
		    <span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu" aria-labelledby="dropdownMenu6">
		    <li><a href="javascript:void(0)">车</a></li>
		  </ul>
		</div> --><!-- 
		--><a href="javascript:void(0)" class="btn" id="cleanBtn" onclick="cleanBtn()">清空</a><!-- 
	    --><input type="hidden" id="ptype" value="${ptype }"  />
		
<script type="text/javascript">

jQuery(document).ready(function() {

	//seachTrafficList();
	
	/* //起点
	$("#startplaceMenu>li>a").click(function(){
		var tid = $(this).parent().parent().attr("aria-labelledby");
		var countryId = $(this).attr('id');
		$("#"+tid).find("font").text($(this).text());
		$("#"+tid).find("input").val(countryId);
		seachTrafficList();
	});
	//终点
	$("#endplaceMenu>li>a").click(function(){
		var tid = $(this).parent().parent().attr("aria-labelledby");
		var countryId = $(this).attr('id');
		$("#"+tid).find("font").text($(this).text());
		$("#"+tid).find("input").val(countryId);
		seachTrafficList();
	}); */
	//用车等级
	$("#carlvlMenu>li>a").click(function(){
		var tid = $(this).parent().parent().attr("aria-labelledby");
		var countryId = $(this).attr('id');
		$("#"+tid).find("font").text($(this).text());
		$("#"+tid).find("input").val(countryId);
		seachTrafficList();
	});
	//车型
	$("#cartypeMenu>li>a").click(function(){
		var tid = $(this).parent().parent().attr("aria-labelledby");
		var countryId = $(this).attr('id');
		$("#"+tid).find("font").text($(this).text());
		$("#"+tid).find("input").val(countryId);
		seachTrafficList();
	});
	
});

function cleanBtn(){
	
	$("#country").val('');
	$("#country").prev().text('');
	
	$("#city").val('');
	$("#city").prev().text('');
	$("#cityselect").empty();
	
	
	$("#startplace").val('');
	$("#startplace").prev().text('起点');
	
	$("#endplace").val('');
	$("#endplace").prev().text('终点');
	
	$("#carlvl").val('');
	$("#carlvl").prev().text('用车等级');
	
	$("#cartype").val('');
	$("#cartype").prev().text('车型');
	
	seachTrafficList();
}

function seachTrafficList(){
	var theme = $(".theme");
	var themeIds = new Array();
	var i = 0;
	$(theme).each(function(index){
		if(theme[index].checked){
			themeIds[i] = theme[index].value;
			i+=1;
		}
	});

		$.ajax({
			type: "GET",
			async: true,
			url: "<%=request.getContextPath()%>/product/traffic_list_ajax.html",
			data: {'pname': $("#pname").val(),'country': $("#country").val(),'city': $("#city").val(),'tags': $("#tags").val(),
				//'startplace': $("#startplace").val(),'endplace': $("#endplace").val(),
				'carlvl': $("#carlvl").val(),'cartype': $("#cartype").val(),
				'startTime': $("#startTime").val(),'endTime': $("#endTime").val(),'themeIds': themeIds.join(","),
				'ptype':$("#ptype").val(),'cnt':$("#orderCnt").val(),'orderPrice':$("#orderPrice").val()},
			dataType: "html",
			success: function(json){
				var objectList =jQuery.parseJSON(json);
				var objectLebel = $("#objectLebel");
				objectLebel.empty();
				/* $("#productListClass").removeClass(); 
				$("#productListClass").addClass("imgs_price container-fluid");  */
				$("#productListClass").removeClass(); 
				$("#productListClass").addClass("info_list"); 
				$(objectList).each(function(index){
					var img = objectList[index].size_img2;
					if(img == null || img == ''){
						img = '<%=basePath%>assets/img/package/package_tmp.jpg';
					}

					var toHref = '<%=basePath%>product/traffic_detail.html?pid='+objectList[index].pid;
					var price = objectList[index].start_price;
					var tags = objectList[index].tags;
					var tagsLebels = tags.split("|");
					var tagsStr = "";
					var enddate = objectList[index].enddate;
					$(tagsLebels).each(function(i){
						tagsStr += '<span>'+tagsLebels[i]+'</span>&nbsp;';
					});
					
					if(price == null){
						price = '--';
					}
					if(index%3 ==0 && index>2 ){
						objectLebel.append('<div class="">&nbsp;</div>');
					}
					objectLebel.append(
							'<a href="'+toHref+'">'+
							'<div class="col col-md-4 col-sm-4 col-xs-4 col-lg-4">'+
							'	<div class="item">'+
							'		<div><img alt="" src="'+img+'" class="p_img_style" ></div>'+
							'		<div class="item_info bs">'+
							'			<p >'+objectList[index].pname+'</p>'+
							'			<p class="sp_info">'+objectList[index].countryName+'&nbsp;'+objectList[index].cityName+'</p>'+
							'			<div class="item_tag">'+
							'				<div class="fl tags">'+
							tagsStr+
							'				</div>'+
							'				<div class="fr infos"><span>有效期：</span><span class="g">'+enddate.substring(0,10)+'</span></div>'+
							'				<div class="clr"></div>'+
							'			</div>'+
							'			<hr>'+
							'			<div class="item_price">'+
							'				<div class="fl price">价格：<span class="r">¥'+price+'</span>元起&nbsp;&nbsp;</div>'+
							'				<div class="clr"></div>'+
							'			</div>'+
							'		</div>'+
							'	</div>'+
							'</div>'+
							'</a>'
					);
					<%-- var img = objectList[index].size_img1;
					if(img == null || img == ''){
						img = '<%=basePath%>assets/img/package/package_tmp.jpg';
					}else{
						var imgs = img.split(",");
						if(imgs.length > 1){
							img = imgs[1];
						}
					}
					
					
					var toHref = '<%=basePath%>product/traffic_detail.html?pid='+objectList[index].pid;
					var price = objectList[index].price;
					if(price == null){
						price = '--';
					}
					if(index%4 ==0 && index>3 ){
						objectLebel.append('<div class="">&nbsp;</div>');
					}
					objectLebel.append(
						'<a href="'+toHref+'">'+	
						'<div class="col-md-3 col-sm-3 col-xs-3 col">'+
						'	<img alt="" src="'+img+'" class="p_img_style">'+
						'	<img class="icon" alt="" src="<%=basePath%>assets/img/traffic/pc_icon.png">'+
						'	<div class="detail">'+
						'		<p class="d_top"><img src="<%=basePath%>assets/img/traffic/start.png">&nbsp;'+objectList[index].startplace+'</p>'+
						'		<p class="d_top"><img src="<%=basePath%>assets/img/traffic/end.png">&nbsp;'+objectList[index].endplace+'</p>'+
						'	</div>'+
						'	<div class="price container-fluid">'+
						'		<div class="row">'+
						'			<div class="col-md-5 col-sm-5 col-xs-5 text_l">价格：<font>¥'+price+'</font></div>'+
						'			<div class="col-md-7 col-sm-7 col-xs-7 text_r">车型：<span class="g">'+objectList[index].cartype+'&nbsp;'+objectList[index].carlvl+'</span></div>'+
						'		</div>'+
						'	</div>'+
						'</div>'+
						'</a>'
					
					); --%>
					
			  	});
				$(".p_img_style").css({
					 "width":$(".col>.item").width()+"px",
					 "height":$(".col>.item").width()/2+"px"
				 });
				shCircleLoaderDestroy();
			}
		});
		 $(".p_img_style").css({
			 "width":$(".col").width()+"px",
			 "height":$(".col").width()/2+"px"
		 });
}
</script>
