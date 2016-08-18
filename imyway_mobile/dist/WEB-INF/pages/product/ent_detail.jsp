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
<link href="<%=basePath%>assets/css/ent.css" rel="stylesheet" type="text/css">


</head>
<body>

	<!-- ==center content -->
	<div class="fl center_content">
		<div class="breadcrumbs"><i class="fa fa-chevron-left i_style"></i><a href="<%=basePath%>home.html">首页</a> &nbsp;<span>&gt;</span>&nbsp;&nbsp;<a href="<%=basePath%>product/product_list.html?ptype=4&fromFlag=0">娱乐</a>&nbsp; <span>&gt;</span>&nbsp;&nbsp;${country.cityName }-${city.cityName }</div>
		<div class="p_detail"  style="height: 85px;">
			<div style="padding-top: 22px;font-size: 24px;height: 80px;line-height: 30px;">${row.pname }</div>
		
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
		<div id="myCarousel" class="carousel slide">
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
		
		<a class="fl nav_item active" catid="1">行程说明</a>
		<a class="fl nav_item"  catid="2">价格&条款</a>
		<a class="fl nav_item"  catid="3">评价</a>
		<a class="fl nav_item last_item"  catid="4">注意事项</a>
		
	</div>
	
<!-- ==End sub nav -->
<!-- ==details -->
	<div class="cat"  catid="1">
			${row.pdesc }
		<div class="clr"></div>
		<div class="day1" id="route1">
			<div class="day1-title">
				<span>行程安排</span><p></p>
			</div>
			<c:forEach items="${entRouteDetailInfoList }" var="entRouteDetailInfo">
				<div class="day1-wrapper">
					<div class="day1-tags">
						<div class="day1-tags-wrapper magtop">
							<div class="day1-tags-tag1">
								<span>${entRouteDetailInfo.starttime }</span>
							</div>
							<div style="display: inline-block;">${entRouteDetailInfo.title }</div>
						</div>
					</div>
				</div>
			</c:forEach>
			<br>
		</div>
		</div>
	
		<div class="price cat" catid="2">
			<div class="price-title">
				<p>价格&条款</p>
			</div>
			<div class="price-content">
			${row.price_desc }	  
				<!-- <div class="price-content1">
					<p>时段价格差说明</p>
				</div>
				<div class="price-content2">
					<span>标准价格</span><i>07:00-19:00</i>
				</div>
				<div class="price-content3">
					<span>额外加价</span><i>19:00-07:00</i>
				</div>
				<div class="price-info1">
					<span>价格包含：</span>
					<p>1、全程国际机票费用、燃油附加税；</p>
					<p>2、全程4星酒店双标住宿；</p>	
					<p>3、全程旅游巴士(含保险)；</p>	
					<p>4、全程中文导游；</p>	
					<p>5、酒店内西式自助早餐，行程中所列午晚正餐(中式5菜1汤+茶水+水果)，共计8餐；（若退餐按照8英镑/人/顿）ADS团队签证费用；</p>
					<p>6、境外旅游人身伤害意外险；</p>	
					<p>7、全程司机，导游服务费；爱丁堡城堡，温莎古堡，霍华德城堡，哈利波特；本公司已为参团旅客购买价值30万之人身意外保险。</p>	
				</div>
				<div class="price-info2">
					<span>价格不含：</span>
					<p>1、个人护照办理费用；</p>
					<p>2、航空保险费、行李保险费、超重行李费；</p>
					<p>3、酒店客房、行李员、餐馆等其它自愿支付小费；</p>
					<p>4、各项私人额外费用如：洗衣、长途电话、酒水等消费；</p>
					<p>5、行程安排外之任何观光项目及自费活动(包括这些活动期间的用车、导游和司机服务等费用)；</p>
					<p>6、单人间房差(不保证夫妻、成年子女与父母同房，否则需补单房4星 5200 元 /人 / 全程 ) </p>
					<p>7、因私人原因、交通延阻、罢工、台风或其它不可抗力因素而产生的额外费用。</p>
				</div>
				<div class="price-info3">
					<span>退赔标准：</span>
					<p>1、如因仙贝旅行无法提供服务而取消，可全额退款，不收取任何费用；</p>
					<p>2、如因客人个人原因取消服务，出行日期前15天收取10%手续费，出行日期前7-14天收取50%违约金，出行日期前7天之内不得退改；</p>
				</div> -->
			</div>
		</div>
		<div class="evaluation cat" catid="3">
			<div id="p_discuss" catid="4" class="cat">
				<div class="evaluation-title">
					<p>评价</p>
				</div>
				<div class="p_content" >
					 <div id="evaluationList" class="discuss_content">
						<c:forEach items="${evaluationList }" var="evaluation">
							<div class="d_detail">
								<div class="d_img fl"><img alt=""  width="20px;" height="20px;"
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
		</div>
		<!-- ==end discuss  -->
		<div class="attention cat" catid="4">
			<div class="attention-title">
				<p>注意事项</p>
			</div>
			<div class="attention-content">
				${row.pnote }
				<!-- <p>1、如因仙贝旅行无法提供服务而取消，可全额退款，不收取任何费用；</p>
				<p>2、如因客人个人原因取消服务，出行日期前15天收取10%手续费，出行日期前7-14天收取50%违约金，出行日期前7天之内不得退改；</p> -->
			</div>
		</div>
		</div>
