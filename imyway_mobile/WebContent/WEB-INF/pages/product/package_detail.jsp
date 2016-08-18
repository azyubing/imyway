<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link href="<%=basePath%>assets/css/package.css" rel="stylesheet" type="text/css">
<style type="text/css">
*{margin:0;padding:0;}
	a img{border:none;}
	.friend-Link{position:relative;margin:0px auto 17px auto;left: -30px;}
	.left-arrow,.fl-pic,.right-arrow{float:left;display:inline;margin:0;}
	.fl-pic{overflow:hidden;width:525px;height:40px;white-space:nowrap;}
	.fl-pic ul{width:3500px;}
	.fl-pic ul li{float:left;display:inline;;width:40px;height:40px;margin-right: 20px;}
	.left-arrow a,.right-arrow a{width:32px;height:54px;display:block;text-indent:-9999px;}
</style>

</head>
<body>
	<!-- ==center content -->
	<div class="fl center_content">
<%-- 		<input type="hidden" id="countryDetail" value="${row.country }"  />
		<input type="hidden" id="cityDetail" value="${row.city }"  /> --%>
		<div class="breadcrumbs">
			<i class="fa fa-chevron-left i_style"></i>
			<a href="<%=basePath%>home.html">首页</a> &nbsp;<span>&gt;</span>&nbsp;&nbsp;
			<a href="<%=basePath%>product/product_list.html?ptype=0&fromFlag=0">套餐</a>&nbsp; <span>&gt;</span>&nbsp;&nbsp;${country.cityName }-${city.cityName }
		</div>
		<div class="p_detail" style="height: 85px;">
			<div class="fl" style="padding-top: 22px;font-size: 24px;height: 80px;line-height: 30px;">${row.pname}</div>
			
			<div class="clr"></div>
		</div>
		<div class="p_tags">
			<div class="fl pl_20">
				<c:forEach items="${fn:split(row.tags,'|')}" var="val" >
					<a  class="btn btn-sm btn-success tag-btn" style="cursor: default;">${val}</a>
				</c:forEach>
			</div>
			<div class="fr p_0 tag_btn_group" >
				<!-- <a href="javascript:void(0)" class="btn btn-sm btn-info addroute" id="setBtn"  disabled="false">放入行程单</a> -->
				<a href="javascript:void(0)" class="tag-item" id="inCollection"><img src="<%=basePath%>assets/img/hotel/star.png"></a>
				<%-- <a href="javascript:void(0)" class="tag-item"><img src="<%=basePath%>assets/img/hotel/chart.png"></a>
				<a href="javascript:void(0)" class="tag-item"><img src="<%=basePath%>assets/img/hotel/link.png"></a> --%>
			</div>
		</div>
		<div class="clr"></div>
		<!-- ==banner -->
		<c:set value="${ fn:split(row.size_img1, ',') }" var="images" />
		<div id="myCarousel" class="carousel slide">
		<!-- 轮播（Carousel）指标 -->
			<ol class="my-indicators carousel-indicators">
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
	<div class="sub_nav rel " >
		<a class="fl nav_item active" catid="1">行程说明</a>
		<a class="fl nav_item"  catid="2">价格&条款</a>
		<a class="fl nav_item"  catid="3">评价</a>
		<a class="fl nav_item last_item"  catid="4">注意事项</a>
		
	</div>
	<div class="clr"></div> 
<!-- ==End sub nav -->
	<div class="cat" catid="1">
