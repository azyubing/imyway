var tmpl_hotThemes = ''
+    '{{each body}}'
+    	'<li>'
+    		'<a href="pdtDetail_villa.html">'
+    			'<div class="fullImg lazy" data-original="{{$value.size_img2}}"></div>'
+    			'<p class="price">¥{{$value.price}}/起</p>'
+    			'<div class="cnt">'
+    				'<h5 class="tit">{{$value.pname}}</h5>'
+    				'<p class="intro">「 {{$value.description}}」</p>'
+    			'</div>'
+    		'</a>'
+    	'</li>'
+    '{{/each}}';

var tmpl_product = ''
+    '{{each body}}'
+    	'<li>'
+    		'<a href="{{}}">'
+    			'<img class="fullImg" src="{{}}" />'
+    			'<p class="price">¥{{$value.price}}/起</p>'
+    			'<div class="cnt">'
+    				'<h5 class="tit"><span class="color1">【泰国 苏梅岛】</span>湄南海滩 W酒店</h5>'
+    				'<p class="intro">W Retreat Koh Samui (苏梅岛W酒店)由著名泰国室内设计公司 P49 Deesign 与 MAPS 设计工作室精心打造</p>'
+ 					'<div class="info f-box">'
+ 						'<div class="label f-flex">商务 | XX | AAA</div>'
+ 					'</div>'
+    			'</div>'
+    		'</a>'
+    	'</li>'
+    '{{/each}}';

var tmpl_dropdown_theme = ''
+    '{{each themeOptions}}'
+    	'<li><a href="{{$index}}">{{$value}}</a></li>'
+    '{{/each}}';
var tmpl_dropdown_destination = ''
+    '{{each destinationOptions}}'
+    	'<li><a href="{{$index}}">{{$value}}</a></li>'
+    '{{/each}}';
var tmpl_dropdown_services = ''
+    '{{each servicesOptions}}'
+    	'<li><a href="{{$index}}">{{$value}}</a></li>'
+    '{{/each}}';
var tmpl_dropdown_orderby = ''
+    '{{each orderby}}'
+    	'<li><a href="{{$index}}">{{$value}}</a></li>'
+    '{{/each}}';