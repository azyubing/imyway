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
<link href="<%=basePath%>assets/css/hotel.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=basePath%>assets/js/javascriptCheck.js"></script>

</head>
<body>


<!-- ==center content -->
<div class="fl center_content">
	<div class="breadcrumbs"><i class="fa fa-chevron-left i_style"></i><a href="<%=basePath%>home.html">首页</a> &nbsp;<span>&gt;</span>&nbsp;&nbsp;<a href="<%=basePath%>product/product_list.html?ptype=1&fromFlag=0">酒店</a>&nbsp; <span>&gt;</span>&nbsp;&nbsp;${country.cityName }-${city.cityName }</div>
	<div class="p_detail"  style="height: 108px;">
		<div style="font-size: 28px;padding: 5px 20px; line-height: 32px;">${row.pname }</div>
		<div class="t2">${row.pname_en}</div>
		<div class="t3">${row.map_address }</div>
	</div>
	<div class="p_tags">
		<div class="fl pl_20">
			<c:forEach items="${fn:split(row.tags,'|')}" var="val" >
			<a  class="btn btn-sm btn-success tag-btn" style="cursor: default;">${val}</a>
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
	<div id="myCarousel" class="carousel slide" data-type="hotel">
   <!-- 轮播（Carousel）指标 -->
   <ol class="my-indicators carousel-indicators" >
   	<c:set value="${ fn:split(row.size_img1, ',') }" var="images" />
	  <c:forEach items="${images}" var="img_val" varStatus="status">
		  <li data-target="#myCarousel" data-slide-to="${status.index}"  <c:if test="${status.index == 0}">class="active" </c:if>></li>
	  </c:forEach>
   </ol>  
   <!-- 轮播（Carousel）项目 -->
   <div class="carousel-inner">
   			<!-- 
      		<div class="item active">
         		<img class="video_icon" src="<%=basePath%>assets/tmp/hotel_tmp_img/h4_video_icon.jpg" alt="" 
         			data-url="http://player.youku.com/player.php/Type/Folder/Fid/26174358/Ob/1/sid/XMTM2OTQ0ODE3Mg==/v.swf"
         			data-title="酒店视频标题">
      		</div>
      		 -->
      		<c:forEach items="${images}" var="img_val" varStatus="status">
				<div class="item <c:if test="${status.index == 0}">active </c:if>">
				   <img class="lazy-carousel" data-original="${img_val}" alt="" >
				</div>
			</c:forEach>
			<!-- 
     		<div class="item">
			   <img src="${row.size_img1 }" alt="" >
			</div>
			<c:if test="${row.size_img2 !=null ||row.size_img2!=''}">
				<div class="item">
				   <img src="${row.size_img2 }" alt="">
				</div>
			</c:if>
			<c:if test="${row.size_img3 !=null ||row.size_img3!=''}">
				<div class="item">
				   <img src="${row.size_img3 }" alt="">
				</div>
			</c:if>
			<c:if test="${row.size_img4 !=null ||row.size_img4!=''}">
				<div class="item">
				   <img src="${row.size_img4 }" alt="">
				</div>
			</c:if>
			<c:if test="${row.size_img5 !=null ||row.size_img5!=''}">
				<div class="item">
				   <img src="${row.size_img5 }" alt="">
				</div>
			</c:if>
			 -->
   </div>
   <!-- 轮播（Carousel）导航 -->
   <a class="slidesjs-navigation " href="#myCarousel" data-slide="prev"><img  src="<%=basePath%>assets/img/left_btn.png"  alt="上一页"></a>
   <a class="slidesjs-navigation slidesjs-next" href="#myCarousel" data-slide="next"><img  src="<%=basePath%>assets/img/right_btn.png"  alt="下一页"></a>
</div>
	<div class="clr"></div>
	<!-- ==end banner -->
<!-- ==sub nav -->
	<div class="sub_nav rel" >
		<a class="fl nav_item active" catid="1">酒店概览</a>
		<a class="fl nav_item"  catid="2">酒店位置</a>
		<a class="fl nav_item"  catid="3">价格&amp;条款</a>
		<a class="fl nav_item"  catid="4">评价</a>
		<a class="fl nav_item last_item"  catid="5">注意事项</a>
	</div>
	<div class="clr"></div>
<!-- ==End sub nav -->
<!-- ==details -->
<div id="details" catid="1" class="cat">
	${row.pdesc }
	<!-- ==map  -->
	<div id="p_map" style="padding: 0 30px 30px 30px;" catid="2" class="cat">
		<div class="p_header">
			<img alt="" src="<%=basePath%>assets/img/hotel/map_icon.png">
			<span>酒店位置</span>
		</div>
		<div class="p_content" id="map_canvas" style="width: 100%; height: 250px"></div>
	</div>	
	<!-- ==End map  -->