<!-- ==details -->
		<div class="trip-days rel">
				<div id="routDaysCarousel" class="carousel slide" style="height: 40px;display:none;">
				     <div class="carousel-inner" id="innerDivs" style="top:-60px;">  
				      	<div class="item active" style="white-space:nowrap; overflow: hidden;height: 40px;">
				      		<c:forEach items="${routeDetailInfoMap }" var="map" varStatus="status">
				      		<a href="javascript:void(0)" onclick="setDayTop(this);" dayid="${map.key}"
								>第${map.key }天</a>
							</c:forEach>
						</div>
						<div class="item" style="white-space:nowrap; overflow: hidden;height: 40px;">
							<c:set var="maxIdx" value="${fn:length(routeDetailInfoMap)}"/>
				      		<c:forEach items="${routeDetailInfoMap }" var="map" varStatus="status">
				      		<a href="javascript:void(0)" onclick="setDayTop(this);" dayid="${maxIdx}" style="float: right;"
							>第${maxIdx}天</a>
							<c:set var="maxIdx" value="${maxIdx - 1}"/>
							</c:forEach>
						</div>
				   	</div>		   
				   <!-- 轮播（Carousel）导航 -->	
				   <a class="carousel-control left" href="#routDaysCarousel"  style="margin-left: -30px;filter:none; background-image:none;text-shadow:none;width: 40px;"
				     data-slide="prev"><span class="left-arrow" style="width: 40px;height: 40px;font-size:120%;color:#666;line-height:40px;
						cursor: pointer;text-align: center;">&lt;</span></a>
				   <a class="carousel-control right" href="#routDaysCarousel" style="margin-left: -30px;margin-right: 0px;filter:none; background-image:none;text-shadow:none;width: 40px;"
				      data-slide="next"><span class="left-arrow" style="width: 40px;height: 40px;font-size:120%;color:#666;line-height:40px;
						cursor: pointer;text-align: center;float:right;">&gt;</span></a>
				</div>
				
			<script type="text/javascript">
				$(function(){
					$('#routDaysCarousel').carousel({
						  interval: false,
						  wrap: false
					})
				});
			
				var UA = navigator.userAgent.toLowerCase();     
				if(UA.indexOf("chrome")>0){
					if(parseInt(UA.match(/chrome\/([\d.]+)/)[1]) <= 35){
						$("#innerDivs").css("top","0px");
					}
				}
			</script>
				
			
				<div style="position:absolute;white-space:nowrap;" id="noRoutDaysCarousel">
				<c:forEach items="${routeDetailInfoMap }" var="map">
						<a href="javascript:void(0)" onclick="setDayTop(this);" dayid="${map.key}"
							<c:if test="${map.key==1 }">
							class="active"
							</c:if>
						>第${map.key }天</a>
				</c:forEach>
				<%-- <a href="#route1" class="active">第一天</a>
				<a href="#route2">第二天</a>
				<a href="#route3" catid="13">第三天</a>
				<a href="#route4" catid="14">第四天</a>
				<a href="#route5" catid="15">第五天</a>
				<a href="#route6" catid="16">第六天</a>
				<a href="#route7" catid="17">第七天</a>
				<a href="#route8" catid="18">第八天</a>
				<a href="#route8" catid="18">第九天</a> --%>
				</div>
		</div>
		<div class="trip-info">
			${row.pdesc }
		</div>
		<c:forEach items="${routeDayInfoList }" var="routeDayInfo">
			<c:forEach items="${routeDetailInfoMap }" var="map">
				<c:if test="${routeDayInfo.pday==map.key }"> 
					<div <c:if test="${map.key == 1}">class="day1"</c:if> <c:if test="${map.key > 1}">class="day2"</c:if> id="route${map.key }">
						<div class="day1-title routeDay"  dayid="${map.key}" >
							<span>第${map.key }天</span><p>${routeDayInfo.mapAddress }</p>
						</div>
						<c:forEach items="${map.rows_ }" var="routeDetailInfo">
							<div class="day1-wrapper">
								<div class="day1-tags">
									<div class="day1-tags-wrapper magtop">
										<div class="day1-tags-tag${routeDetailInfo.itype+1 }">
											<span>${routeDetailInfo.starttime }</span>
										</div>
										<p>${routeDetailInfo.title}</p>
									</div>
								</div>
							</div>
						</c:forEach>
						<div class="day1-content">
							<p>${routeDayInfo.description }</p>
						</div>
						<c:if test="${not empty routeDayInfo.img1}">
						<c:set value="${fn:split(routeDayInfo.img1,',') }" var="str1" />
						<c:forEach items="${str1 }" var="img" varStatus="i">
							<div class="day1-img1">
							<img src=${img } alt="">
							</div>
						</c:forEach>
						</c:if>
						<%-- <div class="day1-img2">
							<img src="<%=basePath%>assets/img/package/21-.png" alt="">
						</div> --%>
					</div>
			
				</c:if>
			</c:forEach>
		
		</c:forEach>
		<%-- 
		<div class="day1" id="route1">
			<div class="day1-title">
				<span>第一天</span><p>上海-伦敦</p>
			</div>
			<div class="day1-wrapper">
				<div class="day1-tags">
					<div class="day1-tags-wrapper magtop">
						<div class="day1-tags-tag1">
							<span>24:30</span>
						</div>
						<p>机场接机</p>
					</div>
				</div>
			</div>
			<div class="day1-wrapper">
				<div class="day1-tags">
					<div class="day1-tags-wrapper">
						<div class="day1-tags-tag2">
							<span>24:30</span>
						</div>
						<p>海洋公园浮潜</p>
					</div>
				</div>
			</div>	
			<div class="day1-wrapper">
				<div class="day1-tags">
					<div class="day1-tags-wrapper">
						<div class="day1-tags-tag3">
							<span>24:30</span>
						</div>
						<p>起点：卡塔海滩酒店  终点：卡塔海滩</p>
					</div>
				</div>
			</div>	
			<div class="day1-wrapper">
				<div class="day1-tags">
					<div class="day1-tags-wrapper">
						<div class="day1-tags-tag4">
							<span>24:30</span>
						</div>
						<p>拉古娜酒店 高级房</p>
					</div>
				</div>
			</div>
			<div class="day1-content">
				<p>按照指定时间于机场集合，在导游的带领下，办理好登记手续，我们满怀着快乐和期待，搭乘豪华客机前往欧洲。抵达后城市观光：游览外观大笨钟（伦敦的标志建筑，钟楼高79米）、唐宁街10号（英国的首相府）、国会大厦（依泰晤士河而建，是英国的政治中心）、伦敦塔桥（泰晤士河上的哥特式吊桥，两座高塔连着一座可以开合大桥，是伦敦的标志性建筑），白金汉宫（这里是英国王权的象征，宫殿里流淌着绵长的历史，见证着“日不落”的“升起”与“落下”）。入住酒店休息，调整时差。如果此天伦敦市区堵车改为自由活动那天上午游览。</p>
			</div>
			<div class="day1-img1">
				<img src="<%=basePath%>assets/img/package/14-.png" alt=""> 
			</div>
			<div class="day1-img2">
				<img src="<%=basePath%>assets/img/package/21-.png" alt="">
			</div>
		</div>
		<div class="day2" id="route2">
			<div class="day2-title">
				<span>第二天</span><p>伦敦-剑桥-约克-利兹</p>
			</div>
			<div class="day2-wrapper">
				<div class="day2-tags">
					<div class="day2-tags-wrapper magtop">
						<div class="day2-tags-tag1">
							<span>24:30</span>
						</div>
						<p>机场接机</p>
					</div>
				</div>
			</div>
			<div class="day2-wrapper">
				<div class="day2-tags">
					<div class="day2-tags-wrapper">
						<div class="day2-tags-tag2">
							<span>24:30</span>
						</div>
						<p>海洋公园浮潜</p>
					</div>
				</div>
			</div>	
			<div class="day2-content">
				<p>早餐后，我们驱车前往剑桥镇，参观剑桥大学（University of Cambridge）（约2小时），体验这座世界知名大学圣名：成立于1209年，最早是由一批为躲避殴斗而从牛津大学（University of Oxford）逃离出来的老师建立的，亨利三世国王在1231年授予剑桥教学垄断权。后前往观赏剑桥镇的“剑河”(RiverCam 又译“康河”) ，中国著名诗人徐志摩的“再别康桥”中所指的“康桥”便是这里。剑河是一条南北走向、曲折前行的小河，剑河两岸风景秀丽，芳草青青，河上架设着许多设计精巧，造型美观的桥梁，其中以数学桥、格蕾桥和叹息桥最为著名，剑桥之名由此而来。剑桥大学本身没有一个指定的校园，没有围墙，也没有校牌。绝大多数的学院、研究所、图书馆和实验室都建在剑桥镇的剑河两岸，以及镇内的不同地点。剑河岸边从南至北的学院依次是达尔文学院，王后学院，国王学院，卡莱尔学院，三一学堂，三一学院，冈维尔与凯斯学院，圣约翰学院和麦格达伦学院。而后,我们会依次外观浏览王后学院、国王学院、圣三一学院、圣约翰学院（均不含学院门票）。</p>
			</div>
			<div class="day2-img1">
				<img src="<%=basePath%>assets/img/package/13-.png" alt=""> 
			</div>
		</div>
		<div class="day3" id="route3">
			<div class="day3-title">
				<span>第三天</span><p>利兹-爱丁堡-格拉斯哥</p>
			</div>
			<div class="day3-wrapper">
				<div class="day3-tags">
					<div class="day3-tags-wrapper magtop">
						<div class="day3-tags-tag1">
							<span>24:30</span>
						</div>
						<p>机场接机</p>
					</div>
				</div>
			</div>
			<div class="day3-wrapper">
				<div class="day3-tags">
					<div class="day3-tags-wrapper">
						<div class="day3-tags-tag2">
							<span>24:30</span>
						</div>
						<p>海洋公园浮潜</p>
					</div>
				</div>
			</div>	
			<div class="day3-content">
				<p>早餐后，乘车前往苏格兰首府爱丁堡，这里依山傍水，风光绮丽，气候湿润温和，市内鲜花盛开，古代宫殿、教堂和城堡点缀其间，文化遗产丰富，是英国最美丽的城市之一，素有“北方雅典”之称，以及极具民族特色的苏格兰格裙，都散发着这座古城独特的魅力，王子大道，市政厅，入内参观★爱丁堡古堡（约120分钟），爱丁古堡位于旧城区，历经千年，目睹了苏格兰的历史的风风雨雨，游览皇家公园，苏格兰人纪念碑，之后前往格拉斯哥。</p>
			</div>
			<div class="day3-img1">
				<img src="<%=basePath%>assets/img/package/12-.png" alt=""> 
			</div>
		</div>
		<div class="day4" id="route4">
			<div class="day4-title">
				<span>第四天</span><p>格拉斯哥-湖区-曼彻斯特</p>
			</div>
			<div class="day4-wrapper">
				<div class="day4-tags">
					<div class="day4-tags-wrapper magtop">
						<div class="day4-tags-tag1">
							<span>24:30</span>
						</div>
						<p>机场接机</p>
					</div>
				</div>
			</div>
			<div class="day4-wrapper">
				<div class="day4-tags">
					<div class="day4-tags-wrapper">
						<div class="day4-tags-tag2">
							<span>24:30</span>
						</div>
						<p>海洋公园浮潜</p>
					</div>
				</div>
			</div>	
			<div class="day4-content">
				<p>早餐后前往参观温德米尔湖（约30分钟），探寻传说中“水怪”的身影。温德米尔湖为英格兰最大的湖，形成于上一次冰期末，位于穿越昆布连山脉的南北走向的一个冰川谷中。该湖形状狭长，最深处在北端。除受四周高地的雨雪滋润，温德米尔湖亦接收来自附近其他湖泊的水源，如格拉斯米尔湖。湖水则自利文河流出。湖区位于英格兰西北海岸，靠近苏格兰边界方圆2300平方公里，1951年被划归为国家公园，是英格兰和威尔士的十一个国家公园中最大的一个。再来前往曼彻斯特（市区观光约1小时）--英国第二繁华城市， 曾经是工业革命发源地，二百年后又因为足球文化享誉全球。因为拥有红色的曼联与蓝色的曼城，周末的曼彻斯特永远是一半海水，一半火焰外观老特拉福德球场--老特拉福德是最受欢迎的英超球队曼彻斯特联队的主场，是世界最著名的足球场之一。</p>
			</div>
			<div class="day4-img1">
				<img src="<%=basePath%>assets/img/package/11-.png" alt=""> 
			</div>
		</div> --%>
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
		</div>
		<!-- ==end discuss  -->
		<div class="attention cat" catid="4">
			<div class="attention-title">
				<p>注意事项</p>
			</div>
			
			<div class="attention-content">
				${row.pnote }
			</div>
		</div>
		</div>
