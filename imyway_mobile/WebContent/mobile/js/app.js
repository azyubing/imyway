//var baseUrl = "http://139.196.38.172:8080/imywaytest/mobile/";
var baseUrl = "http://localhost:8080/imyway/mobile/";

(function($) {
  	$(function() {
  		$(window).smoothScroll({speed:10});
  		
  		//表单-表单验证带错误提示
	    if($('#form-verify-msg').length > 0){
	    	formVerifyMsg();
	    }
	    //表单-表单控件内容清除
	    if($(".fieldClear").length > 0){
	    	$(".fieldClear").siblings(".am-form-field").each(function(){
	    		$(this).val() == "" ? $(this).siblings(".fieldClear").hide() : $(this).siblings(".fieldClear").show();
	    	})
	    	$(".fieldClear").siblings(".am-form-field").keyup(function(){
	    		$(this).val() == "" ? $(this).siblings(".fieldClear").hide() : $(this).siblings(".fieldClear").show();
	    	}).change(function(){
	    		$(this).val() == "" ? $(this).siblings(".fieldClear").hide() : $(this).siblings(".fieldClear").show();
	    	})    
	    	$(".fieldClear").click(function(){
	    		var _this = $(this);
	    		_this.hide();
	    		_this.siblings(".am-form-field").val("").removeClass("am-field-valid am-active").focus();
	    		_this.parents(".am-form-group").removeClass("am-form-success");
	    	})
	    }
	    
  		//首页-toggle搜索框
	    $('#searchOpen').on('click', function() {
	    	$(".searchBox .mask").height($(window).height());
	      	$(".searchBox").toggle();
	      	if($(".searchBox").parent(".am-sticky-placeholder").length > 0){
	      		$(".searchBox").parent(".am-sticky-placeholder").height(0);
	      	}
	    });
	    $('.searchBox .mask').on('click', function() {
	    	$(".searchBox").hide();
	      	if($(".searchBox").parent(".am-sticky-placeholder").length > 0){
	      		$(".searchBox").parent(".am-sticky-placeholder").height(0);
	      	}
	    });
	    
	    //筛选下拉框遮罩
	    $('.am-dropdown').on('opened.dropdown.amui', function (e) {
    		$("#dropdownMask").show();
      		//$("body").addClass("pageHidden");
	    });
	    $('.am-dropdown').on('closed.dropdown.amui', function (e) {
	      	$("#dropdownMask").hide();
	      	//$("body").removeClass("pageHidden");
	      	//筛选条件值还原设置为当前使用的参数值
	      	if($(".filtrateList").length > 0){
	      		$(".filtrateList").each(function(){
	      			$(this).find("a[href='"+waterFallData[$(this).data("name")]+"']").tabClass("am-active");
			    })
	      	}
	    });
	    $("#dropdownMask").on('click', function() {
	    	$('.am-dropdown').dropdown('close');
	    });    
	    
	    //订单操作
	    $(".orderList, .orderDetail").delegate(".orderCancel","click",function(){
	    	modal_confirm("你，确定要取消该订单吗？");
	    	modal_confirm_handle_order(this);
	    	return false;
	    })
	    $(".orderList, .orderDetail").delegate(".orderDelete","click",function(){
	    	modal_confirm("你，确定要删除该订单吗？");
	    	modal_confirm_handle_order(this);
	    	return false;
	    })
	    
	    //收藏添加/取消
	    $(".collectList").delegate(".operateBtn","click",function(){
	    	window.cancelCollectId = $(this).parents("li").data("id");
	    })
	    $("#collectCancel").click(function(){
	    	collectToggle(cancelCollectId,0);
	    })
	    $("#collectBtn").click(function(){
	    	collectToggle($(this).data("id"),$(this).hasClass("collected") ? 0 : 1);
	    })
      	
	    //个人中心-获取验证码
	    $("#getCaptcha").click(function(){
	    	getCaptcha($(this));         
       	})
	    
	    //个人中心-上传头像预览
	    if($(".imgUpload").length > 0){
	    	$(".imgUpload .fileInput").localResizeIMG({
	         	quality: 0.8,
	         	success: function (result,inputElm) {
	                updatePrt(result,inputElm);
	         	}
	     	});    
	    }
	    
	    //产品详情-根据哈希值跳转到锚点特定区域
	    if(location.href.split("#?")[1]){
	    	$("#"+location.href.split("#?")[1]).addClass("am-active").find(".am-accordion-bd").addClass("am-in");
	    	setTimeout(function(){
	    		$(window).smoothScroll({speed:10,position:$(document).height() - $(window).height()});
	    	},100)
	    }
	    
	    //产品详情-房型查看
	    $("#roomSelect").change(function(){
	    	var index = $(this).next(".am-selected").find(".am-selected-list>li.am-checked").index();
	    	$("#roomTables>table").eq(index).addClass("am-active").siblings("table").removeClass("am-active");
	    })
	    
	    //分页数据加载的页面
//	    if($("#waterFall").length > 0){
//	    	waterFall();
//	    }

  	});
})(jQuery);

