<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>

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
<link href="<%=basePath%>assets/css/mypay.css" rel="stylesheet" type="text/css">

</head>
<body>
<!-- ===info main -->
<div id="contact_main" >
  <div id="main">
	<h2 id="title">行程单结算</h2>
	<div class="info_list">
		<!--info list table -->
		<c:set value="" var="startdate" />
		<c:set value="0" var="package_price_idx" />
		<c:forEach var="items" items="${resList }" varStatus="statusIdx">
		<c:if test="${ items.atdate !=  startdate}">
			<c:set value="${ items.atdate}" var="startdate" />
			<c:set value="${ fn:split(items.atdate, '-') }" var="tags" />
			<c:set value="0" var="ent_price_idx" />
			<table class="info_table">
				<thead>
					<tr>
						<td>${tags[1] }-${tags[2] }&nbsp;&nbsp;<span class="y">${tags[0] }</span></td>
					</tr>
				</thead>
				<tbody>
					<tr  class="sub_data" >
						<td >
							<div class="sub_data_list">
		</c:if>
								<!-- li -->
								<div class="sub_data_list_li <c:if test="${ resList[statusIdx.index+1].atdate != startdate }">last</c:if> ">
									<div class="l_content fl">
										<c:choose>
											<c:when test="${items.ptype == 0 }">
												<img alt="" src="<%=basePath%>assets/img/UI/package_icon.png" >
											</c:when>
											<c:when test="${items.ptype == 1 }">
												<img alt="" src="<%=basePath%>assets/img/UI/hotel_icon.png" >
											</c:when>
											<c:when test="${items.ptype == 2 }">
												<img alt="" src="<%=basePath%>assets/img/UI/villa_icon.png" >
											</c:when>
											<c:when test="${items.ptype == 3 }">
												<img alt="" src="<%=basePath%>assets/img/UI/traffic_icon.png" >
											</c:when>
											<c:when test="${items.ptype == 4 }">
												<img alt="" src="<%=basePath%>assets/img/UI/yl_icon.png" >
											</c:when>
										</c:choose>
									&nbsp;&nbsp;${items.attime }</div>
									<div class="c_content fl">
										<c:choose>
											<c:when test="${items.ptype == 0 or items.ptype == 4 }">
												<p>${items.title } - 
													<c:if test="${items.itype == 0 }">交通</c:if>
													<c:if test="${items.itype == 1 }">住宿</c:if>
													<c:if test="${items.itype == 2 }">别墅</c:if>
													<c:if test="${items.itype == 3 }">娱乐</c:if>
												</p>
											</c:when>
											<c:otherwise>
												<p>${items.pname }</p>
											</c:otherwise>
										</c:choose>
									</div>
									<div class="r_content fr">
										<c:choose>
											<c:when test="${items.ptype == 0 }">
												<c:if test="${package_price_idx == 0 }">
													<span>价格：<span class="red1"><f:formatNumber value="${items.amount }" type="currency" pattern="¥.00"/></span></span>
													<%-- <span>预付：<span class="red"><f:formatNumber value="${items.prepay_amount }" type="currency" pattern="¥.00"/></span></span>
													<span>尾款：<span class="red"><f:formatNumber value="${items.amount - items.prepay_amount  }" type="currency" pattern="¥.00"/></span></span> --%>
													<c:set value="1" var="package_price_idx" />
												</c:if>
											</c:when>
											<c:when test="${items.ptype == 4 }">
												<c:if test="${items.amount > 0 }">
													<span>价格：<span class="red1"><f:formatNumber value="${items.amount }" type="currency" pattern="¥.00"/></span></span>
													<%-- <span>预付：<span class="red"><f:formatNumber value="${items.prepay_amount }" type="currency" pattern="¥.00"/></span></span>
													<span>尾款：<span class="red"><f:formatNumber value="${items.amount - items.prepay_amount  }" type="currency" pattern="¥.00"/></span></span> --%>
												</c:if>
											</c:when>
											<c:otherwise>
												<span>价格：<span class="red1"><f:formatNumber value="${items.amount }" type="currency" pattern="¥.00"/></span></span>
												<%-- <span>预付：<span class="red"><f:formatNumber value="${items.prepay_amount }" type="currency" pattern="¥.00"/></span></span>
												<span>尾款：<span class="red"><f:formatNumber value="${items.amount - items.prepay_amount  }" type="currency" pattern="¥.00"/></span></span> --%>				
											</c:otherwise>
										</c:choose>
										<a href="<%=basePath%>personal/updateAndDeleteOrder.html?orderNo=${items.order_no}">修改</a>
										<span class="split"></span>
										<%-- <a href="<%=basePath%>personal/updateAndDeleteOrder.html?orderNo=${items.order_no}">删除</a> --%>&nbsp;&nbsp;&nbsp;&nbsp;
										<c:if test="${items.confirm_time == 0 }"><img class="confirm_now" src="<%=basePath%>assets/img/UI/confirm_now.png"></c:if>
										<c:if test="${items.confirm_time != 0 }"><div class="time_confirm">${items.confirm_time}小时<br>确认</div></c:if>
									</div>
									<div class="clr"></div>
								</div>
		<c:if test="${ resList[statusIdx.index+1].atdate != startdate  }">
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</c:if>
		</c:forEach>
		 <%-- <table class="info_table">
			<thead>
				<tr>
					<td>10-28&nbsp;&nbsp;<span class="y">2015</span></td>
				</tr>
			</thead>
			<tbody>
				<tr  class="sub_data" >
					<td >
						<div class="sub_data_list">
						<!-- li -->
							<div class="sub_data_list_li">
								<div class="l_content fl"><img alt="" src="<%=basePath%>assets/img/UI/traffic_icon.png" >&nbsp;&nbsp;10:30</div>
								<div class="c_content fl">
									<p class="two_p">起点：普吉机场</p>
									<p class="two_p">终点：卡塔海滩酒店</p>
								</div>
								<div class="r_content fr">
									<span>价格：<span class="red1">¥350</span></span>
									<span>预付：<span class="red">¥150</span></span>
									<span>尾款：<span class="red">¥200</span></span>
									<a href="javascript:void(0);">修改</a>
									<span class="split">|</span>
									<a href="javascript:void(0);">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;
									<img class="confirm_now" src="<%=basePath%>assets/img/UI/confirm_now.png">
								</div>
								<div class="clr"></div>
							</div>
						<!-- li -->	
							<div class="sub_data_list_li">
								<div class="l_content fl"><img alt="" src="<%=basePath%>assets/img/UI/traffic_icon.png" >&nbsp;&nbsp;10:30</div>
								<div class="c_content fl">
									<p class="two_p">起点：普吉机场</p>
									<p class="two_p">终点：卡塔海滩酒店</p>
								</div>
								<div class="r_content fr">
									<span>价格：<span class="red1">¥350</span></span>
									<span>预付：<span class="red">¥150</span></span>
									<span>尾款：<span class="red">¥200</span></span>
									<a href="javascript:void(0);">修改</a>
									<span class="split">|</span>
									<a href="javascript:void(0);">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;
									<img class="confirm_now" src="<%=basePath%>assets/img/UI/confirm_now.png">
								</div>
								<div class="clr"></div>
							</div>
						<!-- li -->	
							<div class="sub_data_list_li">
								<div class="l_content fl"><img alt="" src="<%=basePath%>assets/img/UI/hotel_icon.png" >&nbsp;&nbsp;10:30</div>
								<div class="c_content fl">
									<p>塞伦的拉SPA酒店</p>
								</div>
								<div class="r_content fr">
									<span>价格：<span class="red1">¥350</span></span>
									<span>预付：<span class="red">¥150</span></span>
									<span>尾款：<span class="red">¥200</span></span>
									<a href="javascript:void(0);">修改</a>
									<span class="split">|</span>
									<a href="javascript:void(0);">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;
									<img class="confirm_now" src="<%=basePath%>assets/img/UI/24confirm_now.png">
								</div>
								<div class="clr"></div>
							</div>
						<!-- li -->	
							<div class="sub_data_list_li last">
								<div class="l_content fl"><img alt="" src="<%=basePath%>assets/img/UI/yl_icon.png" >&nbsp;&nbsp;10:30</div>
								<div class="c_content fl">
									<p>普吉机场</p>
								</div>
								<div class="r_content fr">
									<span>价格：<span class="red1">¥350</span></span>
									<span>预付：<span class="red">¥150</span></span>
									<span>尾款：<span class="red">¥200</span></span>
									<a href="javascript:void(0);">修改</a>
									<span class="split">|</span>
									<a href="javascript:void(0);">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;
									<img class="confirm_now" src="<%=basePath%>assets/img/UI/24confirm_now.png">
								</div>
							</div>
							<div class="clr"></div>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		
		<table class="info_table">
			<thead>
				<tr>
					<td>10-29&nbsp;&nbsp;<span class="y">2015</span></td>
				</tr>
			</thead>
			<tbody>
				<tr  class="sub_data" >
					<td >
						<div class="sub_data_list">
							<div class="sub_data_list_li">
								<div class="l_content fl"><img alt="" src="<%=basePath%>assets/img/UI/traffic_icon.png" >&nbsp;&nbsp;10:30</div>
								<div class="c_content fl">
									<p class="two_p">起点：普吉机场</p>
									<p class="two_p">终点：卡塔海滩酒店</p>
								</div>
								<div class="r_content fr">
									<span>价格：<span class="red1">¥350</span></span>
									<span>预付：<span class="red">¥150</span></span>
									<span>尾款：<span class="red">¥200</span></span>
									<a href="javascript:void(0);">修改</a>
									<span class="split">|</span>
									<a href="javascript:void(0);">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;
									<img class="confirm_now" src="<%=basePath%>assets/img/UI/confirm_now.png">
								</div>
							</div>
							<div class="clr"></div>
							
							<div class="sub_data_list_li last">
								<div class="l_content fl"><img alt="" src="<%=basePath%>assets/img/UI/yl_icon.png" >&nbsp;&nbsp;10:30</div>
								<div class="c_content fl">
									<p>普吉机场</p>
								</div>
								<div class="r_content fr">
									<span>价格：<span class="red1">¥350</span></span>
									<span>预付：<span class="red">¥150</span></span>
									<span>尾款：<span class="red">¥200</span></span>
									<a href="javascript:void(0);">修改</a>
									<span class="split">|</span>
									<a href="javascript:void(0);">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;
									<img class="confirm_now" src="<%=basePath%>assets/img/UI/confirm_now.png">
								</div>
							</div>
							<div class="clr"></div>
							
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<!--end info list table -->
	</div>  --%>
	
	<div id="pay_price">
		<span>合计（含税）：</span>
		<span class="red" id="amount" data-amount="${routeOrder.amount}" ><f:formatNumber value="${routeOrder.amount }" type="currency" pattern="¥0.00"/></span>
		<c:if test="${routeOrder.amount != routeOrder.oldAmount}">
			<span>折扣：</span>
			<span class="red"><f:formatNumber value="${routeOrder.oldAmount - routeOrder.amount }" type="currency" pattern="¥0.00"/></span>
		</c:if>
		<%-- <span>预付：</span>
		<span class="gray"><f:formatNumber value="${routeOrder.prepay }" type="currency" pattern="¥.00"/></span>
		<span>尾款：</span>
		<span class="gray"><f:formatNumber value="${routeOrder.amount - routeOrder.prepay }" type="currency" pattern="¥.00"/></span> --%>
	</div>
	<div class="clr"></div>
	<!-- select pay type -->
	<div id="pay_type">
		<h5 style="color: #333;margin-bottom: 20px;">请选择支付方式</h5>
		<div class="pay" data-val="1"><img src="<%=basePath%>assets/img/personal/zfb.png"><img data-val="1" class="pay_border" src="<%=basePath%>assets/img/personal/border.png"></div>
		<div class="pay" data-val="2"><img src="<%=basePath%>assets/img/personal/wxzf.png"></div>
		<%--
		<div class="pay" data-val="3"><img src="<%=basePath%>assets/img/personal/zxzf.png"></div>
		 --%>
		<div class="clr"></div>
		<button class="btn" id="payBtn" type="button">立即结算</button>
	</div>
	<!-- end select pay type -->
  </div>
