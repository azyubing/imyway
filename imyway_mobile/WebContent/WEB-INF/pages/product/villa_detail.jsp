<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<html>
<head>
<!-- page level -->
<link href="<%=basePath%>assets/css/villa_detail.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://maps.google.cn/maps/api/js?sensor=false&language=zh-CN"></script>

</head>
<body>

<!-- ==center content -->
		<div class="fl center_content">
			<div class="breadcrumbs"><i class="fa fa-chevron-left i_style"></i><a href="<%=basePath%>home.html">首页</a> &nbsp;<span>&gt;</span>&nbsp;&nbsp;<a href="<%=basePath%>product/product_list.html?ptype=2&fromFlag=0">别墅</a>&nbsp; <span>&gt;</span>&nbsp;&nbsp;${country.cityName }-${city.cityName }</div>
			<div class="p_detail"  style="height: 108px;">
				<div style="font-size: 24px;padding-top: 20px;line-height: 30px;margin-bottom: 8px;">${row.pname }</div>
				<div class="t2">${row.map_address }</div>
			</div>
			<div class="p_tags">
				<div class="fl pl_20">
					<c:forEach items="${fn:split(row.tags,'|')}" var="val" >
						<a class="btn btn-sm btn-success tag-btn" style="cursor: default;">${val}</a>
					</c:forEach>
				</div>
				<div class="fr p_0 tag_btn_group" >
					<!-- <a href="javascript:void(0)" class="btn btn-sm btn-info addroute" id="setBtn" disabled="false">放入行程单</a> -->
					<a href="javascript:void(0)" class="tag-item" id="inCollection"><img src="<%=basePath%>assets/img/hotel/star.png"></a>
					<%-- <a href="javascript:void(0)" class="tag-item"><img src="<%=basePath%>assets/img/hotel/chart.png"></a>
					<a href="javascript:void(0)" class="tag-item"><img src="<%=basePath%>assets/img/hotel/link.png"></a> --%>
				</div>
			</div>
			<div class="clr"></div>
			<!-- ==banner -->
			<div id="myCarousel" class="carousel slide" data-type="villa">
				<!-- 轮播（Carousel）指标 -->
				<ol class="my-indicators carousel-indicators">
				   <c:set value="${ fn:split(row.size_img1, ',') }" var="images" />
				  <c:forEach items="${images}" var="img_val" varStatus="status">
					  <li data-target="#myCarousel" data-slide-to="${status.index}"  <c:if test="${status.index == 0}">class="active" </c:if>></li>
				  </c:forEach>
				</ol>  
				<!-- 轮播（Carousel）项目 -->
				<div class="carousel-inner">
					<c:forEach items="${images}" var="img_val" varStatus="status">
						<div class="item <c:if test="${status.index == 0}">active </c:if>">
						   <img class="lazy-carousel" data-original="${img_val}" alt="" >
						</div>
					</c:forEach>
				</div>
				<!-- 轮播（Carousel）导航 -->
				<a class="slidesjs-navigation " href="#myCarousel" data-slide="prev"><img  src="<%=basePath%>assets/img/left_btn.png"  alt="上一页"></a>
				<a class="slidesjs-navigation slidesjs-next" href="#myCarousel" data-slide="next"><img  src="<%=basePath%>assets/img/right_btn.png"  alt="下一页"></a>
			</div>
			<div class="clr"></div>
			<!-- ==end banner -->
			<!-- ==sub nav -->
			<div class="sub_nav rel">
				<a class="fl nav_item active" catid="1">别墅概览</a>
				<a class="fl nav_item"  catid="2">别墅位置</a>
				<a class="fl nav_item"  catid="3">价格&amp;条款</a>
				<a class="fl nav_item"  catid="4">评价</a>
				<a class="fl nav_item last_item"  catid="5">注意事项</a>
			</div>
			<!-- ==End sub nav -->
			<!-- ==details -->
			<div class="cat"  catid="1">
			${row.pdesc }
			</div>
			<div id="p_map" catid="2" class="cat">
				<div class="p_header">
					<img alt="" src="<%=basePath%>assets/img/hotel/map_icon.png">
					<span>别墅位置</span>
				</div>
				<div class="p_content" id="map_canvas" style="width: 100%; height: 250px"></div>
			</div>
			<div class="price cat" catid="3">
				<div class="price-title">
					<p>价格&条款</p>
				</div>
				<div class="price-content" style="padding: 0px;">
					<div class="price-table">
						<table>
							<tr>
								<th>价格（每晚）</th><th>卧室</th><th>至少入住晚数</th><th>时间范围</th>
							</tr>
							<tbody>
							<c:forEach items="${villaDetailPriceInfoList}" var="row" varStatus="i">
							<c:if test="${i.index<=2 }">
								<tr 
									<c:if test="${i.index % 2 == 0 }">
										class="greencolor"
									</c:if>
									<c:if test="${i.index % 2 == 0 }">
										class="borderb"
									</c:if>
									>  
									<td style="max-width: 200px;"><fmt:formatNumber value="${row.roomPrice}" type="currency" pattern="#"/></td>
									<td style="max-width: 200px;">${row.roomCnt }</td>
									<td style="max-width: 200px;">${row.mindays }</td>
									<td style="min-width: 210px;"><fmt:formatDate value="${row.starttime }" type="both" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${row.enddate }" type="both" pattern="yyyy-MM-dd"/></td>
								</tr>
							</c:if>
							</c:forEach>
							</tbody>
							
							<tbody id="disTr" style="display: none;">
								<c:forEach items="${villaDetailPriceInfoList}" var="row" varStatus="i">
								<c:if test="${i.index>2 }">
									<tr 
										<c:if test="${i.index % 2 == 0 }">
											class="greencolor"
										</c:if>
										<c:if test="${i.index % 2 == 0 }">
											class="borderb"
										</c:if>
										>  
										<td style="max-width: 200px;"><fmt:formatNumber value="${row.roomPrice}" type="currency" pattern="#"/></td>
										<td style="max-width: 200px;">${row.roomCnt }</td>
										<td style="max-width: 200px;">${row.mindays }</td>
										<td style="min-width: 210px;"><fmt:formatDate value="${row.starttime }" type="both" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${row.enddate }" type="both" pattern="yyyy-MM-dd"/></td>
									</tr>
								</c:if>
									
								</c:forEach>
							</tbody>
							
						</table>
					</div>
					
					<div id="time_price">
						<div class="row">
							<div class="col-md-8 col-sm-8 col-xs-8 note"></div>
				  			<div class="col-md-4 col-sm-4 col-xs-4 expand" ><span id="expandBtn">查看所有时间段价格&nbsp;<i class="fa fa-caret-down"></i></span></div>
				  		</div>
				  </div>
					<hr>
					${row.price_desc }
					<%-- 
				<!-- ==time zone price -->
				  <div id="time_price">
				  		<div class="row">
				  			<div class="col-md-8 col-sm-8 col-xs-8 note">备注：此房价为6位客人，3卧室的价格。</div>
				  			<div class="col-md-4 col-sm-4 col-xs-4 expand" ><span id="expandBtn">收起所有时间段价格&nbsp;<i class="fa fa-caret-up"></i></span></div>
				  		</div>
				  		<div class="price_list">
				  			<div class="list_item dark row m_0">
				  				<div class="col-md-3 col-sm-3 col-xs-3  t">地方税：</div>
				  				<div class="col-md-9 col-sm-9 col-xs-9  p" >7.7%</div>
				  			</div>
				  			<div class="list_item row m_0">
				  				<div class="col-md-3 col-sm-3 col-xs-3  t">服务费：</div>
				  				<div class="col-md-9 col-sm-9 col-xs-9  p" >10%</div>
				  			</div>
				  			<div class="list_item  dark row m_0">
				  				<div class="col-md-3 col-sm-3 col-xs-3  t">成人加床费：</div>
				  				<div class="col-md-9 col-sm-9 col-xs-9  p" >¥ 310（不含服务费）</div>
				  			</div>
				  		</div>
				  </div>
				  <div class="clr"></div>
				  <!-- ==end time zone price -->
					<div class="price-info4">
						<div class="media">
						  <div class="media-left">
						    <a href="#">
						      <img class="media-object" src="<%=basePath%>assets/img/UI/baby.jpg" >
						    </a>
						  </div>
						  <div class="media-body">
						    <span>儿童条款：</span><i>免费提供婴儿床和儿童座椅（需提前告知）</i>
						    <p>预订/取消条款：任何取消预订，需得到书面通知（可接受EMAIL）。取消将从收到书面通知时生效。在收到取消通知后以下，取消条款适用于如下： 标准时间和高峰时间 30天及以上时间到达： - 不退款但从官方确认取消时9个月内记入信用值，信用值可做为客人及相关人士的保留预约权力，但仅限于别墅的最初保留。 30天以内到达： - 不退款。可将额度用于确认取消后9个月之内的预订，若价格不同，需补差价 圣诞和新年期间： - 仅在有其他团体预订相同时期住宿或部分时间住宿时，可退换全部或部分款项</p>
						  </div>
						</div>
					</div>
					<div class="price-info5">
						<span>儿童和加床</span>
						<p>允许客人携带儿童入住。</p>
						<p class="redcol">免费！允许1名6岁以下儿童，使用现有床铺免费。</p>
						<p>允许1名年龄较大的儿童或成人，一张床收费；没人每晚CNY550</p>
						<p class="redcol">免费！允许1名2岁以下儿童，加1张婴儿床，免费。</p>
						<p>最多容纳：每间客房1张加床。</p>
						<p>附加费用不会计算在总价中，您需在入住时另行支付。 </p>
					</div> --%>
				</div>
			</div>
			<div id="p_discuss" catid="4" class="cat">
				<div class="p_header">
					<img alt="" src="<%=basePath%>assets/img/hotel/discuss_icon.png">
					<span>评价</span>
				</div>
				<div class="p_content" >
					 <div id="evaluationList" class="discuss_content">
						<c:forEach items="${evaluationList }" var="evaluation">
							<div class="d_detail">
								<div class="d_img fl"><img alt="" width="20px;" height="20px;"
									<c:if test="${empty evaluation.photo}">
										src="<%=basePath%>assets/tmp/hotel_tmp_img/man2.png"
									</c:if>
									<c:if test="${!empty evaluation.photo}">
										src="${evaluation.photo}"
									</c:if>
								></div>
								<div class="d_name fl">
									<c:if test="${empty evaluation.customerName}">
										匿名用户
									</c:if>
									<c:if test="${!empty evaluation.photo}">
										${evaluation.customerName}
									</c:if>
								</div>
								<div class="d_time fl"><fmt:formatDate value="${evaluation.ctdt}" type="both" pattern="yyyy-MM-dd"/></div>
								<div class="d_mark clr">${evaluation.content}</div>
							</div>
						</c:forEach>
					 </div>
					<div class="y_comm">您的评论：
					<c:if test="${empty loginUser.id}">
						<span>评论请先
							<a href="<%=basePath%>tologin.html">登录</a>，或
							<a href="<%=basePath%>toregister.html">注册</a>
						</span>
					</c:if>
					</div>
					<form action="" id="y_remark">
						<input type="hidden" value="${pid }" name="productId">
						<input type="hidden" value="${loginUser.username }" name="customerName">
						<input type="hidden" value="${loginUser.id }" name="userId">
						<input type="hidden" value="0" name="core">
						<textarea rows="2" cols="2" name="content"  ></textarea>
						<a id="subCommBtn" href="javascript:void(0)" onclick="addEvaluation('${pid}','${loginUser.id }');" class="btn btn-info">发表评论</a>
					</form>
				</div>
			</div>
			<!-- ==end discuss  -->
			<div id="p_warning" catid="5" class="cat">
				<div class="p_header">
					<img alt="" src="<%=basePath%>assets/img/hotel/warning.png">
					<span>注意事项</span>
				</div>
				<div class="p_content" style="padding: 0px;">
				${row.pnote }
				</div>
			</div>
		</div>
		<!--=== End center content ===-->
