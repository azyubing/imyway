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
<link href="<%=basePath%>assets/css/contact.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=basePath%>assets/js/javascriptCheck.js"></script>
</head>
<body>

<!-- add new form -->
<div class="modal fade" id="addForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
               <h4 class="modal-title" id="myModalLabel">新增旅客信息</h4>
           </div>
           <div class="modal-body">
           <form action="" id="addCustomer" name="addCustomer">
           	<input type="hidden" name="id" value="0">
           	<input type="hidden" name="birthday">
           	<input type="hidden" name="isUse" value="0">
           	<input type="hidden" name="passportImg" id="passportImg">
           	
              <table>
              	<tr>
              		<td>真实姓名<font class="red">&nbsp;*</font></td>
              		<td>真实姓名拼音<font class="red">&nbsp;*</font></td>
              		<td class="sp_t"></td>
              	</tr>
              	<tr>
              		<td><input type="text" style="padding-left:10px;" name="realName" placeholder="请输入真实姓名" title="请输入真实姓名"></td>
              		<td><input type="text" style="padding-left:10px;" name="customerName" placeholder="请输入旅客姓名拼音" title="请输入旅客姓名拼音"></td>
              	</tr>
              	<tr class="sp_tr">
              		<td>证件类型<font class="red">&nbsp;*</font></td>
              		<td colspan="3">出生日期<font class="red">&nbsp;*</font></td>
              	</tr>
              		<tr>
              		<td>
	              		<select name="cardType" class="select1">
							<option value="1">身份证</option>
							<option value="2">护照</option>
							<option value="3">军人证</option>
							<option value="4">回乡证</option>
							<option value="5">台胞证</option>
							<option value="6">港澳通行证</option>
							<option value="7">户口簿</option>
							<option value="8">出生证明</option>
							<option value="9">其他</option>
						</select> 
					</td>
              		<td colspan="2" class="w100">
              		<div class="dropdown mr_10">
						  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
						    <font id="fontYear">1980</font>
						    <span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu" aria-labelledby="dropdownMenu1" id="year" style="height: 100px;overflow:auto;">
						  </ul>
						</div><div class="dropdown">
						  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
						    <font id="fontMonth">1月</font>
						    <span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu" aria-labelledby="dropdownMenu2" style="height: 100px;overflow:auto;">
						    <li><a href="javascript:void(0)" onclick="getDay(1);">1月</a></li>
						    <li><a href="javascript:void(0)" onclick="getDay(2);">2月</a></li>
						    <li><a href="javascript:void(0)" onclick="getDay(3);">3月</a></li>
						    <li><a href="javascript:void(0)" onclick="getDay(4);">4月</a></li>
						    <li><a href="javascript:void(0)" onclick="getDay(5);">5月</a></li>
						    <li><a href="javascript:void(0)" onclick="getDay(6);">6月</a></li>
						    <li><a href="javascript:void(0)" onclick="getDay(7);">7月</a></li>
						    <li><a href="javascript:void(0)" onclick="getDay(8);">8月</a></li>
						    <li><a href="javascript:void(0)" onclick="getDay(9);">9月</a></li>
						    <li><a href="javascript:void(0)" onclick="getDay(10);">10月</a></li>
						    <li><a href="javascript:void(0)" onclick="getDay(11);">11月</a></li>
						    <li><a href="javascript:void(0)" onclick="getDay(12);">12月</a></li>
						  </ul>
						</div><div class="dropdown last">
						  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
						    <font id="fontDay">1日</font>
						    <span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu" aria-labelledby="dropdownMenu3" id="day" style="height: 100px;overflow:auto;">
						  </ul>
						</div>
					</td>
              	</tr>
              	<tr>
              		<td  colspan="3">证件号码<font class="red">&nbsp;*</font></td>
              	</tr>
              	<tr>
              		<td colspan="3" class="w100"><input class="w100" style="padding-left:10px;"  type="text" name="cardNumber"  placeholder="请输入证件号码" title="请输入证件号码"></td>
              	</tr>
              </table>
              </form>
           </div>
           <div class="modal-footer">
               <button type="button" class="btn save" onclick="submit()">保存</button>
           </div>
       </div>
   </div>
