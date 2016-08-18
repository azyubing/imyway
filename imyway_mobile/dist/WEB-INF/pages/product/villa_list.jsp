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
	<%-- <div class="dropdown bottom-btns mr_10" style="margin-left: 10px;">
		  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
		    <font>卧室数</font>
		    <input type="hidden" id="roomCnt"/>
		    <span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu" id="roomCntMenu" aria-labelledby="dropdownMenu3">
		    <c:forEach var="item" items="${roomCnt }" varStatus="statusIdx" >
		  		<li><a href="javascript:void(0)" id="${item.room_cnt }">${item.room_cnt }</a></li>
		  	</c:forEach>
		  </ul>
		</div> --%><!-- 
	 --><div class="dropdown bottom-btns mr_10" style="margin-left: 10px;">
		  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu4" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
		    <font>所在区域</font>
		    <input type="hidden" id="area"/>
		    <span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu" id="areaMenu" aria-labelledby="dropdownMenu4">
		  	<li><a href="javascript:void(0)" id="">请选择</a></li>
		    <c:forEach var="item" items="${area }" varStatus="statusIdx" >
		    	<c:if test="${item.area != null and item.area != '' }">
		  			<li><a href="javascript:void(0)" id="${item.area }">${item.area }</a></li>
		  		</c:if>
		  	</c:forEach>
		  </ul>
		</div><!--
	 --><div class="dropdown bottom-btns mr_10">
		  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu5" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
		    <font>地理特征</font>
		    <input type="hidden" id="geography" />
		    <span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu" id="geographyMenu" aria-labelledby="dropdownMenu5">
		  	<li><a href="javascript:void(0)" id="">请选择</a></li>
		  	<li><a href="javascript:void(0)" id="0">沙滩</a></li>
		  	<li><a href="javascript:void(0)" id="1">花园</a></li>
	  		<li><a href="javascript:void(0)" id="2">半山</a></li>
	  		<li><a href="javascript:void(0)" id="3">山顶</a></li>
		    <%-- <c:forEach var="item" items="${geography }" varStatus="statusIdx" >
		  		<li><a href="javascript:void(0)" id="${item.geography }">${item.geography }</a></li>
		  	</c:forEach> --%>
		  </ul>
		</div><!-- 
	    --><img src="<%=basePath%>assets/img/y.png" class="rel" style="left: 10px;z-index: 1000;"><input type="text" class="mon_ipt" id="minPrice" style="border-left: 1px solid #e5e5e5;width: 70px;padding-left: 20px;margin-left: -10px;"> -<!-- 
	    --><img src="<%=basePath%>assets/img/y.png" class="rel" style="left: 10px;z-index: 1000;"><input type="text" class="mon_ipt" id="maxPrice" style="border-left: 1px solid #e5e5e5;width: 70px;padding-left: 20px;margin-left: -10px;"><!-- 
	    --><a href="javascript:void(0)" class="btn" id="confirmBtn" onclick="confirmBtn()">确定</a><!-- 
	    --><a href="javascript:void(0)" class="btn" id="cleanBtn" onclick="cleanBtn()">清空</a><!-- 
	    --><input type="hidden" id="ptype" value="${ptype}"  /><input type="hidden" id="offset" value="1"  />
<script type="text/javascript"> 
	
jQuery(document).ready(function() {

	seachVillaList();
	
	//卧室数
	$("#roomCntMenu>li>a").click(function(){
		var tid = $(this).parent().parent().attr("aria-labelledby");
		var countryId = $(this).attr('id');
		$("#"+tid).find("font").text($(this).text());
		$("#"+tid).find("input").val(countryId);
		$("#offset").val(1);
		seachVillaList();
	
	});
	
	//所在区域 
	$("#areaMenu>li>a").click(function(){
		var tid = $(this).parent().parent().attr("aria-labelledby");
		var countryId = $(this).attr('id');
		$("#"+tid).find("font").text($(this).text());
		$("#"+tid).find("input").val(countryId);
		$("#offset").val(1);
		seachVillaList();
	
	});
	
	//地理特征
	$("#geographyMenu>li>a").click(function(){
		var tid = $(this).parent().parent().attr("aria-labelledby");
		var countryId = $(this).attr('id');
		$("#"+tid).find("font").text($(this).text());
		$("#"+tid).find("input").val(countryId);
		$("#offset").val(1);
		seachVillaList();
		
	});


	
	
});