<!--=== End center content ===-->
<!-- ==right content -->
<div class="right_content fr" id="right_content">
	<div class="r_top">
		<p><span class="account_icon r">&nbsp;</span><span class="account_price r"><fmt:formatNumber value="${row.start_price }" type="currency" pattern="¥"/>&nbsp;</span><span class="account_info">&nbsp;元起</span></p>
		<p class="account_time">价格有效期:<fmt:formatDate value="${row.startdate }" type="both" pattern="yyyy年MM月dd日"/>-<fmt:formatDate value="${row.enddate }" type="both" pattern="yyyy年MM月dd日"/></p>
	</div>
	<div class="r_middle">
		<div class="package_info">
			<div style="border-bottom:1px solid #e5e5e5; padding: 8px 0 0 20px;">
				<span class="ri">开始时间（入住）：</span>
				<%--
				<span><input class="ri ri-btn sdate ndate" onclick="showPriceCalendar(this);" id="packageBeginDate" value="<fmt:formatDate value="${date }" type="both" pattern="yyyy-MM-dd"/>" type="text" readonly="readonly"/></span>
				 --%>
				<div class="input-append date " onclick="showPriceCalendar(this);" style="cursor: pointer;height: 42px;width:140px;display: inline-block;">
						<input type="text" id="packageBeginDate" class="dateinput sdate ndate" readonly="readonly" style="padding-left:8px;text-align: left; width: 120px;border-color: #e5e5e5;height: 32px;line-height: 32px; " value="<fmt:formatDate value="${date }" type="both" pattern="yyyy-MM-dd"/>" >
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
	            url:'<%=basePath%>product/packagePriceCal.html',
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
	    	 var viewStart = $.fullCalendar.formatDate(view.start, "yyyy-MM-dd");
		    	$.ajax({
		            url:'<%=basePath%>product/packagePriceCal.html',
		            dataType: 'json',
		            data: {"date":viewStart,"pid":'${pid}'},
		            success:function(data) {
		                var events =[];
		               for(var i=0;i<data.length;i++){
		                   events.push({
		                        title:'￥'+data[i].title,
		                        start:data[i].start 
		                    });
		               }
		               $('#'+eid).fullCalendar('updateEvent', events);
		            }
		        }); 
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
				            url:'<%=basePath%>product/packagePriceCal.html',
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
				    	 var viewStart = $.fullCalendar.formatDate(view.start, "yyyy-MM-dd");
				    	$.ajax({
				            url:'<%=basePath%>product/packagePriceCal.html',
				            dataType: 'json',
				            data: {"date":viewStart,"pid":'${pid}'},
				            success:function(data) {
				                var events =[];
				               for(var i=0;i<data.length;i++){
				                   events.push({
				                        title:'￥'+data[i].title,
				                        start:data[i].start 
				                    });
				               }
				               $("#priceCalendar").fullCalendar('updateEvent', events);
				            }
				        }); 
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
		</div>	
			<div id="package_type" >
				<c:if test="${mainRows!=null && fn:length(mainRows)!=0 }">
					<div class="package_type_child">
						<div class="main">
							<select class="ri ri-btn select1" onchange="changePackage(this);">
								<c:forEach items="${mainRows }" var="r" varStatus="i">
									<option value="${i.index }">${r.priceItem }</option>
								</c:forEach>
							</select>
							<!-- &nbsp;x&nbsp; -->
							<div  style="padding-left:10px;padding-right:10px">
								<span>dexdx</span>
							</div>
							
							<select class="ri ri-btn select2" style="width: 50px;" onchange="countprice()">
								<c:forEach begin="1" end="${mainRows[0].maxCnt }" var="v">
									<option value="${v }">${v }</option>
								</c:forEach>
							</select>
							<span class="ri ri-btn" style="width: 100px;"><fmt:formatNumber value="${mainRows[0].price}" type="currency"  pattern="¥"/>(含税)</span>
						</div>
						
						<div class="additional">
							<c:forEach items="${additionalRows }" var="r">
								<div class="child">
									<span class="ri ri-btn addition_p">${r.priceItem }</span>&nbsp;x&nbsp;
									<select class="ri ri-btn select2" style="width: 50px;" onchange="countprice()">
										<c:forEach begin="0" end="${r.maxCnt }" var="v">
											<option value="${v }">${v }</option>
										</c:forEach>
									</select>
									<span class="ri ri-btn" style="width: 70px;"><fmt:formatNumber value="${r.price}" type="currency" pattern="¥"/>(含税)</span>
									<br>
								</div>
							</c:forEach>
						</div>
					</div>
				</c:if>
			</div>
				
			
			<!-- <span class="ri ri-btn">
				<span>豪华套餐</span><a href="javascript:void(0)"><i class="fa fa-caret-down"></i></a>
			</span>&nbsp;&nbsp;x&nbsp;&nbsp;<span class="ri ri-btn2">
				<span class="count">1</span><span class="btns"><a class="up" href="javascript:void(0)"><i class="fa fa-caret-up"></i></a>
				<a class="down" href="javascript:void(0)"><i class="fa fa-caret-down"></i></a></span>
			</span>&nbsp;<span class="person">人</span> -->
			<p id="addNewPackage" style="margin:20px;"><a href="javascript:void(0)" style="color: #69a8ff;font-size: 14px;" onclick="addNewPackage(this)">+添加其他套餐类型</a></p>
		</div>
	<div class="r_down">
		<div class="price_list">
			<p class="li"><span class="li_l">房费</span><span class="li_r"><span class="sm_r">¥</span></span></p>
			<p class="li"><span class="li_l">税费</span><span class="li_r"><span class="sm_r">¥</span><span id="taxationPrice"></span></span></p>
			<p class="li"><span class="li_l">服务费</span><span class="li_r"><span class="sm_r">¥</span><span id="servicePrice"></span></span></p>
		</div>
		<div class="price_total">
			<p class="li"><span class="li_l">总价</span><span class="li_r"><span class="sm_r">¥</span> <span id="total"></span></span></p>
		</div>
		<p class="p_info">套餐规则：按每人/套餐 计费</p>
		<p class="p_btn"><a class="btn btn-info addroute" id="setCtripBtn" disabled="false">放入行程单</a></p>
	</div>