//分页数据加载
function waterFall(){
	self = this;
	self.config = function(){
		this.setBind();
		this.begin();
	}
	self.setBind = function(){
		//下滑分页加载
        $(window).bind('scroll',self.scrollReload);
        //下拉列表项切换
        $(".am-dropdown-content").delegate("li","click",function(){
        	if(!$(this).hasClass("am-active")){
        		$(this).tabClass("am-active");
	        	$(".paramCur[for='"+$(this).parent().attr("id")+"']").text($(this).find("a").text());
	        	$(window).smoothScroll({speed:10});
	    		self.begin();
        	}
        	$('.am-dropdown').dropdown('close');
        	return false;
        })
        //搜索关键字切换
        $("#searchBtn").click(function(){
        	if($("#searchField").val() != waterFallData[$("#searchField").data("name")]){
        		$('.am-dropdown').dropdown('close');
        		$(window).smoothScroll({speed:10});
        		self.begin();
        		return false;
        	}
        })
        //更多筛选条件切换
        $(".filtrateItem>.list>a").click(function(){
        	$(this).tabClass("am-active");
        	return false;
        })
        $("#filtrateBtn").click(function(){
        	$(".filtrateList").each(function(){
      			if($(this).find("a.am-active").attr("href") != waterFallData[$(this).data("name")]){
    				$(window).smoothScroll({speed:10});  
		        	self.begin();
        			return false;      	
      			}
		    })	
        	$('.am-dropdown').dropdown('close');
        })
        //订单选项卡切换
        $("#orderTab>li").click(function(){
        	if(!$(this).hasClass("am-active")){
        		$(this).tabClass("am-active");
        		$(window).smoothScroll({speed:10});
	    		self.begin();
        	}
        	return false;
        })
	}
    self.begin = function(){
		self.paramInit();
        self.loadData();
    }
    self.paramInit = function(){
        self.listElm = $("#waterFall");
        self.loadElm = $("#pageLoading");
        self.ajaxType = "get";
        self.ajaxDateType = "json";
        self.ajaxParam = self.getAjaxParam();
        self.ajaxCache = false;
        self.ajaxLock = true;
        self.ajaxPage = 1;
        self.listElm.empty();
		//console.log(self.ajaxParam)
    }
    self.getAjaxParam = function (){
    	var waterFallData = new Object();
    	$(".dropdownSelect").each(function(){
	    	waterFallData[$(this).data("name")] = $(this).find("li.am-active>a").attr("href");
	    })
		$(".filtrateList").each(function(){
	    	waterFallData[$(this).data("name")] = $(this).find("a.am-active").attr("href");
	    })
		if($("#searchField").length > 0){
			waterFallData[$("#searchField").data("name")] = $("#searchField").val();
		}
		if($("#orderTab").length > 0){
			waterFallData[$("#orderTab").data("name")] = $("#orderTab>li.am-active>a").attr("href");
		}
		return waterFallData;
    }
    self.scrollReload = function() {
        var wh = parseInt($(window).height());
        var ws = parseInt($(window).scrollTop());
        var dh = document.body.scrollHeight;
        if( dh - 90 <= wh + ws && !self.ajaxLock){
            self.ajaxLock = true;
            setTimeout(function(){
                self.ajaxPage++;
                self.loadData();
            },1000);
        }
    }
    self.loadData = waterFallAjax;
    self.loadDataHandle = function(data){
    	$(".resultNull").remove();
	    if(!data.html || data.html == ""){
	    	if(self.ajaxPage <= 1){ //表示条件改变
	    		var text = data.msg || "对不起，没有查找到相关数据";
	            self.listElm.after('<p class="resultNull">'+text+'</p>');
	            self.listElm.hide();
	    	}
	    }
	    else{
	        self.listElm.append(data.html).show();
	        //如果存在星级HTML
	        if($(".starLv").length > 0){
	        	setStarHtml();                 	
	        }
	    }
	    if(!data.over){
	        self.ajaxLock = false;
	        self.loadElm.removeClass("loading").show().find(".text").text("上拉有更多信息");
	    }
	    else{
	        self.ajaxLock = true;
	        $(window).unbind('scroll',self.scrollReload);
	        if((!data.html || data.html == "") && self.ajaxPage <= 1){
	        	self.loadElm.hide();
	        }
	        else{
	        	self.loadElm.removeClass("loading").show().find(".text").text("没有更多了");
	            setTimeout(function(){
	                self.loadElm.hide();
	            },3000);
	        }
	    }
    }
    self.config();
}