function confirmBtn(){
	$("#offset").val(1);
	seachVillaList();
}

function cleanBtn(){
	
	$("#country").val('');
	$("#country").prev().text('');
	
	$("#city").val('');
	$("#city").prev().text('');
	$("#cityselect").empty();
	
	
	$("#roomCnt").val('');
	$("#roomCnt").prev().text('卧室数');
	
	$("#area").val('');
	$("#area").prev().text('所在区域');
	
	$("#geography").val('');
	$("#geography").prev().text('地理特征');
	
	$("#minPrice").val('');
	$("#maxPrice").val('');
	$("#offset").val(1);
	seachVillaList();
}


function seachVillaList(){
	
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
			url: "<%=request.getContextPath()%>/product/villa_list_ajax.html?"+new Date(),
			data: {'pname': $("#pname").val(),'country': $("#country").val(),'city': $("#city").val(),
				'tags': $("#tags").val(),'startTime': $("#startTime").val(),'endTime': $("#endTime").val(),
				//'roomCnt': $("#roomCnt").val(),
				'area': $("#area").val(),'geography': $("#geography").val(),
				'minPrice': $("#minPrice").val(),'maxPrice': $("#maxPrice").val(),'themeIds': themeIds.join(","),
				'ptype':$("#ptype").val(),'cnt':$("#orderCnt").val(),'orderPrice':$("#orderPrice").val(),
				'offset' : $("#offset").val()
				},
			dataType: "html",
			success: function(json){
				var reslut =jQuery.parseJSON(json);
				var objectList = reslut.rows;
				var objectLebel = $("#objectLebel");
				objectLebel.empty();
				$("#productListClass").removeClass(); 
				$("#productListClass").addClass("info_list"); 
				$(objectList).each(function(index){
					var img = objectList[index].size_img2;
					if(img == null || img == ''){
						img = '<%=basePath%>assets/img/package/package_tmp.jpg';
					}else{
						img=img.replace("images","images2");
					}

					var toHref = '<%=basePath%>product/villa_detail.html?pid='+objectList[index].pid;
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
						'		<div><img alt="" src="'+img+'" class="p_img_style"></div>'+
						'		<div class="item_info bs">'+
						'			<p style=" overflow: hidden; text-overflow: ellipsis;white-space: nowrap;">'+objectList[index].pname+'</p>'+
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
					
			  	});
				$(".p_img_style").css({
					 "width":$(".col>.item").width()+"px",
					 "height":$(".col>.item").width()/2+"px"
				 });
				$("#pagination").remove();
				var pagenationHtml = '<div id="pagination"><ul>';
				var offset = $("#offset").val();
				if(offset != 1 ){
					pagenationHtml += '<li class="l_arrow" id="pre_btn"><a href="javascript:void(0)" onclick="prePage()" ><img src="<%=basePath%>assets/img/personal/la.png"></a></li>';
				}
				var pageCount = Math.ceil(reslut.totalCount*1/ reslut.pageSize );
				for(var i=0; i<pageCount;i++){
					if( (i+1) == offset){
						pagenationHtml += '<li class="l_arrow"><a class="active">'+(i+1)+'</a></li>';
					}else{
						pagenationHtml += '<li class="l_arrow"><a href="javascript:void(0)" onclick="changePage('+(i+1)+')" >'+(i+1)+'</a></li>';
					}
				}
				if(offset != pageCount && pageCount != 0){
					pagenationHtml += '<li class="l_arrow" id="next_btn"><a href="javascript:void(0)" onclick="nextPage()" ><img src="<%=basePath%>assets/img/personal/ra.png"></a></li></ul></div>';
				}
				
				objectLebel.after(pagenationHtml);
				shCircleLoaderDestroy();
			}
		});

	
	 $(".p_img_style").css({
		 "width":$(".col>.item").width()+"px",
		 "height":$(".col>.item").width()/2+"px"
	 });
	 
}

function changePage(pageNo){
	shCircleLoaderLoading();
	$("#offset").val(pageNo);
	seachVillaList();
}

function prePage(){
	shCircleLoaderLoading();
	var pageNo = $("#offset").val();
	$("#offset").val(pageNo*1 - 1);
	seachVillaList();
}

function nextPage(){
	shCircleLoaderLoading();
	var pageNo = $("#offset").val();
	$("#offset").val(pageNo*1 + 1);
	seachVillaList();
}

</script>
