function orderDatePicker(){
	self = this;
	self.config = function(){
		self.setData();
		self.setView();
		self.setBind();
		self.begin();
	}
	self.setView = function(){
        $(".propItems").each(function(){
        	var $this = $(this);
        	var id = $this.attr("for");
        	var val = $(".propItemsField#"+id).val();
        	if(val != ""){
        		$this.find("li[data-value='"+val+"']").tabClass("am-active");
        	}
        	else{
        		if(this.hasAttribute("data-default")){
        			var activeElm = $this.find("li").first();
        			activeElm.tabClass("am-active");
        			$(".propItemsField#"+id).val(activeElm.data("value"));
        		}
        	}
	    }) 
	    if(self.calendarData.dateSelect){
	    	$(".counterItem").find(".price").show();
	    }
	    self.setDateShow();
	}
	self.setData = function(){
		//本地应用数据
		var todayDate = new Date();
        self.calendarData = new Object(); 
	    self.calendarData.yearCur = todayDate.getFullYear();; //当天_年
	    self.calendarData.monthCur = todayDate.getMonth()+1; //当天_月
	    self.calendarData.dayCur = todayDate.getDate(); //当天_日
	    self.calendarData.weekFirst = new Date(self.calendarData.yearCur+'-'+self.calendarData.monthCur+'-1').getDay(); //本月1号的星期
	    if($("#feild_dateSelect").val() != ""){ //选中日期
	    	self.calendarData.dateSelect = $("#feild_dateSelect").val().split("-");
	    	self.calendarData.weekFirst = new Date(self.calendarData.dateSelect[0]+'-'+self.calendarData.dateSelect[1]+'-1').getDay();
	    }
	    else{
	    	self.calendarData.dateSelect = null;
	    }
	    self.calendarData.data = null; //当前月份json数据
	    //ajax日历提交数据
	    self.datePickerData = new Object(); 
	    if(self.calendarData.dateSelect){
	    	self.datePickerData.year = self.calendarData.dateSelect[0];
			self.datePickerData.month = self.calendarData.dateSelect[1];
	    }
	    else{
	    	self.datePickerData.year = self.calendarData.yearCur;
			self.datePickerData.month = self.calendarData.monthCur;
	    }
		self.datePickerData.code = $("#pdtCode").val();
    	//ajax配置项
	    self.ajaxType = "post";
        self.ajaxDateType = "json";
        self.ajaxCache = false;
        self.ajaxLock = true;
	}
	self.setBind = function(){
		//月份切换
		$("#monthPrev").click(function(){
	        if(self.datePickerData.year <= self.calendarData.yearCur && self.datePickerData.month <= self.calendarData.monthCur){
	            return false;
	        }
	        if(self.datePickerData.month > 1){
	            self.datePickerData.month--;
	        }
	        else{
	            self.datePickerData.month = 12;
	            self.datePickerData.year--;
	        }      
	        self.calendarData.weekFirst = new Date(self.datePickerData.year+'-'+self.datePickerData.month+'-1').getDay();
	        self.setDateShow();
	        self.begin();
	    })
	    $("#monthNext").click(function(){ 
	        if(self.datePickerData.month < 12){
	            self.datePickerData.month++;
	        }
	        else{
	            self.datePickerData.month = 1;
	            self.datePickerData.year++;
	        }  
	        self.calendarData.weekFirst = new Date(self.datePickerData.year+'-'+self.datePickerData.month+'-1').getDay();
	        self.setDateShow();
	        self.begin();
	    })
	    //规格项切换
        $(".propItems>li").click(function(){
        	var $this = $(this);
        	if(!$this.hasClass("am-active")){
        		$this.tabClass("am-active");
        		$("#"+$this.parent().attr("for")).val($this.data("value"));
        		if($this.parent()[0].hasAttribute("data-default")){
        			self.resetData();
        			self.begin();
        		}
        	}
        	return false;
        })   
	    //计数器
	    $(".numAdd").click(function(){
	    	self.counterAdd($(this).parents(".counterItem"));
	    })
	    $(".numReduce").click(function(){
	    	self.counterReduce($(this).parents(".counterItem"));
	    }) 
	    //选择日期
        $("#monthDate").delegate("li","click",function(){
	    	var $this = $(this);	    	      	
        	var year = self.datePickerData.year;
        	var month = self.datePickerData.month;
        	var day = parseInt($this.text());  
	        if(!$this.hasClass("valid")){
	            return false;
	        }
	        else{
        		$this.tabClass("booked");
        		self.calendarData.dateSelect = [year,month,day];
        		$("#feild_dateSelect").val(year+"-"+month+"-"+day);
        		var priceData = self.calendarData.data[$this.attr("no")-1].feeSet;
        		for(var i = 0; i < priceData.length; i ++){
        			$(".feeType[for='fee_"+priceData[i].name+"']").val(priceData[i].feeTotal).parents(".price").show();
        		}
        		self.feeTotal();
	        }
	    })
	}
	self.begin = function(){
        self.getAjaxParam();
        self.loadData();
    }
	self.getAjaxParam = function (){  	
		$(".propItemsField").each(function(){
			var $this = $(this);
			self.datePickerData[$this.attr("name")] = $this.val();
		})
		console.log(self.datePickerData)
	}
    //商品数量增加
	self.counterAdd = function(dom){
	    var fieldElm = dom.find(".numField");
	    var num = parseInt(fieldElm.val());
	    fieldElm.val(++num);
	    self.feeTotal();
	}	
	//商品数量减少
	self.counterReduce = function(dom){
	    var fieldElm = dom.find(".numField");
	    var num = parseInt(fieldElm.val());
	    if(num > fieldElm.data("min")){
	    	fieldElm.val(--num);
	    	self.feeTotal();
	    }
	}
	//总费用计算
	self.feeTotal = function(fee){
		var feeTotal = 0;
		if(self.calendarData.dateSelect){
			$(".counterItem").each(function(){
				var num = $(this).find(".numField").val();
				var price = $(this).find(".feeType").val();
				feeTotal += price*num; 	
			})
		}
		$("#feeTotal").text(feeTotal);
		$("#feild_feeTotal").val(feeTotal);
	}
	self.loadData = datePickerAjax;
	self.loadDataHandle = function(data){ 
		self.calendarData.data = data;
		self.setDatePickerHtml();
		self.feeTotal();
	}
	//重置日历数据
	self.resetData = function(){
		self.calendarData.dateSelect = null;
		$("#feild_dateSelect").val("");
		$(".counterItem").find(".price").hide();
	}
	//获得月份的天数
    self.getDays = function(){
        var daysArray = [31,28,31,30,31,30,31,31,30,31,30,31];
        if(self.datePickerData.month == 2 && self.isLeapYear()){
            return 29;  
        }
        else{ 
            return daysArray[self.datePickerData.month-1];
        }
    }
    //判断是否为闰年
    self.isLeapYear = function(){
    	var year = self.datePickerData.year;
        if((year%4 == 0 && year%100 != 0) || year%400 == 0){
            return true;
        }
        else{
            return false;
        }
    }
    //年月显示
    self.setDateShow = function(){
        $("#year").text(self.datePickerData.year);
        $("#month").text(self.datePickerData.month);
    }
	//生成日历当前月份HTML
	self.setDatePickerHtml = function(){
		var days = self.getDays(); 
		var data = self.calendarData.data;
	    var dateHtml = "";
	    var classIndex = 0;
	    var num = 1;
		for(var i = 1; i <= 42; i ++){
	        if(i <= 7){
	            if(i < self.calendarData.weekFirst){
	                dateHtml += '<li class="null"></li>';
	            }
	            else{
	                dateHtml += self.getHtmlLogic(data,classIndex,num);
	                classIndex++;  
	                num++;
	            }
	        }
	        else{
	            if(num > days){
	                dateHtml += '<li class="null"></li>';
	            }
	            else{
	                dateHtml += self.getHtmlLogic(data,classIndex,num);
	                classIndex++; 
	            } 
	            num++;
	        }
	    }
	    $("#monthDate").html(dateHtml);	
	}
	self.getHtmlLogic = function(data,classIndex,day){
		var dateHtml = "";
		var dateSelect = self.calendarData.dateSelect;
		var year = self.datePickerData.year;
		var month = self.datePickerData.month;
		if(data[classIndex].status == 0){
            dateHtml += '<li no="'+day+'" class="invalid"><p class="day">'+(day < 10 ? "0"+day : day)+'</p></li>';
        }
        else if(data[classIndex].status == 1){  
        	if(dateSelect && dateSelect[0] == year && dateSelect[1] == month && dateSelect[2] == day){
        		dateHtml += '<li no="'+day+'" class="valid booked">';
        	}
        	else{
        		dateHtml += '<li no="'+day+'" class="valid">';
        	}
        	dateHtml += '<p class="day">'+(day < 10 ? "0"+day : day)+'</p></li>';
        }
        return dateHtml;
	}
}

$(function(){
	var odp = {};
	orderDatePicker.call(odp);
	odp.config();
})