<!-- ==right content -->
<div class="right_content fr" id="right_content">
	<div class="r_top">
		<p><span class="account_icon r"></span><span class="account_price r"><fmt:formatNumber value="${row.start_price }" type="currency" pattern="¥"/>&nbsp;</span><span class="account_info">&nbsp;元起</span></p>
		<p class="account_time">价格有效期:<fmt:formatDate value="${row.startdate }" type="both" pattern="yyyy年MM月dd日"/>-<fmt:formatDate value="${row.enddate }" type="both" pattern="yyyy年MM月dd日"/></p>
	</div>
	<!-- <div class="r_top">
		<p><span class="account_icon r">¥&nbsp;</span><span class="account_price r">2540&nbsp;</span><span class="account_info">/&nbsp;人起</span></p>
		<p class="account_time">价格有效期：2015年4月1日 - 2016年3月31日</p>
	</div> -->
	<div class="r_middle">
		<div class="villa_content">
			<!-- <div><i>风格</i><span>名家设计，奢华</span></div> -->
			<div><i>卧室</i><span>${row.minroomcnt }-${row.maxroomcnt  }</span></div>
			<!-- <div><i>浴室</i><span>5</span></div>
			<div><i>可住人数</i><span>6-10人</span></div>
			<div><i>入住时间</i><span>15：00</span></div>
			<div><i>退房时间</i><span>10:00</span></div>
			<div><i>设施</i><span><img src="../assets/img/villa/11.png"><img src="../assets/img/villa/21.jpg"><img src="../assets/img/villa/31.png"><img src="../assets/img/villa/41.png"><img src="../assets/img/villa/51.png"></span><span class="more"><a href="javascript:void(0)">MORE</a></span></div>
			<div><i>服务</i><span><img src="../assets/img/villa/1.png"><img src="../assets/img/villa/2.png"><img src="../assets/img/villa/3.png"><img src="../assets/img/villa/4.png"><img src="../assets/img/villa/5.png"></span><span class="more"><a href="javascript:void(0)">MORE</a></span></div>
		 -->
		</div>
		
			<div class="villa_info">
				<!-- 
				<p>
					<span class="ri">开始时间（入住）</span><span class="ri ml_20">结束时间（退房）</span>
				</p>
				-->
				<%--
				<p >
					<span class="ri">开始时间（入住）：</span>
					<span><input class=" sdate" onclick="showPriceCalendar(this);" id="starttime" value="<fmt:formatDate value="<%=new Date() %>" type="both" pattern="yyyy-MM-dd"/>" type="text" readonly="readonly"/></span>
					
				</p>
				
				 --%>
			<div style="border-bottom:1px solid #e5e5e5; padding: 8px 0 0 20px;">
				<span class="ri">开始时间（入住）：</span>
				<%--
				<span><input class="ri ri-btn sdate ndate" onclick="showPriceCalendar(this);" id="packageBeginDate" value="<fmt:formatDate value="${date }" type="both" pattern="yyyy-MM-dd"/>" type="text" readonly="readonly"/></span>
				 --%>
				<div class="input-append date " onclick="showPriceCalendar(this);" style="cursor: pointer;height: 42px;width:140px;display: inline-block;">
						<input type="text" id="starttime" class="dateinput sdate ndate" readonly="readonly" style="padding-left:8px;text-align: left; width: 120px;border-color: #e5e5e5;height: 32px;line-height: 32px;border-right: 1px solid #e5e5e5; " value="<fmt:formatDate value="<%=new Date() %>" type="both" pattern="yyyy-MM-dd"/>" >
						<span class="add-on date_picker_btn rel" style="height: 12px;border: 0px;width: 15px; left:-28px;top:1px;margin-bottom: 18px;"  ><i class="fa fa-calendar"></i></span>
				</div>
			</div>
				
				<div style="padding: 10px 20px;margin-bottom: 20px">
					<span class="ri">结束时间（退房）：</span>
					<div class="input-append date date-picker" style="cursor: pointer;height: 42px;width:140px;display: inline-block;">
						<input type="text" id="enddate" class="dateinput" readonly="readonly" style="padding-left:8px;text-align: left; width: 120px;border-right: 1px solid #e5e5e5;">
						<span class="add-on date_picker_btn rel" style="height: 12px;border: 0px;width: 15px; left:-28px;top:1px;margin-bottom: 18px;" ><i class="fa fa-calendar"></i></span>
				    </div>
				    <!-- 
					<input type="text" id="enddate" placeholder="" class="enddate date-picker" readonly="readonly" >
					<button class="btn date_picker_btn">
					<span class="fa fa-calendar"></span>
					</button>
				     -->
					
					<script type="text/javascript" src="<%=basePath%>assets/js/bootstrap-datepicker.min.js"></script>
					<script type="text/javascript">
					$('.date-picker').datepicker({
					    	format: 'yyyy-mm-dd',
					        autoclose: true,
					        todayHighlight: true,
					        language: 'cn', //en
					    });
					</script>
					<script type="text/javascript">
					$('.date-picker').datepicker().on('changeDate', function(e) {
						   countprice();
					});
					
					$('.date-picker').datepicker().on('show', function(e) {
						$('.date-picker').datepicker('setStartDate', $("#starttime").val());
						var days=$(".datepicker-days>table>tbody>tr>.day");
						for(var i=0;i<days.length;i++){
							if(!$(days[i]).hasClass("disabled")){
								$(days[i]).css("background","#EFFBD6");
								break;
							}
						}
					});
					</script>
				</div>
				<div id="vill_detail">
					<!-- 
					<p class="villa_date">
						<input type="text" id="starttime" readonly="readonly" onclick="showPriceCalendar(this);" value="<fmt:formatDate value="<%=new Date() %>" type="both" pattern="yyyy-MM-dd"/>" class="ri ri-btn sdate ndate">
						~&nbsp<input type="text" id="enddate"  value="" class="ri ri-btn sdate">
					</p>
					 -->
					
					<div id="priceCalendar" style="display: none;">
					</div>
			<script src="<%=basePath%>assets/js/moment.min.js"></script>
			<script src='<%=basePath%>assets/fullcalender/fullcalendar.min.js'></script>
			<script type="text/javascript">