<!-- ==price -->
<div id="p_price" catid="3" class="cat">
	<div class="p_header">
		<img alt="" src="<%=basePath%>assets/img/hotel/price_icon.png">
		<span>价格&amp;条款</span>
	</div>
	<div class="p_content">
	<c:forEach items="${showInpageList }" var="roomTypeInfo">
	 <div class="price_detail">
		<div class="price_detail_head">${roomTypeInfo.roomTypeName }</div>
		<div class="row">
			<div class="col-md-6 col-sm-6 col-xs-6"><img id="main_img_1" alt="" src="${fn:split(roomTypeInfo.roomImg1,',')[0] }" style="width: 100%;"></div>
			<div class="col-md-6 col-sm-6 col-xs-6">
			  <div class="pd_top">
				<p>最多成人入住人数：<font class="f_green">${roomTypeInfo.adultCnt }</font></p>
				<p>最多儿童入住人数：<font class="f_green">${roomTypeInfo.childCnt }(6岁以下)</font></p>
				<hr>
			  </div>
			  <div class="pd_down">
			  	<c:forEach items="${fn:split(roomTypeInfo.roomInfra,'|')}" var="val" varStatus="i" >
			  		<span 
			  			<c:if test="${i.index==0 }">
					  		class="first"
			  			</c:if>
			  			<c:if test="${i.index==(fn:length(roomTypeInfo.roomInfra)-1) }">
					  		class="last"
			  			</c:if>
			  		>${val }</span>
				</c:forEach>
			  </div>
			</div>
		</div>
		<div class="detail_imgs">
			<c:set value="${fn:split(roomTypeInfo.roomImg1,',') }" var="str1" />
			<c:forEach items="${str1 }" var="img" varStatus="i">
				<img alt="" src=${img } targetid="main_img_1"
					<c:if test="${i.index==0 }">
					class="hover"
					</c:if>
				style="width: 80px;height: 40px;">
			</c:forEach>
		</div>
	  </div>
	</c:forEach>
	
	
	
	${row.price_desc }	  
	</div>
</div>
<!-- ==End price -->
<!-- ==discuss  -->
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
<!-- ==warning  -->
<div id="p_warning" catid="5" class="cat">
	<div class="p_header">
		<img alt="" src="<%=basePath%>assets/img/hotel/warning.png">
		<span>注意事项</span>
	</div>
	<div class="p_content" style="padding: 0px;">
	${row.pnote }
	</div>
</div>


<!-- ==end warning  -->
</div>
<!-- ==End details -->
</div>
<!--=== End center content ===-->