<!--=== End center content ===-->
<!-- ==right content -->
<div class="right_content fr">
	<div class="r_top">
		<p><span class="account_icon r"></span><span class="account_price r"><fmt:formatNumber value="${row.start_price }" type="currency" pattern="¥"/>&nbsp;</span><span class="account_info">&nbsp;元起</span></p>
		<p class="account_time">价格有效期:<fmt:formatDate value="${row.startdate }" type="both" pattern="yyyy年MM月dd日"/>-<fmt:formatDate value="${row.enddate }" type="both" pattern="yyyy年MM月dd日"/></p>
	</div>
	<div class="r_middle" style="border: 0px;padding-bottom: 0px;">
		<div class="room_info">
		<%--
			<p style="border-bottom:1px solid #e5e5e5">
				<span class="ri">开始时间：</span>
				<span><input class="ri ri-btn sdate ndate" onclick="showPriceCalendar(this);" id="childDate" value="<fmt:formatDate value="<%=new Date() %>" type="both" pattern="yyyy-MM-dd"/>" type="text" readonly="readonly"/></span>
			</p>
		 --%>
			
			<div style="border-bottom:1px solid #e5e5e5; padding: 8px 0 0 20px;">
				<span class="ri">开始时间：</span>
				<%--
				<span><input class="ri ri-btn sdate ndate" onclick="showPriceCalendar(this);" id="packageBeginDate" value="<fmt:formatDate value="${date }" type="both" pattern="yyyy-MM-dd"/>" type="text" readonly="readonly"/></span>
				 --%>
				<div class="input-append date " onclick="showPriceCalendar(this);" style="cursor: pointer;height: 42px;width:140px;display: inline-block;">
						<input type="text" id="childDate" class="dateinput sdate ndate" readonly="readonly" style="padding-left:8px;text-align: left; width: 120px;border-color: #e5e5e5;height: 32px;line-height: 32px; border-right: 1px solid #e5e5e5;  " value="<fmt:formatDate value="<%=new Date() %>" type="both" pattern="yyyy-MM-dd"/>" >
						<span class="add-on date_picker_btn rel" style="height: 12px;border: 0px;width: 15px; left:-28px;top:1px;margin-bottom: 18px;" ><i class="fa fa-calendar"></i></span>
				</div>
			</div>
			
			
			<%-- 
			<p><span class="ri">开始时间</span></p>
			<p class="room_date">
			<span class="">
		     <input class="ri ri-btn sdate ndate" id="childDate" onclick="showPriceCalendar(this);" value="<fmt:formatDate value="<%=new Date() %>" type="date" pattern="yyyy-MM-dd"/>" type="text" readonly="readonly"/>
			 </span>
			</p>
			 --%>
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
	            url:'<%=basePath%>product/entPriceCal.html',
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
			   getpriceItemDetail(viewStart.substring(0,10));
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
				            url:'<%=basePath%>product/entPriceCal.html',
				            dataType: 'json',
				            data: {"date":start,"pid":'${pid}'},
				            success:function(data) {
				                var events =[];
				               for(var i=0;i<data.length;i++){
				                   events.push({
				                        title:'￥'+data[i].title,
				                        start:data[i].start 
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
					   getpriceItemDetail(viewStart);
					   $("#priceCalendar").hide();
				   },
				   prevClick: function(calEvent, jsEvent, view) {
				        alert(calEvent.title);
				    }
				});
			}
			</script>
			--%>
			
			<div id="ent_detail">
				<c:if test="${!empty rows }">
					<div class="ent_detail_child">
						<select class="select1"  onchange="changeEnt(this);">
							<c:forEach items="${rows }" var="r" varStatus="i">
								<option value="${i.index }">${r.priceItem }</option>
							</c:forEach>
						</select>
						&nbsp;x&nbsp;
						<select class="select2" onchange="countprice()">
							<c:forEach begin="1" end="${rows[0].maxCnt }" var="v">
								<option value="${v }">${v }</option>
							</c:forEach>
						</select>
						<span class="ri ri-btn" style="color:#ff0000;float:right;line-height:34px"><fmt:formatNumber value="${rows[0].price}" type="currency" pattern="¥"/>(含税)</span>
					</div>
				</c:if>
			</div>
			<div class="clr"></div>
		</div>
		<p id="addNewEnt" style="margin:20px;"><a href="javascript:void(0)" style="color: #69a8ff;font-size: 14px;" onclick="addNewEnt(this)">+添加其他娱乐</a></p>
	</div>
	<div class="r_down">
		<div class="price_list">
			<p class="li"><span class="li_l">娱乐费</span><span class="li_r"><span class="sm_r">¥</span>0</span></p>
			<p class="li"><span class="li_l">税费</span><span class="li_r"><span class="sm_r">¥</span> <span id="taxationPrice">0</span></span></p>
			<p class="li"><span class="li_l">服务费</span><span class="li_r"><span class="sm_r">¥</span> <span id="servicePrice">0</span></span></p>
		</div>
		<div class="price_total">
			<p class="li"><span class="li_l">总价</span><span class="li_r"><span class="sm_r">¥</span> <span id="total">0</span></span></p>
		</div>
		<p class="p_info">娱乐预订规则：按每人/项目 计费</p>
		<p class="p_btn"><a class="btn btn-info addroute" id="setCtripBtn"  disabled="false">放入行程单</a></p>
	</div>
