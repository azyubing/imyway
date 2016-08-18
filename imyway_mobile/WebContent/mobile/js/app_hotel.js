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
	    if($("#feild_dateStart").val() != "" && $("#feild_dateEnd").val() != ""){ //入住日期
	    	var dateStart = $("#feild_dateStart").val().split("-");
	    	var dateEnd = $("#feild_dateEnd").val().split("-");
	    	self.calendarData.weekFirst = new Date(dateStart[0]+'-'+dateStart[1]+'-1').getDay();
	    	self.calendarData.dateStart = [dateStart[0],dateStart[1],dateStart[2]];
	    	self.calendarData.dateEnd = [dateEnd[0],dateEnd[1],dateEnd[2]];
	    }
	    else{
	    	self.calendarData.dateStart = null;
		    self.calendarData.dateEnd = null;
	    }
	    self.calendarData.dateStartElm = null;
	    self.calendarData.dateEndtElm = null;
	    self.calendarData.daysGap = new Array(); //开选中区间是否存在无效日期
	    if($("#feild_daysData").val() != ""){ //选中区间的日期数据
	    	self.calendarData.daysData = JSON.parse($("#feild_daysData").val());
	    }
	    else{
	    	self.calendarData.daysData = new Array();
	    }
	    self.calendarData.daysMin = 1; //最少预订天数
	    self.calendarData.bookMax = null; //可预订最大数量
	    self.calendarData.data = null; //当前月份json数据
	    //ajax日历提交数据
	    self.datePickerData = new Object(); 
	    if($("#feild_dateStart").val() != "" && $("#feild_dateEnd").val() != ""){
	    	self.datePickerData.year = self.calendarData.dateStart[0];
			self.datePickerData.month = self.calendarData.dateStart[1];
			self.setBookMax();
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
	        self.setDaysGap("prev");
	        self.setDaysData("prev");
	        self.calendarData.weekFirst = new Date(self.datePickerData.year+'-'+self.datePickerData.month+'-1').getDay();
	        self.setDateShow();
	        self.begin();
	    })
	    $("#monthNext").click(function(){  
	        self.setDaysGap("next");
	        self.setDaysData("next");
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
        	var dateStart = self.calendarData.dateStart;
        	var dateEnd = self.calendarData.dateEnd;
        	var year = self.datePickerData.year;
        	var month = self.datePickerData.month;
        	var day = parseInt($this.text());  
        	var data = self.calendarData.data;
	        if(!$this.hasClass("valid")){
	            return false;
	        }
	        else{
        		if(dateStart){
        			if(dateEnd){
        				self.resetData();
	        			self.calendarData.dateStart = [year,month,day];
	        			self.calendarData.dateStartElm = $this;	  
	        			//最少预订天数
			        	self.calendarData.daysMin = data[day-1].daysMin;
        			}
        			else{
        				//结束日期与开始日期为同一天
        				if(dateStart[0] == year && dateStart[1] == month && dateStart[2] == day){
			        		return false;
				        } 
				        //结束日期早于开始日期
				        if( year < dateStart[0] || (year == dateStart[0] && month < dateStart[1]) || (year == dateStart[0] && month == dateStart[1] && day < dateStart[2]) ){ 
				        	alert("退房日期不能早于入住日期")
				        	self.resetData();
							self.setDatePickerHtml();
			        		return false;
				        }
				        //是否包含不可预约日期
				        if(self.calendarData.daysGap.length > 0){
				        	alert("所选区间包含不可预约的日期，请重新选择时间段")
							self.resetData();
							self.setDatePickerHtml();
	        				return false;
				        }
				        else{
				        	var sdate = 0;
				        	month == dateStart[1] ? sdate = self.calendarData.dateStart[2] : "";
				        	for(var i = sdate; i < day-1; i ++){
	        					if(!self.calendarData.data[i].status){
	        						alert("所选区间包含不可预约的日期，请重新选择时间段")
        							self.resetData();
	    							self.setDatePickerHtml();
			        				return false;
	        					}
	        				}  
				        }
        				self.calendarData.dateEnd = [year,month,day];
        				self.calendarData.dateEndElm = $this;   
        				//低于预订最少天数
        				if(self.daysCount() < self.calendarData.daysMin){
        					alert("最少预定天数为"+self.calendarData.daysMin+"天")
    						self.resetData();
							self.setDatePickerHtml();
			        		return false;
        				}
        				//保存选择的日期区间数据
        				self.setDaysData();
        				//可预订最大数量
        				self.setBookMax();
        			}      			
        			self.setDatePickerHtml();
        		}
        		else{
    				self.resetData();
        			self.calendarData.dateStart = [year,month,day];
        			self.calendarData.dateStartElm = $this;	  
        			//最少预订天数
			        self.calendarData.daysMin = data[day-1].daysMin;
        			self.setDatePickerHtml();
        		}
	        	//console.log("开始："+self.calendarData.dateStart+" 结束："+self.calendarData.dateEnd+" 是否存在间断："+self.calendarData.daysGap+" 最少预订天数："+self.calendarData.daysMin+" 可预订最大数量："+self.calendarData.bookMax)
	        }
	    })
	}
	//可预订最大数量
	self.setBookMax = function(){
		var daysData = self.calendarData.daysData;
		for(var i = 0; i < daysData.length; i ++){
			var daysDataMonth = daysData[i][2];
			for(var j = 0; j < daysDataMonth.length; j ++){
				if(daysDataMonth[j].bookMax){
		        	if(self.calendarData.bookMax){
		        		if(daysDataMonth[j].bookMax < self.calendarData.bookMax){
		        			self.calendarData.bookMax = daysDataMonth[j].bookMax;
			        		$("#field_num").data("max",self.calendarData.bookMax);
		        		}
			        }
			        else{
			        	self.calendarData.bookMax = daysDataMonth[j].bookMax;
			        	$("#field_num").data("max",self.calendarData.bookMax);
			        }
		        }
				if(self.calendarData.bookMax && self.calendarData.bookMax <= 1){
					break;
				}
			}    					
		}
		if(self.calendarData.bookMax && parseInt($("#field_num").val()) > self.calendarData.bookMax){
			$("#field_num").val(self.calendarData.bookMax);
		}
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
	}
    //商品数量增加
	self.counterAdd = function(dom){
	    var fieldElm = dom.find(".numField");
	    var num = parseInt(fieldElm.val());
	    var max = dom.find(".numField").data("max");
		if(max && max <= num){
			alert("最多可预定"+max+"间")
			return;
		}
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
	//天数计算
	self.daysCount = function(){
		var num = 0;
		var dateStart = self.calendarData.dateStart;
		var dateEnd = self.calendarData.dateEnd;
		if(dateStart && dateEnd){
			var d1 = new Date(dateStart[0],dateStart[1]-1,dateStart[2]);
		 	var d2 = new Date(dateEnd[0],dateEnd[1]-1,dateEnd[2]);
		 	num = (d2.getTime()-d1.getTime())/(1000*3600*24);
		}
		return num;
	}
	//总费用计算
	self.feeTotal = function(fee){
		var feeTotal = 0;
		if(self.calendarData.dateStart && self.calendarData.dateEnd){
			var daysData = self.calendarData.daysData;
			for(var i = 0; i < daysData.length; i ++){
				var daysDataMonth = daysData[i][2];
				for(var j = 0; j < daysDataMonth.length; j ++){
					feeTotal += daysDataMonth[j].feeTotal;
				}    					
			}
			var num = parseInt($("#field_num").val());
			feeTotal = feeTotal*num;
		}
		$("#feeTotal").text(feeTotal);
		$("#feild_feeTotal").val(feeTotal);
	}
	self.loadData = datePickerAjax;
	self.loadDataHandle = function(data){ 
		self.calendarData.data = data;
		self.setDatePickerHtml();
	}
	//保存待选择日期数据
	self.setDaysData = function(flag){
		var dateStart = self.calendarData.dateStart;
		var dateEnd = self.calendarData.dateEnd;
		var year = self.datePickerData.year;
		var month = self.datePickerData.month;
		var daysData = self.calendarData.daysData;
		var data = self.calendarData.data;
		if(!dateStart || $("#daysNum").text() > 0){
			return;
		}
		if(flag == "prev"){
			for(var i = 0; i < daysData.length; i ++){
				if(year == daysData[i][0] && month == daysData[i][1]){
					daysData.splice(i,1);
					break;
				}
			}
		}
		else if(flag == "next"){
			if(month == dateStart[1]){
				daysData.push([year,month,data.slice(dateStart[2]-1)]);
			}
			else{
				daysData.push([year,month,data]);
			}
		}
		else{
			if(dateEnd[1] == dateStart[1]){
				daysData.push([year,month,data.slice(dateStart[2]-1,dateEnd[2]-1)]);
			}
			else{
				daysData.push([year,month,data.slice(0,dateEnd[2]-1)]);
			}
		}
		self.calendarData.daysData = daysData;
		$("#feild_daysData").val(JSON.stringify(daysData));
		//console.log(self.calendarData.daysData)
	}
	//检测当前月份是否存在不可选的日期
	self.setDaysGap = function(flag){
		var dateStart = self.calendarData.dateStart;
		var dateEnd = self.calendarData.dateEnd;
		var year = self.datePickerData.year;
		var month = self.datePickerData.month;
		var daysGap = self.calendarData.daysGap;
		if(!dateStart || dateEnd){
			return;
		}
		if(flag == "prev"){
			for(var i = 0; i < daysGap.length; i ++){
				if(year == daysGap[i][0] && month == daysGap[i][1]){
					daysGap.splice(i,1);
					break;
				}
			}
		}
		if(flag == "next"){
			if(month == dateStart[1]){
				if($("#monthDate>li.start").nextAll(".invalid").length > 0){
					daysGap.push([year,month]);
				}
			}
			else{
				if($("#monthDate>li.invalid").length > 0){
					daysGap.push([year,month]);
				}
			}
		}
		self.calendarData.daysGap = daysGap;
		//console.log(self.calendarData.daysGap)
	}
	//重置日历数据
	self.resetData = function(){
		self.calendarData.dateStart = null;
		self.calendarData.dateStartElm = null;
		self.calendarData.dateEnd = null;
		self.calendarData.dateEndElm = null;
		self.calendarData.bookMax = null;
		self.calendarData.daysGap = [];
		self.calendarData.daysData = [];
		$("#feild_daysData").val("");
		$("#field_num").removeData("max");
		$("#feild_dateStart").val("");
		$("#feild_dateEnd").val("");
		$("#feild_daysNum").val(0);
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
	    if($("#daysNum").length > 0){
	    	var daysNum = self.daysCount();
	    	$("#daysNum").text(daysNum);
	    	$("#feild_daysNum").val(daysNum);
	    }
	    if(self.calendarData.dateStart){
	    	var dateStart = self.calendarData.dateStart;
	    	$("#feild_dateStart").val(dateStart[0]+"-"+dateStart[1]+"-"+dateStart[2]);
	    }
	    if(self.calendarData.dateEnd){
	    	var dateEnd = self.calendarData.dateEnd;
	    	$("#feild_dateEnd").val(dateEnd[0]+"-"+dateEnd[1]+"-"+dateEnd[2]);
	    }
	    self.feeTotal();
	}
	self.getHtmlLogic = function(data,classIndex,day){
		var dateHtml = "";
		var dateStart = self.calendarData.dateStart;
		var dateEnd = self.calendarData.dateEnd;
		var year = self.datePickerData.year;
		var month = self.datePickerData.month;
		if(data[classIndex].status == 0){
            dateHtml += '<li no="'+day+'" class="invalid"><p class="day">'+(day < 10 ? "0"+day : day)+'</p><p class="fee"></p></li>';
        }
        else if(data[classIndex].status == 1){  
        	if(dateStart){
        		if(dateEnd){
        			if(dateStart[0] == dateEnd[0] && dateStart[1] == dateEnd[1]){
        				if(dateStart[0] == year && dateStart[1] == month){ 
        					if(day == dateStart[2]){
		    					dateHtml += '<li no="'+day+'" class="valid booked start">';
		        			}
	        				else if(day == dateEnd[2]){
	        					dateHtml += '<li no="'+day+'" class="valid booked end">';
	        				}
	        				else if(day > dateStart[2] && day < dateEnd[2]){
	        					dateHtml += '<li no="'+day+'" class="valid booked">';
	        				}
		    				else{
		    					dateHtml += '<li no="'+day+'" class="valid">';
		    				}
        				}
        				else{
	    					dateHtml += '<li no="'+day+'" class="valid">';
        				}
        			}
        			else{
        				if(dateStart[0] == year && dateStart[1] == month){ 
	        				if(day > dateStart[2]){
		    					dateHtml += '<li no="'+day+'" class="valid booked">';
		        			}
	        				else if(day == dateStart[2]){
	        					dateHtml += '<li no="'+day+'" class="valid booked start">';
	        				}
		    				else{
		    					dateHtml += '<li no="'+day+'" class="valid">';
		    				}
        				}
        				else if(dateEnd[0] == year && dateEnd[1] == month){
        					if(day < dateEnd[2]){
		    					dateHtml += '<li no="'+day+'" class="valid booked">';
		        			}
        					else if(day == dateEnd[2]){
		    					dateHtml += '<li no="'+day+'" class="valid booked end">';
		        			}
		    				else{
		    					dateHtml += '<li no="'+day+'" class="valid">';
		    				}
        				}
        				else if(year > dateStart[0] && year < dateEnd[0]){
        					dateHtml += '<li no="'+day+'" class="valid booked">';
        				}
        				else if(dateStart[0] != dateEnd[0] && year == dateStart[0] && month > dateStart[1]){
        					dateHtml += '<li no="'+day+'" class="valid booked">';
        				}
        				else if(dateStart[0] != dateEnd[0] && year == dateEnd[0] && month < dateEnd[1]){
        					dateHtml += '<li no="'+day+'" class="valid booked">';
        				}
        				else if(dateStart[0] == dateEnd[0] && month > dateStart[1] && month < dateEnd[1]){
        					dateHtml += '<li no="'+day+'" class="valid booked">';
        				}
        				else{
	    					dateHtml += '<li no="'+day+'" class="valid">';
        				}
        			}
        		}
        		else{
        			if(dateStart[0] == year && dateStart[1] == month && dateStart[2] == day){
        				dateHtml += '<li no="'+day+'" class="valid booked start">';
        			}
        			else{
        				dateHtml += '<li no="'+day+'" class="valid">';
        			}
        		}
        	}
        	else{
        		dateHtml += '<li no="'+day+'" class="valid">';
        	}
        	dateHtml += '<p class="day">'+(day < 10 ? "0"+day : day)+'</p><p class="fee">¥'+data[classIndex].feeTotal+'</p></li>';
        }
        return dateHtml;
	}
}

var odp = {};
orderDatePicker.call(odp);
odp.config();