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
	<div class="dropdown bottom-btns mr_10" style="margin-left: 10px;">
		  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
		    <font>娱乐类型</font>
		   	<input type="hidden" id="enttype"/>
		    <span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu" id="enttypeMenu" aria-labelledby="dropdownMenu3">
		  	<li><a href="javascript:void(0)" id="">请选择</a></li>
		  	<li><a href="javascript:void(0)" id="0">门票</a></li>
		  	<li><a href="javascript:void(0)" id="1">观光</a></li>
<%-- 		    <c:forEach var="item" items="${enttype }" varStatus="statusIdx" >
		  		<li>
		  			<a href="javascript:void(0)" id="${item.enttype }">
						<c:if test="${item.enttype == 0 }">门票</c:if>
						<c:if test="${item.enttype == 1 }">观光</c:if>
					</a>
				</li>
		  	</c:forEach> --%>
		  </ul>
		</div><!-- 
	 --><div class="dropdown bottom-btns mr_10">
		  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu4" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
		    <font>服务类型</font>
		    <input type="hidden" id="servicetype"/>
		    <span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu" id="servicetypeMenu" aria-labelledby="dropdownMenu4">
		  	<li><a href="javascript:void(0)" id="">请选择</a></li>
		  	<li><a href="javascript:void(0)" id="0">散团</a></li>
		  	<li><a href="javascript:void(0)" id="1">独立包团</a></li>
<%-- 		    <c:forEach var="item" items="${servicetype }" varStatus="statusIdx" >
		  		<li>
		  			<a href="javascript:void(0)" id="${item.servicetype }">
						<c:if test="${item.servicetype == 0 }">散团</c:if>
						<c:if test="${item.servicetype == 1 }">独立包团</c:if>
					</a>
				</li>
		  	</c:forEach> --%>
		  </ul>
		</div><!--
	 --><div class="dropdown bottom-btns mr_10">
		  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu5" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
		    <font>服务语言</font>
		    <input type="hidden" id="language"/>
		    <span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu" id="languageMenu" aria-labelledby="dropdownMenu5">
		  	<li><a href="javascript:void(0)" id="">请选择</a></li>
		  	<li><a href="javascript:void(0)" id="0">中文</a></li>
		  	<li><a href="javascript:void(0)" id="1">英文</a></li>
		  	<li><a href="javascript:void(0)" id="2">任意</a></li>
<%-- 		    <c:forEach var="item" items="${language }" varStatus="statusIdx" >
		  		<li>
		  			<a href="javascript:void(0)" id="${item.language }">
						<c:if test="${item.language == '0' }">中文</c:if>
						<c:if test="${item.language == '1' }">英文</c:if>
						<c:if test="${item.language == '2' }">任意</c:if>
					</a>
				</li>
		  	</c:forEach> --%>
		  </ul>
		</div><!-- 
	    --><img src="<%=basePath%>assets/img/y.png" class="rel" style="left: 10px;z-index: 1000;"><input type="text" class="mon_ipt" id="minPrice" style="border-left: 1px solid #e5e5e5;width: 70px;padding-left: 20px;margin-left: -10px;"> -<!-- 
	    --><img src="<%=basePath%>assets/img/y.png" class="rel" style="left: 10px;z-index: 1000;"><input type="text" class="mon_ipt" id="maxPrice" style="border-left: 1px solid #e5e5e5;width: 70px;padding-left: 20px;margin-left: -10px;"><!-- 
	    --><a href="javascript:void(0)" class="btn" id="confirmBtn" onclick="confirmBtn()">确定</a><!-- 
	    --><a href="javascript:void(0)" class="btn" id="cleanBtn" onclick="cleanBtn()">清空</a><!-- 
	    --><input type="hidden" id="ptype" value="${ptype }"  /><input type="hidden" id="offset" value="1"  />
	    
	    
	    
<script type="text/javascript">

//对Date的扩展，将 Date 转化为指定格式的String
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
//例子： 
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function (fmt) { //author: meizz 
var o = {
   "M+": this.getMonth() + 1, //月份 
   "d+": this.getDate(), //日 
   "h+": this.getHours(), //小时 
   "m+": this.getMinutes(), //分 
   "s+": this.getSeconds(), //秒 
   "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
   "S": this.getMilliseconds() //毫秒 
};
if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
for (var k in o)
if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
return fmt;
}

