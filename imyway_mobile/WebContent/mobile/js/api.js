//收藏添加/取消
function collectToggle(id,flag){
	/*$.ajax({
        url : "",
        type : "post",
        dataType : "json",
        data : {
        	"id" : cancelCollectId, //产品
        	"flag" : flag //1表示收藏，0表示取消收藏
        },
        cache : false,
        success:function(data) {*/
       		//收藏列表页
       		if($('#my-actions').length > 0){
       			$(".collectList>li[data-id='"+cancelCollectId+"']").remove();
	       		if($(".collectList").height() < $(window).height() - 120){
	       			loader.loadData();
	       		}
				$('#my-actions').modal('close');
       		}
       		//产品详情页
       		if($("#collectBtn").length > 0){
       			$("#collectBtn").toggleClass("collected");
       		}
        /*}
  	})*/
}

//发送短信获取验证码ajax
function ajax_getCaptcha(){
	$.ajax({
	    url:"",
	    type:"post",
	    dataType:"json",
	    data:{
	        phone : phone
	    },
	    cache:false,
	    success:function(data) {  
	        
	    }
	})
}

//上传头像接口
function updatePrt(result,inputElm){
	/*$.ajax({
	    url:"",
	    type:"post",
	    dataType:"json",
	    data:{
	        base64 : result.base64
	    },
	    cache:false,
	    success:function(data) { */         
         	inputElm.siblings(".picPreview").remove();
            inputElm.after('<div class="picPreview" style="background-image:url('+result.base64+');"></div>');
            inputElm.siblings(".fileBase64").val(result.base64)
	    /*}
	})*/
}

//订单confirm回调处理
function modal_confirm_handle_order(dom){
	$('#modal_confirm').modal({
		relatedTarget: dom,
        onConfirm: function(options) {	
        	var $link = $(this.relatedTarget);
        	var $wrap = $link.parents(".orderItem");
        	/*$.ajax({
			    url:$link.attr("href"),
			    type:"post",
			    dataType:"json",
			    cache:false,
			    success:function(data) {  */
			   		var data = {
			   			"success" : true,
			   			"msg" : "订单取消失败"
			   		}  //模拟假数据，需删除
			    	if(data.success){
			    		if($link.hasClass("orderCancel")){
							$wrap.find(".orderOperate").html('<a class="btn btnH" disabled="disabled">关闭交易</a>');
				    		$wrap.find(".state").text("交易取消");
						}
						else if($link.hasClass("orderDelete")){
							$wrap.remove();
							if($(".orderList").height() < $(window).height() - 200){
				       			loader.loadData();
				       		}
						}
			          	$('#modal_confirm').modal('close');
			    	}
			    	else{
			    		alert(data.msg)
			    	}		        
			    /*}
			})*/
        },
        onCancel: function() {
          	$('#modal_confirm').modal('close');
        }
  });
}

