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
<!DOCTYPE html>
<html>
<head>
<!-- page level -->
<link href="<%=basePath%>assets/css/job.css" rel="stylesheet" type="text/css">
</head>
<body>
<!-- === main -->
<div id="job_main" >
	<img  src="<%=basePath%>assets/img/job/job_bak.jpg" style="width: 100%;">
	<div class="content_txt">
		<h2>梦寐以求的好工作，应该有</h2>
		<img src="<%=basePath%>assets/img/job/job1.png" style="width: 100%;">
		<ul class="text_ul"><!-- 
		 --><li class="li1">明亮舒适时尚的办公空间</li><!-- 
		 --><li class="li2">年轻有活力的工作伙伴</li><!--
		 --><li class="li3">站在潮流尖端的互联网行业</li><!--
		 --><li class="li4">经验丰富的管理团队</li><!--
		 --><li class="li5">专业系统的培训体系</li><!--
		 --><li class="li6">规范的五险一金</li><!--
		 --><li class="li7">弹性的工作时间</li><!--
		 --><li class="li8">每年享受假期</li><!--
		 --><li class="li9">能看到未来、有升职的空间</li><!--
	 --></ul>
		<div class="clr"></div>
	</div>
	
	<div class="content_txt">
		<h2>就这些？还不够！如果还有<br>......</h2>
		<img src="<%=basePath%>assets/img/job/job2.png" style="width: 100%;">
		<ul class="text_ul"><!-- 
		 --><li class="li1">暖心暖胃的早餐热粥</li><!-- 
		 --><li class="li2">轻松愉悦的下午茶点</li><!--
		 --><li class="li3">半年递增的加薪空间</li><!--
		 --><li class="li4">丰厚的试用期转正奖励</li><!--
		 --><li class="li5">高规格的海外培训、体验奢华</li><!--
		 --><li class="li6">每年最少一次的境外旅游</li><!--
		 --><li class="li7">家属享受国际旅行度假最优惠价</li><!--
		 --><li class="li8">精彩团队活动、感受温馨</li><!--
		 --><li class="li9">精致节日礼物、感受关怀</li><!--
	 --></ul>
		<div class="clr"></div>
	</div>
	<img  src="<%=basePath%>assets/img/job/job3.png" style="width: 100%; margin-top: 80px;">
	<div class="mid_content">
		<div class="sub_title sub_title1">麦味旅行引领当下最新潮的旅行度假概念，专注于打造主题度假以及私人订制的中高端旅行度假平台</div>
		<div class="sub_title sub_title2">高品质的度假生活&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;全球精选的目的地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;会具特色的行程规划&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;细致周到的咨询服务&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;全方位的管家服务</div>
		<div class="sub_title sub_title3">卿卿我我的二人世界、和和美美的小家庭、与父母公婆出行、公司团建年会旅行，麦味给你独一无二的旅行享受</div>
	</div>
	
	<div class="sub_title " style="background-color: #F6F6F6;">
		<div class="imgs">
			<div style="width: 280px;height: 145px;background-color: #50C088;">&nbsp;</div>
			<div s="img_title">奢华的别墅度假</div>
		</div>
		<div class="imgs">
			<div style="width: 280px;height: 145px;background-color: #50C088;">&nbsp;</div>
			<div class="img_title">欢乐的亲子游乐</div>
		</div>
		<div class="imgs">
			<div style="width: 280px;height: 145px;background-color: #50C088;">&nbsp;</div>
			<div class="img_title">浓情的海岛蜜月</div>
		</div>
		<div class="imgs last">
			<div style="width: 280px;height: 145px;background-color: #50C088;">&nbsp;</div>
			<div class="img_title">精致的休闲养生</div>
		</div>
		<div class="clr"></div>
	</div>
	
	<div class="content_txt" style="border-top: 1px solid #e5e5e5;margin-top: -35px;">
		<h2 style="margin-top: 50px;">还等什么？快来加入麦味</h2>
		<h3>如果你是，<span style="color: #5298FF;">Cooperated Confident Creative Charming Colorful</span>，那就是你，麦味要找的伙伴！</h3>
		<img src="<%=basePath%>assets/img/job/job_person.png" style="width: 96px;margin-right: 35px;">
		<img src="<%=basePath%>assets/img/job/job_person.png" style="width: 96px;margin-right: 35px;">
		<img src="<%=basePath%>assets/img/job/job_person.png" style="width: 96px;margin-right: 35px;">
		<img src="<%=basePath%>assets/img/job/job_person.png" style="width: 96px;margin-right: 35px;">
		<img src="<%=basePath%>assets/img/job/job_person.png" style="width: 96px;margin-right: 35px;">
		<img src="<%=basePath%>assets/img/job/job_person.png" style="width: 96px;margin-right: 35px;">
		<img src="<%=basePath%>assets/img/job/job_person.png" style="width: 96px;margin-right: 35px;">
		<img src="<%=basePath%>assets/img/job/job_person.png" style="width: 96px;">
		<ul class="text_ul"><!-- 
		 --><li class="li1 f14">运营总监<br><span>全职</span></li><!-- 
		 --><li class="li2 f14">市场经理<br><span>全职</span></li><!--
		 --><li class="li3 f14">网站产品经理<br><span>全职</span></li><!--
		 --><li class="li4 f14">旅行顾问<br><span>全职</span></li><!--
		 --><li class="li5 f14">产品专员<br><span>全职</span></li><!--
		 --><li class="li6 f14">总经理助理<br><span>全职</span></li><!--
		 --><li class="li7 f14">文案策划<br><span>可兼职</span></li><!--
		 --><li class="li8 f14">管理培训生<br><span>实习生岗位</span></li><!--
	 --></ul>
		<div class="clr"></div>
	</div>
	
	 <div id="map" class="rel">
	 	<img src="<%=basePath%>assets/img/job/map.png" >
	 	<div id="address">
	 		<p class="p1">来MY WAY吧！</p>
	 		<p class="p2">走我们的路，实现我们的梦！</p>
	 		<p class="p3">上海市普陀区大华路88弄36号</p>
	 		<p class="p4"><img class="rel" src="<%=basePath%>assets/img/job/file.png" style="width: 32px;height: 22px;
	 		top:-1px;">&nbsp;&nbsp;&nbsp;<a href="mailto:hr@imyway.cn" style="color: #4E9DFA;">hr@imyway.cn</a></p>
	 	</div>
	 </div> 
</div>
<!-- ===End  main -->

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
jQuery(document).ready(function() {
	initPage();
	setTopHeight();
});

function setTopHeight(){
	var imgh = $("#map>img").height();
	$("#address").css({
		"height":imgh+"px","padding-top":"100px"
	});
}
</script>

</body>
</html>