//日历设定
function renderCal(eid){
	$("#calContent").css("height","450px");
	$('#'+eid).fullCalendar({
		theme: false,
		header: {
			left: 'prev,next today',
			center: 'title',
			right: ''
		},
		height: 450,
		editable: false,
		disableDragging :false,
		events: function(start,end, callback) {
			var start = $.fullCalendar.formatDate(start, "yyyy-MM-dd");
	        $.ajax({
	            url:'<%=basePath%>product/villaPriceCal.html',
	            dataType: 'json',
	            async: false,
	            data: {"date":start,"pid":'${pid}'},
	            success:function(data) {
	                var events =[];
	               for(var i=0;i<data.length;i++){
	            	   events.push({
	            		    title:'￥'+data[i].title,
	                        start:data[i].start ,
	                        description: data[i].start,
	                        id:data[i].room_type
	                    });   
	            	   /*
	            	   if(i==10 || i==8 || i==2){
	            		   if(i==8){
	            			   events.push({
			                        title:'售完',
			                        start:data[i].start ,
			                        description: data[i].start,
			                        id:data[i].room_type,
			                        className: 'sale-off off-icon'
			                    });
	            		   }else{
		            		   events.push({
			                        title:'售完',
			                        start:data[i].start ,
			                        description: data[i].start,
			                        id:data[i].room_type,
			                        className: 'sale-off'
			                    });   
	            		   }
	            	   }else{
	            		   if(i==3||i==4){
	            			   events.push({
			                        title:'￥'+data[i].title+'起',
			                        start:data[i].start ,
			                        description: data[i].start,
			                        id:data[i].room_type,
			                        className: 'off-icon'
			                    }); 
	            			
	            		   }else{
			                   events.push({
			                        title:'￥'+data[i].title+'起',
			                        start:data[i].start ,
			                        description: data[i].start,
			                        id:data[i].room_type
			                    });   
	            		   }
	            	   }  */  
	               }
	               callback(events);
	            }
	        });
	    },
		eventClick: function(calEvent, jsEvent, view) {
			 var viewStart = calEvent.description;
			 var d = new Date(); 
			   var nowStr = d.format('yyyy-MM-dd');
			   if(viewStart.substring(0,10)<= nowStr){
				   alert("开始时间必须大于当前日期");
				   return;
			   }
			 priceItemDetail(viewStart.substring(0,10));
			 hideCal();
	    }
	    ,viewDisplay: function (view) {//动态把数据查出，按照月份动态查询
            var events =[];
            $('#'+eid).fullCalendar('updateEvent', events);
		},
	   dayClick:function( date, allDay, jsEvent, view ) {
		   var viewStart = $.fullCalendar.formatDate(date, "yyyy-MM-dd");
		   var d = new Date(); 
		   var nowStr = d.format('yyyy-MM-dd');
		   if(viewStart<= nowStr){
			   alert("开始时间必须大于当前日期");
			   return;
		   }
		  
		   priceItemDetail(viewStart);
		   hideCal();
	   }
			
	});
	$(".fc-header-right").append('<button type="button" class="close" onclick="hideCal()"  style="font-size:30px;">&times;</button>');
	$(".fc-header-left>.fc-button-prev>.fc-text-arrow").empty().html('<img  src="<%=basePath%>assets/img/UI/left-arrow.png">');
	$(".fc-header-left>.fc-button-next>.fc-text-arrow").empty().html('<img  src="<%=basePath%>assets/img/UI/right-arrow.png">');
	$(".fc-header-left>.fc-button-today").empty().html('<img  src="<%=basePath%>assets/img/UI/today.png" style="position: relative; top: -2px;" >').removeClass().css({"cursor": "pointer"});
	$(".fc-header-left>.fc-button-prev").removeClass().css({"cursor": "pointer","margin-right":"10px"}); 
	$(".fc-header-left>.fc-button-next").removeClass().css({"cursor": "pointer"}); 
	var ww = $(window).width(), wh=$(document).height();
	var leftval = (ww/2-451) > 0?(ww/2-451):0;
	$("#maskBak").show().css({"width": ww+"px", "height": wh+"px", "filter": "alpha(opacity=70)" , "opacity":"0.7", "z-index":"99999"});
	$("#calContent").css({"top": "100px", "left": leftval+"px", "filter": "alpha(opacity=100)" , "opacity":"1", "z-index":"100000"});

}