//分页数据加载_数据请求
function waterFallAjax(){
	loader = this;
    /*$.ajax({
        url : loader.ajaxUrl+"&page="+loader.ajaxPage,
        type : loader.ajaxType,
        dataType : loader.ajaxDateType,
        data : loader.ajaxParam,
        cache : loader.ajaxCache,
        beforeSend:function() {
            if(loader.ajaxPage > 1){
                loader.loadElm.addClass("loading").show().find(".text").text("努力加载中...");
            }
        },
        success:function(data) {*/
       	
       		/*此段为ajax测试硬编码数据，统一返回JSON格式数据，需删除_start*/
       		if($("#waterFall").hasClass("pdtList") && !$("#waterFall").hasClass("collectList")){
       			var data = {
                    html : '<li><a href="pdtDetail_hotel.html"><img class="fullImg" src="demo/theme1.jpg" /><p class="price">¥6999/起</p><div class="cnt"><h5 class="tit"><span class="color1">【泰国 苏梅岛】</span>湄南海滩 W酒店</h5><p class="intro">W Retreat Koh Samui (苏梅岛W酒店)由著名泰国室内设计公司 P49 Deesign 与 MAPS 设计工作室精心打造</p><div class="info f-box"><div class="label f-flex">商务 | XX | AAA</div></div></div></a></li><li><a href="pdtDetail_villa.html"><img class="fullImg" src="demo/theme2.jpg" /><p class="price">¥7999/起</p><div class="cnt"><h5 class="tit"><span class="color1">【泰国 苏梅岛】</span>水晶别墅</h5><p class="intro">水晶别墅是一项建筑和设计杰作，由建筑和室内设计师精诚合作完成。</p><div class="info f-box"><div class="label f-flex">6卧室 | 家庭 | 婚礼 | 半山</div></div></div></a></li><li><a href="pdtDetail_meal.html"><img class="fullImg" src="demo/theme3.jpg" /><p class="price">¥4999/起</p><div class="cnt"><h5 class="tit"><span class="color1">【日本 冲绳】</span>亲子奇幻之旅 5晚套餐</h5><div class="info f-box"><div class="label f-flex">4卧室 | 家庭 | 婚礼 | 海景</div></div></div></a></li>', //html模板
                    over : false, //false表示还有数据,true表示数据全部加载完
                    msg : "矮油~没有对应的商品<br/>去看看别的吧~"  //若该条件下没有相关数据，或因条件不足而不能搜索相关数据，此参数设定的是此种情况下的提示文字，如不设定此参数或设定为空字符串，则默认会提示"对不起，没有查找到相关数据"
                }    			
       		} 
       		else if($("#waterFall").hasClass("collectList")){
       			var data = {
                    html : '<li data-id="001"><a href="pdtDetail_hotel.html"><img class="fullImg" src="demo/theme1.jpg" /><p class="price">¥6999/起</p><div class="cnt"><h5 class="tit"><span class="color1">【泰国 苏梅岛】</span>湄南海滩 W酒店</h5><div class="starLv" data-lv="4.5"></div><p class="intro">W Retreat Koh Samui (苏梅岛W酒店)由著名泰国室内设计公司 P49 Deesign 与 MAPS 设计工作室精心打造</p><div class="info f-box"><div class="label f-flex">商务 | XX | AAA</div></div></div></a><button class="operateBtn sprite" data-am-modal="{target:\'#my-actions\'}"></button></li><li data-id="002"><a href="pdtDetail_villa.html"><img class="fullImg" src="demo/theme2.jpg" /><p class="price">¥7999/起</p><div class="cnt"><h5 class="tit"><span class="color1">【泰国 苏梅岛】</span>水晶别墅</h5><p class="intro">水晶别墅是一项建筑和设计杰作，由建筑和室内设计师精诚合作完成。</p><div class="info f-box"><div class="label f-flex">6卧室 | 家庭 | 婚礼 | 半山</div></div></div></a><button class="operateBtn sprite" data-am-modal="{target:\'#my-actions\'}"></button></li><li data-id="003"><a href="pdtDetail_meal.html"><img class="fullImg" src="demo/theme3.jpg" /><p class="price">¥4999/起</p><div class="cnt"><p class="intro">描述描述描述描述描述描述描述描述描述描述</p><div class="info f-box"><div class="label f-flex">4卧室 | 家庭 | 婚礼 | 海景</div></div></div></a><button class="operateBtn sprite" data-am-modal="{target:\'#my-actions\'}"></button></li>', //html模板
                    over : false, //false表示还有数据,true表示数据全部加载完
                    msg : "矮油~您还没有收藏该类型的商品<br/>快把您喜欢的商品收藏起来吧~"  //若该条件下没有相关数据，或因条件不足而不能搜索相关数据，此参数设定的是此种情况下的提示文字，如不设定此参数或设定为空字符串，则默认会提示"对不起，没有查找到相关数据"
               }    	        			
       		}
       		else if($("#waterFall").hasClass("orderList")){
       			var data = {
                    html : '<li class="orderItem"><a class="link" href="mineOrderDetail.html"><p class="state">交易取消</p><p class="name f-toe">泰国双城（曼谷＋芭提雅）6天5晚自由行</p><p class="dest">泰国</p><div class="cnt1 f-box"><div class="img"><img src="demo/order1.jpg" /><p class="type">套餐</p></div><div class="info"><p>出行日期：2016/01/12</p><p>返程日期：2016/01/15</p><p>人数：3成人，1儿童</p></div></div><div class="cnt2 f-box"><p class="f-flex f-otvc">下单时间：2016/01/03</p><p class="total f-flex f-otvc">合计：<span class="color2">¥ 16677</span></p></div></a><div class="orderOperate f-box"><a class="btn btnH" disabled="disabled">关闭交易</a></div></li><li class="orderItem"><a class="link"href="mineOrderDetail.html"><p class="state">待付款</p><p class="name f-toe">泰国双城（曼谷＋芭提雅）6天5晚自由行</p><p class="dest">泰国</p><div class="cnt1 f-box"><div class="img"><img src="demo/order1.jpg"/><p class="type">套餐</p></div><div class="info"><p>出行日期：2016/01/12</p><p>返程日期：2016/01/15</p><p>人数：3成人，1儿童</p></div></div><div class="cnt2 f-box"><p class="f-flex f-otvc">下单时间：2016/01/03</p><p class="total f-flex f-otvc">合计：<span class="color2">¥16677</span></p></div></a><div class="orderOperate f-box"><a class="btn btnH orderCancel"href="abc.php">取消订单</a><a class="btn btnS"href="orderPay.html">去付款</a></div></li><li class="orderItem"><a class="link"href="mineOrderDetail.html"><p class="state">待付款</p><p class="name f-toe">泰国双城（曼谷＋芭提雅）6天5晚自由行</p><p class="dest">泰国</p></a><div class="cnt1 f-box"><div class="img"><img src="demo/order1.jpg"/><p class="type">套餐</p></div><div class="info"><p>出行日期：2016/01/12</p><p>返程日期：2016/01/15</p><p>人数：3成人，1儿童</p></div></div><div class="cnt2 f-box"><p class="f-flex f-otvc">下单时间：2016/01/03</p><p class="total f-flex f-otvc">合计：<span class="color2">¥16677</span></p></div><div class="orderOperate f-box"><a class="btn btnS"disabled="disabled">处理中...</a></div></li><li class="orderItem"><a class="link"href="mineOrderDetail.html"><p class="state">已支付</p><p class="name f-toe">【泰国苏梅岛】西拉别墅</p><p class="dest">泰国</p><div class="cnt1 f-box"><div class="img"><img src="demo/order2.jpg"/><p class="type">别墅</p></div><div class="info"><p>入住日期：2016/01/28</p><p>退房日期：2016/02/02</p><p>数量：1栋</p><p class="remark">5卧室，可住10人+3晚</p></div></div><div class="cnt2 f-box"><p class="f-flex f-otvc">下单时间：2016/01/03</p><p class="total f-flex f-otvc">合计：<span class="color2">¥10000</span></p></div></a><div class="orderOperate f-box"><a class="btn btnH orderRefund"data-am-modal="{target:\'#modal_orderRefund\'}">申请退款</a></div></li><li class="orderItem"><a class="link"href="mineOrderDetail.html"><p class="state">退款中</p><p class="name f-toe">新西兰霍比特人电影拍摄地霍比屯+怀托摩萤火虫.....</p><p class="dest">新西兰</p><div class="cnt1 f-box"><div class="img"><img src="demo/order3.jpg"/><p class="type">娱乐</p></div><div class="info"><p>开始日期：2016/01/28</p><p>游玩时间：15:50</p><p>人数：2成人，2儿童</p><p class="remark">潜水+攀冰</p></div></div><div class="cnt2 f-box"><p class="f-flex f-otvc">下单时间：2016/01/03</p><p class="total f-flex f-otvc">合计：<span class="color2">¥3259</span></p></div></a><div class="orderOperate f-box"><a class="btn btnH"disabled="disabled">申请退款</a></div></li><li class="orderItem"><a class="link"href="mineOrderDetail.html"><p class="state">交易关闭</p><p class="name f-toe">【曼谷廊曼国际机场-曼谷市区接机/送机（单程/......</p><p class="dest">泰国</p><div class="cnt1 f-box"><div class="img"><img src="demo/order1.jpg"/><p class="type">交通</p></div><div class="info"><p>使用日期：2016/01/12,2016/01/16</p><p>接机/送机时间：早上10:00，早上10:00</p><p>数量<span class="remark">（总计）</span>：2辆</p><p class="remark">接机+经济型5座，送机+经济型5座</p></div></div><div class="cnt2 f-box"><p class="f-flex f-otvc">下单时间：2016/01/01</p><p class="total f-flex f-otvc">合计：<span class="color2">¥278</span></p></div></a><div class="orderOperate f-box"><a class="btn btnH orderDelete">删除订单</a></div></li><li class="orderItem"><a class="link"href="mineOrderDetail.html"><p class="state">已完成</p><p class="name f-toe">新西兰霍比特人电影拍摄地霍比屯+怀托摩萤火虫.....</p><p class="dest">新西兰</p><div class="cnt1 f-box"><div class="img"><img src="demo/order2.jpg"/><p class="type">娱乐</p></div><div class="info"><p>开始日期：2016/01/28</p><p>游玩时间：10:30</p><p>人数：2成人，2儿童</p><p class="remark">潜水+攀冰+自助午餐</p></div></div><div class="cnt2 f-box"><p class="f-flex f-otvc">下单时间：2016/01/01</p><p class="total f-flex f-otvc">合计：<span class="color2">¥3259</span></p></div></a><div class="orderOperate f-box"><a class="btn btnH orderDelete"href="abc.php">删除订单</a><a class="btn btnS"href="review.html">去评价</a></div></li><li class="orderItem"><a class="link"href="mineOrderDetail.html"><p class="state">已完成</p><p class="name f-toe">新西兰霍比特人电影拍摄地霍比屯+怀托摩萤火虫.....</p><p class="dest">新西兰</p><div class="cnt1 f-box"><div class="img"><img src="demo/order3.jpg"/><p class="type">娱乐</p></div><div class="info"><p>开始日期：2016/01/28</p><p>游玩时间：10:30</p><p>人数：2成人，2儿童</p><p class="remark">潜水+攀冰+自助午餐</p></div></div><div class="cnt2 f-box"><p class="f-flex f-otvc">下单时间：2016/01/01</p><p class="total f-flex f-otvc">合计：<span class="color2">¥3259</span></p></div></a><div class="orderOperate f-box"><a class="btn btnH orderDelete"href="abc.php">删除订单</a></div></li>', //html模板
                    over : true, //false表示还有数据,true表示数据全部加载完
                    msg : "矮油~无相应订单数据喔~"  //若该条件下没有相关数据，或因条件不足而不能搜索相关数据，此参数设定的是此种情况下的提示文字，如不设定此参数或设定为空字符串，则默认会提示"对不起，没有查找到相关数据"
               }    	        			
       		}        		
       		/*此段为ajax测试硬编码数据，统一返回JSON格式数据，需删除_end*/
       		
            loader.loadDataHandle(data);
        /*}
    });*/
}

