<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<link href="<%=basePath%>assets/css/vedioDetail.css" rel="stylesheet" type="text/css">

</head>
<body>

<!-- ==center content -->
<div class="center_content">
	<div class="p_detail">
		
		<embed class="vedio_style"
			src="${media.mediaUrl}"
			quality="high" align="middle"
			allowScriptAccess="always" allowFullScreen="true" mode="transparent"
			type="application/x-shockwave-flash"></embed>
		
	</div>
	<div class="p_tags">
		<div class="tags">
			<div class="tag_l fl">
				<c:forEach items="${media.mediatags}" var="item" >
					<a class="btn btn-sm btn-success tag-btn" style="cursor: default;">${item.name}</a>
				</c:forEach>
				<span class="p_title">${media.name}</span>
				<div class="p_desc">${media.remark}</div>
			</div>
			<div class="tag_r fr">
				<img alt="" src="<%=basePath%>assets/img/UI/package.jpg">
				<span class="package_name">${media.title}</span>
				<a href="${media.packageUrl}" id="detailBtn">查看套餐详情</a>
			</div>
			<div class="clr"></div>
		</div>
	</div>
	<div class="bottom_content">
		<!-- ===same packages === -->
		<div class="same_package">
			<h4>相似套餐</h4>
			<!-- img price -->
			<div class="info_list">
				<div class="row">
				  <c:forEach items="${media.mediasimilar}" var="item" >
						<div class="col col-md-4 col-sm-4 col-xs-4 col-lg-4">
							<div class="item">
								<div><a href="<%=basePath%>product/package_detail.html?pid=${item.pid}"><img alt="" src="${item.list_img}"></a></div>
								<div class="item_info bs">
									<p ><a class="nameLink" href="<%=basePath%>product/package_detail.html?pid=${item.pid}">${item.pname}</a></p>
									<c:if test="${fn:length(item.pdesc)>29}">  
						               <p class="sp_info">${fn:substring(item.pdesc,0,29)}...</p>
						            </c:if>  
						            <c:if test="${fn:length(item.pdesc)<=29}">  
						               <p class="sp_info">${item.pdesc}</p>
						            </c:if>   
									
									<div class="item_tag">
										<div class="fl tags">
											<c:forEach items="${item.tags}" var="tag">
												<span>${tag}</span>
											</c:forEach>
										</div>
										<div class="fr infos"><span>有效期：</span><span class="g"><fmt:formatDate value="${item.enddate}" type="date" dateStyle="long"/></span></div>
										<div class="clr"></div>
									</div>
									<hr>
									<div class="item_price">
										<div class="fl price">价格：<span class="r"><fmt:formatNumber value="${item.start_price}" type="currency" /></span>&nbsp;&nbsp;人起</div>
										<div class="clr"></div>
									</div>
								</div>
							</div>
						</div>
				  </c:forEach>
				</div>
			</div>
		<!-- end img price -->
		</div>
		<!-- ===end same packages === -->
		<hr>
		<!-- 
		<div class="same_package">
			<h4>更多推荐套餐</h4>
			<!- img price --
			<div class="info_list">
				<div class="row">
				<c:forEach items="${morePackage}" var="item" >
					<div class="col col-md-3 col-sm-3 col-xs-3 col-lg-3">
						<div class="item">
								<div><a href="<%=basePath%>product/package_detail.html?pid=${item.pid}"><img alt="" src="${item.list_img}"></a></div>
								<div class="item_info bs">
									<p ><a class="nameLink" href="<%=basePath%>product/package_detail.html?pid=${item.pid}">${item.pname}</a></p>
									<c:if test="${fn:length(item.pdesc)>29}">  
						               <p class="sp_info">${fn:substring(item.pdesc,0,29)}...</p>
						            </c:if>  
						            <c:if test="${fn:length(item.pdesc)<=25}">  
						               <p class="sp_info">${item.pdesc}</p>
						            </c:if>   
									
									<div class="item_tag">
										<div class="fl tags">
											<c:forEach items="${item.tags}" var="tag">
												<span>${tag}</span>
											</c:forEach>
										</div>
										<div class="fr infos"><span>有效期：</span><span class="g"><fmt:formatDate value="${item.enddate}" type="date" dateStyle="long"/></span></div>
										<div class="clr"></div>
									</div>
									<hr>
									<div class="item_price">
										<div class="fl price">价格：<span class="r"><fmt:formatNumber value="${item.start_price}" type="currency" /></span>&nbsp;&nbsp;人起</div>
										<div class="clr"></div>
									</div>
								</div>
							</div>
					  </div>
					</c:forEach>
				</div>
			</div>
		<-- end img price --
		</div>-->
	</div>
</div>
<!--=== End center content ===-->

<!-- Page level JS -->

<script type="text/javascript">

jQuery(document).ready(function() {

	
});
</script>

</body>
</html>