</div>
<!-- end add new form -->

<!-- ===contact main -->
<div id="contact_main" >
	<div id="main">
	<button class="btn" id="addBtn">新增旅客信息</button>
	<table id="contact_list">
	<thead>
	<tr>
		<td><input class="ck" type="checkbox"  onclick="allChecked(this)">&nbsp;&nbsp;序号</td>
		<td>姓名</td>
		<td>证件号码</td>
		<td>操作</td>
	</tr>
	</thead>
	<tbody id="customerList">
	</tbody>
	<tfoot>
	<tr>
	<td colspan="6"><input class="ck"  type="checkbox" onclick="allChecked(this)">&nbsp;&nbsp;<a href="#" onclick="delAll()">删除</a></td>
	</tr>
	</tfoot>
	</table>
	</div>
</div>
<!-- ===End contact main -->

<!-- Page level JS -->
<script type="text/javascript">
	$(function(){
			$(".tags-nav").find("a").removeClass("active");
			$(".tags-nav").find("a").eq(2).addClass("active");
		$("#addBtn").click(function(){
			$("#addForm").modal('show');
		});
		$('#addForm').on('hide.bs.modal', function () {
			clear();
		});
		$("#uploadBtn_2").change(function(){
			$("#upload_txt_2").val($(this).val());
		});
		setYearHtml();
		getDay(1);
		
		search();
		
	});
	
	
	function search(){
		$.ajax({
			type : "post",
			url : "<%=basePath%>personal/customerAdminSearchList.html",
			data : {},
			cache : false,
			dataType : 'json',
			beforeSend : function() {
			},
			success : function(data) {
				var html = '';
				var json = eval(data.rows);
				for(var i = 0 ;i<json.length;i++){
					html = html+'<tr>'
							+'<input type="hidden" name="id" value="'+json[i].id+'">'
							+'<td><input class="ck" type="checkbox">&nbsp;&nbsp;'+(i+1)+'</td>'
							+'<td>'+json[i].realName+'</td>'
							+'<td>'+json[i].cardNumber+'</td>'
							+'<td><a href="#" onclick="edit('+"'"+json[i].id+"'"+')">编辑</a>&nbsp;<a href="#" onclick="del('+"'"+json[i].id+"','"+json[i].realName+"'"+')">删除</a></td>'
							+'</tr>';
				}
				$("#customerList").html(html);
			}
		});
	}
	
	function del(id,realName){
		var bool = window.confirm("您确定删除"+realName+"吗?");
		if(bool){
			$.ajax({
				type : "post",
				url : "<%=basePath%>personal/deleteCustomer.html",
				data : {"id":id},
				cache : false,
				dataType : 'text',
				beforeSend : function() {
				},
				success : function(data) {
					if(data='success'){
						alert("删除成功");
						search();
					}
				}
			});
			
		}
	}
	
	function delAll(){
		var checkbox = $("#customerList").find("input[type='checkbox']");
		var id ='';
		for(var i=0;i<checkbox.length;i++){
			if($(checkbox).eq(i).attr("checked")){
				id =id+ $(checkbox).eq(i).parent().parent().find("input[name='id']").val()+",";
			}
		}
		var ids = id.substring(0,id.length-1);
		var bool = window.confirm("您确定删除勾选的旅客信息吗?");
		if(bool){
			$.ajax({
				type : "post",
				url : "<%=basePath%>personal/deleteBucthCustomer.html",
				data : {"ids":ids},
				cache : false,
				dataType : 'text',
				beforeSend : function() {
				},
				success : function(data) {
					if(data='success'){
						alert("删除成功");
						search();
					}
				}
			});
		}
	}
	
	function allChecked(obj){
		var checkbox = $("#customerList").find("input[type='checkbox']");
		if($(obj).attr("checked")){
			for(var i=0;i<checkbox.length;i++){
				$(checkbox).eq(i).attr("checked",true);
			}
		}else{
			for(var i=0;i<checkbox.length;i++){
				$(checkbox).eq(i).attr("checked",false);
			}
		}
	}
	
	
	function edit(id){
		clear();
		$.ajax({
			type : "post",
			url : "<%=basePath%>personal/getCustomerById.html",
			data : {"id":id},
			cache : false,
			dataType : 'json',
			beforeSend : function() {
			},
			success : function(data) {
				var data = eval(data.customer);
				var id = data.id;
				var customerName = data.customerName;
				var realName = data.realName;
				var birthday = data.birthday;
				var cardType = data.cardType;
				var cardNumber = data.cardNumber;
				$("#addCustomer").find("input[name='id']").val(id);
				$("#addCustomer").find("input[name='customerName']").val(customerName);
				$("#addCustomer").find("input[name='realName']").val(realName);
				$("#addCustomer").find("input[name='cardNumber']").val(cardNumber);
				$("#addCustomer").find("select[name='cardType']").val(cardType);
				var time = new Date(birthday);
				$("#fontYear").html(time.getFullYear());
				$("#fontMonth").html((time.getMonth()+1)+"月");
				$("#fontDay").html(time.getDate()+"日");
				
				
			$("#addForm").modal('show');
			}
		});
		
	}
	
	function submit(){
		var yearStr = $("#fontYear").html();
		var monthStr = $("#fontMonth").html();
		var dayStr = $("#fontDay").html();
		var month = monthStr.split("月")[0];
		var day = dayStr.split("日")[0];
		var d = new Date(yearStr,month-1,day);
		var id = $("#addCustomer").find("input[name='id']").val();
		$("#addCustomer").find("input[name='birthday']").val(d);
		var customerName = $("#addCustomer").find("input[name='customerName']").val().trim();
		var realName = $("#addCustomer").find("input[name='realName']").val().trim();
		var cardNumber = $("#addCustomer").find("input[name='cardNumber']").val().trim();
		if(isNull(realName)){
			alert("请填写真实姓名");
			return false;
		}
		if(isNull(customerName)){
			alert("请填写真实姓名拼音");
			return false;
		}
		if(isNull(cardNumber)){
			alert("请填写证件号码");
			return false;
		}
		
		$.ajax({
			type : "post",
			url : "<%=basePath%>personal/saveOrUpdateCustomer.html",
			data : $("#addCustomer").serialize(),
			cache : false,
			dataType : 'text',
			beforeSend : function() {
			},
			success : function(data) {
				if(data=='success'){
					if(id!=null && id!=''&&id!=0){
						alert("修改成功");
					}else{
						alert("添加成功");
					}
					$("#addForm").modal('hide');
					clear();
					search();
				}
			}
		});
	}
	
	function clear(){
		$("#addCustomer").find("input[name='id']").val('0');
		$("#addCustomer").find("input[name='customerName']").val('');
		$("#addCustomer").find("input[name='realName']").val('');
		$("#addCustomer").find("input[name='cardNumber']").val('');
		$("#addCustomer").find("select[name='cardType']").val(1);
	}
	
	
	function getNowYear(){
		var myDate = new Date();
		var year = myDate.getYear();
	}
	
	function setYearHtml(){
		var myDate = new Date();
		var year = myDate.getFullYear();
		var html = '';
		for(var i=parseInt(year);i>1920;i--){
			html = html+'<li><a href="javascript:void(0)" onclick="year(this)">'+i+'</a></li>';
		}
		$("#fontYear").html(year);
		$("#year").html(html);
	}
	
	 function getDay(month){
		 var year = $("#fontYear").html().substring(0,4);
		 var d = DayNumOfMonth(year, month);
		 var html = '';
		for(var i=1;i<=parseInt(d);i++){
			html = html+'<li><a href="javascript:void(0)" onclick="day(this)">'+i+'日</a></li>';
		}
		$("#fontMonth").html(month+"月");
		$("#day").html(html);
	 }
	 
	 function year(obj){
		 var d = $(obj).html();
		 $("#fontYear").html(d);
		var month =  $("#fontMonth").html().split("月")[0];
		getDay(month);
		 
	 }
	 function day(obj){
		 var d = $(obj).html();
		 $("#fontDay").html(d);
	 }
	function DayNumOfMonth(Year, Month) {
		var d = new Date(Year, Month, 0);
		return d.getDate();
	}
	
</script>

</body>
</html>