<!-- ==right content -->
<div class="right_content fr">
	<div class="r_top">
		<p><span class="account_icon r">&nbsp;</span><span class="account_price r"><fmt:formatNumber value="${row.start_price }" type="currency" pattern="¥"/>&nbsp;</span><span class="account_info">&nbsp;元起</span></p>
		<p class="account_time">价格有效期:<fmt:formatDate value="${row.startdate }" type="both" pattern="yyyy年MM月dd日"/>-<fmt:formatDate value="${row.enddate }" type="both" pattern="yyyy年MM月dd日"/></p>
	</div>
	<!-- <div class="r_top">
		<p><span class="account_icon r">¥&nbsp;</span><span class="account_price r">2540&nbsp;</span><span class="account_info">/&nbsp;人起</span></p>
		<p class="account_time">价格有效期：2015年4月1日 - 2016年3月31日</p>
	</div> -->
	<div class="r_middle">
		<div class="room_info">
		<%--
			<p style="border-bottom:1px solid #e5e5e5;padding: 10px 20px">
				<span class="ri">开始时间（入住）：</span>
				<span><input class="ri ri-btn sdate ndate" onclick="showPriceCalendar(this);"   id="childDate" value="<fmt:formatDate value="<%=new Date() %>" type="both" pattern="yyyy-MM-dd"/>" type="text" readonly="readonly" style="cursor: pointer;"/></span>
			</p>
		 --%>

			<div style="border-bottom:1px solid #e5e5e5; padding: 8px 0 0 20px;">
				<span class="ri">开始时间（入住）：</span>
				<%--
				<span><input class="ri ri-btn sdate ndate" onclick="showPriceCalendar(this);" id="packageBeginDate" value="<fmt:formatDate value="${date }" type="both" pattern="yyyy-MM-dd"/>" type="text" readonly="readonly"/></span>
				 --%>
				<div class="input-append date " onclick="showPriceCalendar(this);" style="cursor: pointer;height: 42px;width:140px;display: inline-block;">
						<input type="text" id="childDate" class="dateinput sdate ndate" readonly="readonly" style="padding-left:8px;text-align: left; width: 120px;border-color: #e5e5e5;height: 32px;line-height: 32px; " value="<fmt:formatDate value="<%=new Date() %>" type="both" pattern="yyyy-MM-dd"/>" >
						<span class="add-on date_picker_btn rel" id="date_picker_btn2" style="height: 13px;border: 0px;width: 15px; left:-28px;top:0px;margin-bottom: 18px;" ><i class="fa fa-calendar"></i></span>
				</div>
				<script type="text/javascript">
					var UA = navigator.userAgent.toLowerCase();     
					if(UA.indexOf("chrome")>0){
						if(parseInt(UA.match(/chrome\/([\d.]+)/)[1]) <= 35){
							$("#date_picker_btn2").css("top","-3px");
						}
					}
				</script>
			</div>
			
			<div style="border-bottom:1px solid #e5e5e5; padding: 8px 0 0 20px; display: none;">
				<span class="ri">预定结束日期：</span>
				<div class="input-append date date-picker"  style="cursor: pointer;height: 42px;width:140px;display: inline-block;">
						<input type="text" id="endDate" class="dateinput sdate ndate" readonly="readonly" style="padding-left:8px;text-align: left; width: 120px;border-color: #e5e5e5;height: 32px;line-height: 32px; " value="" >
						<span class="add-on date_picker_btn rel" id="date_picker_btn3" style="height: 13px;border: 0px;width: 15px; left:-28px;top:0px;margin-bottom: 18px;" ><i class="fa fa-calendar"></i></span>
				</div>
				
				<script type="text/javascript" src="<%=basePath%>assets/js/bootstrap-datepicker.min.js"></script>
					<script type="text/javascript">
					$('.date-picker').datepicker({
					    	format: 'yyyy-mm-dd',
					        autoclose: true,
					        todayHighlight: true,
					        language: 'cn', //en
					    });
					$('.date-picker').datepicker().on('changeDate', function(e) {
						   countprice();
					});
					</script>
			</div>
			
			
			
			<div id="priceCalendar" style="display: none;">
			</div>

			
			<!-- 
			<p><span class="ri">开始时间（入住）</span></p>
			<p class="room_date">
			<span ><input class="ri ri-btn sdate" id="childDate" value="<fmt:formatDate value="<%=new Date() %>" type="date" pattern="yyyy-MM-dd"/>" type="text" readonly="readonly"/></span>
			<!-- <span class="ri ri-btn">
				<a href="javascript:void(0)"><i class="fa fa-caret-left"></i></a>2007-06-14<a href="javascript:void(0)"><i class="fa fa-caret-right"></i></a>
			</span> -- >
			</p>
			 -->
			
			<div id="room">
			<c:if test="${rows!=null && fn:length(rows)!=0 }">
				<div class="roomChild">
					<img src="<%=basePath%>assets/img/colse.png" onclick="removeRoom(this);" style="position:absolute;top:0;right:0"/>
					
					<p class="room-types">
					     <select onchange="changeRoomType(this)" class="select1">
							<c:forEach items="${rows }" var="r" varStatus="i" >
								<option value="${r.roomType }">${r.roomTypeName }</option>
							</c:forEach>
						</select>
				    <!--  <span class="ri ri-btn">
							豪华双人间<a href="javascript:void(0)"><i class="fa fa-caret-down"></i></a></span> -->
					</p>
					<p class="room_type">
						<c:if test="${map!=null }">
							<c:forEach items="${map }" var="m">
								<c:if test="${m.key==rows[0].roomType }">
									<c:if test="${m.value!=null}">
								     	<select  class="select3"  onchange="changeRoomTypePrice(this)">
											<c:forEach items="${m.value }" var="r" varStatus="i" >
												<c:if test="${r.priceGroup=='0' }">
													<option value="${i.index }">${r.priceItem }</option>
												</c:if>
												<c:if test="${i.index==0 }">
													<c:set var="num" value="${r.maxCnt }"></c:set>
													<c:set var="price" value="${r.roomPrice }"></c:set>
												</c:if>
											</c:forEach>
										</select>
									&nbsp;x&nbsp;
										<select onchange="countprice();" class="select2" >
											<c:forEach end="${num }" begin="1" var="v" >
													<option value="${v }">${v}</option>
											</c:forEach>
										</select>
										<span><fmt:formatNumber value="${price}" type="currency" pattern="¥"/>(含税)</span>
									</c:if>
								</c:if>
							</c:forEach>
						</c:if>
				     <!-- 2人同住<a href="javascript:void(0)"><i class="fa fa-caret-down"></i></a></span>&nbsp;&nbsp;x&nbsp;&nbsp;<span class="ri ri-btn2">
						<span class="count">1</span><span class="btns"><a class="up" href="javascript:void(0)"><i class="fa fa-caret-up"></i></a>
						<a class="down" href="javascript:void(0)"><i class="fa fa-caret-down"></i></a></span>
					</span> -->
					</p>
					<div class="otherRoomTypePrice">
						<%-- <c:if test="${map!=null }">
							<c:forEach items="${map }" var="m">
								<c:forEach items="${m.value }" var="r" varStatus="i" >
									<c:if test="${r.priceGroup=='1' }">
										<span class="t">${r.priceItem }</span>&nbsp;x&nbsp;
										<select onchange="" class="ri ri-btn" style="width: 50px;">
											<c:forEach end="${r.maxCnt }" begin="0" var="v" >
													<option value="${v }">${v}</option>
											</c:forEach>
										</select>
										<span class="p1" style="width: 70px;">¥ ${r.roomPrice }</span>
									</c:if>
								</c:forEach>
							</c:forEach>
						</c:if> --%>
					</div>
				</div>
				</c:if>
			</div>
			<!-- <p><span class="t">加床</span></p>
			<p class="room_add_price" style="margin-top: 5px;"><span class="ri ri-btn">
				<span class="count">1</span><span class="btns"><a class="up" href="javascript:void(0)"><i class="fa fa-caret-up"></i></a>
				<a class="down" href="javascript:void(0)"><i class="fa fa-caret-down"></i></a></span>
			</span>
		</p>
			<p><span class="p2">¥ 500</span></p> -->
			
			<!-- <p><span class="t">早餐</span></p>
			<p class="room_add_price" style="margin-top: 5px;"><span class="ri ri-btn">
				<span class="count">1</span><span class="btns"><a class="up" href="javascript:void(0)"><i class="fa fa-caret-up"></i></a>
				<a class="down" href="javascript:void(0)"><i class="fa fa-caret-down"></i></a></span>
			</span>
		</p>
			<p><span class="p2">¥ 500</span></p>
			
			<p><span class="t">午餐</span></p>
			<p class="room_add_price" style="margin-top: 5px;"><span class="ri ri-btn">
				<span class="count">1</span><span class="btns"><a class="up" href="javascript:void(0)"><i class="fa fa-caret-up"></i></a>
				<a class="down" href="javascript:void(0)"><i class="fa fa-caret-down"></i></a></span>
			</span>
		</p>
			<p><span class="p2">¥ 500</span></p>
			
			<p><span class="t">晚餐</span></p>
			<p class="room_add_price" style="margin-top: 5px;"><span class="ri ri-btn">
				<span class="count">1</span><span class="btns"><a class="up" href="javascript:void(0)"><i class="fa fa-caret-up"></i></a>
				<a class="down" href="javascript:void(0)"><i class="fa fa-caret-down"></i></a></span>
			</span>
		</p>
			<p><span class="p2">¥ 500</span></p>
			
			<hr>
			 -->
			<p id="addNewRoom" style="margin:20px;"><a href="javascript:void(0)" onclick="addNewRoom(this)">+添加一个房间</a></p>
		</div>
	</div>
	<div class="r_down">
		<div class="price_list">
			<p class="li"><span class="li_l">房费</span><span class="li_r"><span class="sm_r">¥</span> 0</span></p>
			<c:if test="${row.tax_rate!=null }">
				<p class="li"><span class="li_l">税费</span><span class="li_r"><span class="sm_r">¥</span> <span id="taxationPrice"></span></span></p>
			</c:if>
			<c:if test="${row.service_fee_rate!=null }">
				<p class="li"><span class="li_l">服务费</span><span class="li_r"><span class="sm_r">¥</span> <span id="servicePrice"></span></span></p>
			</c:if>
		</div>
		<div class="price_total">
			<p class="li"><span class="li_l">总价</span><span class="li_r"><span class="sm_r">¥</span> <span id="total">0</span></span></p>
		</div>
		<p class="p_btn"><a class="btn btn-info addroute" id="setCtripBtn" disabled="false">放入行程单</a></p>
	</div>