jQuery(document).ready(function() {

	seachEntList();
	
	//娱乐类型
	$("#enttypeMenu>li>a").click(function(){
		var tid = $(this).parent().parent().attr("aria-labelledby");
		var countryId = $(this).attr('id');
		$("#"+tid).find("font").text($(this).text());
		$("#"+tid).find("input").val(countryId);
		$("#offset").val(1);
		seachEntList();
	});
	
	//服务类型
	$("#servicetypeMenu>li>a").click(function(){
		var tid = $(this).parent().parent().attr("aria-labelledby");
		var countryId = $(this).attr('id');
		$("#"+tid).find("font").text($(this).text());
		$("#"+tid).find("input").val(countryId);
		$("#offset").val(1);
		seachEntList();
	});
	
	//服务语言
	$("#languageMenu>li>a").click(function(){
		var tid = $(this).parent().parent().attr("aria-labelledby");
		var countryId = $(this).attr('id');
		$("#"+tid).find("font").text($(this).text());
		$("#"+tid).find("input").val(countryId);
		$("#offset").val(1);
		seachEntList();
	});

});

function confirmBtn(){
	$("#offset").val(1);
	seachEntList();
}

function cleanBtn(){
	
	$("#country").val('');
	$("#country").prev().text('');
	
	$("#city").val('');
	$("#city").prev().text('');
	$("#cityselect").empty();
	
	
	$("#enttype").val('');
	$("#enttype").prev().text('娱乐类型');
	
	$("#servicetype").val('');
	$("#servicetype").prev().text('服务类型');
	
	$("#language").val('');
	$("#language").prev().text('服务语言');
	
	$("#minPrice").val('');
	$("#maxPrice").val('');
	$("#offset").val(1);
	seachEntList();
}

function seachEntList(){
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
			url: "<%=request.getContextPath()%>/product/ent_list_ajax.html?"+new Date(),
			data: {'pname': $("#pname").val(),'country': $("#country").val(),'city': $("#city").val(),
				'tags': $("#tags").val(),'startTime': $("#startTime").val(),'endTime': $("#endTime").val(),
				'enttype': $("#enttype").val(),'servicetype': $("#servicetype").val(),'language': $("#language").val(),
				'minPrice': $("#minPrice").val(),'maxPrice': $("#maxPrice").val(),'themeIds': themeIds.join(","),
				'ptype':$("#ptype").val(),'cnt':$("#orderCnt").val(),'orderPrice':$("#orderPrice").val(),
				'offset' : $("#offset").val()},
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
					
					var toHref = '<%=basePath%>product/ent_detail.html?pid='+objectList[index].pid;
					var price = objectList[index].start_price;
					var tags = objectList[index].tags;
					var tagsLebels = tags.split("|");
					var tagsStr = "";
					var enddate = objectList[index].enddate;
					var enddateDate = new Date(enddate);
					var enddateStr = enddateDate.Format("yyyy-MM-dd");
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
							'		<div><img alt="" src="'+img+'"  class="p_img_style" ></div>'+
							'		<div class="item_info bs">'+
							'			<p style=" overflow: hidden; text-overflow: ellipsis;white-space: nowrap;">'+objectList[index].pname+'</p>'+
							'			<p class="sp_info">'+objectList[index].countryName+'&nbsp;'+objectList[index].cityName+'</p>'+
							'			<div class="item_tag">'+
							'				<div class="fl tags" >'+
							tagsStr+
							'				</div>'+
							'				<div class="fr infos"><span>有效期：</span><span class="g">'+enddateStr+'</span></div>'+
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
				var pageCount = Math.ceil(reslut.totalCount*1/reslut.pageSize);
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
			 "width":$(".col").width()+"px",
			 "height":$(".col").width()/2+"px"
		 });
}

function changePage(pageNo){
	shCircleLoaderLoading();
	$("#offset").val(pageNo);
	seachEntList();
}

function prePage(){
	shCircleLoaderLoading();
	var pageNo = $("#offset").val();
	$("#offset").val(pageNo*1 - 1);
	seachEntList();
}

function nextPage(){
	shCircleLoaderLoading();
	var pageNo = $("#offset").val();
	$("#offset").val(pageNo*1 + 1);
	seachEntList();
}


</script>