</div>
<!--=== End right content ===-->
<div class="clr"></div>

<!-- Page level JS -->
<script type="text/javascript" src="<%=basePath%>assets/js/product_detail.js"></script>
<script type="text/javascript">

var entModel = '';
var rowsStr='';
function addNewEnt(obj){
	if(entModel==null||entModel==''){
		entModel = $("#ent_detail").html();
	}
	if(entModel!=''){
		$("#ent_detail").append(entModel);
		countprice();
	}
}



function changeEnt(obj){
	var index = $(obj).val();
	var row = rowsStr[index];
	var price = row.price;
	var maxCnt = row.maxCnt;
	var option = '';
	for(var i=1;i<=maxCnt;i++){
		option = option +'<option value="'+i+'">'+i+'</option>';
	}
	$(obj).next().html(option);
	$(obj).next().next().html("￥"+price+"(含税)");
	$(obj).next().next().next().html(row.description);
	countprice();
}

function countprice(){
	var ent_detail = $("#ent_detail").find(".ent_detail_child");
	var total = 0;
	for(var i = 0;i<ent_detail.length;i++){
		var index = $(ent_detail).eq(i).find("select").eq(0).val();
		var number = $(ent_detail).eq(i).find("select").eq(1).val();
		var price = rowsStr[index].price;
		total = total+number*parseFloat(price).toFixed(2);
	}
	
	
	var taxationPrice = (total* parseFloat('${row.tax_rate}')).toFixed(2);
	var servicePrice = (total* parseFloat('${row.service_fee_rate}')).toFixed(2);
	
	$("#taxationPrice").html(taxationPrice);
	$("#servicePrice").html(servicePrice);
	$("#total").html(total);
	$(".price_list").find(".li_r").eq(0).html('<span class="sm_r">¥</span>'+(total-taxationPrice-servicePrice).toFixed(2));
}

function add(){
	var productEndtime = new Date('${row.enddate }');
	var endtime = productEndtime.format('yyyy-MM-dd');
	var starttime = $("#childDate").val().trim()
	var n = getDateDiff(starttime, endtime) ;
	if(n<0){
		alert("产品无效，无法就加入行程单");
		return false;
	}
	
	buliderObject();	
}