</div>
<!--=== End right content ===-->
<div class="clr"></div>

<!-- Page level JS -->
<script type="text/javascript" src="<%=basePath%>assets/js/product_detail.js"></script>
<script type="text/javascript">
var packageModel='';
var mainRows = '';
var additionalRows='';
function addNewPackage(obj){
	if(packageModel==null||packageModel==''){
		packageModel = $("#package_type").html();
	}
	if(packageModel!=''){
		$("#package_type").append(packageModel);
		countprice();
	}
}

function changePackage(obj){
	var index = $(obj).val();
	var main = mainRows[index];
	var price = main.price;
	var maxCnt = main.maxCnt;
	var option = '';
	for(var i=1;i<=maxCnt;i++){
		option = option +'<option value="'+i+'">'+i+'</option>';
	}
	$(obj).next().html(option);
	$(obj).next().next().html("￥"+price+'(含税)');
	$(obj).next().next().next().html(main.description);
	countprice();
}


function countprice(){
	var packageTypeList = $("#package_type").find(".package_type_child");
	var total =0;
	for(var i=0;i<packageTypeList.length;i++){
		var main = $(packageTypeList).eq(i).find(".main");
		var main_index = $(main).find("select").eq(0).val();
		var main_number = $(main).find("select").eq(1).val();
		var main_price = mainRows[main_index].price;
		total = total+main_number*parseFloat(main_price);
		
		var additional = $(packageTypeList).eq(i).find(".additional");
		var additional_list = $(additional).find(".child");
		if(additional_list.length>0){
			for(var j=0;j<additional_list.length;j++){
				var num = $(additional_list).eq(j).find("select").val();
				if(num>0){
					var additional_price = additionalRows[j].price;
					total = total+num*parseFloat(additional_price);
				}
			}
		}
	}
	var taxationPrice = (total* parseFloat('${row.tax_rate}')).toFixed(2);
	var servicePrice = (total* parseFloat('${row.service_fee_rate}')).toFixed(2);
	var roomPrice = (total - taxationPrice - servicePrice).toFixed(2);
	$(".price_list").find(".li_r").eq(0).html('<span class="sm_r">¥</span>'+roomPrice);
	$("#taxationPrice").html(taxationPrice);
	$("#servicePrice").html(servicePrice);
	$("#total").html(total);
}