function showPriceCalendar(obj) {
	$('#calContent').empty();
	renderCal('calContent');
}

function hideCal(){
	$("#maskBak").hide().css({ "z-index":"1"});
	$("#calContent").css({"filter": "alpha(opacity=0)" , "opacity":"0", "z-index":"1" , "height":"2px"}).empty();
}
</script>
			<%--
			 
			<script type="text/javascript">
			function showPriceCalendar(obj) {
				$("#priceCalendar").show();
				
				$('#priceCalendar').fullCalendar({
					theme: false,
					header: {
						left: 'prev,next today',
						center: 'title',
						right: ''
					},
					editable: true,
					events: function(start,end, callback) {
						var start = $.fullCalendar.formatDate(start, "yyyy-MM-dd");
				        $.ajax({
				            url:'<%=basePath%>product/villaPriceCal.html',
				            dataType: 'json',
				            data: {"date":start,"pid":'${pid}'},
				            success:function(data) {
				                var events =[];
				               for(var i=0;i<data.length;i++){
				                   events.push({
				                        title:'￥'+data[i].title,
				                        start:data[i].start ,
				                        id:data[i].room_type
				                    });
				               }
				               callback(events);
				            }
				        });
				    },
				    viewDisplay: function (view) {//动态把数据查出，按照月份动态查询
		                var events =[];
		                $("#priceCalendar").fullCalendar('updateEvent', events);
					},
				   dayClick:function( date, allDay, jsEvent, view ) {
					   var viewStart = $.fullCalendar.formatDate(date, "yyyy-MM-dd");
					   priceItemDetail(viewStart);
					   $("#priceCalendar").hide();
				   },
				   prevClick: function(calEvent, jsEvent, view) {
				        alert(calEvent.title);
				    }
				});
			}
			</script>
			--%>
			
					<div id="villa" >
					<c:if test="${rows!=null && fn:length(rows)!=0 }">
						<p class="villa_type">
							<select class="selectpicker" onchange="changeVilla(this);" >
								<c:forEach items="${rows }" var="r" varStatus="i">
									<option value="${i.index }">${r.roomCnt }卧室,可住${r.peopleCnt}人</option>
								</c:forEach>
							</select>
							&nbsp;x&nbsp;
							<select class="select2">
								<option value="1">1栋</option>
								<option value="2">2栋</option>
								<option value="3">3栋</option>
								<option value="4">4栋</option>
								<option value="5">5栋</option>
							</select>
							<!-- 
							<span class="ri ri-btn" style="width: 40px;"> <span class="count">1间</span></span>
							 -->
							<span><span id="roomPrice"><fmt:formatNumber value="${rows[0].roomPrice}" type="currency" pattern="¥"/>(含税)</span></span>
						</p>
						<p style="" id="extrabed">
							<c:if test="${rows[0].extrabedflg==1 }">
								<span class="addition_p">加床</span>&nbsp;x&nbsp;
								<select class="select3"  onchange="countprice()" >
									<c:forEach  var="v" begin="0" end="${rows[0].extraCnt }">
										<option value="${v}">${v }</option>
									</c:forEach>
								</select>
								<span><fmt:formatNumber value="${rows[0].addPrice}" type="currency" pattern="¥"/>(含税)</span>
							</c:if>
						</p>
					</c:if>
					</div>
					<div style="border-bottom:1px solid #e5e5e5;"></div>
				</div>
				<!-- <p class="villa_type">
					<span class="ri ri-btn"> <span>3间卧室，可住6位客人</span><a
						href="javascript:void(0)"><i class="fa fa-caret-down"></i></a>
					</span> &nbsp;&nbsp;x&nbsp;&nbsp;<span class="ri ri-btn2"> <span
						class="count">1间</span><span class="btns"><a class="up"
							href="javascript:void(0)"><i class="fa fa-caret-up"></i></a> <a
							class="down" href="javascript:void(0)"><i
								class="fa fa-caret-down"></i></a></span>
					</span>
				</p> -->
				<!-- <p style="margin-top: 10px;">
					<span class="ri">加床</span>
				</p>
				<p class="room_add_price" style="margin-top: 5px;">
					<span class="ri ri-btn"> <span class="count">1</span><span
						class="btns"><a class="up" href="javascript:void(0)"><i
								class="fa fa-caret-up"></i></a> <a class="down"
							href="javascript:void(0)"><i class="fa fa-caret-down"></i></a></span>
					</span>
				</p>
				<p>
					<span class="p2">¥ 500</span>
				</p> -->
				<p id="addNewPackage" style="margin:20px;"><a href="javascript:void(0)" style="color: #69a8ff;font-size: 14px;" onclick="addNewVilla(this)">+添加其他别墅类型</a></p>
			</div>
		</div>
	<div class="r_down">
		<div class="price_list">
			<p class="li"><span class="li_l">房费</span><span class="li_r"><span class="sm_r">¥</span> 0</span></p>
			<p class="li"><span class="li_l">税费</span><span class="li_r"><span class="sm_r">¥</span> <span id="taxationPrice"></span></span></p>
			<p class="li"><span class="li_l">服务费</span><span class="li_r"><span class="sm_r">¥</span> <span id="servicePrice"></span></span></p>
		</div>
		<div class="price_total">
			<p class="li"><span class="li_l">总价</span><span class="li_r"><span class="sm_r">¥</span> <span id="total"></span></span></p>
		</div>
		<p class="p_info">别墅规则：按每栋/晚 计费</p>
		<p class="p_btn"><a class="btn btn-info addroute" id="setCtripBtn" disabled="false">放入行程单</a></p>
	</div>