function buliderObject(){
	var ent_detail = $("#ent_detail").find(".ent_detail_child");
	
	var total = 0;	
	var entPrice="{";
	for(var i = 0;i<ent_detail.length;i++){
		var index = $(ent_detail).eq(i).find("select").eq(0).val();
		var number = $(ent_detail).eq(i).find("select").eq(1).val();
		var price = rowsStr[index].price;
		var prepay = rowsStr[index].prepay;
		var priceItem = rowsStr[index].priceItem;
		var id = rowsStr[index].id;
		total = total+number*parseFloat(price).toFixed(2);
		
		entPrice = entPrice+'"price":'+'"'+price+'",'+'"prepay":'+'"'+prepay+'",'+'"id":'+'"'+id+'",'
		+'"number":'+'"'+number+'",'+'"priceItem":'+'"'+priceItem+'"},{';
	}
	entPrice = entPrice.substring(0,entPrice.length-2);
	
	
	var taxationPrice = (total* parseFloat('${row.tax_rate}')).toFixed(3);
	var servicePrice = (total* parseFloat('${row.service_fee_rate}')).toFixed(3);
	var timestamp = Date.parse(new Date());
	var date = $("#childDate").val().trim();
	
	var enddate = new Date('${row.enddate}');
	var nowDate = new Date(date);
	if(enddate<nowDate){
		alert("在日期："+date+",该娱乐无效 ");
		return false;
	}
	
	var s = '{"date":'+'"'+date+'",'
				+'"pid":'+'"'+'${row.pid}'+'",'
				+'"leftCountry":'+'"'+'${country.id}'+'",'
				+'"timestamp":'+'"'+timestamp+'",'
				+'"pname":'+'"'+'${row.pname}'+'",'
				+'"startDate":'+'"'+date+'",'
				+'"endDate":'+'"'+date+'",'
				+'"serviceFeeRate":'+'"'+'${row.service_fee_rate}'+'",'
				+'"countryName":'+'"'+'${country.cityName }'+'",'
				+'"cityName":'+'"'+'${city.cityName }'+'",'
				+'"taxRate":'+'"'+'${row.tax_rate}'+'",'
				+'"servicePrice":'+'"'+servicePrice+'",'
				+'"taxPrice":'+'"'+taxationPrice+'",'
				+'"totalPrice":'+'"'+total+'",'
				+'"type":'+'"ent",'
				+'"entPriceList":'+'['+entPrice+']}';
	appendTrafficJson(s,null,'ent');
}

function removeent(obj){
	$(obj).parent(".ent_detail_child").remove();
	countprice();
}
function priceItemDetail(data,date){
	$("#childDate").val(date);
	
	if(data.length>0){
		var ent_detail_child = '<div class="ent_detail_child">'
								+'<img src="<%=basePath%>assets/img/colse.png" onclick="removeent(this);" style="position:absolute;top:0;right:0"/>'
								 +'<select class="select1"  onchange="changeEnt(this);">';
		var priceItem_option = '';
		for(var i=0;i<data.length;i++){
			priceItem_option = priceItem_option + '<option value="'+i+'">'+data[i].priceItem+'</option>'
		}
		ent_detail_child = ent_detail_child+priceItem_option+'</select>&nbsp;x&nbsp;'
						+'<select class="select2" onchange="countprice()">';
						
		var number_option = '';
		for(var i=1;i<=data[0].maxCnt ;i++){
			number_option = number_option + '<option value="'+i+'">'+i+'</option>'
		}
		ent_detail_child = ent_detail_child+number_option+'</select>'
							+'<span class="ri ri-btn" style="color:#ff0000;float:right;line-height:34px">¥'+data[0].price+'(含税)</span>'
							+'<p style="font-size:12px;color:#ccc;padding:0;height:18px;">'+data[0].description+'</p>'
							+'<div style="border-bottom:1px solid #e5e5e5;"></div>'
							+'</div>';
							
		$("#ent_detail").html(ent_detail_child);
		
		entModel=ent_detail_child;
		rowsStr = data;
		allowAdd();
	}else{
		notAllowAdd()
	}
	countprice();
	
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
	entModel = $("#ent_detail").html();
	countprice();
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
			data: {'pid':'${pid}'},
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