routeJson = '${routeJson}';
function add(){
	
	var productEndtime = new Date('${row.enddate }');
	var endtime = productEndtime.format('yyyy-MM-dd');
	var packageBeginDate = $("#packageBeginDate").val();
	var n = getDateDiff(packageBeginDate, endtime) ;
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
	var packageJson = data.package;
	var villaJson = data.villa;
	var hotelJson = data.hotel;
	var staylvl = '${row.staylvl}';
	if(villaJson!='' && villaJson!=null &&villaJson!='undefined' && staylvl!='99'){
		var bool = window.confirm("您选中的套餐包含住宿，行程中已有别墅可提供住宿，是否继续添加此套餐？");
		if(!bool){
			return false;
		}
	}
	if(hotelJson!='' && hotelJson!=null &&hotelJson!='undefined' && staylvl=='99'){
		var bool = window.confirm("您选中的套餐包含住宿，行程中已有酒店可提供住宿，是否继续添加此套餐？");
		if(!bool){
			return false;
		}
	}
	if(packageJson!=null&&packageJson!=''&&packageJson!='undefined'&&packageJson!='null'){
		var bool = window.confirm("一个行程只能含有一个套餐，是否删除其他套餐使用此套餐");
		if(!bool){
			return false;
		}else{
			buliderObject();	
		}
	}else{
		buliderObject();
	}
}