</div>
<div class="clr"></div>
<!--=== End right content ===-->

<!-- Page level JS -->
<script type="text/javascript" src="<%=basePath%>assets/js/product_detail.js"></script>

<script type="text/javascript">
var rowStr = '';

var villaModel='';
function addNewVilla(obj){
	if(villaModel.length>0){
		$("#villa").append(villaModel);
		countprice();
	}
}


function changeVilla(obj){
	var index = $(obj).val();
	var rowsStr = rowStr;
	var extrabedflg = rowsStr[index].extrabedflg;
	var extrabed = '';
	$(obj).parent().find(".roomPrice").html("¥"+rowsStr[index].roomPrice+"(含税)");
	$(obj).parent().parent().find(".descp").html(rowsStr[index].description);
	var maxCntoption = '';
	var max_cnt = rowsStr[index].maxCnt;
	for(var k=1;k<=max_cnt;k++){
		maxCntoption = maxCntoption+'<option value="'+k+'">'+k+'栋</option>';
	}
	$(obj).next().html(maxCntoption);
	
	if(extrabedflg==1 ){
		var op = '';
		for(var j=0;j<=rowsStr[index].extraCnt;j++){
			op = op+'<option value="'+j+'">'+j+'</option>';
		}
		extrabed = extrabed+'<span class="addition_p">加床</span>&nbsp;x&nbsp;'
								+'<select class="select2"  onchange="countprice()" >'
								+op
								+'</select>'
								+'<span  style="color:#ff0000;float:right;line-height:34px">¥'+rowsStr[index].addPrice+'(含税)</span>'
								;
		if($(obj).parents(".villa_child").find(".extrabed").html()==undefined){
			extrabed = '<p style="" class="extrabed">'+extrabed+'</p>';
			$(obj).parents(".villa_child").append(extrabed);
		}else{
			$(obj).parents(".villa_child").find(".extrabed").html(extrabed);
		}
	}else{
		$(obj).parents(".villa_child").find(".extrabed").remove();
	}
	
	countprice();
}