//获取验证码
function getCaptcha(dom){
	var _this = dom; 
	if(_this.hasClass("am-active")){
	    return false;
	}     
	var phone = $("#phone").val().replace(/\s/g, ""); 
	if(typeof(phone) !== 'undefined'){
	    if(phone == ""){
	        alert('请填写您的手机号');
	        return false;
	    } 
	    var regu = /^\s*1\d{10}\s*$/;
	    var re = new RegExp(regu);
	    if (!re.test(phone)) {
	        alert("请输入正确的手机号");
	        return false;
	    }
	} 
	var cd = _this.data("cd")-1;
	_this.addClass("am-active").text(cd+"秒后重发");
	var st = setInterval(function(){
	    --cd;             
	    _this.addClass("am-active").text(cd+"秒后重发");
	    if(cd <= 0){
	        _this.removeClass("am-active").text("获取验证码");
	        clearInterval(st);
	    }
	},1000)
	ajax_getCaptcha();
}

//设置星级HTML
function setStarHtml(){
	$(".starLv").each(function(){
		if(!$(this).html()){
			var startHtml = "";
			var lv = $(this).data("lv");
			for(var i = 1; i <= 5; i ++){
				if(i <= parseInt(lv)){
					startHtml += '<span class="am-icon-star"><span class="am-icon-star" style="width:100%;"></span></span>';
				}
				else if(i <= parseInt(lv)+1){
					startHtml += '<span class="am-icon-star"><span class="am-icon-star" style="width:'+lv%1*100+'%;"></span></span>';
				}
				else{
					startHtml += '<span class="am-icon-star"><span class="am-icon-star"></span></span>';
				}
			}
			$(this).html(startHtml);
		}		
	})
}

//modal_confirm
function modal_confirm(text){
	if($("#modal_confirm").length <= 0){
		$("body").append('<div class="am-modal am-modal-confirm" tabindex="-1" id="modal_confirm" style="display:block;"><div class="am-modal-dialog"><div class="am-modal-bd">' + (text || '你，确定要执行该操作吗？') + '</div><div class="am-modal-footer"><span class="am-modal-btn" data-am-modal-cancel>取消</span><span class="am-modal-btn" data-am-modal-confirm>确定</span></div></div></div>');
	}
	else{
		$("#modal_confirm").find(".am-modal-bd").html(text || '你，确定要执行该操作吗？');
	}
	setTimeout(function(){
		$("#modal_confirm").addClass("am-modal-active");
	},50)
}

//modal_alert
function alert(text){
	if($("#modal_alert").length <= 0){
		$("body").append('<div class="am-modal am-modal-confirm" tabindex="-1" id="modal_alert" style="display:block;"><div class="am-modal-dialog"><div class="am-modal-bd">' + (text || '你，确定要执行该操作吗？') + '</div><div class="am-modal-footer"><span class="am-modal-btn">确定</span></div></div></div>');
	}
	else{
		$("#modal_alert").find(".am-modal-bd").html(text || '你，确定要执行该操作吗？');
	}
	$('#modal_alert').modal()
	setTimeout(function(){
		$("#modal_alert").addClass("am-modal-active");
	},50)
}