function buliderObject(){
	var packageTypeList = $("#package_type").find(".package_type_child");
	var total =0;
	var packagePrice="{"
	for(var i=0;i<packageTypeList.length;i++){
		var main = $(packageTypeList).eq(i).find(".main");
		var main_index = $(main).find("select").eq(0).val();
		var main_number = $(main).find("select").eq(1).val();
		var main_price = mainRows[main_index].price;
		var main_prepay = mainRows[main_index].prepay;
		var main_priceGroup = mainRows[main_index].priceGroup;
		var main_priceItem = mainRows[main_index].priceItem;
		var id = mainRows[main_index].id;
		total = total+main_number*parseFloat(main_price);
		
		packagePrice = packagePrice+'"price":'+'"'+main_price+'",'+'"prepay":'+'"'+main_prepay+'",'+'"id":'+'"'+id+'",'
						+'"number":'+'"'+main_number+'",'+'"priceGroup":'+'"'+main_priceGroup+'",'+'"priceItem":'+'"'+main_priceItem+'"},{'
		
		var additional = $(packageTypeList).eq(i).find(".additional");
		var additional_list = $(additional).find(".child");
		for(var j=0;j<additional_list.length;j++){
			var num = $(additional_list).eq(j).find("select").val();
			if(num>0){
				var additional_price = additionalRows[j].price;
				var additional_prepay = additionalRows[j].prepay;
				var additional_id = additionalRows[j].id;
				var additional_priceGroup = additionalRows[j].priceGroup;
				var additional_priceItem = additionalRows[j].priceItem;
				
				packagePrice = packagePrice+'"price":'+'"'+additional_price+'",'+'"prepay":'+'"'+additional_prepay+'",'+'"id":'+'"'+additional_id+'",'
				+'"number":'+'"'+num+'",'+'"priceGroup":'+'"'+additional_priceGroup+'",'+'"priceItem":'+'"'+additional_priceItem+'"},{'
				
				total = total+num*parseFloat(additional_price);
			}
		}
	}
	packagePrice = packagePrice.substring(0,packagePrice.length-2);
	
	var taxationPrice = (total* parseFloat('${row.tax_rate}')).toFixed(3);
	var servicePrice = (total* parseFloat('${row.service_fee_rate}')).toFixed(3);
	var timestamp = Date.parse(new Date());
	var date = $("#packageBeginDate").val().trim();
	var startDate = new Date(date);
	var endDate = addDate(startDate,'${row.daycnt}'); 
	if(packagePrice==''){
		alert("请选择套餐");
		return false;
	}
	var s = '{"date":'+'"'+date+'",'
				+'"pid":'+'"'+'${row.pid}'+'",'
				+'"leftCountry":'+'"'+'${country.id}'+'",'
				+'"timestamp":'+'"'+timestamp+'",'
				+'"pname":'+'"'+'${row.pname}'+'",'
				+'"staylvl":'+'"'+'${row.staylvl}'+'",'
				+'"startDate":'+'"'+startDate.format('yyyy-MM-dd')+'",'
				+'"endDate":'+'"'+endDate.format('yyyy-MM-dd')+'",'
				+'"serviceFeeRate":'+'"'+'${row.service_fee_rate}'+'",'
				+'"countryName":'+'"'+'${country.cityName }'+'",'
				+'"cityName":'+'"'+'${city.cityName }'+'",'
				+'"taxRate":'+'"'+'${row.tax_rate}'+'",'
				+'"servicePrice":'+'"'+servicePrice+'",'
				+'"taxPrice":'+'"'+taxationPrice+'",'
				+'"totalPrice":'+'"'+total+'",'
				+'"type":'+'"package",'
				+'"packagePriceList":'+'['+packagePrice+']}';
	appendTrafficJson(s,null,'package');
}