function countprice(){
	var rowsStr = rowStr;
	var villa_childList = $("#villa").find(".villa_child");
	var total = 0;
	for(var i=0;i<villa_childList.length;i++){
		var index = $(villa_childList).eq(i).find("select").eq(0).val();
		var roomPrice = rowsStr[index].roomPrice;
		var number = $(villa_childList).eq(i).find("select").eq(1).val();
		total = total+number*parseFloat(roomPrice);
		
		var select_num =  $(villa_childList).eq(i).find(".extrabed").find("select");
		var num = $(select_num).val();
		if(num!=null && num!='' && num!='undefined' && num!=undefined){
			var addPrice = rowsStr[index].addPrice;
			total = total+num*parseFloat(addPrice);
		}
	}
	var starttime = $("#starttime").val();
	var enddate = $("#enddate").val();
	if(enddate!=''&&enddate!=null){
		var n = getDateDiff(starttime, enddate);
		if(n<1){
			alert("结束日期必须大于开始日期");
			return false;
		}
		total = total*n;
	}
	
	var taxationPrice = (total* parseFloat('${row.tax_rate}')).toFixed(2);
	var servicePrice = (total* parseFloat('${row.service_fee_rate}')).toFixed(2);
	//total = (parseFloat(total) + parseFloat(taxationPrice)+parseFloat(servicePrice)).toFixed(2);
	
	$("#taxationPrice").html(taxationPrice);
	$("#servicePrice").html(servicePrice);
	$("#total").html(total);
	$(".price_list").find(".li_r").eq(0).html('<span class="sm_r">¥</span>'+(total-taxationPrice-servicePrice).toFixed(2));
}

routeJson = '${routeJson}';
function add(){
	var starttime = $("#starttime").val();
	var enddate = $("#enddate").val();
	if(enddate==null||enddate==''){
		alert("请输入结束时间");
		$("#enddate").focus();
		return false;
	}
	var productEndtime = new Date('${row.enddate }');
	var endtime = productEndtime.format('yyyy-MM-dd');
	var n = getDateDiff(starttime, endtime) ;
	if(n<0){
		alert("产品无效，无法就加入行程单");
		return false;
	}
	
	
	
	var commonJson = routeJson;
	var data = '';
	if(commonJson!=null&&commonJson!=''){
		if(typeof(routeJson)=='string'){
			data = eval("(" + commonJson + ")");
		}else{
			data = commonJson;
		}
	}
	var villaJson = data.villa;
	var packageJson = data.package;
	var hotelJson = data.hotel;
	var starttime = $("#starttime").val();
	var enddate = $("#enddate").val();
	var dateList = new Array();
	dateList.push(starttime);
	var dateList = getDateList(dateList,starttime, enddate);
	for(var i=0;i<dateList.length;i++){
		if(hotelJson!='' && hotelJson!=null &&hotelJson!='undefined' ){
			var hotel_json = hotelJson[''+dateList[i]+''];
			if(hotel_json!='' && hotel_json!=null &&hotel_json!='undefined'){
				var bool = window.confirm("行程单中日期："+dateList[i]+"已有酒店产品提供住宿，是否继续添加当前别墅？");
				if(!bool){
					return false;
				}
			}
		}
		if(packageJson!='' && packageJson!=null &&packageJson!='undefined'){
			var package_json = packageJson[''+dateList[i]+''];
			if(package_json!='' && package_json!=null &&package_json!='undefined' &&package_json.staylvl!='99'){
				var bool = window.confirm("行程单中日期："+dateList[i]+"已有套餐产品提供住宿，是否继续添加当前别墅？");
				if(!bool){
					return false;
				}
			}
		}
	}
	
	if(villaJson!=null&&villaJson!=''&&villaJson!='undefined'){
		var start = villaJson[''+starttime+''];
		var end = villaJson[''+enddate+''];
		if((end!=null&&end!=''&&end!='undefined')||(start!=null&&start!=''&&start!='undefined')){
			var bool = window.confirm("预定该别墅时间段内行程单中已有其他别墅，是否删除其他别墅预定当前别墅?");
			if(!bool){
				return false;
			}
		}
	}
	buliderObject();	
}

