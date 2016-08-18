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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>MiniCheckout</title>
</head>
<body>
<header>
    <div class="h_content">
        <span></span>
    </div>
</header>
<section class="block">
    <div class="content2">
        <div class="app">
            <label class="text_amount">
                <input id="amount" type="text" placeholder="金额" value="1"/>
            </label>

            <div class="ch">
                <button class="up" onclick="pc_pay('alipay_pc_direct')">支付宝 PC</button>
                <button class="up" onclick="pc_pay('wx_pub_qr')">微信 PC</button>
			</div>
			<div>
			<img src="" style="width:300px;height:300px;" id="wx_qr"/>
			</div>
        </div>
    </div>
</section>
<script type="text/javascript" src="<%=basePath%>assets/js/jquery.min.js"></script>
<script src="<%=basePath%>/assets/js/pingpp-pc.js" type="text/javascript"></script>
<script>
	var c;
    function pc_pay(channel) {
    	window.clearInterval(c);
        var amount = (document.getElementById('amount').value * 100) + "";

        var pay_url = "http://localhost:9001/imyway/requestpay.html";

        var xhr = new XMLHttpRequest();
        xhr.open("POST", pay_url, true);
        xhr.setRequestHeader("Content-type", "application/json");
        xhr.send(JSON.stringify({
            channel: channel,
            amount: amount
        }));

        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4 && xhr.status == 200) {
                console.log(xhr.responseText);
                if("wx_pub_qr" == channel){
                	
                	alert(xhr.responseText);
                	var retobj = JSON.parse(xhr.responseText);
                	
                	var pic = document.getElementById("wx_qr"); //wx_pub_qr
                	
                	alert(retobj.id);
                	
                	pic.src = '<%=basePath%>qr_code.html?code_url=' + retobj.wx_pub_qr;
                	if(xhr.responseText != null && xhr.responseText != ""){
                		id = retobj.id
                		c = self.setInterval('checkPaySts(id)',2000);//每1秒执行一次checkPaySts方法
                	}
                }else if("alipay_pc_direct" == channel){
	                pingppPc.createPayment(xhr.responseText, function(result, err) {
	                    console.log(result);
	                    console.log(err);
	                    alert('error !!');
	                });
                }
            }
        }
    }
    
    function checkPaySts(payid){
    	$.ajax({
            type: "POST",
            url: "http://localhost:9001/imyway/checkpay.html",
            data: "id="+payid + "&time="+new Date().getTime(),
            success: function(rtmsg){
                if(rtmsg == 'true'){
                	window.clearInterval(c);
		        	window.location.href= "http://mooracle.com";
                }
            }
        });
    }
</script>
</body>
</html>