function priceItemDetail(data,date){
	$("#packageBeginDate").val(date);	
	var html = '';
	mainRows = data.mainRows;
	var html_main='';
	if(mainRows!=null&&mainRows.length>0){
		//主价格项
		var html_main_option = '';
		for(var i =0;i<mainRows.length;i++){
			var main = mainRows[i];
			html_main_option = html_main_option+ '<option value="'+i+'">'+main.priceItem+'</option>';
		}
		var maxCnt = parseInt(mainRows[0].maxCnt);
		var html_main_option_number = '';
		for(var i =1;i<=maxCnt;i++){
			html_main_option_number = html_main_option_number+ '<option value="'+i+'">'+i+'</option>';
		}
		html_main = '<div class="package_type_child" > '
					+'<img src="<%=basePath%>assets/img/colse.png" onclick="removepackage(this);" style="position:absolute;top:0;right:0"/>'
					+'<div class="main">'
					+'<select class="ri ri-btn select1" onchange="changePackage(this);">'
					+html_main_option
					+'</select>'
					+'&nbsp;&nbsp;x&nbsp;&nbsp;'
					+'<select class="ri ri-btn select2" onchange="countprice()">'
					+html_main_option_number
					+'</select>'
					+'<span class="ri ri-btn" style="color:#ff0000;float:right;line-height:34px">¥'+mainRows[0].price+'(含税)</span>'
					+'<p style="font-size:12px;color:#ccc;">'+mainRows[0].description+'</p>'
					+'</div>'
					+'<div style="border-bottom:1px solid #e5e5e5;"></div>';
	 	allowAdd();
	}else{
		notAllowAdd();
	}
	additionalRows = data.additionalRows;
	var html_additional = '';
	if(additionalRows!=null&&additionalRows.length>0){
		html_additional = '<div class="additional">';
		//附加价格项
		var html_additional_child='';
		var maxAdd = additionalRows.length;
		for(var i=0; i<maxAdd; i++){
			var additional = additionalRows[i];
			var maxCnt = parseInt(additional.maxCnt);
			var html_number_html='';
			for(var j =0;j<=maxCnt;j++){
				html_number_html = html_number_html+ '<option value="'+j+'">'+j+'</option>';
			}
			
			html_additional_child = html_additional_child+ '<div class="child">'
							+'<span class="ri ri-btn addition_p">'+additional.priceItem+'</span>&nbsp;&nbsp;x&nbsp;&nbsp;'
							+'<select class="ri ri-btn select2" style="width: 50px;" onchange="countprice()">'
							+html_number_html
							+'</select>'
							+'<span class="ri ri-btn" style="color:#ff0000;float:right;line-height:34px">¥'+additional.price+'(含税)</span>'
							+'<p style="font-size:12px;color:#ccc;">'+additional.description+'</p>'
							+'<div style="border-bottom:1px solid #e5e5e5;"></div>'
							+'<br></div>';
		}
		html_additional = html_additional+html_additional_child+'</div>';
	}
	html = html+html_main+html_additional;
	$("#package_type").html(html);
	packageModel=html;
	countprice();
}


