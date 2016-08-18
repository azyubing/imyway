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
<link href="<%=basePath%>assets/css/collection.css" rel="stylesheet" type="text/css">

</head>
<body>
<!-- ===info main -->
<div id="contact_main" >
  <div id="main">
  	<c:set value="8" var="pageSize" />
	<div class="title_nav">
		
		<a href="<%=basePath%>personal/collection.html?page=1&pageSize=${pageSize }&active=1" <c:if test="${ptype == null }">class="active"</c:if>>全部收藏</a>
		<a href="<%=basePath%>personal/collection.html?ptype=0&page=1&pageSize=${pageSize }&active=1" <c:if test="${ptype == 0 }">class="active"</c:if>>套餐</a>
		<a href="<%=basePath%>personal/collection.html?ptype=3&page=1&pageSize=${pageSize }&active=1" <c:if test="${ptype == 3 }">class="active"</c:if>>交通</a>
		<a href="<%=basePath%>personal/collection.html?ptype=2&page=1&pageSize=${pageSize }&active=1" <c:if test="${ptype == 2 }">class="active"</c:if>>别墅</a>
		<a href="<%=basePath%>personal/collection.html?ptype=1&page=1&pageSize=${pageSize }&active=1" <c:if test="${ptype == 1 }">class="active"</c:if>>酒店</a>
		<a href="<%=basePath%>personal/collection.html?ptype=4&page=1&pageSize=${pageSize }&active=1" <c:if test="${ptype == 4 }">class="active"</c:if>>娱乐</a>
	</div>
	<div class="info_list">
		<c:forEach var="items" items="${list }" varStatus="statusIdx">
			<c:set value="${items.size_img2}" var="imgs" />
			<c:set value="${ fn:split(items.tags, '|') }" var="tags" />
			<c:set value="${items.pname }" var="pname" />
			<c:set value="${items.pname_en }" var="pname_en" />
			<c:set value="${items.start_price }" var="start_price" />
			
			
			<c:set value="${fn:substring(items.enddate, 0, 10)}" var="enddate" />
			<c:set value="${items.startplace }" var="startplace" />
			<c:set value="${items.endplace }" var="endplace" />
			<c:set value="${items.roomcnt }" var="roomcnt" />
			<c:set value="${items.staylvl }" var="staylvl" />
			
			
			<c:if test="${statusIdx.index%4==0 }"><div class="row"></c:if>
				<div class="col col-md-3 col-sm-3 col-xs-3 col-lg-3">
					<div class="item">
						<c:choose>
							<c:when test="${items.ptype == '0' }">
								<div>
									<a href="<%=basePath%>product/package_detail.html?pid=${items.pid }"><img alt="" src="${imgs }" width="280px" height="142px"></a>
								</div>
								<div class="item_info bs">
									<img alt="" src="<%=basePath%>assets/img/personal/tc_icon.png" class="icon_img">
									<p >${pname }</p>
									<p class="sp_info">${items.countryName }&nbsp;${items.cityName }</p>
									<div class="item_tag">
										<div class="fl tags">
											<c:forEach var="tag" items="${tags }">
												<span>${tag }</span>
											</c:forEach>
										</div>
										<div class="fr infos"><span>有效期：</span><span class="g">${enddate }</span></div>
										<div class="clr"></div>
									</div>
									<hr>
									<div class="item_price">
										<div class="fl price">价格：<span class="r"><f:formatNumber value="${start_price }" type="currency" pattern="¥.00"/></span>元起</div>
										<div class="fr del"><i class="fa fa-trash-o"></i>&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="delCollection('${items.cid}');">删除</a></div>
										<div class="clr"></div>
									</div>
								</div>
							</c:when>
							<c:when test="${items.ptype == '1' }">
								<div>
									<a href="<%=basePath%>product/hotel_detail.html?pid=${items.pid }"><img alt="" src="${imgs }" width="280px" height="142px"></a>
								</div>
								<div class="item_info bs">
									<img alt="" src="<%=basePath%>assets/img/personal/jd_icon.png" class="icon_img">
									<p >${pname }</p>
									<p class="sp_info">${items.countryName }&nbsp;${items.cityName }</p>
									<div class="item_tag">
										<div class="fl tags">
											<c:forEach var="tag" items="${tags }">
												<span>${tag }</span>
											</c:forEach>
										</div>
										<div class="fr infos"><span>住宿等级：</span><span class="g">${staylvl }</span></div>
										<div class="clr"></div>
									</div>
									<hr>
									<div class="item_price">
										<div class="fl price">价格：<span class="r"><f:formatNumber value="${start_price }" type="currency" pattern="¥.00"/></span>元起</div>
										<div class="fr del"><i class="fa fa-trash-o"></i>&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="delCollection('${items.cid}');">删除</a></div>
										<div class="clr"></div>
									</div>
								</div>
							</c:when>
							<c:when test="${items.ptype == '2' }">
								<div>
									<a href="<%=basePath%>product/villa_detail.html?pid=${items.pid }"><img alt="" src="${imgs }" width="280px" height="142px"></a>
								</div>
								<div class="item_info bs">
									<img alt="" src="<%=basePath%>assets/img/personal/bs_icon.png" class="icon_img">
									<p >${pname }</p>
									<p class="sp_info">${items.countryName }&nbsp;${items.cityName }</p>
									<div class="item_tag">
										<div class="fl tags">
											<c:forEach var="tag" items="${tags }">
												<span>${tag }</span>
											</c:forEach>
										</div>
										<div class="fr infos"><span>卧室数：</span><span class="g">${roomcnt }</span></div>
										<div class="clr"></div>
									</div>
									<hr>
									<div class="item_price">
										<div class="fl price">价格：<span class="r"><f:formatNumber value="${start_price }" type="currency" pattern="¥.00"/></span>元起</div>
										<div class="fr del"><i class="fa fa-trash-o"></i>&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="delCollection('${items.cid}');">删除</a></div>
										<div class="clr"></div>
									</div>
								</div>
							</c:when>
							<c:when test="${items.ptype == '3' }">
								<div>
									<a href="<%=basePath%>product/traffic_detail.html?pid=${items.pid }"><img alt="" src="${imgs }" width="280px" height="142px"></a>
								</div>
								<div class="item_info bs">
									<img alt="" src="<%=basePath%>assets/img/personal/jt_icon.png" class="icon_img">
									<%-- <p ><img alt="" src="<%=basePath%>assets/img/traffic/start.png" >${startplace }</p>
									<p ><img alt="" src="<%=basePath%>assets/img/traffic/end.png">${endplace }</p> --%>
									<p >${pname }</p>
									<p class="sp_info">${items.countryName }&nbsp;${items.cityName }</p>
									<div class="item_tag">
										<div class="fl tags">
											<c:forEach var="tag" items="${tags }">
												<span>${tag }</span>
											</c:forEach>
										</div>
										<div class="clr"></div>
									</div>
									<hr>
									<div class="item_price">
										<div class="fl price">价格：<span class="r"><f:formatNumber value="${start_price }" type="currency" pattern="¥.00"/></span>元起</div>
										<div class="fr del"><i class="fa fa-trash-o"></i>&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="delCollection('${items.cid}');" >删除</a></div>
										<div class="clr"></div>
									</div>
								</div>
							</c:when>
							<c:when test="${items.ptype == '4' }">
								<div>
									<a href="<%=basePath%>product/ent_detail.html?pid=${items.pid }"><img alt="" src="${imgs }" width="280px" height="142px"></a>
								</div>
								<div class="item_info bs">
									<img alt="" src="<%=basePath%>assets/img/personal/yl_icon.png" class="icon_img">
									<p >${pname }</p>
									<p class="sp_info">${items.countryName }&nbsp;${items.cityName }</p>
									<div class="item_tag">
										<div class="fl tags">
											<c:forEach var="tag" items="${tags }">
												<span>${tag }</span>
											</c:forEach>
										</div>
										<div class="fr infos"></div>
										<div class="clr"></div>
									</div>
									<hr>
									<div class="item_price">
										<div class="fl price">价格：<span class="r"><f:formatNumber value="${start_price }" type="currency" pattern="¥.00"/></span>元起</div>
										<div class="fr del"><i class="fa fa-trash-o"></i>&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="delCollection('${items.cid}');" >删除</a></div>
										<div class="clr"></div>
									</div>
								</div>
							</c:when>
						</c:choose>
					</div>
				</div>
			<c:if test="${statusIdx.index%4==3 }"></div></c:if>
			<c:if test="${statusIdx.index == fn:length(list) }"></div></c:if>
		</c:forEach>
	</div>
	<div id="pagination">
		<c:if test="${fn:length(list) > 0  }">
			<ul>
			<li class="l_arrow"><a href="<%=basePath%>personal/collection.html?ptype=${ptype}&page=${la}&pageSize=${pageSize }&active=${la}"><img alt="" src="<%=basePath%>assets/img/personal/la.png"></a></li>
			<c:forEach begin="1" end="${pageSizes }" varStatus="pageIdx">
				<li><a href="<%=basePath%>personal/collection.html?ptype=${ptype}&page=${pageIdx.index}&pageSize=${pageSize }&active=${pageIdx.index}" class="<c:if test="${pageIdx.index ==active }">active</c:if>" >${pageIdx.index }</a></li>
			</c:forEach>
			<li class="r_arrow"><a href="<%=basePath%>personal/collection.html?ptype=${ptype}&page=${ra}&pageSize=${pageSize }&active=${ra}"><img alt="" src="<%=basePath%>assets/img/personal/ra.png"></a></li>
		</ul>
		</c:if>
		
	</div>
	<div class="clr"></div>
  </div>
</div>
<!-- ===End info main -->

<!-- Page level JS -->
<script type="text/javascript">
function delCollection(obj){
	setTimeout(function(){
		$.ajax({
			type: "GET",	
			url: "<%=basePath%>collection/ajaxDelCollection.html",
			data: {'cid':obj},
			dataType: "html",
			success: function(htmlData){
				var objectList =jQuery.parseJSON(htmlData);
				alert(objectList);
				window.location.reload();
			}
		});
	},500);
}

$(function(){
$(".tags-nav").find("a").removeClass("active");
$(".tags-nav").find("a").eq(1).addClass("active");
});
</script>

</body>
</html>