$(document).ready(function() {
	$.ajax({
	     type: "get",
	     url: baseUrl+"recommendThemeProducts.do" ,
	     context: "imyway",
	     dataType: "json",
	     success: function(data) {
	    	 if (data.status == 'success') {
	    	 	var render = template.compile(tmpl_hotThemes);
				var html = render(data);
	    	 	document.getElementById('themeList').innerHTML = html;
	    	 	$('#themeList .lazy').addClass("lazyLoaded").lazyload({
					effect : 'fadeIn'
				});
	    	 }
	     },
	     error: function(XMLHttpRequest, textStatus, errorThrown) {
	    	 alert(textStatus);
	     }
	});
});