$(document).ready(function() {
	$.ajax({
     	url: baseUrl+"productSearchOptions.do",
     	type: "get",
     	dataType: "json",
     	context: "imyway",
		cache : false,
     	success: function(data) {
    	 	if (data.status == 'success') {
	    	 	var render;
	    	 	var html;
	    	 	/*render = template.compile(tmpl_dropdown_theme);
				html = render(data.body);
	    	 	document.getElementById('dropdown_theme').innerHTML = html;*/
	    	 	render = template.compile(tmpl_dropdown_destination);
				html = render(data.body);
	    	 	document.getElementById('dropdown_dest').innerHTML = html;
	    	 	render = template.compile(tmpl_dropdown_services);
				html = render(data.body);
	    	 	document.getElementById('dropdown_serve').innerHTML = html;
	    	 	render = template.compile(tmpl_dropdown_orderby);
				html = render(data.body);
	    	 	document.getElementById('dropdown_sort').innerHTML = html;
	    	 	$("#dropdown_dest>li").first().tabClass("am-active");
	    	 	$("#dropdown_serve>li").first().tabClass("am-active");
	    	 	$("#dropdown_sort>li").first().tabClass("am-active");
	    	 	waterFall();
    	 	}
     	},
     	error: function(XMLHttpRequest, textStatus, errorThrown) {
    	 	alert(textStatus);
     	}
	});
});

//分页数据加载_数据请求
function waterFallAjax(){
	loader = this;
	var ajaxParam = $.extend(loader.ajaxParam,{
		page : loader.ajaxPage,
    	pageSize : 10
	})
	console.log(ajaxParam)
    $.ajax({
    	url: baseUrl+"products.do",
        type: "get",
     	dataType: "json",
     	context: "imyway",
		cache : false,
        data : ajaxParam,
        beforeSend:function() {
            if(loader.ajaxPage > 1){
                loader.loadElm.addClass("loading").show().find(".text").text("努力加载中...");
            }
        },
        success:function(data) {
       		if (data.status == 'success') {
	    	 	console.log(data)
    	 	}
            //loader.loadDataHandle(data);
        }
    });
}