function buliderObject(){
	var rowsStr = rowStr;
	var villa_childList = $("#villa").find(".villa_child");
	var total = 0;
	var valliPrice="{"
	var day = 0;
	for(var i=0;i<villa_childList.length;i++){
		var index = $(villa_childList).eq(i).find("select").eq(0).val();
		var roomPrice = rowsStr[index].roomPrice;
		var prepay = rowsStr[index].prepay;
		var id = rowsStr[index].id;
		var villa_nm = rowsStr[index].villaNm;
		var minDay = rowsStr[index].mindays;
		if(minDay>day){
			day = minDay;
		}
		var number = $(villa_childList).eq(i).find("select").eq(1).val();
		
		valliPrice=valliPrice+'"room_price":'+'"'+roomPrice+'",'+'"prepay":'+'"'+prepay+'",'+'"number":'+'"'+number+'"'+',"id":'+'"'+id+'"';
		
		total = total+number*parseFloat(roomPrice);
		var select_num =  $(villa_childList).eq(i).find(".extrabed").find("select");
		var num = $(select_num).val();
		if(num!=null && num!='' && num!='undefined' && num!=undefined){
			var addPrice = rowsStr[index].addPrice;
			total = total+num*parseFloat(addPrice);
			valliPrice = valliPrice+','+'"extrabed_price":'+'"'+addPrice+'",'+'"extrabed_number":'+'"'+num+'"';
		}
		valliPrice = valliPrice+'},{'
	}
	
	valliPrice = valliPrice.substring(0,valliPrice.length-2);
	var starttime = $("#starttime").val();
	var enddate = $("#enddate").val();
	/* var endd = new Date(enddate);
	var end_date = new Date(endd.setDate(endd.getDate()-1));
	var e = end_date.getFullYear()+ "-" + (end_date.getMonth() + 1) + "-" + end_date.getDate(); */
	var n = getDateDiff(starttime, enddate);
	if(n<day){
		alert("您选择的别墅最少预定天数为:"+day+"天,当前预定天数是:"+n+"天,请重新选择");
		return false;
	}
	total = total*n;
	
	var taxationPrice = (total* parseFloat('${row.tax_rate}')).toFixed(3);
	var servicePrice = (total* parseFloat('${row.service_fee_rate}')).toFixed(3);
	
	
	var timestamp = Date.parse(new Date());
	
	var s = '{"pid":'+'"'+'${row.pid}'+'",'
			+'"pname":'+'"'+'${row.pname}'+'",'
			+'"leftCountry":'+'"'+'${country.id}'+'",'
			+'"startDate":'+'"'+starttime+'",'
			+'"time":'+'"23:59",'
			+'"endDate":'+'"'+enddate+'",'
			+'"timestamp":'+'"'+timestamp+'",'
			+'"serviceFeeRate":'+'"'+'${row.service_fee_rate}'+'",'
			+'"countryName":'+'"'+'${country.cityName }'+'",'
			+'"cityName":'+'"'+'${city.cityName }'+'",'
			+'"taxRate":'+'"'+'${row.tax_rate}'+'",'
			+'"villa_nm":'+'"'+villa_nm+'",'
			+'"servicePrice":'+'"'+servicePrice+'",'
			+'"taxPrice":'+'"'+taxationPrice+'",'
			+'"totalPrice":'+'"'+total+'",'
			+'"type":'+'"villa",'
			+'"valliPriceList":['+valliPrice+']}';
	appendTrafficJson(s,null,'villa');
}

/**
 * route.js 引用
 */
function priceItemDetail(date){
	$("#starttime").val(date);
	getpriceItem();
}

//获取价格项
function getpriceItem(){
	var starttime = $("#starttime").val();
	if(starttime!=null&&starttime!=''){
		getVillaPriceItemDetail();
	}
}

//有效价格项
function getVillaPriceItemDetail(){
	var pid = $("#pid").val();
	var starttime = $("#starttime").val();;
	var enddate = $("#enddate").val();
	$.ajax({    
        type:'post',        
        url:"<%=basePath%>product/villa_priceItemDetail.html",    
        data:{"pid":pid,"enddate":enddate,"starttime":starttime},    
        cache:false,    
        dataType:'json',    
        success:function(data){
        	setHtml(data);
        }    
    });
}

function removevilla(obj){
	$(obj).parent().prev().remove();
	$(obj).parent().remove();
	countprice();
}

/**
 * 填充价格项html
 */
function setHtml(data){
	rowStr = data;
	if(data.length>0){
		var villa_type = '<div class="linehelp" style="border-bottom:1px solid #e5e5e5;"></div><div class="villa_child">'
						+'<img src="<%=basePath%>assets/img/colse.png" onclick="removevilla(this);" style="position:absolute;top:0;right:0"/>'
						+' <p class="villa_type"><select class="select1" onchange="changeVilla(this);" >';
		var option = '';
		for(var i =0;i<data.length;i++){
			var r = data[i];
			option = option+'<option value="'+i+'">'+r.roomCnt+'卧室,可住'+r.peopleCnt+'人</option>';
		}
		
		var maxCntoption = '';
		var max_cnt = data[0].maxCnt;
		for(var k=1;k<=max_cnt;k++){
			maxCntoption = maxCntoption+'<option value="'+k+'">'+k+'栋</option>';
		}
		villa_type = villa_type+option+'</select>'
					+'&nbsp;x&nbsp;'
					+'<select class="select2" onchange="countprice()">'
					/* +'<option value="1">1间</option>'
					+'<option value="2">2间</option>'
					+'<option value="3">3间</option>'
					+'<option value="4">4间</option>'
					+'<option value="5">5间</option>' */
					+maxCntoption
					+'</select>'
					+'<span><span class="roomPrice" style="color:#ff0000;float:right;line-height:34px">¥'+data[0].roomPrice+'(含税)</span></span></p>'
					+'<p class="descp" style="font-size:12px;color:#ccc;">'+data[0].description+'</p>'
					+'<div style="margin:0 20px 20px;border-bottom:1px solid #e5e5e5;padding:0 20px"></div>';
		if(data[0].extrabedflg==1 ){
			var op = '';
			for(var j=0;j<=data[0].extraCnt;j++){
				op = op+'<option value="'+j+'">'+j+'</option>';
			}
			villa_type = villa_type+'<p style="" class="extrabed"><span class="addition_p">加床</span>&nbsp;x&nbsp;'
									+'<select class="select3"  onchange="countprice()" >'
									+op
									+'</select>'
									+'<span style="color:#ff0000;float:right;line-height:34px">¥'+data[0].addPrice+'(含税)</span>'
									+'</p>';
		}
		villa_type = villa_type+'</div>';
		villaModel = villa_type;
		$("#villa").html(villa_type);
		countprice();
		allowAdd();
	}else{
		notAllowAdd();	
	}
	
}