</div>
<!-- ===End info main -->
</div>

<!-- model -->
<div class="modal fade " id="wxModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
   <div class="modal-dialog" style="width: 700px;">
        <div class="modal-content" style="width: 700px;border-radius:0px;">
            <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
               <h4 id="wxTitle" style="font-size: 14px;color: #333;">微信支付</h4>
           </div>
           <div class="modal-body" id="wxContent" style="padding: 0px 40px;">
           		<div class="fl">
		           	<div style="border: 1px solid #e5e5e5;width:300px;height:300px;margin-top: 40px;">
			           	<img src="" style="width:298px;height:298px;" id="wx_qr"/>
		           	</div>
		           	<div style="padding-top: 20px;width: 300px;text-align: center;font-size: 16px;">请使用微信扫一扫扫描二维码支付</div>
           		</div>
	           	<img class="fr" src="<%=basePath%>assets/img/personal/phone.png">
	           	<div class="clr"></div>
           </div>
       </div>
   </div>
</div>
<!-- end model -->

<script src="<%=basePath%>/assets/js/pingpp-pc.js" type="text/javascript"></script>
<!-- Page level JS -->
<script type="text/javascript">
$(function(){
	$(".tags-nav").find("a").removeClass("active");
	$(".tags-nav").find("a").eq(0).addClass("active");
	$("#pay_type>.pay").click(function(){
		var selectVal = $(this).data("val");
		var imghtml = '<img class="pay_border" data-val="'+selectVal+'"  src="<%=basePath%>assets/img/personal/border.png">';
		$(".pay_border").remove();
		if(selectVal==1){
			$(this).append(imghtml);
		}else if(selectVal==2){
			$(this).append(imghtml);
		}else if(selectVal==3){
			$(this).append(imghtml);
		}
	});
	
	$("#payBtn").click(function(){
		var selectVal = $(".pay_border").data("val");
		if(selectVal==1){
			pc_pay('alipay_pc_direct');
		}else if(selectVal==2){
			pc_pay('wx_pub_qr');
		}
	});
});