//日历价格信息_数据请求
function datePickerAjax(){
	loader = this;
    /*$.ajax({ //获取当前月的日程数据
        url : "",
        type : loader.ajaxType,
        dataType : loader.ajaxDateType,
        data : loader.ajaxParam,
        cache : loader.ajaxCache,
        beforeSend:function() {
            
        },
        success:function(data) { */  
        	
        	/*此段为ajax测试硬编码数据，统一返回JSON格式数据，需删除_start*/
        	if($(".datePicker_villa").length > 0){ //别墅
        		var data = [
	                {status:1,feeTotal:14143,feeBasic:13000,feeServe:620,feeTax:523,daysMin:1,bookMax:2},
	                {status:1,feeTotal:14143,feeBasic:13000,feeServe:620,feeTax:523,daysMin:1,bookMax:2},
	                {status:1,feeTotal:14143,feeBasic:13000,feeServe:620,feeTax:523,daysMin:1,bookMax:2},
	                {status:1,feeTotal:14143,feeBasic:13000,feeServe:620,feeTax:523,daysMin:1,bookMax:2},
	                {status:1,feeTotal:14143,feeBasic:13000,feeServe:620,feeTax:523,daysMin:1,bookMax:2},
	                {status:1,feeTotal:9000,feeBasic:8000,feeServe:500,feeTax:500,daysMin:3,bookMax:2},
	                {status:1,feeTotal:9000,feeBasic:8000,feeServe:500,feeTax:500,daysMin:3,bookMax:1},
	                {status:1,feeTotal:9000,feeBasic:8000,feeServe:500,feeTax:500,daysMin:3,bookMax:1},
	                {status:1,feeTotal:9000,feeBasic:8000,feeServe:500,feeTax:500,daysMin:3,bookMax:1},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:1,feeTotal:9000,feeBasic:8000,feeServe:500,feeTax:500,daysMin:3,bookMax:1},
	                {status:1,feeTotal:9000,feeBasic:8000,feeServe:500,feeTax:500,daysMin:3,bookMax:1},
	                {status:1,feeTotal:9000,feeBasic:8000,feeServe:500,feeTax:500,daysMin:3,bookMax:1},
	                {status:1,feeTotal:9000,feeBasic:8000,feeServe:500,feeTax:500,daysMin:3,bookMax:1},
	                {status:1,feeTotal:9000,feeBasic:8000,feeServe:500,feeTax:500,daysMin:3,bookMax:1},
	                {status:1,feeTotal:9000,feeBasic:8000,feeServe:500,feeTax:500,daysMin:3,bookMax:1},
	                {status:1,feeTotal:14143,feeBasic:13000,feeServe:620,feeTax:523,daysMin:3,bookMax:1},
	                {status:1,feeTotal:14143,feeBasic:13000,feeServe:620,feeTax:523,daysMin:3,bookMax:1},
	                {status:1,feeTotal:14143,feeBasic:13000,feeServe:620,feeTax:523,daysMin:3,bookMax:1},
	                {status:1,feeTotal:14143,feeBasic:13000,feeServe:620,feeTax:523,daysMin:3,bookMax:1},
	                {status:1,feeTotal:14143,feeBasic:13000,feeServe:620,feeTax:523,daysMin:3,bookMax:1},
	                {status:1,feeTotal:14143,feeBasic:13000,feeServe:620,feeTax:523,daysMin:3,bookMax:1},
	                {status:1,feeTotal:14143,feeBasic:13000,feeServe:620,feeTax:523,daysMin:3,bookMax:1},
	                {status:1,feeTotal:14143,feeBasic:13000,feeServe:620,feeTax:523,daysMin:3,bookMax:2},
	                {status:1,feeTotal:14143,feeBasic:13000,feeServe:620,feeTax:523,daysMin:3,bookMax:2}
	            ]; //status值为0表示不可预订，1表示可预订,feeTotal表示单日总费用（房费+服务费+税费），feeBasic表示房费，feeServe表示服务费，feeTax表示税费,daysMin表示最少预订天数,bookMax表示可预订最大数量(如果没有最大数量限制则无此字段
        	}
        	else if($(".datePicker_hotel").length > 0){ //酒店
        		var data = [
	                {status:1,feeTotal:450,daysMin:1},
	                {status:1,feeTotal:450,daysMin:1},
	                {status:1,feeTotal:450,daysMin:1},
	                {status:1,feeTotal:450,daysMin:1},
	                {status:1,feeTotal:450,daysMin:1},
	                {status:1,feeTotal:600,daysMin:1,bookMax:5},
	                {status:1,feeTotal:600,daysMin:1,bookMax:5},
	                {status:1,feeTotal:600,daysMin:1,bookMax:5},
	                {status:1,feeTotal:600,daysMin:1,bookMax:5},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:1,feeTotal:500,daysMin:1,bookMax:2},
	                {status:1,feeTotal:500,daysMin:1,bookMax:2},
	                {status:1,feeTotal:500,daysMin:1,bookMax:2},
	                {status:1,feeTotal:500,daysMin:1,bookMax:2},
	                {status:1,feeTotal:500,daysMin:1,bookMax:2},
	                {status:1,feeTotal:500,daysMin:1,bookMax:2},
	                {status:1,feeTotal:500,daysMin:1,bookMax:2},
	                {status:1,feeTotal:500,daysMin:1,bookMax:2},
	                {status:1,feeTotal:500,daysMin:1,bookMax:2},
	                {status:1,feeTotal:500,daysMin:1,bookMax:2},
	                {status:1,feeTotal:500,daysMin:1,bookMax:2},
	                {status:1,feeTotal:500,daysMin:1,bookMax:2},
	                {status:1,feeTotal:500,daysMin:1,bookMax:2},
	                {status:1,feeTotal:500,daysMin:1,bookMax:2},
	                {status:1,feeTotal:500,daysMin:1,bookMax:2},
	            ]; //status值为0表示不可预订，1表示可预订,feeTotal表示单日总费用（房费+服务费+税费）,daysMin表示最少预订天数,bookMax表示可预订最大数量(如果没有最大数量限制则无此字段)
        	}
        	else if($(".datePicker_meal").length > 0){ //套餐
        		var data = [
	                {status:1,daysRange:5,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500},{name:"baby",feeTotal:100}]},
	                {status:1,daysRange:5,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500},{name:"baby",feeTotal:100}]},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:1,daysRange:5,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500},{name:"baby",feeTotal:100}]},
	                {status:1,daysRange:5,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500},{name:"baby",feeTotal:100}]},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:1,daysRange:5,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500},{name:"baby",feeTotal:100}]},
	                {status:1,daysRange:5,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500},{name:"baby",feeTotal:100}]},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:1,daysRange:5,feeSet:[{name:"adult",feeTotal:1200},{name:"child",feeTotal:600},{name:"baby",feeTotal:100}]},
	                {status:1,daysRange:5,feeSet:[{name:"adult",feeTotal:1400},{name:"child",feeTotal:700},{name:"baby",feeTotal:100}]},
	                {status:0},
	                {status:0},
	                {status:0}
	            ]
	            //status值为0表示不可预订，1表示可预订,daysRange表示套餐行程天数，feeSet数组表示不同价格项的集合(其中name值与HTML属性映射关系，feeTotal表示费用)
        	}
        	else if($(".datePicker_amuse").length > 0){ //娱乐
        		var data = [
	                {status:1,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1000},{name:"child",feeTotal:500}]},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:1,feeSet:[{name:"adult",feeTotal:1200},{name:"child",feeTotal:600}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1200},{name:"child",feeTotal:600}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1400},{name:"child",feeTotal:700}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1400},{name:"child",feeTotal:700}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1400},{name:"child",feeTotal:700}]},
	                {status:1,feeSet:[{name:"adult",feeTotal:1400},{name:"child",feeTotal:700}]}
	            ]
	            //status值为0表示不可预订，1表示可预订,feeSet数组表示不同价格项的集合(其中name值与HTML属性映射关系，feeTotal表示费用)
        	}
        	else if($(".datePicker_traffic").length > 0){ //交通
        		var data = [
	                {status:1,feeSet:[{name:"unit",feeTotal:139}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:139}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:139}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:139}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:139}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:139}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:139}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:139}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:139}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:139}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:139}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:139}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:139}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:139}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:139}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:139}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:139}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:139}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:139}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:139}]},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:0},
	                {status:1,feeSet:[{name:"unit",feeTotal:150}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:150}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:200}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:200}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:200}]},
	                {status:1,feeSet:[{name:"unit",feeTotal:200}]}
	            ]
	            //status值为0表示不可预订，1表示可预订，feeTotal表示费用
        	}
            /*此段为ajax测试硬编码数据，统一返回JSON格式数据，需删除_end*/
            
            loader.loadDataHandle(data);
        /*},
        error:function(data) {
            alert("您的网络出问题啦！");
        }
    })*/
}