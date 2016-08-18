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
<style type="text/css">
#about_main{min-width: 1180px;max-width: 1600px;background-color: #f6f6f6;margin-bottom: -28px;min-height: 500px;}
.content_txt{width: 1180px;margin: 0 auto;}
.content_body{font-size: 14px;color: #666;width: 775px;}.content_body p{font-size: 14px;line-height: 24px;margin-bottom: 28px;color: #666;}
.content_body font{color: #529CFF;}.content_txt .imgs img{display: block;}
.content_txt h3{font-size: 24px;color: #333;} .content_txt p{font-size: 14px;color: #666;line-height: 24px;}
</style>
</head>
<body>
<!-- === main -->
<div id="about_main" >
	<img src="<%=basePath%>assets/img/aboutUs_bak.jpg" style="width: 100%;">
	<div class="content_txt">
		<img src="<%=basePath%>assets/img/aboutUs_logo.png" style="width: 200px;margin: 39px 0 40px;">
		<div class="content_body">
			<p><font >imway.cn</font> 于2015年11月正式上线，是麦味旅行（My Way Travel）的唯一官方网络服务平台。网站以麦味旅行成立以来的旅行定制服务经验为基础，通过对目的地的深入分析和考察，结合不同旅客的深层需求，打造独一无二的主题旅行产品，开创个性化旅行服务新时代。</p>
			
		</div>
		<div class="imgs">
			<img class="fl" src="<%=basePath%>assets/img/aboutUs_6.jpg" style="margin-right: 20px;">
			<img class="fl" src="<%=basePath%>assets/img/aboutUs_7.jpg" >
			<img class="fr" src="<%=basePath%>assets/img/aboutUs_5.jpg"  style="margin-top: -347px;z-index: 9;position: relative;margin-bottom: 60px;">
		</div>
		<div class="clr"></div>
		<h3 style="margin-top: -20px;margin-bottom: 20px;">品牌历史</h3>
		<p>麦味旅行（Myway Travel）起始于2013年，总部位于中国上海。作为一家专业的旅行（旅游）咨询公司，致力于为（全国）中高端人群打造独一无二的个性化旅行服务体验。服务区域包含马来西亚、泰国、马尔代夫、澳大利亚、日本。</p>
		<p style="margin-top: 30px;">2014年，我们（麦味）将更多地精力投放于（中高端人群的）家庭及小团队旅行定制服务。借助于目的地服务供应商的良好管理，进一步合作推出深度主题还旅行产品，包含海外亲子、婚礼 、蜜月、探索、旅拍等。服务区域进一步的覆盖到毛里求斯、斯里兰卡、斐济、塞班、帕劳、印度尼西亚、大溪地等印度洋、太平洋岛国等地。</p>
		<p style="margin-top: 30px;">2015年，麦味旅行获得A轮投资，并购河北炎程国际旅行社、设立麦味（上海）总部办公楼。提高旅行顾问服务质量，启动含有独特行程设计工具的麦味旅行主题旅行服务平台（2015年12月上线），同时研发自有的客户管理系统（CRM），供应商产品管理系统。 同时产品线进一步拓展到欧美等主要旅游城市。</p>
	
		<h3 style="margin-top: 50px;margin-bottom: 25px;">产品及服务</h3>
		<div>
			<div class="fl" style="margin-right: 20px;width: 380px;">
				<img  src="<%=basePath%>assets/img/aboutUs_8.jpg" >
				<p style="font-size: 18px;color: #333;margin-top: 18px;">高端定制</p>
				<p>专业旅行顾问，根据客户不同需求，量身定制旅行计划，让旅行更私密更享受。</p>
			</div>
			<div class="fl" style="margin-right: 20px;width: 380px;">
				<img  src="<%=basePath%>assets/img/aboutUs_9.jpg" >
				<p style="font-size: 18px;color: #333;margin-top: 18px;">主题旅行</p>
				<p>亲子旅行、海外婚礼，情侣蜜月、家庭独家、公司团建、医疗养生、狩猎射击，海钓潜水等多种主题，旅行更深入更纯粹。</p>
			</div>
			<div class="fl" style="width: 380px;">
				<img  src="<%=basePath%>assets/img/aboutUs_10.jpg" >
				<p style="font-size: 18px;color: #333;margin-top: 18px;">DIY自助游</p>
				<p>imway网站服务平台自助DIY模块，选取个性产品自动生成行程，让旅行更方便更自由。</p>
			</div>
		</div>
		<div class="clr"></div>
	</div>
	<div class="rel" style="margin-top: 40px;text-align: center; background-image: url('<%=basePath%>assets/img/aboutUs_bak_1.jpg');height:400px; ">
		<img  src="<%=basePath%>assets/img/aboutUs_logo_2.png" style="margin: 60px auto 0px auto;width: 119px;">
		<div   style="text-align: center; margin: 60px auto 0px auto;">
		<p style="color: #333;text-align: center;line-height: 16px;">麦味相信除了沿途的风景，旅行对每一个人来说都附有着更多不同的人生意义。</p>
		<p style="color: #333;text-align: center;line-height: 16px;">麦味致力于让每一位旅客在以不同身份出行时，都有属于自己的专属旅行，</p>
		<p style="color: #333;text-align: center;line-height: 16px;">能够在最适合的时间置身于最心仪的景象之中，带给您目的地的深度体验，满足旅行带来身心深层满足。</p>
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