//表单验证-带错误提示
function formVerifyMsg(){
	$('#form-verify-msg').validator({
	    onValid: function(validity) {
	      	$(validity.field).closest('.am-form-group').find('.am-alert').hide();
	    },
	    onInValid: function(validity) {
	      	var $field = $(validity.field);
	      	var $group = $field.closest('.am-form-group');
	      	var $alert = $group.find('.am-alert');
	      	// 使用自定义的提示信息 或 插件内置的提示信息
	      	var msg = $field.data('validationMessage') || this.getValidationMessage(validity);	
	      	if (!$alert.length) {
	        	$alert = $('<div class="am-alert am-alert-danger"></div>').hide().
	          	appendTo($group);
	      	}	
	      	$alert.html(msg).show();
	    },
	    submit: function() {
	    	
		    var formValidity = this.isFormValid();
		    var formData = formFieldPackage($(this.$element.context).find("[name]"));
		    if(formValidity){
		    	console.log(formData)
		    	$.ajax({
				     url: baseUrl+"login.do",
				     type: "post",
				     context: "imywaytest",
				     dataType: "json",
				     data: {loginName:"junking1983", password:"123"},
				     success: function(data) {
				    	 if (data.status == 'success') {
				    	 	alert(data.message);
				    	 }
				    	 else{
				    	 	alert(data.message);
				    	 }
				     },
				     error: function(XMLHttpRequest, textStatus, errorThrown) {
				    	 alert(textStatus);
				     }
				});
		    }
		    return false;
	  	}
  	});
}

//表单数据对象打包
function formFieldPackage(fields){
	var data = new Object();
	fields.each(function(i,item){
		data[item.name] = item.value;
	})
	return data;
}

//通用验证
function checkForm(form){
    var returnVal = true;  //表单是否可提交
    var formElm = $(form);  //验证的当前表单  
	if(formElm.find("[type='submit']").val() == "提交中..."){
		return false;
	}
    var submitItems = formElm.find("[name]");  //表单所有提交项

    submitItems.each(function(i,item){
        if($(item).attr("data-tipNull")){  //为必填项
            if($(item).attr("type") == "text" || $(item).attr("type") == "password" || $(item).attr("type") == "hidden" || $(item).attr("type") == "file" || $(item).attr("type") == "number" || $(item)[0].tagName == "SELECT" || $(item)[0].tagName == "TEXTAREA"){
                var itemVal = $(item).val();
                if(!itemVal || itemVal.replace(/\s/g, "") == ""){
                    alert($(item).attr("data-tipNull"));
                    returnVal = false;
                    return false;
                }
            }
            if($(item).attr("type") == "radio" || $(item).attr("type") == "checkbox"){
                if(!formElm.find('[name="'+$(item).attr("name")+'"]:checked').val()){
                    alert($(item).attr("data-tipNull"));
                    returnVal = false;
                    return false;
                }
            }
            if($(item)[0].tagName == "SELECT" && ($(item).val() == "请选择省" || $(item).val() == "请选择市" || $(item).val() == "请选择区")){
                alert($(item).attr("data-tipNull"));
                returnVal = false;
                return false;
            }
        }
        if($(item).attr("data-reg")){  //填写不符合正则规则
            var itemVal = $(item).val().replace(/\s/g, "");
            if(itemVal != "" && itemVal != null){
                var regu = eval($(item).attr("data-reg"));
                var re = new RegExp(regu);
                if (!re.test(itemVal)) {
                    alert($(item).attr("data-tipReg"));
                    returnVal = false;
                    return false;
                }
            }
        }
        //两次输入不一致(仅限一个比较项)
        if(submitItems.filter("[data-same]").length > 0){
            var itemSameVal1 = submitItems.filter("[data-same]").eq(0).val().replace(/\s/g, "");
            var itemSameVal2 = submitItems.filter("[data-same]").eq(1).val().replace(/\s/g, "");    
            if(itemSameVal1 != "" && itemSameVal2 != "" ){  
                if(itemSameVal1 != itemSameVal2){
                    alert(submitItems.filter("[data-same]").eq(1).attr("data-tipSame"));
                    returnVal = false;
                    return false;
                }
            }
        }
    }) 
	
	if(returnVal){
		formElm.find("[type='submit']").val("提交中...");
		$("body").append('<div style="position:fixed;z-index:1000;left:0;top:0;width:100%;height:100%;"><div style="position:absolute;left:50%;top:50%;width:120px;height:120px;margin:-60px 0 0 -60px;background-color:rgba(0,0,0,0.5);border-radius:10px;"><img style="display:block;width:62px;height:62px;margin:15px auto 8px auto;" src="images/loading.gif"><p style="color:#FFF;text-align:center;font-size:22px;">提交中</p></div></div>')
	}

    return returnVal;
}

jQuery.fn.extend({
	//添加类名并且清除同类该类名
	tabClass:function(className) {
		return this.each(function(){
			$(this).addClass(className).siblings().removeClass(className)
		})
	}
})