function removepackage(obj){
	$(obj).parent(".package_type_child").remove();
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

//对Date的扩展，将 Date 转化为指定格式的String   
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，   
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)   
//例子：   
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423   
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18   
Date.prototype.format = function(fmt) { //author: meizz   
	var o = {
		"M+" : this.getMonth() + 1, //月份   
		"d+" : this.getDate(), //日   
		"h+" : this.getHours(), //小时   
		"m+" : this.getMinutes(), //分   
		"s+" : this.getSeconds(), //秒   
		"q+" : Math.floor((this.getMonth() + 3) / 3), //季度   
		"S" : this.getMilliseconds()
	//毫秒   
	};
	if (/(y+)/.test(fmt))
		fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(fmt))
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]): (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt;
}
var isExpend = false;
function initPage() {  
    try {  
        $window = $(window);  
        var resize = $window.jqElemResize();  
        $(resize).on("resize", function (size) {  
        	setTopHeight(); 
        	dayssetting();
        });  
    } catch (exp) {  
        alert(exp.message);  
    }  
} 

function dayssetting(){
	$("#innerDivs").width($(".center_content").width() - 80);
	
	if($("#noRoutDaysCarousel").width() > $(".center_content").width()){
		$("#routDaysCarousel").show();
		$("#noRoutDaysCarousel").hide();
	}else{
		$("#routDaysCarousel").hide();
		$("#noRoutDaysCarousel").show();
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

function setDayTop(obj){
	console.log(obj);

	var dayid=$(obj).attr("dayid");
	var top=$(".routeDay[dayid='"+dayid+"']").offset().top;
	$(window).scrollTop(top-100);
}

jQuery(document).ready(function() {
	//packageModel = $("#package_type").html();
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
		if(catid == 1){
			$(window).scrollTop(top-100);
		}else{
			$(window).scrollTop(top-50);
		}
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
	dayssetting();
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