var c;
function pc_pay(channel) {
	window.clearInterval(c);
    var amount = ($("#amount").data("amount") * 100) + "";
    if(!isNaN(amount) && amount!=''){
    	var pay_url = "<%=basePath%>requestpay.html";
        var xhr = new XMLHttpRequest();
        xhr.open("POST", pay_url, true);
        xhr.setRequestHeader("Content-type", "application/json");
        xhr.send(JSON.stringify({
            channel: channel,
            amount: amount,
            orderNo: "${routeOrder.orderNo}"
        }));

        xhr.onreadystatechange = function () { 
        	
            if (xhr.readyState == 4 && xhr.status == 200) {
            	
             //   console.log(xhr.responseText);
                if("wx_pub_qr" == channel){
                	if(xhr.responseText == "charge_order_no_used"){
                		alert("您当前的行程单支付状态确认中，请不要重复支付！");
                		return;
                	}
                	
                	var retobj = JSON.parse(xhr.responseText);
                	
                	var pic = document.getElementById("wx_qr"); //wx_pub_qr
                	$("#wxModal").modal('show'); 
                //	alert(retobj.id);
                	
                	pic.src = '<%=basePath%>qr_code.html?code_url=' + retobj.wx_pub_qr;
                	if(xhr.responseText != null && xhr.responseText != ""){
                		id = retobj.id
                		c = self.setInterval('checkPaySts(id)',2000);//每1秒执行一次checkPaySts方法
                	}
                }else if("alipay_pc_direct" == channel){
	                pingppPc.createPayment(xhr.responseText, function(result, err) {
	                    alert('系统繁忙。请稍后再试！');
	                });
                }
            }
        }
   }

    
}
    
function checkPaySts(payid){
	$.ajax({
        type: "POST",
        url: "<%=basePath%>checkpay.html",
        data: "id="+payid + "&time="+new Date().getTime(),
        success: function(rtmsg){
            if(rtmsg == 'true'){
            	window.clearInterval(c);
      			window.location.href= "<%=basePath%>paystatus.html?id=${routeOrder.orderNo}";
            }
        }
    });
}

</script>
</body>
</html>