</div>
<!--=== End right content ===-->
<div class="clr"></div>

<!-- model -->
<div class="modal fade " id="videoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
   <div class="modal-dialog" style="width: 700px;">
        <div class="modal-content" style="width: 700px;border-radius:0px;">
            <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
               <h4 id="videoTitle" style="font-size: 14px;color: #333;"></h4>
           </div>
           <div class="modal-body" id="videoContent" ></div>
       </div>
   </div>
</div>
<!-- end model -->

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
	            url:'<%=basePath%>product/hotelPriceCal.html',
	            dataType: 'json',
	            async: false,
	            data: {"date":start,"pid":'${pid}'},
	            success:function(data) {
	                var events =[];
	               for(var i=0;i<data.length;i++){
	            	   events.push({
	                        title:'￥'+data[i].title+'起',
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
			   getpriceItemDetail(viewStart.substring(0,10));
			   hideCal();
	    }
	    <%--
		,eventMouseover: function( event, jsEvent, view ) { 
		  		var tooltipHtml = '<div id="tip_content"><div id="tip_txt"></div><img id="tip_icon" src="<%=basePath%>assets/img/UI/ar_down.png"></div>';
		  		$(this).append(tooltipHtml);
		  		$("#tip_txt").text(event.description);
		  		if($(this).hasClass("sale-off")){
		  			$("#tip_content").css("top","-76px");
		  			$("#tip_icon").css("top","12px");
		  		}
	    },
	    eventMouseout: function( event, jsEvent, view ) { 
			$("#tip_content").remove();
	    }
	    --%>
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
		  
		   getpriceItemDetail(viewStart);
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

<!-- Page level JS -->
<script type="text/javascript" src="<%=basePath%>assets/js/product_detail.js"></script>

<script type="text/javascript">
var roomModel = '';
var roomtypeList = '';
var roomPriceMap = '';
function addNewRoom(obj){
	if(roomModel==null||roomModel==''){
		roomModel = $("#room").html();
	}
	if(roomModel!=''){
		$("#room").append(roomModel);
		countprice();
	}
	
}

function removeRoom(obj){
	$(obj).parent(".roomChild").remove();
	countprice();
}

function changeRoomType(obj){
	var roomType = $(obj).val();
	var list = roomPriceMap[roomType];
	var html = '';
	var otherHtml = '';
	var k = -1;
	var flag = false;
	for(var i = 0;i<list.length;i++){
		if(list[i].priceGroup=='0'){
			if(k==-1){
				k = i;
			}
			html = html+'<option value="'+i+'">'+list[i].priceItem+'</option>';
		}else{
			otherHtml = otherHtml+'<div class="otherRoomTypePrice_child"><span class="addition_p">'+list[i].priceItem+'</span>&nbsp;x&nbsp;';
			otherHtml = otherHtml+'<select onchange="countprice();" class="select2">';
			var option = '';
			for(var n = 0;n<=list[i].maxCnt;n++){
				option = option+'<option value="'+n+'">'+n+'</option>';
			}
			otherHtml = otherHtml+option+'</select>';
			otherHtml = otherHtml+'<input type="hidden" value="'+i+'" name="index">';
			otherHtml = otherHtml+'<span style="color:#ff0000;float:right;line-height:34px">&nbsp;¥&nbsp;'+list[i].roomPrice +'(含税)</span>'
						+'<p style="font-size:12px;color:#ccc;">'+list[i].description+'</p>'
						+'</div>'+ '<div style="border-bottom:1px solid #e5e5e5;"></div>';
		}
	}
	$(obj).parent().next().find("select").eq(0).html(html);
	$(obj).parent().parent().find(".otherRoomTypePrice").html(otherHtml);
	var numhtml=''
	for(var j=1;j<=list[k].maxCnt;j++){
		numhtml = numhtml+'<option value="'+j+'">'+j+'</option>';
	}
	$(obj).parent().next().find("select").eq(1).html(numhtml);
	var price = list[k].roomPrice;
	$(obj).parent().next().find("span").html("￥"+price+"(含税)");
	$(obj).parent().next().next().html(list[k].description);
	countprice();
}

function changeRoomTypePrice(obj){
	var roomType = $(obj).parent().prev().find("select").val();
	var index = $(obj).val();
	var mapStr = roomPriceMap;
	var list = mapStr[roomType];
	var object = list[index];
	var option = ''
	for(var i=1;i<=object.maxCnt;i++){
		option = option+'<option value="'+i+'">'+i+'</option>';
	}
	var price = object.roomPrice;
	$(obj).next().html(option);
	$(obj).next().next().html("￥"+price+"(含税)");
	$(obj).parent().next().html(object.description);
	countprice();
}


function countprice(){
	var div = $("#room").find(".roomChild");
	var mapStr = roomPriceMap;
	var hotelRouteJson='{';
	var priceItemList='';
	var priceItem='';
	if(div.length==0){
		return;
	}
	for(var i =0;i<div.length;i++){
		var roomType=$(div).eq(i).find(".room-types").find("select").val();
		var list = mapStr[roomType];
		var priceIndex=$(div).eq(i).find(".room_type").find("select").eq(0).val();
		var priceTypeNumber=$(div).eq(i).find(".room_type").find("select").eq(1).val();
		priceItem=priceItem+'{"id":"'+list[priceIndex].id+'","number":"'+priceTypeNumber+'","roomTypeId":"'+roomType+'"},';
		var otherpricediv=$(div).eq(i).find(".otherRoomTypePrice").find(".otherRoomTypePrice_child");
		for(var j=0;j<otherpricediv.length;j++){
			var index = $(otherpricediv).eq(j).find("input[name='index']").val();
			var number = $(otherpricediv).eq(j).find("select").val();
			priceItem=priceItem+'{"id":"'+list[index].id+'","number":"'+number+'","roomTypeId":"'+roomType+'"},';
		}
	}
	priceItem = priceItem.substring(0,priceItem.length-1);
	priceItemList = '['+priceItem+']';
	var startDate = $("#childDate").val();
	var endDate = $("#childDate").val();//$("#endDate").val();
	if(endDate==null||endDate==''){
		endDate=startDate;
	}
	var n = getDateDiff(startDate, endDate);
	if(n<0){
		alert("开始日期不能小于结束日期");
		notAllowAdd();
		return false;
	}else{
		allowAdd();
	}
	hotelRouteJson=hotelRouteJson+'"priceItemList":'+priceItemList+',"taxRate":"'+'${row.tax_rate}'+'","serviceFeeRate":"'+'${row.service_fee_rate}'
					+'","startDate":"'+startDate+'","endDate":"'+endDate+'"}';

					
	$.ajax({    
        type:'post',        
        url:'<%=basePath%>product/checkAddHotelRoute.html',    
        data:{"hotelRouteJson":hotelRouteJson},    
        cache:false,    
        dataType:'json',    
        success:function(data){
        	if(data!=null){
	        	if(data.type=='error'){
	        		alert(data.msg);
	        		notAllowAdd();
	        		return false;
	        	}else{
	        		allowAdd();
	        		var total = data.total;
	        		var taxRateTotal = data.taxRateTotal;
	        		var serviceFeeRateTotal = data.serviceFeeRateTotal;
	        		var roomPrice = (parseFloat(total) - parseFloat(taxRateTotal) - parseFloat(serviceFeeRateTotal)).toFixed(2);
	        		$(".price_list").find(".li_r").eq(0).html('<span class="sm_r">¥</span>'+roomPrice);
	        		$("#taxationPrice").html(taxRateTotal);
	        		$("#servicePrice").html(serviceFeeRateTotal);
	        		$("#total").html(total);
	        	}
        	}else{
        		notAllowAdd();
        	}
        }    
    });				
					
	/* var taxationPrice = (total* parseFloat('${row.tax_rate}')).toFixed(2);
	var servicePrice = (total* parseFloat('${row.service_fee_rate}')).toFixed(2);
	var roomPrice = (total - taxationPrice - servicePrice).toFixed(2);
	$(".price_list").find(".li_r").eq(0).html('<span class="sm_r">¥</span>'+roomPrice);
	$("#taxationPrice").html(taxationPrice);
	$("#servicePrice").html(servicePrice);
	$("#total").html(total); */
}

/* function countprice(){
	var div = $("#room").find(".roomChild");
	var mapStr = roomPriceMap;
	var total = 0;
	for(var i =0;i<div.length;i++){
		var roomType=$(div).eq(i).find(".room-types").find("select").val();
		var list = mapStr[roomType];
		var priceIndex=$(div).eq(i).find(".room_type").find("select").eq(0).val();
		var priceTypeNumber=$(div).eq(i).find(".room_type").find("select").eq(1).val();
		var otherpricediv=$(div).eq(i).find(".otherRoomTypePrice").find(".otherRoomTypePrice_child");
		for(var j=0;j<otherpricediv.length;j++){
			var index = $(otherpricediv).eq(j).find("input[name='index']").val();
			var number = $(otherpricediv).eq(j).find("select").val();
			total = total+number*parseFloat(list[index].roomPrice);
		}
		total = total+priceTypeNumber*parseFloat(list[priceIndex].roomPrice);
	}
	
	
	var taxationPrice = (total* parseFloat('${row.tax_rate}')).toFixed(2);
	var servicePrice = (total* parseFloat('${row.service_fee_rate}')).toFixed(2);
	var roomPrice = (total - taxationPrice - servicePrice).toFixed(2);
	$(".price_list").find(".li_r").eq(0).html('<span class="sm_r">¥</span>'+roomPrice);
	$("#taxationPrice").html(taxationPrice);
	$("#servicePrice").html(servicePrice);
	$("#total").html(total);
} */



routeJson = '${routeJson}';
function add(){
	if(isNull($("#childDate").val())){
		alert("请输入开始时间");
		return false;
	}
	var productEndtime = new Date('${row.enddate }');
	var endtime = productEndtime.format('yyyy-MM-dd');
	var packageBeginDate =$("#childDate").val();
	var n = getDateDiff(packageBeginDate, endtime) ;
	if(n<0){
		alert("产品无效，无法就加入行程单");
		return false;
	}
	
	var startDate = $("#childDate").val();
	var endDate = $("#childDate").val();//$("#endDate").val();
	if(endDate==null||endDate==''){
		alert("请填写预定结束日期");
		return false;
	}
	var dateList = new Array();
	if(endDate==startDate){
		dateList.push(startDate);
	}else{
		dateList = getDateList(dateList,startDate, endDate);
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
	var packageJson = data.package;
	var villaJson = data.villa;
	var hotelJson = data.hotel;
	if(packageJson!='' && packageJson!=null &&packageJson!='undefined'){
		for(var key in packageJson){  
			var staylvl = packageJson[key].staylvl;
			if(staylvl!='99'){
				var bool = window.confirm("当前行程选定的套餐产品已包含住宿，是否继续添加此酒店？");
				if(!bool){
					return false;
				}
				break;
			}
        } 
	}
	if(villaJson!='' && villaJson!=null &&villaJson!='undefined'){
		for(var i = 0;i<dateList.length;i++){
			var json = villaJson[dateList[i]];
			if(json!='' && json!=null &&json!='undefined'){
				var bool = window.confirm("当前行程选定的别墅产品已包含住宿，是否继续添加此酒店？");
				if(!bool){
					return false;
				}
				break;
			}
		}
	}
	if(hotelJson!='' && hotelJson!=null &&hotelJson!='undefined'){
		for(var i = 0;i<dateList.length;i++){
			var json = hotelJson[dateList[i]];
			if(json!='' && json!=null &&json!='undefined'){
				var bool = window.confirm("当前行程选定的别墅产品已包含住宿，是否继续添加此酒店？");
				if(!bool){
					return false;
				}
			}
			break;
		}
	}
		
	buliderObject();
}

function buliderObject(){
	var div = $("#room").find(".roomChild");
	var mapStr = roomPriceMap;
	var roomtypeList = '';
	var roomtype= '{';
	var total=0;
	
	var hotelRouteJson='{';
	var priceItemList='';
	var priceItem='';
	
	var startDate = $("#childDate").val();
	var endDate = $("#childDate").val();//$("#endDate").val();
	
	for(var i =0;i<div.length;i++){
		var roomType=$(div).eq(i).find(".room-types").find("select").val();
		var list = mapStr[roomType];
		var priceIndex=$(div).eq(i).find(".room_type").find("select").eq(0).val();
		var priceTypeNumber=$(div).eq(i).find(".room_type").find("select").eq(1).val();
		var otherpricediv=$(div).eq(i).find(".otherRoomTypePrice").find(".otherRoomTypePrice_child");
		
		var roomTypePriceList="[";
		var roomTypePrice="{"
			
		priceItem=priceItem+'{"id":"'+list[priceIndex].id+'","number":"'+priceTypeNumber+'","roomTypeId":"'+roomType+'"},';
		for(var j=0;j<otherpricediv.length;j++){
			var index = $(otherpricediv).eq(j).find("input[name='index']").val();
			var number = $(otherpricediv).eq(j).find("select").val();
			if(number>0){
				total = total+number*parseFloat(list[index].roomPrice);
				var prepay = list[index].prepay;
				var id = list[index].id;
				if(prepay=='undefined'||prepay==''||prepay==undefined){
					prepay=0;
				}
				roomTypePrice = roomTypePrice+'"'+'roomPrice":'+'"'+list[index].roomPrice+'",'
								+'"'+'id":'+'"'+id+'",'
								+'"'+'prepay":'+'"'+prepay+'",'
								+'"'+'priceGroup":'+'"'+list[index].priceGroup+'",'
								+'"'+'priceItem":'+'"'+list[index].priceItem+'",'
								+'"'+'number":'+'"'+number+'"'+"},{";
				priceItem=priceItem+'{"id":"'+list[index].id+'","number":"'+number+'","roomTypeId":"'+roomType+'"},';
			}
		}
		var prepay = list[priceIndex].prepay;
		var id = list[priceIndex].id;
		if(prepay=='undefined'||prepay==''||prepay==undefined){
			prepay=0;
		}
		roomTypePrice = roomTypePrice+'"'+'roomPrice":'+'"'+list[priceIndex].roomPrice+'",'
						+'"'+'prepay":'+'"'+prepay+'",'
						+'"'+'id":'+'"'+id+'",'
						+'"'+'priceGroup":'+'"'+list[priceIndex].priceGroup+'",'
						+'"'+'priceItem":'+'"'+list[priceIndex].priceItem+'",'
						+'"'+'number":'+'"'+priceTypeNumber+'"'+"},{";					
							
		roomTypePrice = roomTypePrice.substring(0,roomTypePrice.length-2);
		roomTypePriceList = roomTypePriceList+roomTypePrice+"]";
		roomtype =roomtype+ '"roomType":'+'"'+roomType+'",'+'"roomTypePriceList":'+roomTypePriceList+"},{";
		total = total+priceTypeNumber*parseFloat(list[priceIndex].roomPrice);
	}
	priceItem = priceItem.substring(0,priceItem.length-1);
	priceItemList = '['+priceItem+']';
	hotelRouteJson=hotelRouteJson+'"priceItemList":'+priceItemList+',"taxRate":"'+'${row.tax_rate}'+'","serviceFeeRate":"'+'${row.service_fee_rate}'
	+'","startDate":"'+startDate+'","endDate":"'+endDate+'"}';	
	$.ajax({    
        type:'post',        
        url:'<%=basePath%>product/checkAddHotelRoute.html',    
        data:{"hotelRouteJson":hotelRouteJson},    
        cache:false,    
        dataType:'json',    
        success:function(data){
        	if(data.type=='error'){
        		alert(data.msg);
        		notAllowAdd();
        		return false;
        	}else{
        		allowAdd();
        		var dateMap = data.dateMap;
        		var dateJson = eval("("+dateMap+")");
        		
        		roomtype = roomtype.substring(0,roomtype.length-2);
        		roomtypeList = roomtypeList+roomtype;
        		var timestamp = Date.parse(new Date());
        		var dateList = new Array();
        		dateList.push(startDate);
        		if(startDate!=endDate){
	        		dateList = getDateList(dateList,startDate, endDate);
	        		dateList.push(endDate);
        		}
        		var s ='';
        		for(var i=0;i<dateList.length;i++){
        			var roomTypeArray = dateJson[''+dateList[i]+''];
        			var to=0;
        			var ta=0;
        			var se=0;
        			for(var j=0;j<roomTypeArray.length;j++){
        				var priceJson = roomTypeArray[j];
        				var total = priceJson.total;
        				var taxRate = priceJson.taxRate;
        				var serviceFeeRate = priceJson.serviceFeeRate;
        				to = parseFloat(to)+parseFloat(total);
        				ta = parseFloat(ta)+parseFloat(taxRate);
        				se = parseFloat(se)+parseFloat(serviceFeeRate);
        			}
        		s = s+ '{"date":'+'"'+dateList[i]+'",'
        					+'"startDate":'+'"'+dateList[i]+'",'
        					+'"endDate":'+'"'+dateList[i]+'",'
        					+'"leftCountry":'+'"'+'${country.id}'+'",'
        					+'"pid":'+'"'+'${row.pid}'+'",'
        					+'"timestamp":'+'"'+timestamp+'",'
        					+'"time":'+'"23:59",'
        					+'"pname":'+'"'+'${row.pname}'+'",'
        					+'"serviceFeeRate":'+'"'+'${row.service_fee_rate}'+'",'
        					+'"countryName":'+'"'+'${country.cityName }'+'",'
        					+'"cityName":'+'"'+'${city.cityName }'+'",'
        					+'"taxRate":'+'"'+'${row.tax_rate}'+'",'
        					+'"servicePrice":'+'"'+ta+'",'
        					+'"taxPrice":'+'"'+se+'",'
        					+'"totalPrice":'+'"'+to+'",'
        					+'"type":'+'"hotel",'
        					+'"roomtypeList":'+'['+roomtypeList+']},';
        			
        		}
        		
        		s = s.substring(0,s.length-1);
        		var sList = '['+s+']';
        		appendTrafficJson(sList,null,'hotel');
        	}
        }    
    });	
}


function priceItemDetail(data,date){
	$("#childDate").val(date);
	$("#endDate").val('');
	roomtypeList = data.newRows;
	roomPriceMap = data.roomPriceMap;
	if(roomtypeList.length>0){
		//一个div下的所有html
		var roomChildHtml='<div class="roomChild"><img src="<%=basePath%>assets/img/colse.png" onclick="removeRoom(this);" style="position:absolute;top:0;right:0"/>';
		//房型
		var roomTypesHtml='<p class="room-types"><select onchange="changeRoomType(this)" class="select1">';
		var roomTypeOption = '';
		for(var i=0;i<roomtypeList.length;i++){
			var r = roomtypeList[i];
			roomTypeOption = roomTypeOption+'<option value="'+r.roomType +'">'+r.roomTypeName+'</option>';
		}
		roomTypesHtml = roomTypesHtml+roomTypeOption+'</select></p>';
		
		//默认第一个房型的价格项
		//主价格项
		var roomTypeHtml = '<p class="room_type"><select  class="select3"  onchange="changeRoomTypePrice(this)">';
		var defaultRoomType = roomtypeList[0].roomType;
		var roomPriceList = roomPriceMap[''+defaultRoomType+''];
		var defaultPrice='';
		var desc = '';
		var number=0;
		//附加价格项html
		var otherRoomTypePriceHtml_child='';
		//价格项下拉框
		var roomTypeOptionHtml='';
		for(var j=0;j<roomPriceList.length;j++){
			var r = roomPriceList[j];
			if(r.priceGroup=='0'){//主价格项
				roomTypeOptionHtml = roomTypeOptionHtml+'<option value="'+j+'">'+r.priceItem+'</option>';
				if(number==0){
					number = r.maxCnt;
					defaultPrice = r.roomPrice;
					desc = r.description;
				}
			}else{//附加价格项
				var maxCnt = r.maxCnt;
				otherRoomTypePriceHtml_child = otherRoomTypePriceHtml_child+'<div class="otherRoomTypePrice_child">'
												+'<span class="addition_p">'+r.priceItem+'</span>&nbsp;x&nbsp;'
												+'<select onchange="countprice()" class="select2" style="width: 50px;">';
				var option = '';
				for(var n=0;n<=maxCnt;n++){
					option = option+'<option value="'+n+'">'+n+'</option>';							
				}
				otherRoomTypePriceHtml_child = otherRoomTypePriceHtml_child+option+'</select>'
											+'<input type="hidden" value="'+j+'" name="index">'
											+'<span class="" style="color:#ff0000;float:right;line-height:34px">¥ '+r.roomPrice+'(含税)</span>'
											+'<p style="font-size:12px;color:#ccc;">'+r.description+'</p>'
				otherRoomTypePriceHtml_child = otherRoomTypePriceHtml_child+'</div>'+ '<div style="border-bottom:1px solid #e5e5e5;"></div>'
			}
		}
		roomTypeHtml =roomTypeHtml+roomTypeOptionHtml+'</select>&nbsp;x&nbsp;';
		roomTypeHtml = roomTypeHtml+'<select onchange="countprice();" class="select2" >';
		//数量下拉框
		var roomTypeDefaultNumberOptionHtml='';
		for(var k=1;k<=number;k++){
			roomTypeDefaultNumberOptionHtml = roomTypeDefaultNumberOptionHtml+'<option value="'+k+'">'+k+'</option>';
		}
		roomTypeHtml = roomTypeHtml+roomTypeDefaultNumberOptionHtml+'</select>';
		roomTypeHtml = roomTypeHtml+'<span style="color:#ff0000;float:right;line-height:34px">¥'+defaultPrice+'(含税)</span>';
		roomTypeHtml = roomTypeHtml+'<p style="font-size:12px;color:#ccc;">'+desc+'</p>'
		roomTypeHtml = roomTypeHtml+'</p>'+ '<div style="border-bottom:1px solid #e5e5e5;"></div>';
		//附加价格项
		var otherRoomTypePriceHtml = '<div class="otherRoomTypePrice">'+otherRoomTypePriceHtml_child+'</div>';
		
		roomChildHtml = roomChildHtml+roomTypesHtml+roomTypeHtml+otherRoomTypePriceHtml;
		$("#room").html(roomChildHtml);
		roomModel = $("#room").html();
		allowAdd();
		countprice();
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
	
function initPage() {  
    try {  
        $window = $(window);  
        var resize = $window.jqElemResize();  
        $(resize).on("resize", function (size) {  
        	setTopHeight(); 
        	initializeMap()
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
	roomModel = $("#room").html();
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
		if($("#time_price>.price_list").is(":hidden")){
			$("#time_price>.price_list").show(); 
			$("#expandBtn>i").removeClass("fa-caret-down").addClass("fa-caret-up"); 
		}else{
			$("#time_price>.price_list").hide();  
			$("#expandBtn>i").removeClass("fa-caret-up").addClass("fa-caret-down");   
		}
	});

	$(".detail_imgs>img").mouseover(function(){
		var attr = $(this).attr("src");
		var targetid = $(this).attr("targetid");
		if($(this).siblings().hasClass("hover")){
			$(this).siblings().removeClass("hover");
		}
		$("#"+targetid).attr("src",attr);
		$(this).addClass("hover");
	});
	
	//video play
	$(".video_icon").click(function(){
		var v_title = $(this).data('title');
		var v_url = $(this).data('url');
		$("#videoTitle").text(v_title);
		$("#videoContent").empty().append('<object width=660 height=350><param name="movie" value="http://share.vrs.sohu.com/my/v.swf&topBar=1&id=81886735&autoplay=false&from=page"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><param name="wmode" value="Transparent"></param><embed width=660 height=350 wmode="Transparent" allowfullscreen="true" allowscriptaccess="always" quality="high" src="http://share.vrs.sohu.com/my/v.swf&topBar=1&id=81886735&autoplay=false&from=page" type="application/x-shockwave-flash"/></embed></object>');
		$("#videoModal").modal('show');
	});
	

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
	
	//set map
	initializeMap();

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
			data: {'pid':'${pid}','staylvl':'3'},
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
<script type="text/javascript" src="http://maps.google.cn/maps/api/js?sensor=false&language=zh-CN"></script> 

<script type="text/javascript">
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
</script>
</body>
</html>