/**
 * 可以加入行程单
 */
function allowAdd(){
	if(typeof($(".addroute").attr("disabled"))=="undefined"){
	}else{
		$(".addroute").bind("click",function(){
			add();
		});
		$(".addroute").removeAttr("disabled");
	}
}
/**
 * 步可以加入行程单
 */
function notAllowAdd(){
	$(".addroute").unbind("click")
	$(".addroute").attr("disabled",true);
}



var isExpend = false;
var map;  
var position= new google.maps.LatLng(${row.map_lat},${row.map_lng}); 
//地图初始化  
function initializeMap() {  
	var mapOptions = {        
		zoom: 10,                //缩放级别    
		center: position,       //将地图的中心设置为指定的地理点 可以使用 0（最低缩放级别，在地图上可以看到整个世界）到 19（最高缩放级别，可以看到独立建筑物）之间的缩放级别  
		mapTypeId: google.maps.MapTypeId.ROADMAP,   //ROADMAP-默认视图 SATELLITE-显示Google地球卫星图像 HYBRID-混合显示普通视图和卫星视图 TERRAIN-地形图   
		scaleControl: true,    //比例尺  
		mapTypeControl: false      
	   // mapTypeControlOptions: {style: google.maps.MapTypeControlStyle.DROPDOWN_MENU}  
	};  
	map = new google.maps.Map(document.getElementById("map_canvas"),mapOptions);//编写 JavaScript 函数创建“map”对象  
	createMark();
}    

//创建标记  
function createMark(){  
    var marker = new google.maps.Marker({  
		position:position,  
		map: map//要添加标记的地图  
    });  
} 

function initPage() {  
    try {  
        $window = $(window);  
        var resize = $window.jqElemResize();  
        $(resize).on("resize", function (size) {  
        	setTopHeight(); 
        	initializeMap();
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
	
jQuery(document).ready(function() {
	initPage();
	setTopHeight();
	$('#myCarousel').carousel({interval: 5000});
	
	//set next/pre hover 
	$(".carousel-inner,.slidesjs-navigation,.my-indicators").hover(
		function(){
			$(".slidesjs-navigation").removeClass("opacity-hide").addClass("opacity-harf-show");
		},
		function(){
			$(".slidesjs-navigation").removeClass("opacity-harf-show").addClass("opacity-hide");
		}
	);
	//sub_nav
	$(".sub_nav>.nav_item").click(function(){
		var obj = this;
		setCatTop(obj);
		setTimeout(function(){
			setCatTop(obj);
		},50);
	});
	function setCatTop(obj){
		if(!$(obj).hasClass("active")){
			$(".sub_nav>.nav_item").removeClass("active");
			$(obj).addClass("active");			
		}
		var catid=$(obj).attr("catid");
		var top=$(".cat[catid='"+catid+"']").offset().top;
		$(window).scrollTop(top-50);
	}

	//set check
	$("#rf>a").click(function(){
		if($(this).children().eq(0).hasClass("checked")){
			$(this).children().eq(0).attr("src","<%=basePath%>assets/img/hotel/check1.png").removeClass("checked");
		}else{
			$(this).children().eq(0).attr("src","<%=basePath%>assets/img/hotel/check2.png").addClass("checked");
		}
	});

	$("#expandBtn").click(function(){
		if($("#disTr").is(":hidden")){
			$("#disTr").show(); 
			$("#expandBtn>i").removeClass("fa-caret-down").addClass("fa-caret-up"); 
		}else{
			$("#disTr").hide();  
			$("#expandBtn>i").removeClass("fa-caret-up").addClass("fa-caret-down");   
		}
	});
	
	//set map
	initializeMap();
	
	var snavTop = $('.sub_nav').offset().top;
	$('.sub_nav').setScroll({
	  startTop:snavTop
	});
	
	
	var t1 = $(".t1");
	var checkeddate = $.session.get('checkeddate');
	$(t1).each(function(index){
		var t1date = $(t1[index]).attr('date');
		if(t1date == checkeddate){
			$("#endTime").val($(t1[index]).attr('date'));
			ischecked($(t1[index]));
		}
	});
	
});
</script>
<!-- jianghuiqing javascript start -->
<script type="text/javascript">
//加入收藏夹
$("#inCollection").click(function(){
	setTimeout(function(){
		$.ajax({
			type: "GET",	
			url: "<%=basePath%>collection/ajaxAddCollection.html",
			data: {'pid':'${pid}','roomcnt':'5'},
			dataType: "html",
			success: function(htmlData){
				var objectList =jQuery.parseJSON(htmlData);
				alert(objectList);
			}
		});
	},500);
});
</script>
<!-- jianghuiqing javascript end -->
</body>
</html>