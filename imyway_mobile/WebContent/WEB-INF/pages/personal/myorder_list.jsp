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

<td colspan="6">
	<div class="sub_data_list">
		<c:set value="" var="startdate" />
		<c:set value="0" var="package_price_idx" />
		<c:forEach var="items" items="${resList }" varStatus="statusIdx">
		<c:if test="${ items.atdate !=  startdate}">
			<c:set value="${ items.atdate}" var="startdate" />
			<c:set value="0" var="ent_price_idx" />
			<div><span style="font-size: 16px;font-weight: bold;">${startdate }</span></div>
		</c:if>
		<div class="sub_data_list_li <c:if test="${ resList[statusIdx.index+1].atdate != startdate }">last</c:if> ">
			<div class="l_content fl">
				<c:choose>
					<c:when test="${items.ptype == 0 }">
						<c:set value="package_detail.html?pid=${items.pid }#p_discuss" var="productDetail" />
						<img alt="" src="<%=basePath%>assets/img/UI/package_icon.png" >
					</c:when>
					<c:when test="${items.ptype == 1 }">
						<c:set value="hotel_detail.html?pid=${items.pid }#p_discuss" var="productDetail" />
						<img alt="" src="<%=basePath%>assets/img/UI/hotel_icon.png" >
					</c:when>
					<c:when test="${items.ptype == 2 }">
						<c:set value="villa_detail.html?pid=${items.pid }#p_discuss" var="productDetail" />
						<img alt="" src="<%=basePath%>assets/img/UI/villa_icon.png" >
					</c:when>
					<c:when test="${items.ptype == 3 }">
						<c:set value="traffic_detail.html?pid=${items.pid }#p_discuss" var="productDetail" />
						<img alt="" src="<%=basePath%>assets/img/UI/traffic_icon.png" >
					</c:when>
					<c:when test="${items.ptype == 4 }">
						<c:set value="ent_detail.html?pid=${items.pid }#p_discuss" var="productDetail" />
						<img alt="" src="<%=basePath%>assets/img/UI/yl_icon.png" >
					</c:when>
				</c:choose>
			&nbsp;&nbsp;${items.attime }
			</div>
			<div class="c_content fl">
				<c:choose>
					<c:when test="${items.ptype == 0 or items.ptype == 4 }">
						<p>${items.title } - 
							<c:if test="${items.itype == 0 }">交通</c:if>
							<c:if test="${items.itype == 1 }">住宿</c:if>
							<c:if test="${items.itype == 2 }">别墅</c:if>
							<c:if test="${items.itype == 3 }">娱乐</c:if>
						</p>
					</c:when>
					<c:otherwise>
						<p>${items.pname }</p>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="r_content fr">
				<c:choose>
					<c:when test="${items.ptype == 0 }">
						<c:if test="${package_price_idx == 0 }">
							<c:if test="${not empty items.confirm_img && items.confirm_status == 0}"><a target="_blank" href="${items.confirm_img}">查看凭证</a></c:if>
							<c:if test="${routeOrder.status == 5}"><a target="_self" href="<%=basePath%>product/${productDetail }">评论</a></c:if>
							<span>价格：<span class="red1"><f:formatNumber value="${items.amount }" type="currency" pattern="¥.00"/></span></span>
							<%-- <span>预付：<span class="red"><f:formatNumber value="${items.prepay_amount }" type="currency" pattern="¥.00"/></span></span>
							<span>尾款：<span class="red"><f:formatNumber value="${items.amount - items.prepay_amount  }" type="currency" pattern="¥.00"/></span></span> --%>
							<c:set value="1" var="package_price_idx" />
							
						</c:if>
					</c:when>
					<c:when test="${items.ptype == 4 }">
						<c:if test="${items.amount > 0 }">
							<c:if test="${not empty items.confirm_img && items.confirm_status == 0}"><a target="_blank" href="${items.confirm_img}">查看凭证</a></c:if>
							<c:if test="${routeOrder.status == 5}"><a target="_self" href="<%=basePath%>product/${productDetail }">评论</a></c:if>
							<span>价格：<span class="red1"><f:formatNumber value="${items.amount }" type="currency" pattern="¥.00"/></span></span>
							<%-- <span>预付：<span class="red"><f:formatNumber value="${items.prepay_amount }" type="currency" pattern="¥.00"/></span></span>
							<span>尾款：<span class="red"><f:formatNumber value="${items.amount - items.prepay_amount  }" type="currency" pattern="¥.00"/></span></span> --%>
							
						</c:if>
					</c:when>
					<c:when test="${items.ptype == 2 }">
						<c:if test="${items.amount > 0 }">
							<c:if test="${not empty items.confirm_img && items.confirm_status == 0}"><a target="_blank" href="${items.confirm_img}">查看凭证</a></c:if>
							<c:if test="${routeOrder.status == 5}"><a target="_self" href="<%=basePath%>product/${productDetail }">评论</a></c:if>
							<span>价格：<span class="red1"><f:formatNumber value="${items.amount }" type="currency" pattern="¥.00"/></span></span>
							<%-- <span>预付：<span class="red"><f:formatNumber value="${items.prepay_amount }" type="currency" pattern="¥.00"/></span></span>
							<span>尾款：<span class="red"><f:formatNumber value="${items.amount - items.prepay_amount  }" type="currency" pattern="¥.00"/></span></span> --%>
							
						</c:if>
					</c:when>
					<c:otherwise>
						<c:if test="${not empty items.confirm_img && items.confirm_status == 0}"><a target="_blank" href="${items.confirm_img}">查看凭证</a></c:if>
						<c:if test="${routeOrder.status == 5}"><a target="_self" href="<%=basePath%>product/${productDetail }">评论</a></c:if>
						<span>价格：<span class="red1"><f:formatNumber value="${items.amount }" type="currency" pattern="¥.00"/></span></span>
						<%-- <span>预付：<span class="red"><f:formatNumber value="${items.prepay_amount }" type="currency" pattern="¥.00"/></span></span>
						<span>尾款：<span class="red"><f:formatNumber value="${items.amount - items.prepay_amount  }" type="currency" pattern="¥.00"/></span></span> --%>				
					</c:otherwise>
				</c:choose>
				<c:if test="${status == 1 }"><a href="<%=basePath%>personal/updateAndDeleteOrder.html?orderNo=${items.order_no}">修改</a></c:if>
				<span class="split"></span>
				<%-- <a href="<%=basePath%>personal/updateAndDeleteOrder.html?orderNo=${items.order_no}">删除</a> --%>&nbsp;&nbsp;&nbsp;&nbsp;
				<c:if test="${items.confirm_time == 0 }"><img class="confirm_now" src="<%=basePath%>assets/img/UI/confirm_now.png"></c:if>
				<c:if test="${items.confirm_time != 0 }"><div class="time_confirm">${items.confirm_time}小时<br>确认</div></c:if>
			</div>
			<div class="clr"></div>
		</div>
		</c:forEach>
		<c:if test="${routeOrder.amount != routeOrder.oldAmount}">
		<div class="r_content fr">
			<span>折扣：</span>
			<span class="red"><f:formatNumber value="${routeOrder.oldAmount - routeOrder.amount }" type="currency" pattern="¥0.00"/></span>
		</div>
		</c:if>
	</div>
</td>

<script type="text/javascript">


</script>
